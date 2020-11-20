import json

from django.http import JsonResponse
from django.views import View

from .models  import(
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
    )

class FirstCategoryView(View):
    def get(self, request):
        try:
            data            = json.loads(request.body)
            first_category  = FirstCategory.objects.get(id=data['id'])
            second_category = SecondCategory.objects.get(id=data['id'])
            third_category  = ThirdCategory.objects.get(id=data['id'])

            if first_category:
                first_category_list =[{
                    'brand'          : product.brand.name,
                    'title'          : product.title,
                    'price'          : product.price,
                    'discount_rate'  : product.discount_rate,
                    'main_image_url' : product.main_image_url,
                    'discount_price' : product.price * product.discount_rate
                    }for product in first_category]

                return JsonResponse({'message:':'SUCCESS', 'first_category':first_category_list}, status=200)
        except Product.DoesNotExist:
            return JsonResponse({'message:':'PRODUCT_DOES_NOT_EXIST'}, status=400)

class SecondCategoryView(View):
    def get(self, request):
        try:
            data            = json.loads(request.body)
            second_category = SecondCategory.objects.get(id=data['id'])

            if second_category:
                second_category_list =[{
                    'brand'          : product.brand.name,
                    'title'          : product.title,
                    'price'          : product.price,
                    'discount_rate'  : product.discount_rate,
                    'main_image_url' : product.main_image_url,
                    'discount_price' : product.price * product.discount_rate
                    }for product in second_category]
            return JsonResponse({'message:':'PRODUCT_DOES_NOT_EXIST'}, status=400)

        except Product.DoesNotExist:
            return JsonResponse({'message:':'PRODUCT_DOES_NOT_EXIST'}, status=400)

class SecondCategoryView(View):
    def get(self, request):
        try:
            data            = json.loads(request.body)
            third_category  = ThirdCategory.objects.get(id=data['id'])

            if third_category:
                third_category_list=[{
                    'brand'          : product.brand.name,
                    'title'          : product.title,
                    'price'          : product.price,
                    'discount_rate'  : product.discount_rate,
                    'main_image_url' : product.main_image_url,
                    'discount_price' : product.price * product.discount_rate
                    }for product in third_category]

                return JsonResponse({'message:':'SUCCESS', 'third_category':third_category_list}, status=200)

        except Product.DoesNotExist:
            return JsonResponse({'message:':'PRODUCT_DOES_NOT_EXIST'}, status=400)
