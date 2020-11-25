from django.urls import path, include

urlpatterns = [
    path('carts', include('cart.urls')),
    path('ootds',include('ootd.urls')),
    path('users', include('user.urls')),
    path('products', include('product.urls'))
]
