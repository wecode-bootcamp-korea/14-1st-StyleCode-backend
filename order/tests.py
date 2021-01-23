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
from cart.models    import Coupon, UserCoupon, Cart
from order.models   import (
                        OrdererInformation, 
                        OrderRequest, 
                        OrderStatus, 
                        Order
                    )

class TestProductDetail(TransactionTestCase):

    def setUp(self):
        self.client = Client()
        self.order_url = reverse('order')

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

        OrdererInformation.objects.create(
            orderer_name         = 'kim',
            orderer_email        = 'kim@naver.com',
            orderer_phone_number = '01011112222',
            user_id              = 1
        )

        OrderRequest.objects.create(request='배송 전에 전화 부탁드립니다.')
        OrderStatus.objects.create(order_status='주문완료')

        cart_url  = reverse('cart')
        data      = {
            'product_id' : 1,
            'color_id'   : 1,
            'size_id'    : 1,
            'quantity'   : 1
        }
        
        response = self.client.post(
            cart_url,
            data,
            **self.header,
            content_type='application/json'
        )
        
        self.assertEqual(response.status_code, 200)

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
            cursor.execute('truncate orders')
            cursor.execute('truncate order_statuses')
            cursor.execute('truncate order_requests')
            cursor.execute('truncate order_informations')
            cursor.execute('set foreign_key_checks=1')
   
    def test_get_order_information(self):
        order_data = {
            "cart_ids" : [1] 
        }
 
        response = self.client.generic(
            method       = 'GET', 
            path         = self.order_url, 
            data         = json.dumps(order_data), 
            content_type = 'application/json', 
            **self.header
        )

        result = {
            'orderer_info' : {
                'orderer_name'         : 'kim', 
                'orderer_email'        : 'kim@naver.com', 
                'orderer_phone_number' : '01011112222'
                }, 
                'address'       : None,
                'order_request' : [
                    {
                        'order_request_id' : 1, 
                        'order_request'    : '배송 전에 전화 부탁드립니다.'
                    }
                ],
                'products' : [
                    {
                        'cart_id'        : 1, 
                        'title'          : '나이키 반팔티', 
                        'price'          : '1000.00',
                        'discount_price' : 900,
                        'size'           : 'L', 
                        'color'          : 'Black',
                        'quantity'       : 1
                    }
                ], 
                'coupon' : [
                    {
                        'coupon_id'   : 1, 
                        'coupon_name' : '신규쿠폰'
                    }
                ],
                'points' : 0
            }

        self.assertEqual(response.status_code, 200)
        self.assertEqual(json.loads(response.content)['order'], result)

    def test_get_order_information_fail_key_error(self):
        order_data = {
        }
 
        response = self.client.generic(
            method       = 'GET', 
            path         = self.order_url, 
            data         = json.dumps(order_data), 
            content_type = 'application/json', 
            **self.header
        )

        self.assertEqual(response.status_code, 400)
        self.assertEqual(json.loads(response.content)['message'], 'KEY_ERROR')

    def test_get_order_information_fail_already_ordered(self):
        Order.objects.create(
            address                = '용암동',
            order_number           = '202001010233',
            orderer_phone_number   ='01022223333',
            orderer_email          = 'kim@nave.com',
            recipient_name         = 'kim',
            recipient_phone_number = '01033334444',
            user_id                = 1
        )
        Cart.objects.create(
            product_id = 1,
            color_id   = 1,
            size_id    = 1,
            quantity   = 1,
            order_id   = 1,
            user_id    = 1
        )

        order_data = {
            "cart_ids" : [2] 
        }
 
        response = self.client.generic(
            method       = 'GET', 
            path         = self.order_url, 
            data         = json.dumps(order_data), 
            content_type = 'application/json', 
            **self.header
        )

        self.assertEqual(response.status_code, 400)
        self.assertEqual(json.loads(response.content)['message'], 'ALREADY_ORDERED')

    def test_create_order(self):
        order_data = {
            'cart_ids'               : [1],
            'orderer_name'           : 'kim',
            'orderer_phone_number'   : '01022223333',
            'orderer_email'          : 'kim@naver.com',
            'orderer_save_check'     : 1,
            'recipient_name'         : 'kim',
            'recipient_phone_number' : '01022223333',
            'address'                : '용암동',
            'address_save_check'     : 1,
            'point'                  : 0,
            'order_request_id'       : 1
        }
        
        response = self.client.post(
            self.order_url,
            order_data,
            **self.header,
            content_type='application/json'
        )
        
        self.assertEqual(response.status_code, 200)
        self.assertEqual(json.loads(response.content)['message'], 'SUCCESS')

    def test_create_order_fail_key_error(self):
        order_data = {
            'cart_ids'               : [1],
            'orderer_name'           : 'kim',
            'orderer_phone_number'   : '01022223333',
            'orderer_email'          : 'kim@naver.com',
            'recipient_name'         : 'kim',
            'recipient_phone_number' : '01022223333',
            'address'                : '용암동',
            'address_save_check'     : 1,
            'point'                  : 0,
            'order_request_id'       : 1
        }
        
        response = self.client.post(
            self.order_url,
            order_data,
            **self.header,
            content_type='application/json'
        )
        
        self.assertEqual(response.status_code, 400)
        self.assertEqual(json.loads(response.content)['message'], 'KEY_ERROR')

    def test_create_order_fail_cart_does_not_exist(self):
        order_data = {
            'cart_ids'               : [110],
            'orderer_name'           : 'kim',
            'orderer_phone_number'   : '01022223333',
            'orderer_email'          : 'kim@naver.com',
            'orderer_save_check'     : 1,
            'recipient_name'         : 'kim',
            'recipient_phone_number' : '01022223333',
            'address'                : '용암동',
            'address_save_check'     : 1,
            'point'                  : 0,
            'order_request_id'       : 1
        }
        
        response = self.client.post(
            self.order_url,
            order_data,
            **self.header,
            content_type='application/json'
        )
        
        self.assertEqual(response.status_code, 404)
        self.assertEqual(json.loads(response.content)['message'], 'CART_DOES_NOT_EXIST')
    
    def test_create_order_fail_already_ordered(self):
        Order.objects.create(
            address                = '용암동',
            order_number           = '202001010233',
            orderer_phone_number   ='01022223333',
            orderer_email          = 'kim@nave.com',
            recipient_name         = 'kim',
            recipient_phone_number = '01033334444',
            user_id                = 1
        )
        Cart.objects.create(
            product_id = 1,
            color_id   = 1,
            size_id    = 1,
            quantity   = 1,
            order_id   = 1,
            user_id    = 1
        )

        order_data = {
            'cart_ids'               : [2],
            'orderer_name'           : 'kim',
            'orderer_phone_number'   : '01022223333',
            'orderer_email'          : 'kim@naver.com',
            'orderer_save_check'     : 1,
            'recipient_name'         : 'kim',
            'recipient_phone_number' : '01022223333',
            'address'                : '용암동',
            'address_save_check'     : 1,
            'point'                  : 0,
            'order_request_id'       : 1
        }


        response = self.client.post(
            self.order_url,
            order_data,
            **self.header,
            content_type='application/json'
        )
        
        self.assertEqual(response.status_code, 400)
        self.assertEqual(json.loads(response.content)['message'], 'ALREADY_ORDERED')
