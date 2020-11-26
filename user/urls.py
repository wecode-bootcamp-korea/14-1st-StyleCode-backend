from django.urls import path

from .views      import SignUpView, LogInView, ProfileView

urlpatterns= [
    path('/signup'  , SignUpView.as_view()),
    path('/login'   , LogInView.as_view()),
    path('/profile' , ProfileView.as_view()),
]
