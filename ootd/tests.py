from datetime import datetime
import json
import ipdb
from django.http import response

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
        user_data = {
         "login_id" : 'dummy93',
         "password" : 'abc12345!',
         "email" : 'dummy93@naver.com',
         "nickname" : 'dummyname93',
        "gender" : "남자",
        "birth_date": "2020-10-24"
        }

        response = self.client.post('/user/signup', data =json.dumps(user_data), content_type = 'application/json')
        self.assertEqual(response.status_code, 200)

        data = {
            "login_id" : "dummy93",
            "password" : "abc12345!"
        }
        response =self.client.post('/user/login', data = json.dumps(data), content_type = 'application/json')
        self.assertEqual(response.status_code, 200)
        self.access_token =json.loads(response.content)['token']
        self.header = {'HTTP_Authorization' : self.access_token}
    def tearDown(self):
        pass
    
    def test_ootd_detail_post_success(self):
        data = {
            'description' : '초능력 맛 좀 볼래?',
            'image_list'  : []
        }
        response = self.client.post('/ootds',data = json.dumps(data),content_type='application/json', **self.header)
        self.assertEqual(response.status_code, 200)

    def test_ootd_detail_get_success(self):
        data = {
            'description' : '초능력 맛 좀 볼래?',
            'image_list'  : []
        }
        response = self.client.post('/ootds',data = json.dumps(data),content_type='application/json', **self.header)
        self.assertEqual(response.status_code, 200)
        
        response = self.client.get('/ootds/1',content_type='application/json')

        self.assertEqual(response.json(),{
            'author': 'dummyname93',
            'authorImg': None,
            'commentNum': 0,
            'comments': [],
            'contentImg': [],
            'datetime': datetime.now().strftime("%Y-%m-%d %H:%M:%S") ,
            'description': '초능력 맛 좀 볼래?',
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
        gender = Gender.objects.create(name='남자')
        user = User.objects.create(
         login_id= 'dummy93',
         password= '1234',
         email= 'dummy93@naver.com',
         nickname= 'dummy93',
         gender= gender,
         birth_date = "2020-10-24"
        )
        Ootd.objects.create(
            id = 1,
            description = '커피 중독자',
            user = user
        )
        Ootd.objects.create(
            id = 2,
            description = '커피 중독자',
            user = user
        )
        Ootd.objects.create(
            id = 3,
            description = '커피 중독자',
            user = user
        )
        
    def tearDown(self):
        pass
  
    def test_ootd_detail_get_success(self):
        response = self.client.get('/ootds?offset=0&limit=3',content_type='application/json')
        self.assertEqual(response.json(),{"ootd_list" : [
            {
            "id" : 1,
            "contentImg": [],
            "productImg": [],
            "productName": [],
            "price": [],
            "sale": [],
            "authorImg": None,
            "author": "dummy93",
            "tagsName": [],
            "datetime": datetime.now().strftime("%Y-%m-%d %H:%M:%S"),
            "description": "커피 중독자",
            "follower": 0,
            "commentNum": 0,
            "comments": []
        },
         {
             "id" : 2,
            "contentImg": [],
            "productImg": [],
            "productName": [],
            "price": [],
            "sale": [],
            "authorImg": None,
            "author": "dummy93",
            "tagsName": [],
            "datetime": datetime.now().strftime("%Y-%m-%d %H:%M:%S"),
            "description": "커피 중독자",
            "follower": 0,
            "commentNum": 0,
            "comments": []
        },
        {
            "id" : 3,
            "contentImg": [],
            "productImg": [],
            "productName": [],
            "price": [],
            "sale": [],
            "authorImg": None,
            "author": "dummy93",
            "tagsName": [],
            "datetime": datetime.now().strftime("%Y-%m-%d %H:%M:%S"),
            "description": "커피 중독자",
            "follower": 0,
            "commentNum": 0,
            "comments": []
        }
        ]})
        
        self.assertEqual(response.status_code, 200)
