import json

from django.http import JsonResponse
from django.views import View
from django.db.models import Q

from product.models import Product, Brand
from ootd.models import Ootd
from user.models import User

class Search(View):
    def get(self, request):
        keyword = request.GET.get('keyword')
        
        if not keyword:
            return JsonResponse({'message':'KEY_ERROR'}, status=400)        

        brands  = Brand.objects.filter(name__icontains=keyword)
        products = Product.objects.filter(Q(title__icontains=keyword) | Q(description__icontains=keyword)).select_related('brand')
        ootds   = Ootd.objects.filter(description__icontains=keyword).prefetch_related('user', 'ootdimageurl_set', 'like_user', 'comment_set', 'product_set')
        users = User.objects.filter(nickname__icontains=keyword)

        brand_list = [{
            'brand_name' : brand.name,
            'brand_image' : brand.image_url
        } for brand in brands]

        product_count = products.count()
        product_list = [{
            'product_brand' : product.brand.name,
            'product_image' : product.main_image_url,
            'description' : product.description,
            'discount_rate' : product.discount_rate,
            'discount_price' : format(int(round(product.price-(product.discount_rate * product.price),-2)),'.2f')
        } for product in products]

        ootd_count = ootds.count()
        ootd_list = [{
            'author' : ootd.user.nickname,
            'ootd_images' : [image.image_url for image in ootd.ootdimageurl_set.all()],
            'description' : ootd.description,
            'like'   : ootd.like_user.count(),
            'comment_count' : ootd.comment_set.count(),
            'ootd_products' : [{
                'product_title' : product.title,
                'product_image' : product.main_image_url,
                'product_discount_rate' : product.discount_rate,
                'product_discount_price' : format(int(round(product.price - (product.price * product.discount_rate),-2)),'.2f') 
            } for product in ootd.product_set.all()]
        } for ootd in ootds]

        user_count = users.count()
        user_list = [{
            'user_nickname' : user.nickname,
            'user_image' : user.profile_image_url,
            'description' : user.description
        } for user in users]

        return JsonResponse({
            'results' : {
                'brands' : brand_list,
                'product_count' : product_count,
                'products' : product_list,
                'ootd_count' : ootd_count,
                'ootds' : ootd_list,
                'user_count' : user_count,
                'users' : user_list
            }
        }, status=200)
