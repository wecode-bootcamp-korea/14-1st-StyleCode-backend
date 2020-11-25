import json

from django.http import JsonResponse
from django.views import View
from user.utils import Login_decorator

class OrderView(View):
    pass

#    @Login_decorator
#    def get(self, request):
#        data = json.loads(request.body)
#        if 'cart' not in data:
#            return JsonResponse({'message':'KEY_ERROR'},status=400)
#        user = request.user
#        orderer_info = OrdererInformation.objects.filter(user=user)
#        order_request = OrderRequest.objects.all()
#        carts = Cart.objects.filter(id__in=data['cart'])
#        return JsonResponse({
#            'order' : {
#                'user_info' : orderer_info,
#                'address' : user.address,
#                'order_request' : [request for request in order_request],
#                'products' : [{
#                    'title' : cart.product.title,
#                    'price' : cart.product.price,
#                    'discount_price' : format(int(round(cart.product.price - (cart.product.price * cart.product.discount_rate),-2)),'.2f'),
#                    'size' : cart.product.size.name,
#                    'color' : cart.product.color.name,
#                    'quantity' : cart.quantity,
#                    } for cart in carts]
#                'coupon' : [coupon.name for coupon in user.coupon.all()],
#                'points' : user.point
#            }
#        })

    @Login_decorator
    def post(self, request):
#       data = json.loads(request.body)
#       orderer_name = data['orderer_name'] 
#       orderer_phone = data['orderer_phone']
#       orderer_email = data['orderer_email']
#       orderer_save_check = data['orderer_save_check']
#       recipient_name = data['recipient_name']
#       recipient_phone = data['recipient_phone']
#       address = data['address']
#       address_save_check = data['address_save_check']
#       order_request = data.get(order_request)
#       self_request = data.get(self_request)
#       coupon = data.get(coupon)
#       point = data['point']
#       
#       if orderer_save_check:
#           orderer_info = OrdererInformation.objects.update_or_create(user=user, defaults={'orderer_email':orerer_email,'orderer_phone':orderer_phone,'orderer_name':orderer_name})
#
#       if address_save_check:           
#           user.address = address
#
#

        pass 

class OrderedView(View):
    @Login_decorator
    def get(self, request, order_id):
        pass

    def delete(self,request, order_id):
        pass

