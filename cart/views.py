import json

from django.http import JsonResponse
from django.views import View

class CartView(View):
    def get(self, request):
        data = json.loads(request.body)
        user_id = data['user_id']
        user = User.objects.prefetch_related('Product', 'cart_set').get(id=user_id)

        return JsonResponse({
            'product' : [{
                'product' : cart.product.title,
                'product_image' : cart.product.main_image_url,
                'color' : cart.color.name,
                'size' : cart.size.name,
                'quantity' : cart.quantity,
                'product_price' : cart.product.price,
                'discount_price' : format(int(round(cart.product.price-(cart.product.price * cart.product.discount_rate),-2)),'.2f')}for cart in user.cart_set.all()]
        })
