from datetime import datetime
import json
import pdb

from django.test import TestCase, Client

from user.models import User,Gender
from ootd.models      import (
        OotdImageUrl,
        Tag,
        OotdTag,
        Ootd,
        Like,
        Comment,
        Follow
    )

# Create your tests here.
class OotdDetailTestCase(TestCase):
    def setUp(self):
        Gender.objects.create(id = 1, name='남자')
        User.objects.create(id= 1,
         login_id= 'dummy93',
         password= '1234',
            email= 'dummy93@naver.com',
         nickname= 'dummyname93',
        gender_id= 1,
        birth_date = "2020-10-24"
        )
        Ootd.objects.create(
            id= 1,
            description = '커피 중독자',
            user_id = 1

        )
        self.client = Client()
    def tearDown(self):
        pass
    
    def test_ootd_detail_post_success(self):
        response = self.clientget('/ootd/register', content_type='application/json')

    def test_ootd_detail_get_success(self):
        response = self.client.get('/ootd/1',content_type='application/json')

        self.assertEqual(response.json(),{
            'author': 'dummyname93',
            'authorImg': None,
            'commentNum': 0,
            'comments': [],
            'contentImg': [],
            'datetime': datetime.now().strftime("%Y-%m-%d %H:%M:%S") ,
            'description': '커피 중독자',
            'follower': 0,
            'introdution': None,
            'price': [],
            'productImg': [],
            'productName': [],
            'sale': [],
            'tagsName': []
        })
        self.assertEqual(response.status_code, 200)

class OotdListTestCase(TestCase):
    def setUp(self):
        Gender.objects.create(id = 1, name='남자')
        User.objects.create(id= 1,
         login_id= 'dummy93',
         password= '1234',
            email= 'dummy93@naver.com',
         nickname= 'dummyname93',
        gender_id= 1,
        birth_date = "2020-10-24"
        )
        Ootd.objects.create(
            id= 1,
            description = '커피 중독자',
            user_id = 1
        )
        Ootd.objects.create(
            id= 2,
            description = '커피 중독자',
            user_id = 1
        )
        Ootd.objects.create(
            id= 3,
            description = '커피 중독자',
            user_id = 1
        )
        self.client = Client()
        
    def tearDown(self):
        pass
  
    def test_ootd_detail_get_success(self):
        response = self.client.get('/ootd/list',content_type='application/json')

        self.assertEqual(response.json(),{"ootd_list" : [
            {
            "contentImg": [],
            "productImg": [],
            "productName": [],
            "price": [],
            "sale": [],
            "authorImg": None,
            "author": "dummyname93",
            "tagsName": [],
            "datetime": datetime.now().strftime("%Y-%m-%d %H:%M:%S"),
            "description": "커피 중독자",
            "follower": 0,
            "commentNum": 0,
            "comments": []
        },
         {
            "contentImg": [],
            "productImg": [],
            "productName": [],
            "price": [],
            "sale": [],
            "authorImg": None,
            "author": "dummyname93",
            "tagsName": [],
            "datetime": datetime.now().strftime("%Y-%m-%d %H:%M:%S"),
            "description": "커피 중독자",
            "follower": 0,
            "commentNum": 0,
            "comments": []
        },
        {
            "contentImg": [],
            "productImg": [],
            "productName": [],
            "price": [],
            "sale": [],
            "authorImg": None,
            "author": "dummyname93",
            "tagsName": [],
            "datetime": datetime.now().strftime("%Y-%m-%d %H:%M:%S"),
            "description": "커피 중독자",
            "follower": 0,
            "commentNum": 0,
            "comments": []
        }
        
        ]})
        self.assertEqual(response.status_code, 200)


