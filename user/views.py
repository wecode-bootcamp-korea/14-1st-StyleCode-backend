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

            if 
