import jwt, json
from django.http           import JsonResponse

from .models               import User
from stylecode.my_settings import JWT_SECRET_KEY,JWT_ALGORITHM

def Login_decorator(func):
    def wrapper(self, request, *args, **kwargs):
        try:
            token        = request.headers.get('Authorization', None)
            payload      = jwt.decode(token, JWT_SECRET_KEY, algorithm = JWT_ALGORITHM)
            user         = User.objects.get(login_id=payload['login_id'])
            request.user = user

        except jwt.exceptions.DecodeError:
            return JsonResponse ({'message':'Invalid token'}, status=400)
        except User.DoesNotExist:
            return JsonResponse ({'message':'Invalid user'}, status=400)

        return func(self, request, *args, **kwargs)
    return wrapper




