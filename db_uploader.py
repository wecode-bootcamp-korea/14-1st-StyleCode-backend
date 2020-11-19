import os
import sys
import csv

import django

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'stylecode.settings')

django.setup()

from cart.models import Cart, Coupon, UserCoupon
from ootd.models import Tag, OotdTag, Ootd, OotdImageUrl, Like, Comment, Follow
from order.models import OrderStatus, OrderRequest, OrdererInformation, ShippingCompany, ShippingNumber, Order
from product.models import FirstCategory, SecondCategory, ThirdCategory, Brand, Color, ProductColor, Size, ProductSize, ProductImageUrl, Stock, Product, ProductOotd
from user.models import User, Gender

csv_path_genders = './csv_data/genders.csv'
with open(csv_path_genders) as csv_file:
    rows = csv.reader(csv_file, delimiter=',')
    next(rows)
    for row in rows:
        Gender.objects.create(name=row[0])

csv_path_users = './csv_data/users.csv'
with open(csv_path_users) as csv_file:
    rows = csv.reader(csv_file, delimiter=',')
    next(rows)
    for row in rows:
        User.objects.create(login_id=row[0], password=row[1], email=row[2], gender_id=row[3], birth_date=row[4], nickname=row[5], profile_image_url=row[6],description=row[7], country=row[8], website_url=row[9])


