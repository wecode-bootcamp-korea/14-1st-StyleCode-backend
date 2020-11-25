from django.db import models

class OrderStatus(models.Model):
    order_status = models.CharField(max_length=30)

    class Meta:
        db_table = 'order_statuses'

class OrderRequest(models.Model):
    request      = models.CharField(max_length=50, null=True)

    class Meta:
        db_table = 'order_requests'

class OrdererInformation(models.Model):
    orderer_name         = models.CharField(max_length=10)
    orderer_email        = models.EmailField()
    orderer_phone_number = models.CharField(max_length=20)
    user                 = models.OneToOneField('user.User', on_delete=models.CASCADE)

    class Meta:
        db_table = 'order_informations'

class ShippingCompany(models.Model):
    name = models.CharField(max_length=20)

    class Meta:
        db_table = 'shipping_companies'

class ShippingNumber(models.Model):
    shipping_number  = models.CharField(max_length=50)
    order            = models.ForeignKey('Order', on_delete=models.CASCADE)
    shipping_company = models.ForeignKey('ShippingCompany', on_delete=models.CASCADE)

    class Meta:
        db_table = 'shipping_numbers'

class Order(models.Model):
    address                = models.CharField(max_length=50)
    order_number           = models.CharField(max_length=20)
    orderer_name           = models.CharField(max_length=10)
    orderer_phone_number   = models.CharField(max_length=20)
    orderer_email          = models.EmailField()
    recipient_name         = models.CharField(max_length=10)
    recipient_phone_number = models.CharField(max_length=20)
    user                   = models.ForeignKey('user.User', on_delete=models.CASCADE)
    coupon                 = models.ForeignKey('cart.Coupon', on_delete=models.CASCADE)
    order_status           = models.ForeignKey('OrderStatus', on_delete=models.CASCADE)
    order_request          = models.ForeignKey('OrderRequest', on_delete=models.CASCADE)
    self_request           = models.CharField(max_length=50, null=True)

    class Meta:
        db_table = 'orders'

