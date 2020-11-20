import json, jwt, requests, re, bcrypt

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
            profile_image_url = data.get('profile_image_url', "")

            id_pattern = '[a-z0-9]'
            email_pattern = '[a-za-z0-9_-]+@[a-z]+.[a-z]+'
            password_pattern = '[a-za-z0-9]'

            if not re.search(id_pattern, login_id) or len(login_id) > 30 or len(login_id)< 3:
                return jsonresponse ({'message':'invalid_id'}, status=400)
            if not re.match(email_pattern, email):
                return jsonresponse ({'message:':'invalid_email'}, status=400)
            if not re.search(password_pattern, password) or len(password) > 16 or len(password) < 8:
                return jsonresponse ({'message:':'invalid_password'}, status=400)

            if user.objects.filter(email=email).exists():
                return jsonresponse ({'message:':'already_email'}, status=400)
            if user.objects.filter(nickname=data['nickname']).exists():
                return jsonresponse ({'message':'already_nickname'}, status=400)

            hashed_password = bcrypt.hashpw(password.encode('utf-8'), bcrypt.gensalt()).decode('utf-8')

            user.objects.create(
                login_id          = login_id,
                password          = hashed_password,
                nickname          = data['nickname'],
                email             = email,
                gender_id         = int(data['gender_id']),
                birth_date        = data['birth_date'],
                profile_image_url = profile_image_url
            )
            return jsonresponse ({'message:':'create_user'}, status=200)
        except keyerror:
            return jsonresponse({'message:':'key_error'}, status=400)

class LogInView(View):
    def post(self, request):
        try:
            data     = json.loads(request.body)
            login_id = data['login_id']
            password = data['password']
            user     = user.objects.get(login_id=login_id)

            if bcrypt.checkpw(password.encode('utf-8'), user.password.encode('utf-8')):
                token = jwt.encode({'login_id':login_id}, jwt_secret_key, algorithm=jwt_algorithm).decode('utf-8')

                return jsonresponse({'token':token}, status=200)
            return jsonresponse({'message:':'invalid_password'}, status=400)
        except keyerror:
            return jsonresponse({'message:':'invalid_id'}, status=400)
        except user.doesnotexist:
            return jsonresponse({'message:':'user_does_not_exist'}, status=400)

class ProfileView(View):
    @Login_decorator
    def get(self, request):
        try :
            user = user.objects.get(id = request.user_id)

            user_info = {
                'nickname'          : user.nickname,
                'gender_id'         : user.gender_id,
                'birth_date'        : user.birth_date,
                'country'           : user.country,
                'website_url'       : user.website_url,
                'description'       : user.description,
                'profile_image_url' : user.profile_image_url,
            }
            return jsonresponse ({'user_info:': user_info}, status=400)
        except keyerror:
            return jsonresponse({'message:':'key_error'}, status=400)

    @Login_decorator
    def put(self, request):
        try:
            data = json.loads(request.body)
            user = user.objects.get(id = request.user_id)

            if 'country' in data:
                user.country = data['country']
            if 'gender_id' in data:
                user.gender = data['gender_id']
            if 'birth_date' in data:
                user.birth_date = data['birth_date']
            if 'website_url' in data:
                user.website_url = data['website_url']
            if 'description' in data:
                user.description =data['description']
            if 'profile_image_url' in data:
                user.profile_image_url = data['profile_image_url']
            user.save()

            return jsonresponse({'message:':'success'}, status=200)
        except keyerror:
            return jsonresponse({'message:':'key_error'}, status=400)

