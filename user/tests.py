import json, bcrypt

from django.test import TestCase, Client

from user.models import User, Gender
from unittest.mock import patch, MagicMock

class UserSignUp(TestCase):
    def setUp(self):

        Gender.objects.create(
            name= "남자"
        )

        User.objects.create(
            login_id = 'gustjr11',
            password = 'gustjr11',
            nickname = 'gustjr11',
            email = 'gustjr@we.com',
            gender_id = 1,
            birth_date = '2000-02-22'
        )

    def tearDown(self):
        User.objects.all().delete()

    def test_sigup_success(self):
        client = Client()
        user = {
            'login_id' : 'gustjr111',
            'password' : 'gustjr111',
            'nickname' : 'gustjr111',
            'email' : 'gustjr1@we.com',
            'gender': '남자',
            'birth_date' : '2000-02-22'
        }
        response = client.post('/users/signup', json.dumps(user), content_type='application/json')
        self.assertEqual(response.status_code, 200)
        self.assertEqual(response.json),{
                'message': 'SUCCESS'
            }

    def test_sigup_ID_Overlap(self):

        client = Client()
        user = {
            'login_id' : 'gusgggggggggggggggggggggggggggggggtjr111',
            'password' : 'gustjr1111',
            'nickname' : 'gustjr1111',
            'email' : 'gustjr11@we.com',
            'gender': '남자',
            'birth_date' : '2000-02-22'
        }
        response = client.post('/users/signup', json.dumps(user), content_type='application/json')
        self.assertEqual(response.status_code, 400)
        self.assertEqual(response.json),{
                'message': 'INVALID_ID'
            }

    def test_sigup_NoEmail(self):

        client = Client()
        user = {
            'login_id' : 'gustjr1211',
            'password' : 'gustjr1121',
            'nickname' : 'gustjr1121',
            'gender': '남자',
            'birth_date' : '2000-02-22'
        }
        response = client.post('/users/signup', json.dumps(user), content_type='application/json')
        self.assertEqual(response.status_code, 400)

    def test_sigup_PassWord_Overlap(self):

        client = Client()
        user = {
            'login_id' : 'gustjr2111',
            'password' : 'gusdkfjeaksjdj3tjr111',
            'nickname' : 'gustjr1411',
            'email' : 'gustj4r1@we.com',
            'gender': '남자',
            'birth_date' : '2000-02-22'
        }
        response = client.post('/users/signup', json.dumps(user), content_type='application/json')
        self.assertEqual(response.status_code, 400)
