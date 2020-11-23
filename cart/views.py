import json

from django.http import JsonResponse
from django.views import View

from user.models import User
from cart.models import Cart
from product.models import Product

class CartView(View):
    def post(self, request):
        data = json.loads(request.body)

        if 'product_id' not in data or 'color_id' not in data or 'size_id' not in data or 'quantity' not in data:
            return JsonResponse({'message':'KEY_ERROR'}, status=400)

        user_id = data['user_id']
        product_id = data['product_id']
        color_id = data['color_id']
        size_id = data['size_id']
        quantity = data['quantity'] 

        if not Product.objects.filter(id=product_id).exists():
            return JsonResponse({'message':'PRODUCT_DOES_NOT_EXISTS'}, status=400)
        
        product = Product.objects.get(id=product_id)

        if not product.color.filter(id=color_id).exists() or not product.size.filter(id=size_id).exists() or type(quantity) is not int:
            return JsonResponse({'message':'BAD_REQUEST'}, status=400)

        if Cart.objects.filter(user_id=user_id, product_id=product_id, color_id=color_id, size_id=size_id).exists():
            cart = Cart.objects.get(user_id=user_id, product_id=product_id, color_id=color_id, size_id=size_id)
            cart.quantity = quantity
            cart.save()
            return JsonResponse({'message':'QUANTITY_ADD_SUCCESS'}, status=200)

        Cart.objects.create(user_id=user_id, product_id=data['product_id'], size_id=size_id, color_id=color_id, quantity=quantity)
        return JsonResponse({'message':'SUCCESS'}, status=200)

    def get(self, request):
        data = json.loads(request.body)
        user_id = data['user_id']
        user = User.objects.get(id=user_id)

        return JsonResponse({
            'product' : [{
                'product' : cart.product.title,
                'product_image' : cart.product.main_image_url,
                'color' : cart.color.name,
                'size' : cart.size.name,
                'quantity' : cart.quantity,
                'product_price' : cart.product.price,
                'discount_price' : format(int(round(cart.product.price-(cart.product.price * cart.product.discount_rate),-2)),'.2f')
            } for cart in user.user_cart.all()]
        })

class CartDetailView(View):
    def put(self, request, cart_id):
        data = json.loads(request.body)
        
        if 'quantity' not in data:
            return JsonResponse({'message':'KEY_ERROR'}, status=400)

        user_id = data['user_id']
        quantity = data['quantity']
        
        if type(quantity) is not int:
            return JsonResponse({'message':'BAD_REQUEST'}, status=400)

        if not Cart.objects.filter(id=cart_id, user_id=user_id).exists():
            return JsonResponse({'message':'CART_DOES_NOT_EXISTS'}, status=404)

        cart = Cart.objects.get(id=cart_id, user_id=user_id)
        cart.quantity = quantity
        cart.save()
        return JsonResponse({'message':'SUCCESS'}, status=200)

    def delete(self, request, cart_id):
        data = json.loads(request.body)
        user_id = data['user_id']

        if not Cart.objects.filter(id=cart_id, user_id=user_id).exists():
            return JsonResponse({'message':'CART_DOES_NOT_EXISTS'}, status=404)

        cart = Cart.objects.get(id=cart_id, user_id=user_id)
        cart.delete()
        return JsonResponse({'message':'SUCCESS'}, status=200)


