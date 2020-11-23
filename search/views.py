import json

from djagno.http import JsonResponse
from django.views import View

class Search(View):
    def get(request):
        key_word = request.GET.get()
        

