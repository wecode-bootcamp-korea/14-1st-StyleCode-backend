from django.urls import path
from .views      import ProductView, MdChoiceView, CategoryView


urlpatterns= [
    path('/products', ProductView.as_view()),
    path('/mdchoice', MdChoiceView.as_view()),
    path('/categorys', CategoryView.as_view()),

]

