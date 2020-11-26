from django.urls import path, include

urlpatterns = [
    path('carts', include('cart.urls')),
    path('search', include('search.urls')),
    path('ootds',include('ootd.urls')),
    path('user', include('user.urls')),
    path('products', include('product.urls')),
    path('orders', include('order.urls'))
]
