from user.models import User
from django.utils import timezone

def coupon_check(user):
    coupons = user.coupon.all()
    for coupon in coupons:
        if coupon.limit_period and coupon.limit_period < timezone.now():
            coupon.delete()
    
    return coupons
