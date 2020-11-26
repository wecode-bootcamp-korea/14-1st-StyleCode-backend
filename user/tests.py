import json
import jwt
import re
import bcrypt
import pdb

from datetime import datetime
from django.test import TestCase

from stylecode.my_settings import JWT_SECRET_KEY, JWT_ALGORITHM
from .models               import User,Gender

class UserTestCase(TestCase):
    def setUp(self):
        Gender.objects.create(id=1,name="남자")
        self.data = {
            
            "login_id" : "hyunjae",
            "password" : "abc12345!",
            "email"    : "dlqhs1024@naver.com",
            "gender"   : "남자",
            "birth_date" : "2020-11-25",
            "nickname"  : "gracefulPark",
        }

    def tearDown(self):
        pass

    def test_sigh_up_post_success(self):
        response = self.client.post('/user/signup', data =json.dumps(self.data), content_type = 'application/json')
        self.assertEqual(response.status_code, 200)

    def test_login_up_post_success(self):
        response = self.client.post('/user/signup', data =json.dumps(self.data), content_type = 'application/json')
        self.assertEqual(response.status_code, 200)

        data = {
            
            "login_id" : "hyunjae",
            "password" : "abc12345!"
             }
        response =self.client.post('/user/login', data = json.dumps(data), content_type = 'application/json')
        self.assertEqual(response.status_code, 200)
        self.assertIn('token',json.loads(response.content))