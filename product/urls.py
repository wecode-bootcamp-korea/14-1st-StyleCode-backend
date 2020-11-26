from django.urls import path
from .views      import ProductDetail, CategoryView, ProductView, MdChoiceView

urlpatterns = [
    path('/<int:product_id>', ProductDetail.as_view()),
    path('', ProductView.as_view()),
    path('/mdchoice/<int:mdchoice>', MdChoiceView.as_view()),
    path('/categorys', CategoryView.as_view()),
]
