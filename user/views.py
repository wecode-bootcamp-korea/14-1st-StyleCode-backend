import json, jwt, re, bcrypt

from django.http           import JsonResponse
from django.views          import View

from stylecode.my_settings import JWT_SECRET_KEY, JWT_ALGORITHM
from .models               import User
from .utils                import Login_decorator

class SignUpView(View):
    def post(self, request):
        try:
            data      = json.loads(request.body)
            login_id  = data['login_id']
            password  = data['password']
            email     = data['email']
            profile_image_url = data.get('profile_image_url', None)

            id_pattern = '[a-z0-9]'
            email_pattern = '[a-zA-Z0-9_-]+@[a-z]+.[a-z]+'
            password_pattern = '[A-Za-z0-9]'

            if not re.search(id_pattern, login_id) or len(login_id) > 30 or len(login_id)< 3:
                return JsonResponse ({'message':'INVALID_ID'}, status=400)
            if not re.match(email_pattern, email):
                return JsonResponse ({'message':'INVALID_EMAIL'}, status=400)
            if not re.search(password_pattern, password) or len(password) > 16 or len(password) < 8:
                return JsonResponse ({'message':'INVALID_PASSWORD'}, status=400)

            if User.objects.filter(login_id=login_id).exists():
                return JsonResponse ({'message':'EXIST_EMAIL'}, status=400)
            if User.objects.filter(email=email).exists():
                return JsonResponse ({'message':'EXIST_EMAIL'}, status=400)
            if User.objects.filter(nickname=data['nickname']).exists():
                return JsonResponse ({'message':'EXIST_NICKNAME'}, status=400)

            hashed_password = bcrypt.hashpw(password.encode('utf-8'), bcrypt.gensalt()).decode('utf-8')

            user = User.objects.create(
                login_id          = login_id,
                password          = hashed_password,
                nickname          = data['nickname'],
                email             = email,
                gender_id         = 1 if data['gender']=='남자' else 2,
                birth_date        = data['birth_date'],
                profile_image_url = profile_image_url,
            )
            user.coupon.add(1)
            return JsonResponse ({'message':'SUCCESS'}, status=200)
        except KeyError:
            return JsonResponse({'message':'INVALID_KEYS'}, status=400)

class LogInView(View):
    def post(self, request):
        try:
            data     = json.loads(request.body)
            login_id = data['login_id']
            password = data['password']
            user     = User.objects.get(login_id=login_id)

            if bcrypt.checkpw(password.encode('utf-8'), user.password.encode('utf-8')):
                token = jwt.encode({'login_id':login_id}, JWT_SECRET_KEY, algorithm=JWT_ALGORITHM).decode('utf-8')

                return JsonResponse({'token':token}, status=200)
            return JsonResponse({'message':'INVALID_PASSWORD'}, status=400)
        except KeyError:
            return JsonResponse({'message':'INVALID_ID'}, status=400)
        except User.DoesNotExist:
            return JsonResponse({'message':'USER_DOES_NOT_EXIST'}, status=400)

class ProfileView(View):
    @Login_decorator
    def get(self, request):
        try :
            user = request.user

            user_info = {
                'nickname'          : user.nickname,
                'gender_id'         : user.gender_id,
                'birth_date'        : user.birth_date,
                'country'           : user.country,
                'website_url'       : user.website_url,
                'description'       : user.description,
                'profile_image_url' : user.profile_image_url,
            }
            return JsonResponse ({'user_info:': user_info}, status=200)
        except KeyError:
            return JsonResponse({'message':'INVALID_KEYS'}, status=400)

    @Login_decorator
    def put(self, request):
        try:
            data = json.loads(request.body)
            user = request.user

            if 'country' in data:
                user.country = data['country']
            if 'gender_id' in data:
                user.gender_id = 1 if data['gender'] == "남자" else 2 ,
            if 'birth_date' in data:
                user.birth_date = data['birth_date']
            if 'website_url' in data:
                user.website_url = data['website_url']
            if 'description' in data:
                user.description =data['description']
            if 'profile_image_url' in data:
                user.profile_image_url = data['profile_image_url']
            user.save()

            return JsonResponse({'message':'SUCCESS'}, status=200)
        except KeyError:
            return JsonResponse({'message':'INVALID_KEY'}, status=400)
