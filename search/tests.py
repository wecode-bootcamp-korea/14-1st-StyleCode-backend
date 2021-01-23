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
        self.url    = reverse('search')
        
        FirstCategory.objects.create(name='first')
        SecondCategory.objects.create(name='second', first_category_id=1)
        ThirdCategory.objects.create(name='third', second_category_id=1)
        Brand.objects.create(name='나이키', image_url='brand_image_url.com')
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
            description       = '안녕하세요 나이키를 사랑합니다.'
        )
        User.objects.create(
            login_id          = 'douner',
            password          = '1q2w3e',
            email             = 'douner@naver.com',
            gender_id         = 1,
            birth_date        = '2020-01-01',
            nickname          = 'douner는 나이키를 좋아해',
            profile_image_url = 'profile_image_url2.com',
            description       = '안녕하세요 나이키를 사랑합니다.'
        )
        Ootd.objects.create(description='나이키 이쁘다', user_id=1)
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
            cursor.execute('truncate products')
            cursor.execute('truncate users')
            cursor.execute('truncate genders')
            cursor.execute('truncate ootds')
            cursor.execute('truncate ootd_image_urls')
            cursor.execute('set foreign_key_checks=1')
    
    def test_get_search_keyword_nike(self):
        data     = {'keyword':'나이키'}
        response = self.client.get(self.url, data)
        result   = {
            'brands' : [
                {
                    'brand_name'  : '나이키',
                    'brand_image' : 'brand_image_url.com'
                }
            ],
            'product_count' : 1, 
            'products'      : [
                {
                    'product_title'  : '나이키 반팔티',
                    'product_brand'  : '나이키', 
                    'product_image'  : 'main_image_url.com',
                    'description'    : '상품 설명',
                    'discount_rate'  : '0.10', 
                    'discount_price' : '900.00'
                }
            ],
            'ootd_count' : 1,
            'ootds'      : [
                {
                    'author'      : 'nickname_dooly',
                    'ootd_images' : [
                        'ootd_image_url1.com',
                        'ootd_image_url2.com'
                    ],
                    'description'   : '나이키 이쁘다',
                    'like'          : 0,
                    'comment_count' : 0,
                    'ootd_products' : [
                        {
                            'product_title'          : '나이키 반팔티',
                            'product_image'          : 'main_image_url.com',
                            'product_discount_rate'  : '0.10',
                            'product_discount_price' : '900.00'
                        }
                    ]
                }
            ],
            'user_count' : 1,
            'users'      : [
                {
                    'user_nickname' : 'douner는 나이키를 좋아해',
                    'user_image'    : 'profile_image_url2.com',
                    'description'   : '안녕하세요 나이키를 사랑합니다.'
                }
            ] 
        }
        
        self.assertEqual(json.loads(response.content)['results'], result)

    def test_get_search_fail_no_data(self):
        data     = {'keyword':'디올'}
        response = self.client.get(self.url, data)
        result   = {
            'brands'        : [], 
            'product_count' : 0, 
            'products'      : [], 
            'ootd_count'    : 0, 
            'ootds'         : [], 
            'user_count'    : 0, 
            'users'         : []
        }

        self.assertEqual(json.loads(response.content)['results'], result)
    
    def test_get_search_fail_key_error(self):
        response = self.client.get(self.url)
        
        self.assertEqual(json.loads(response.content)['message'], 'KEY_ERROR')

