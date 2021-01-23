import json

from django.test    import Client, TransactionTestCase
from django.urls    import reverse
from django.db      import connection

from product.models import ( 
                        FirstCategory, 
                        SecondCategory, 
                        ThirdCategory, 
                        Product,
                        Brand, 
                        Color, 
                        ProductColor, 
                        Size,
                        ProductSize,
                        ProductImageUrl, 
                        Stock, 
                        ProductOotd
                    )
from ootd.models    import Ootd, OotdImageUrl
from user.models    import Gender, User

class TestProductDetail(TransactionTestCase):
    
    def setUp(self):
        self.client = Client()
        
        FirstCategory.objects.create(name='first')
        SecondCategory.objects.create(name='second', first_category_id=1)
        ThirdCategory.objects.create(name='third', second_category_id=1)
        Brand.objects.create(name='나이키')
        Color.objects.create(name='Black')
        Size.objects.create(name='L')
        Product.objects.create(
            title              = '나이키 반팔티',
            price              = 1000.00,
            model_name         = 'T-1000',
            description        = '상품 설명',
            discount_rate      = 0.10,
            main_image_url     = 'main_image_url.com',
            brand_id           = 1,
            first_category_id  = 1,
            second_category_id = 1,
            third_category_id  = 1
        )
        ProductSize.objects.create(product_id=1, size_id=1)
        ProductColor.objects.create(product_id=1, color_id=1)
        ProductImageUrl.objects.create(product_id=1, image_url='product_image_url1.com')
        ProductImageUrl.objects.create(product_id=1, image_url='product_image_url2.com')
        Stock.objects.create(product_id=1, size_id=1, color_id=1, stock_count=100)
        Gender.objects.create(name='남자')
        User.objects.create(
            login_id          = 'dooly',
            password          = '1q2w3e',
            email             = 'dooly@naver.com',
            gender_id         = 1,
            birth_date        = '2020-01-01',
            nickname          = 'nickname_dooly',
            profile_image_url = 'profile_image_url.com',
            description       = '안녕하세요'
        )
        Ootd.objects.create(description='이쁘다', user_id=1)
        OotdImageUrl.objects.create(image_url='ootd_image_url1.com', ootd_id=1)
        OotdImageUrl.objects.create(image_url='ootd_image_url2.com', ootd_id=1)
        ProductOotd.objects.create(ootd_id=1, product_id=1)

    def tearDown(self):
        with connection.cursor() as cursor:
            cursor.execute('set foreign_key_checks=0')
            cursor.execute('truncate first_categories')
            cursor.execute('truncate second_categories')
            cursor.execute('truncate third_categories')
            cursor.execute('truncate brands')
            cursor.execute('truncate colors')
            cursor.execute('truncate products_colors')
            cursor.execute('truncate sizes')
            cursor.execute('truncate products_sizes')
            cursor.execute('truncate product_image_urls')
            cursor.execute('truncate stocks')
            cursor.execute('truncate products_ootds')
            cursor.execute('truncate users')
            cursor.execute('truncate genders')
            cursor.execute('truncate ootds')
            cursor.execute('truncate ootd_image_urls')
            cursor.execute('set foreign_key_checks=1')
    
    def test_get_product_detail(self):
        url      = reverse('product_detail', args=[1])
        response = self.client.get(url)
        result   = {
            'productId'       : 1,
            'headerTopTitle'  : '나이키 반팔티',
            'headerMiddleImg' : 'main_image_url.com',
            'discount'        : '0.10',
            'originPrice'     : '1000.00',
            'discountPrice'   : '900.00',
            'likeNumber'      : 0,
            'reviewNumber'    : 1,
            'mile'            : 994,
            'colors'          : [
                {
                    'colorId'   : 1,
                    'colorName' : 'Black'
                }
            ],
            'sizes'           : [
                {
                    'sizeId'    : 1,
                    'sizeName'  : 'L'
                }
            ],
            'stocks'          : [
                {
                    'color'     : 'Black',
                    'size'      : 'L',
                    'stock'     : 100
                }
            ],
            'headerBottomBrand'   : '나이키',
            'brand_product_count' : 1,
            'headerBottomImg'     : '',
            'ootd'                : [
                {
                    'author'         : 'nickname_dooly',
                    'authorImg'      : 'profile_image_url.com',
                    'description'    : '이쁘다', 
                    'ootd_image_url' : [
                        'ootd_image_url1.com',
                        'ootd_image_url2.com'
                    ],
                    'like'           : 0,
                    'comment_count'  : 0
                }
            ], 
            'articleProductDetailImgTitle' : '상품 설명',
            'articleProductDetailImg'      : [
                'product_image_url1.com',
                'product_image_url2.com'
            ]
        }
        self.assertEqual(response.status_code, 200)
        self.assertEqual(json.loads(response.content)['product'], result)
