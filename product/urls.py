from django.urls import path
from .views      import ProductView, MdChoiceView


urlpatterns= [
    path('/products', ProductView.as_view()),
    path('/mdchoice', MdChoiceView.as_view()),

]

