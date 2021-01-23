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
from cart.models    import Coupon, UserCoupon

class TestProductDetail(TransactionTestCase):
    
    def setUp(self):
        self.client   = Client()
        self.cart_url = reverse('cart')

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
        Coupon.objects.create(name='신규쿠폰')
        user_data = { 
            'login_id'   : 'dooly',
            'password'   : '1q2w3e4r',
            'email'      : 'dooly@naver.com',
            'gender'     : '남자',
            'birth_date' : '2020-01-01',
            'nickname'   : 'nickname_dooly',
        }
        response = self.client.post(
            '/user/signup',
            user_data,
            content_type='application/json'
        )
        self.assertEqual(response.status_code, 200)

        login_data = {
            'login_id' : 'dooly',
            'password' : '1q2w3e4r'
        }

        response = self.client.post(
            '/user/login',
            login_data,
            content_type='application/json'
        )

        self.assertEqual(response.status_code, 200)
        token = json.loads(response.content)['token']
        self.header = {'HTTP_Authorization':token}

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
            cursor.execute('truncate coupons')
            cursor.execute('truncate users_coupons')
            cursor.execute('truncate products_sizes')
            cursor.execute('truncate product_image_urls')
            cursor.execute('truncate stocks')
            cursor.execute('truncate products')
            cursor.execute('truncate users')
            cursor.execute('truncate genders')
            cursor.execute('truncate carts')
            cursor.execute('set foreign_key_checks=1')
   
    def test_create_cart(self):
        data = {
            'product_id' : 1,
            'color_id'   : 1,
            'size_id'    : 1,
            'quantity'   : 1
        }
        
        response = self.client.post(
            self.cart_url,
            data,
            **self.header,
            content_type='application/json'
        )
        
        self.assertEqual(response.status_code, 200)
        self.assertEqual(json.loads(response.content)['message'], 'SUCCESS')

    def test_create_cart_fail_key_error(self):
        data = {
            'product_id' : 1,
            'color_id'   : 1
        }

        response = self.client.post(
            self.cart_url,
            data,
            **self.header,
            content_type='application/json'
        )

        self.assertEqual(response.status_code, 400)
        self.assertEqual(json.loads(response.content)['message'], 'KEY_ERROR')

    def test_create_cart_fail_product_does_not_exist(self):
        data = {
            'product_id' : 100,
            'color_id'   : 1,
            'size_id'    : 1,
            'quantity'   : 1
        }

        response = self.client.post(
            self.cart_url,
            data,
            **self.header,
            content_type='application/json'
        )

        self.assertEqual(response.status_code, 404)
        self.assertEqual(json.loads(response.content)['message'], 'PRODUCT_DOES_NOT_EXISTS')

    def test_get_cart(self):
        data = {
            'product_id' : 1,
            'color_id'   : 1,
            'size_id'    : 1,
            'quantity'   : 1
        }
        
        response = self.client.post(
            self.cart_url,
            data,
            **self.header,
            content_type='application/json'
        )
        
        self.assertEqual(response.status_code, 200)

        response = self.client.get(
            self.cart_url,
            **self.header
        )
        result = [
            {
                'cart_id'        : 1, 
                'product'        : '나이키 반팔티', 
                'product_image'  : 'main_image_url.com', 
                'color'          : 'Black', 
                'size'           : 'L', 
                'quantity'       : 1, 
                'product_price'  : '1000.00',
                'discount_price' : 900,
                'shipping_fee'   : 2500
            }
        ] 
        
        self.assertEqual(response.status_code, 200)
        self.assertEqual(json.loads(response.content)['product'], result)

    def test_get_cart_is_null(self):
        response = self.client.get(
            self.cart_url,
            **self.header
        )

        self.assertEqual(response.status_code, 200)
        self.assertEqual(json.loads(response.content)['product'], [])

    def test_update_cart(self):
        data = {
            'product_id' : 1,
            'color_id'   : 1,
            'size_id'    : 1,
            'quantity'   : 1
        }
        
        response = self.client.post(
            self.cart_url,
            data,
            **self.header,
            content_type='application/json'
        )
        
        self.assertEqual(response.status_code, 200)

        detail_url  = reverse('cart_detail', args=[1])
        data        = {
            'quantity' : 3
        }

        response = self.client.post(
            detail_url,
            data,
            **self.header,
            content_type='application/json'
        )

        self.assertEqual(response.status_code, 200)
        self.assertEqual(json.loads(response.content)['message'], 'SUCCESS')

        response = self.client.get(
            self.cart_url,
            **self.header
        )
        result = [
            {
                'cart_id': 1, 
                'product': '나이키 반팔티', 
                'product_image': 'main_image_url.com', 
                'color': 'Black', 
                'size': 'L', 
                'quantity': 3, 
                'product_price': '1000.00',
                'discount_price': 900,
                'shipping_fee': 2500
            }
        ] 
        
        self.assertEqual(response.status_code, 200)
        self.assertEqual(json.loads(response.content)['product'], result)
    
    def test_update_cart_fail_cart_does_not_exist(self):
        data = {
            'product_id' : 1,
            'color_id'   : 1,
            'size_id'    : 1,
            'quantity'   : 1
        }
        
        response = self.client.post(
            self.cart_url,
            data,
            **self.header,
            content_type='application/json'
        )
        
        self.assertEqual(response.status_code, 200)

        detail_url  = reverse('cart_detail', args=[100])
        data        = {
            'quantity' : 1
        }

        response = self.client.post(
            detail_url,
            data,
            **self.header,
            content_type='application/json'
        )

        self.assertEqual(response.status_code, 404)
        self.assertEqual(json.loads(response.content)['message'], 'CART_DOES_NOT_EXISTS')

    def test_update_cart_fail_key_error(self):
        data = {
            'product_id' : 1,
            'color_id'   : 1,
            'size_id'    : 1,
            'quantity'   : 1
        }
        
        response = self.client.post(
            self.cart_url,
            data,
            **self.header,
            content_type='application/json'
        )
        
        self.assertEqual(response.status_code, 200)

        detail_url  = reverse('cart_detail', args=[1])
        data        = {
        }

        response = self.client.post(
            detail_url,
            data,
            **self.header,
            content_type='application/json'
        )
        
        self.assertEqual(response.status_code, 400)
        self.assertEqual(json.loads(response.content)['message'], 'KEY_ERROR')

    def test_update_cart_fail_invalid_key(self):
        data = {
            'product_id' : 1,
            'color_id'   : 1,
            'size_id'    : 1,
            'quantity'   : 1
        }
        
        response = self.client.post(
            self.cart_url,
            data,
            **self.header,
            content_type='application/json'
        )
        
        self.assertEqual(response.status_code, 200)

        detail_url  = reverse('cart_detail', args=[1])
        data        = {
            'quantity' : '1'
        }

        response = self.client.post(
            detail_url,
            data,
            **self.header,
            content_type='application/json'
        )
        
        self.assertEqual(response.status_code, 400)
        self.assertEqual(json.loads(response.content)['message'], 'BAD_REQUEST')

    def test_delete_cart(self):
        data = {
            'product_id' : 1,
            'color_id'   : 1,
            'size_id'    : 1,
            'quantity'   : 1
        }
        
        response = self.client.post(
            self.cart_url,
            data,
            **self.header,
            content_type='application/json'
        )
        
        self.assertEqual(response.status_code, 200)

        detail_url  = reverse('cart_detail', args=[1])
        
        response = self.client.delete(
            detail_url,
            **self.header
        )

        self.assertEqual(response.status_code, 200)
        self.assertEqual(json.loads(response.content)['message'], 'SUCCESS')
        
    def test_delete_cart_fail_cart_does_not_exist(self):
        data = {
            'product_id' : 1,
            'color_id'   : 1,
            'size_id'    : 1,
            'quantity'   : 1
        }
        
        response = self.client.post(
            self.cart_url,
            data,
            **self.header,
            content_type='application/json'
        )
        
        self.assertEqual(response.status_code, 200)

        detail_url  = reverse('cart_detail', args=[100])
        
        response = self.client.delete(
            detail_url,
            **self.header
        )

        self.assertEqual(response.status_code, 404)
        self.assertEqual(json.loads(response.content)['message'], 'CART_DOES_NOT_EXISTS')
 
