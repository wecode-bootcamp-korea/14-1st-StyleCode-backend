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
                                   return JsonResponse ({'message':' 




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

