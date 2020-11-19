import jsos

from django.http import JsonResponse
from django.views import View

from .models  import {
    FirstCategory,
    SecondCategory,
    ThirdCategory,
    Brand,
    Color,
    ProductColor,
    Size,
    ProductSize,
    ProductImageUrl,
    Stock,
    Product,
    ProductOotd
    }

class ProductListView(View):
    def get(self, request):
        try:
            products = Product.objects.all()
            price = products.price
            discount_rate = products.discount_rate
            discount_price = 'price * (discount_rate/100)'

            product_list =[{
                'brand' : products.brand,
                'title' : products.title,
                'price' : products.price,
                'discount_rate' : products.discount_rate,
                'main_image_url' : products.main_image_url
                }for product in products_list.select_related('brand_set')]


