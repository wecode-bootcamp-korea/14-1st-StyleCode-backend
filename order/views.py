import json

from django.http  import JsonResponse
from django.views import View
from django.db    import transaction

from user.utils   import Login_decorator
from order.utils  import coupon_check, order_number_create
from order.models import OrdererInformation, Order, OrderRequest, OrderStatus
from cart.models  import Cart

class OrderView(View):
    @Login_decorator
    def get(self, request):
 
        data = json.loads(request.body)
        user = request.user
        
        if 'cart_ids' not in data:
            return JsonResponse({'message':'KEY_ERROR'}, status=400)

        if Cart.objects.filter(id__in=data['cart_ids'], order_id__isnull=False).exists():
            return JsonResponse({'message':'ALREADY_ORDERED'}, status=400)

        coupons       = coupon_check(user)
        orderer_info  = OrdererInformation.objects.filter(user=user)
        order_request = OrderRequest.objects.all()
        carts         = Cart.objects.filter(id__in=data['cart_ids']).select_related('size','color','product')

        return JsonResponse({
            'order' : {
                'orderer_info'  : {
                    'orderer_name'          : orderer_info[0].orderer_name,
                    'orderer_email'         : orderer_info[0].orderer_email,
                    'orderer_phone_number'  : orderer_info[0].orderer_phone_number
                } if orderer_info else None,
                'address'       : user.address,
                'order_request' : [{
                    'order_request_id' : request.id,
                    'order_request'    : request.request
                } for request in order_request],
                'products'      : [{
                    'cart_id'          : cart.id,
                    'title'            : cart.product.title,
                    'price'            : cart.product.price,
                    'discount_price'   : int(round(cart.product.price - (cart.product.price * cart.product.discount_rate),-2)),
                    'size'             : cart.size.name,
                    'color'            : cart.color.name,
                    'quantity'         : cart.quantity,
                    } for cart in carts],
                'coupon'        : [{
                    'coupon_id'        : coupon.id,
                    'coupon_name'      : coupon.name
                } for coupon in coupons],
                'points'        : user.point
            }
        })

    @transaction.atomic
    @Login_decorator
    def post(self, request):
        data         = json.loads(request.body)
        user         = request.user
        
        ORDER_STATUS_COMPLETE = 1

        required_key = { 
            'orderer_name',
            'orderer_phone_number',
            'orderer_email',
            'orderer_save_check',
            'recipient_name',
            'recipient_phone_number',
            'address',
            'address_save_check',
            'point',
            'cart_ids'
        }

        for key in required_key:
            if key not in data:
                return JsonResponse({'message':'KEY_ERROR'}, status=400)
        
        cart_ids               = data['cart_ids']
        orderer_name           = data['orderer_name']
        orderer_phone_number   = data['orderer_phone_number']
        orderer_email          = data['orderer_email']
        orderer_save_check     = data['orderer_save_check']
        recipient_name         = data['recipient_name']
        recipient_phone_number = data['recipient_phone_number']
        address                = data['address']
        address_save_check     = data['address_save_check']
        point                  = data['point']
        order_request_id       = data.get('order_request')
        self_request           = data.get('self_request')
        coupon_id              = data.get('coupon_id')
        order_number           = order_number_create()

        carts = []
        for cart_id in cart_ids:
            if not Cart.objects.filter(id=cart_id).exists():
                return JsonResponse({'message':'CART_DOES_NOT_EXIST'},status=404)
            if Order.objects.filter(cart__id=cart_id).exists():
                return JsonResponse({'message':'ALREADY_ORDERED'}, status=400)
            carts.append(Cart.objects.get(id=cart_id))

        if orderer_save_check:
            OrdererInformation.objects.update_or_create(user=user, defaults={
                    'orderer_email'        : orderer_email,
                    'orderer_phone_number' : orderer_phone_number,
                    'orderer_name'         : orderer_name
                })

        if address_save_check:           
            user.address = address
            user.save()
        
        order_id = Order.objects.create(
            address                = address,
            orderer_name           = orderer_name,
            orderer_phone_number   = orderer_phone_number,
            orderer_email          = orderer_email,
            order_number           = order_number,
            recipient_name         = recipient_name,
            recipient_phone_number = recipient_phone_number,
            user                   = user,
            coupon_id              = coupon_id        if coupon_id else None,
            order_status_id        = ORDER_STATUS_COMPLETE,
            order_request_id       = order_request_id if order_request_id else None,
            self_request           = self_request     if self_request else None
        ).pk

        if coupon_id:
            user.coupon.get(id=coupon_id).delete()
        
        user.point -= point
        user.save()

        for cart in carts:
            cart.order_id = order_id 
            cart.save()

        return JsonResponse({'message':'SUCCESS'},status=200)
