from django.urls import path
from .views      import CategoryView, MdChoiceView


urlpatterns= [
    path('/category', CategoryView.as_view()),
    path('/mdchoice', MdChoiceView.as_view()),

]

