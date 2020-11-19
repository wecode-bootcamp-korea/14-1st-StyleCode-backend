import json, jwt, requests, re, bcrypt

from django.http  import JsonResponse
from django.views import View

from stylecode.my_settings  import JWT_SECRET_KEY, JWT_ALGORITHM
from .models      import User
from .utils       import Login_decorator

class SignUpView(View):
    def post(self, request):
        try:
            data      = json.loads(request.body)
            password  = data['password']
            email     = data['email']
            profile_image_url = data.get('profile_image_url', "")

            email_pattern = '[a-zA-Z0-9_-]+@[a-z]+.[a-z]+'
            password_pattern = '[A-Za-z0-9]'


            if not re.match(email_pattern, email):
                return JsonResponse ({'message:':'INVALID_EMAIL'}, status=400)
            if not re.search(password_pattern, password) or len(password) > 16 or len(password) < 8:
                return JsonResponse ({'message:':'INVALID_PASSWORD'}, status=400)

            if User.objects.filter(email=email).exists():
                return JsonResponse ({'message:':'ALREADY_EMAIL'}, status=400)
            if User.objects.filter(nickname=data['nickname']).exists():
                return JsonResponse ({'message':'ALREADY_NICKNAME'}, status=400)

            hashed_password = bcrypt.hashpw(password.encode('utf-8'), bcrypt.gensalt()).decode('utf-8')

            User.objects.create(
                login_id          = data['login_id'],
                password          = hashed_password,
                nickname          = data['nickname'],
                email             = email,
                gender_id         = data['gender_id'],
                birth_date        = data['birth_date'],
                profile_image_url = profile_image_url
            )
            return JsonResponse ({'message:':'CREATE_USER'}, status=200)
        except KeyError:
            return JsonResponse({'message:':'KEY_ERROR'}, status=400)

class IdCheckView(View):
    def post(self, request):
        data       = json.loads(request.body)
        try:
            login_id   = data.get('login_id')
            id_pattern = '[a-z0-9]'

            if not re.search(id_pattern, login_id) or len(login_id) > 30 or len(login_id) < 3:
                return JsonResponse ({'message':'INVALID_ID'}, status=400)
            if User.objects.filter(login_id=login_id).exists():
                return JsonResponse ({'message:':'INVALID_ID'}, status=400)
            return JsonResponse({'message:':'SUCCESS'}, status=200)
        except KeyError:
            return JsonResponse({'message:':'KEY_ERROR'}, status=400)

class LogInView(View):
    def post(self, request):
        try:
            data     = json.loads(request.body)
            email    = data['email']
            password = data['password']
            user     = User.objects.get(email=email)

            if bcrypt.checkpw(password.encode('utf-8'), user.password.encode('utf-8')):
                token = jwt.encode({'email':email}, JWT_SECRET_KEY, algorithm=JWT_ALGORITHM).decode('utf-8')

                return JsonResponse({'token':token}, status=200)
            return JsonResponse({'message:':'INVALID_PASSWORD'}, status=400)
        except KeyError:
            return JsonResponse({'message:':'INVALID_ID'}, status=400)
        except User.DoesNotExist:
            return JsonResponse({'message:':'USER_DOES_NOT_EXIST'}, status=400)


