from django.db import models

class Cart(models.Model):
    quantity = models.IntegerField()
    product  = models.ForeignKey('product.Product', on_delete=models.CASCADE, related_name='product_cart')
    user     = models.ForeignKey('user.User', on_delete=models.CASCADE)
    order    = models.ForeignKey('order.Order', on_delete=models.CASCADE, null=True)

    class Meta:
        db_table = 'carts'

class Coupon(models.Model):
    name          = models.CharField(max_length=20)
    discount_cost = models.IntegerField(null=True)
    discount_rate = models.DecimalField(max_digits=3, decimal_places=2, null=True)

    class Meta:
        db_table = 'coupons'

class UserCoupon(models.Model):
    user   = models.ForeignKey('user.User', on_delete=models.CASCADE)
    coupon = models.ForeignKey('Coupon', on_delete=models.CASCADE)

    class Meta:
        db_table = 'users_coupons'
