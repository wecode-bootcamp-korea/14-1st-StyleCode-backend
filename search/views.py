import json

from djagno.http import JsonResponse
from django.views import View
from django.db.models import Q

class Search(View):
    def get(request):
        key_word = request.GET.get()
        


