from django.test import TestCase, Client
import json

from .models import User

client = Client()

class UserTestCase(TestCase):
    def test_user(self):
        data = {
        "login_id"   : "gustjr88" ,
        "password"   : "dfa231s2334" ,
        "nickname"   : "nickname22" ,
        "email"      : "we22c2@we.com",
        "gender_id"  : "여자" ,
        "birth_date" : "2000-02-22"
        }

        response = client.post('/user/signup', json.dumps(data), content_type= 'application/json')

        self.assertEqual(response.status_code, 200)
        self.assertEqual(response.json(),{
            "message:":"SUCCESS" })

