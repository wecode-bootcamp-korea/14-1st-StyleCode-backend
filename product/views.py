import json
import decimal

from django.views    import View
from django.http     import JsonResponse
from django.db.models import Q

from product.models  import(
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

class ProductDetail(View):
    def get(self, request, product_id):
        if not Product.objects.filter(id=product_id).exists():
            return JsonResponse({'message':'PRODUCT_NOT_FOUND'}, status=404)

        product = Product.objects.select_related('brand').prefetch_related(
            'brand__product_set',
            'ootd',
            'ootd__like_user',
            'ootd__comment_set',
            'ootd__user',
            'ootd__ootdimageurl_set',
            'color',
            'size',
            'stock_set',
            'stock_set__color',
            'stock_set__size',
            'productimageurl_set'
        ).get(id=product_id)

        return JsonResponse({
            'product' : {
                'headerTopTitle'  : product.title,
                'headerMiddleImg' : product.main_image_url,
                'discount'        : product.discount_rate,
                'originPrice'     : product.price,
                'discountPrice'   : format(int(round(product.price - (product.price * product.discount_rate),-2)),'.2f'),
                'likeNumber'      : product.like,
                'reviewNumber'    : product.ootd.count(),
                'mile'            : int(product.price - (product.price * product.discount_rate) * decimal.Decimal(0.05)),
                'colors'          : [color.name for color in product.color.all()],
                'sizes'           : [size.name for size in product.size.all()],
                'stocks'          : [{
                    'color' : stock.color.name,
                    'size'  : stock.size.name,
                    'stock' : stock.stock_count
                } for stock in product.stock_set.all()],
                'headerBottomBrand'   : product.brand.name,
                'brand_product_count' : product.brand.product_set.count(),
                'headerBottomImg'     : product.brand.image_url,
                'ootd'                : [{
                    'author'            : ootd.user.nickname,
                    'authorImg'         : ootd.user.profile_image_url,
                    'description'       : ootd.description,
                    'ootd_image_url'    : [image.image_url for image in ootd.ootdimageurl_set.all()],
                    'like'              : ootd.like_user.count(),
                    'comment_count'     : ootd.comment_set.count()
                } for ootd in product.ootd.all()],
                'articleProductDetailImgTitle' : product.description,
                'articleProductDetailImg'      : [image.image_url for image in product.productimageurl_set.all()]
            }
        }, status=200)

class CategoryView(View):
    def get(self, request):
        try:
            first_categories = FirstCategory.objects.prefetch_related('secondcategory_set__thirdcategory_set')
            print (first_categories)
            categories = [{
                'id'   : first_category.id,
                'name' : first_category.name,
                'second_category' : [{
                    'id'   : second_category.id,
                    'name' : second_category.name,
                    'third_category': [{
                        'id'   : third_category.id,
                        'name' : third_category.name,
                    }for third_category in second_category.thirdcategory_set.all()]
                }for second_category in first_category.secondcategory_set.all()]
            }for first_category in first_categories]

            return JsonResponse({ 'message:':'SUCCESS', 'categories':categories}, status=200)
        except Category.DoesNotExist :
            return JsonResponse({'message:':'INVALID_CATEGORY'}, status=400)


class ProductView(View):
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

                return JsonResponse({'message:':'SUCCESS', 'first_category_list':first_category_list, 'sorting':sorting}, status=200)

            if second_category_id:
                second_category_list =[{
                    'brand'          : product.brand.name,
                    'title'          : product.title,
                    'price'          : product.price,
                    'discount_rate'  : product.discount_rate,
                    'main_image_url' : product.main_image_url,
                    'discount_price' :format(int(round(product.price - (product.price * product.discount_rate),-2)),'.2f')
                    }for product in products.order_by(sort_type[sort])]

                return JsonResponse({'message:':'SUCCESS', 'second_category_list':second_category_list, 'sorting':sorting}, status=200)

            if third_category_id:
                third_category_list =[{
                    'brand'          : product.brand.name,
                    'title'          : product.title,
                    'price'          : product.price,
                    'discount_rate'  : product.discount_rate,
                    'main_image_url' : product.main_image_url,
                    'discount_price' :format(int(round(product.price - (product.price * product.discount_rate),-2)),'.2f')
                    }for product in products.order_by(sort_type[sort])]

                return JsonResponse({'message:':'SUCCESS', 'third_category_list':third_category_list, 'sorting':sorting}, status=200)

        except Product.DoesNotExist:
            return JsonResponse({'message:':'PRODUCT_DOES_NOT_EXIST'}, status=400)

class MdChoiceView(View):
    def get (self,request):
        try :
            products = Product.objects.select_related('third_category','second_category__first_category','brand')

            mdchoice_list = [{
            'id'             : product.id,
            'brand'          : product.brand.name,
            'title'          : product.title,
            'price'          : product.price,
            'discount_rate'  : product.discount_rate,
            'main_image_url' : product.main_image_url,
            'discount_price' : format(int(round(product.price - (product.price * product.discount_rate),-2)),'.2f')
            }for product in products[:24]]

            return JsonResponse({'message:':'SUCCESS', 'mdchoice_list':mdchoice_list}, status=200)
        except Product.DoesNotExist:
            return JsonResponse({'message:':'PRODUCT_DOES_NOT_EXIST'}, status=400)

