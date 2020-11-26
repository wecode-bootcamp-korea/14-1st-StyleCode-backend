from django.urls import path

from .views      import ProductDetailView, CategoryView, ProductView, MdChoiceView

urlpatterns = [
    path('/<int:product_id>', ProductDetailView.as_view()),
    path('', ProductView.as_view()),
    path('/mdchoice/<int:mdchoice>', MdChoiceView.as_view()),
    path('/categorys', CategoryView.as_view()),
]
