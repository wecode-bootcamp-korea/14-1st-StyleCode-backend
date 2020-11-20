import json
import decimal

from django.views import View
from django.http import JsonResponse

from product.models import Product, ProductColor, ProductImageUrl, ProductSize, Brand, Stock, Color
from ootd.models import Ootd, Like, Comment, OotdImageUrl
from user.models import User 

class ProductDetail(View):
    def get(self, request, product_id):
        if not Product.objects.filter(id=product_id).exists():
            return JsonResponse({'message':'PRODUCT_NOT_FOUND'}, status=404)

        product = Product.objects.select_related('brand').prefetch_related('brand__product_set','ootd', 'ootd__like_user', 'ootd__comment_set', 'ootd__user', 'color', 'size', 'stock_set', 'stock_set__color', 'stock_set__size', 'productimageurl_set').get(id=product_id)

        return JsonResponse({
            'product' : {
                'title' : product.title,
                'main_image_url' : product.main_image_url,
                'discount_rate' : product.discount_rate,
                'product_price' : product.price,
                'discount_price' : product.price * product.discount_rate,
                'product_like' : product.like,
                'product_ootd_counts' : product.ootd.count(),
                'points' : int(product.price * product.discount_rate * decimal.Decimal(0.05)),
                'colors' : [color.name for color in product.color.all()],
                'sizes' : [size.name for size in product.size.all()],
                'stocks' : [{
                    'color' : stock.color.name,
                    'size' : stock.size.name,
                    'stock' : stock.stock_count
                } for stock in product.stock_set.all()],
                'brand' : product.brand.name,
                'brand_product_count' : product.brand.product_set.count(),
                'brand_image_url' : product.brand.image_url,
                'ootd' : [{
                    'user' : ootd.user.nickname,
                    'user_profile_image_url' : ootd.user.profile_image_url,
                    'description' : ootd.description,
                    'ootd_image_url' : [image.image_url for image in ootd.ootdimageurl_set.all()],
                    'like' : ootd.like_user.count(),
                    'comment_count' : ootd.comment_set.count()
                } for ootd in product.ootd.all()],
                'description' : product.description,
                'sub_image_urls' : [image.image_url for image in product.productimageurl_set.all()]
            }
        }, status=200)
