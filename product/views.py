import json

from django.http      import JsonResponse
from django.views     import View
from django.db.models import Q

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

class CategoryView(View):
    def get(self, request):
        try:
            sort               = request.GET.get('sort', '0')
            first_category_id  = request.GET.get('first')
            second_category_id = request.GET.get('second')
            third_category_id  = request.GET.get('third')
            products           = Product.objects.filter(
                Q(first_category_id=first_category_id)|
                Q(second_category_id=second_category_id)|
                Q(third_category_id=third_category_id)
            ).select_related('third_category','second_category','second_category__first_category','brand')

            if sort :

                sort_type = {
                    '0' : '-created_at',
                    '1' : '-sales_product',
                    '2' : '-discount_rate',
                    '3' : 'price',
                    '4' : '-price'
                }
                sorting =[
                {   'id' : 0,
                   'name' : '최신순'},
                {   'id' : 1,
                  'name' : '인기순'},
                {   'id' : 2,
                  'name' : '할인율순'},
                {   'id' : 3,
                  'name' : '가격 낮은순'},
                {   'id' : 4,
                  'name' : '가격 높은순'}
                ]

            if first_category_id:
                first_category_list =[{
                    'brand'          : product.brand.name,
                    'title'          : product.title,
                    'price'          : product.price,
                    'discount_rate'  : product.discount_rate,
                    'main_image_url' : product.main_image_url,
                    'discount_price' :format(int(round(product.price - (product.price * product.discount_rate),-2)),'.2f')
                    }for product in products.order_by(sort_type[sort])]

                return JsonResponse({'message:':'SUCCESS', 'first_category':first_category_list, 'sorting':sorting}, status=200)

            if second_category_id:
                second_category_list =[{
                    'brand'          : product.brand.name,
                    'title'          : product.title,
                    'price'          : product.price,
                    'discount_rate'  : product.discount_rate,
                    'main_image_url' : product.main_image_url,
                    'discount_price' :format(int(round(product.price - (product.price * product.discount_rate),-2)),'.2f')
                    }for product in products.order_by(sort_type[sort])]

                return JsonResponse({'message:':'SUCCESS', 'second_category':second_category_list, 'sorting':sorting}, status=200)

            if third_category_id:
                third_category_list =[{
                    'brand'          : product.brand.name,
                    'title'          : product.title,
                    'price'          : product.price,
                    'discount_rate'  : product.discount_rate,
                    'main_image_url' : product.main_image_url,
                    'discount_price' :format(int(round(product.price - (product.price * product.discount_rate),-2)),'.2f')
                    }for product in products.order_by(sort_type[sort])]

                return JsonResponse({'message:':'SUCCESS', 'third_category':third_category_list, 'sorting':sorting}, status=200)

        except Product.DoesNotExist:
            return JsonResponse({'message:':'PRODUCT_DOES_NOT_EXIST'}, status=400)

