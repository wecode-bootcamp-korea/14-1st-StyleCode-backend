import json
import decimal

from django.views    import View
from django.db.models import F
from django.http     import JsonResponse

from product.models  import Product, FirstCategory

class ProductDetailView(View):
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

class ProductListView(View):
    def get(self, request, first_category_id):
        sort = request.GET.get('sort', '0')
        second_category_id = request.GET.get('second')
        third_category_id = request.GET.get('third')

        if not FirstCategory.objects.filter(id=first_category_id).exists():
            return JsonResponse({'message':'KEY_ERROR'}, status=400)

        if second_category_id and third_category_id:
            products = Product.objects.filter(
                first_category_id=first_category_id,
                second_category_id=second_category_id,
                third_category_id=third_category_id
            )
        elif second_category_id:
            products = Product.objects.filter(
                first_category_id=first_category_id,
                second_category_id=second_category_id
            ) 
        else:
            products = Product.objects.filter(first_category_id=first_category_id)


        sort_type = {
            '0' : '-created_at',
            '1' : '-sales_product',
            '2' : '-discount_rate',
            '3' : 'discount_price',
            '4' : '-discount_price'
        }

        sorting = [
            {
                'id' : 0,
                'name' : '최신순'
            },{
                'id' : 1,
                'name' : '인기순'
            },{
                'id' : 2,
                'name' : '할인율'
            },{
                'id' : 3,
                'name' : '가격 낮은순'
            },{
                'id' : 4,
                'name' : '가격 높은순'
            }
        ]

        product_list = [{
                'brand' : product.brand.name,
                'title' : product.title,
                'price' : product.price,
                'discount_rate' : product.discount_rate,
                'main_image_url' : product.main_image_url,
                'discount_price' : format(int(round(product.discount_price,-2)),'.2f')
        } for product in products.annotate(discount_price=F('price') - (F('price') * F('discount_rate'))).order_by(sort_type[sort])]
        
        return JsonResponse({'product_list':product_list, 'sorting':sorting}, status=200)
