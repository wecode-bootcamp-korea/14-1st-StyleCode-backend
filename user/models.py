from django.db import models

class User(models.Model):
    login_id          = models.CharField(max_length=20)
    password          = models.CharField(max_length=150)
    email             = models.EmailField()
    gender            = models.CharField(max_length=10)
    birth_date        = models.DateField()
    nickname          = models.CharField(max_length=20)
    profile_image_url = models.URLField(max_length=200, null=True)
    description       = models.TextField(null=True)
    country           = models.CharField(max_length=20, null=True)
    website_url       = models.URLField(max_length=200, null=True)
    address           = models.CharField(max_length=50, null=True)
    coupon            = models.ManyToManyField('cart.Coupon', through='cart.UserCoupon')
    ootd_like         = models.ManyToManyField('ootd.Ootd', through='ootd.Like', related_name='like_user')
    follow            = models.ManyToManyField('self', through='ootd.Follow')
    cart              = models.ManyToManyField('product.Product', through='cart.Cart')

    class Meta:
        db_table = 'users'


