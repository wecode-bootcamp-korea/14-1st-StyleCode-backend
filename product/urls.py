from django.urls import path
from .views      import ProductDetailView, ProductListView

urlpatterns = [
    path('/<int:product_id>', ProductDetailView.as_view()),
    path('/category/<int:first_category_id>', ProductListView.as_view())
]
