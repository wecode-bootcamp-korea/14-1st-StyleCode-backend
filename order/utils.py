from user.models import User
from django.utils import timezone
from order.models import Order

def coupon_check(user):
    coupons = user.coupon.all()
    for coupon in coupons:
        if coupon.limit_period and coupon.limit_period < timezone.now():
            coupon.delete()
    
    return coupons

def order_number_create():
    if Order.objects.count():
        id = Order.objects.all().last().id + 1
    else:
        id = 1
    return timezone.now().strftime('%Y%m%d') + str(id).zfill(10)
