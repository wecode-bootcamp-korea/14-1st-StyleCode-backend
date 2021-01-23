import json

from django.http    import JsonResponse
from django.views   import View

from user.models    import User
from cart.models    import Cart
from product.models import Product
from user.utils     import Login_decorator

class CartView(View):
    @Login_decorator
    def post(self, request):
        data = json.loads(request.body)

        if 'product_id' not in data or 'color_id' not in data or 'size_id' not in data or 'quantity' not in data:
            return JsonResponse({'message':'KEY_ERROR'}, status=400)

        user       = request.user
        product_id = data['product_id']
        color_id   = data['color_id']
        size_id    = data['size_id']
        quantity   = data['quantity']

        if not Product.objects.filter(id=product_id).exists():
            return JsonResponse({'message':'PRODUCT_DOES_NOT_EXISTS'}, status=404)
        
        product = Product.objects.get(id=product_id)

        if not product.color.filter(id=color_id).exists() or not product.size.filter(id=size_id).exists() or type(quantity) is not int:
            return JsonResponse({'message':'BAD_REQUEST'}, status=400)

        cart = Cart.objects.get_or_create(user=user, product_id=product_id, color_id=color_id, size_id=size_id, order_id=None)[0]

        cart.quantity += quantity
        cart.save()

        return JsonResponse({'message':'SUCCESS'}, status=200)
    
    @Login_decorator
    def get(self, request):
        user_id = request.user.id

        user    = User.objects.prefetch_related('user_cart', 'user_cart__product', 'user_cart__size', 'user_cart__color').get(id=user_id)

        return JsonResponse({
            'product' : [{
                'cart_id'        : cart.id,
                'product'        : cart.product.title,
                'product_image'  : cart.product.main_image_url,
                'color'          : cart.color.name,
                'size'           : cart.size.name,
                'quantity'       : cart.quantity,
                'product_price'  : cart.product.price,
                'discount_price' : int(round(cart.product.price-(cart.product.price * cart.product.discount_rate),-2)),
                'shipping_fee'   : 2500
            } for cart in user.user_cart.all() if not cart.order_id]
        },status=200)

class CartDetailView(View): 
    @Login_decorator
    def post(self, request, cart_id):
        data = json.loads(request.body)

        if 'quantity' not in data:
            return JsonResponse({'message':'KEY_ERROR'}, status=400)

        user     = request.user 
        quantity = data['quantity']

        if type(quantity) is not int:
            return JsonResponse({'message':'BAD_REQUEST'}, status=400)

        if not Cart.objects.filter(id=cart_id, user=user).exists():
            return JsonResponse({'message':'CART_DOES_NOT_EXISTS'}, status=404)

        cart          = Cart.objects.get(id=cart_id, user=user)
        cart.quantity = quantity
        cart.save()
        return JsonResponse({'message':'SUCCESS'}, status=200)

    @Login_decorator
    def delete(self, request, cart_id):
        user = request.user 

        if not Cart.objects.filter(id=cart_id, user=user).exists():
            return JsonResponse({'message':'CART_DOES_NOT_EXISTS'}, status=404)

        cart = Cart.objects.get(id=cart_id, user=user)
        cart.delete()
        return JsonResponse({'message':'SUCCESS'}, status=200)


