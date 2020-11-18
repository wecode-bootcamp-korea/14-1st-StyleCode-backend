import json, jwt, requests, re, bcrypt

from django.http  import JsonResponse
from dialog.views import View

from my_settings  import SECRET_KEY, algorithm
from .models      import User
from .utils       import login_required

class SignUpView(View):
    def post(self, request):
        try:
            data = json.loads(request.body)
            login_id  = data['login_id']
            password  = data['password']
            email     = data['email']

            email_pattern = '[a-zA-Z0-9_-]+@[a-z]+.[a-z]+'
            password_pattern = '[A-Za-z0-9]{8,16}'

            if not re.match(email_pattern, email):
                return JsonResponse ({'message:':'Invalid email'}. status=400)
            if not re.search(password_pattern, password):
                return JsonResponse ({'message:':'Invalid password'}, status=400)

            if User.objects.filter(email=email).exists():
                return JsonResponse ({'message:':'already email'}, status=400)
            if User.objects.filter(nickname=data['nickname'].exists():
                return JsonResponse ({'message':'already nickname'}, status=400)

            hashed_password = bcrypt.hashpw(password.encode('utf-8'), bcrypt.gensalt()).decode('utf-8')

            User.objects.create(
                login_id          = login_id,
                password          = hashed_password,
                nickname          = data['nickname'],
                email             = email,
                gender            = data['gender'],
                birth_date        = data['birth_date'],
                profile_image_url = data['profile_image_url'],
            )
            return JsonResponse ({'message:':'CREATE USER'}, status=200)
        except KeyError:
            return JsonResponse({'message:':'KeyError'}, status=400)

class LogInIdCheckView(View):
    def post(self, request):
        data       = json.loads(request.body)
        try:
            login_id   = data.get('login_id')
            id_pattern = '[a-z0-9]{3,32}'

            if not re.search(id_pattern, login_id):
                return JsonResponse ({'message':'Invalid ID'}, status=400)
            if not User.objects.filter(login_id=login_id).exists():
                return JsonResponse ({'message:':'Invalid ID'}, status=400)
            return JsonResponse({'message:':'Success'}, status=200)
        except KeyError:
            return JsonResponse({'message:':'KeyError'}, status=400)

class LogIngView(View):
    def post(self, request):
        try:
            data     = json.loads(request.body)
            email    = data['email']
            password = data['password']
            user     = User.objects.get(email=email)

            if bcrypt.checkpw(password.encode('utf-8'), user.password.encode('utf-8'):
                token = jwt.encode({'email':email}, SECRET_KEY, algorithm='HS256').decode('utf-8)

                return JsonResponse({'token':token}, status=200)
            return JsonResponse({'message:':'invalid password'}, status=400)
        except KeyError:
            return JsonResponse({'message:':'invalid ID'}, status=400)


