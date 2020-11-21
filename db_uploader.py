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

csv_path = './csv_data/genders.csv'
with open(csv_path) as csv_file:
    rows = csv.reader(csv_file, delimiter=',')
    next(rows)
    for row in rows:
        Gender.objects.create(name=row[0])

csv_path = './csv_data/users.csv'
with open(csv_path) as csv_file:
    rows = csv.reader(csv_file, delimiter=',')
    next(rows)
    for row in rows:
        User.objects.create(login_id=row[0], password=row[1], email=row[2], gender_id=row[3], birth_date=row[4], nickname=row[5], profile_image_url=row[6],description=row[7], country=row[8], website_url=row[9])

csv_path = './csv_data/first_categoies.csv'
with open(csv_path) as csv_file:
    rows = csv.reader(csv_file, delimiter=',')
    next(rows)
    for row in rows:
        FirstCategory.objects.create(name=row[0])

csv_path = './csv_data/second_categories.csv'
with open(csv_path) as csv_file:
    rows = csv.reader(csv_file, delimiter=',')
    next(rows)
    for row in rows:
        SecondCategory.objects.create(name=row[0], first_category_id=row[1])

csv_path = './csv_data/third_categories.csv'
with open(csv_path) as csv_file:
    rows = csv.reader(csv_file, delimiter=',')
    next(rows)
    for row in rows:
        ThirdCategory.objects.create(name=row[0], second_category_id=row[1])
        
csv_path = './csv_data/brands.csv'
with open(csv_path) as csv_file:
    rows = csv.reader(csv_file, delimiter=',')
    next(rows)
    for row in rows:
        Brand.objects.create(name=row[0], image_url=row[1])

csv_path = './csv_data/products.csv'
with open(csv_path) as csv_file:
    rows = csv.reader(csv_file, delimiter=',')
    next(rows)
    for row in rows:
        Product.objects.create(title=row[0],price=row[1],model_name=row[2], description=row[3], discount_rate=row[4], sales_product=row[5], brand_id=row[6], second_category_id=row[7], third_category_id=row[8], main_image_url=row[9], like=row[10], first_category_id=row[11])

csv_path = './csv_data/colors.csv'
with open(csv_path) as csv_file:
    rows = csv.reader(csv_file, delimiter=',')
    next(rows)
    for row in rows:
        Color.objects.create(name=row[0])

csv_path = './csv_data/product_colors.csv'
with open(csv_path) as csv_file:
    rows = csv.reader(csv_file, delimiter=',')
    next(rows)
    for row in rows:
        ProductColor.objects.create(product_id=row[0], color_id=row[1]
)

csv_path = './csv_data/sizes.csv'
with open(csv_path) as csv_file:
    rows = csv.reader(csv_file, delimiter=',')
    next(rows)
    for row in rows:
        Size.objects.create(name=row[0])

csv_path = './csv_data/product_sizes.csv'
with open(csv_path) as csv_file:
    rows = csv.reader(csv_file, delimiter=',')
    next(rows)
    for row in rows:
        ProductSize.objects.create(product_id=row[0], size_id=row[1])

csv_path = './csv_data/product_image_urls.csv'
with open(csv_path) as csv_file:
    rows = csv.reader(csv_file, delimiter=',')
    next(rows)
    for row in rows:
        ProductImageUrl.objects.create(product_id=row[0], image_url=row[1])

csv_path = './csv_data/stocks.csv'
with open(csv_path) as csv_file:
    rows = csv.reader(csv_file, delimiter=',')
    next(rows)
    for row in rows:
        Stock.objects.create(product_id=row[0], size_id=row[1], color_id=row[2], stock_count=row[3])

csv_path = './csv_data/coupons.csv'
with open(csv_path) as csv_file:
    rows = csv.reader(csv_file, delimiter=',')
    next(rows)
    for row in rows:
        if row[0] == '':
            row[0] = None
        if row[1] == '':
            row[1] = None
        if row[2] == '':
            row[2] = None
        if row[3] == '':
            row[3] = None
        if row[4] == '':
            row[4] = None
        Coupon.objects.create(name=row[0], discount_cost=row[1], discount_rate=row[2], limit_price=row[3], limit_period=row[4])

csv_path = './csv_data/users_coupons.csv'
with open(csv_path) as csv_file:
    rows = csv.reader(csv_file, delimiter=',')
    next(rows)
    for row in rows:
        UserCoupon.objects.create(user_id=row[0], coupon_id=row[1])

csv_path = './csv_data/ootds.csv'
with open(csv_path) as csv_file:
    rows = csv.reader(csv_file, delimiter=',')
    next(rows)
    for row in rows:
        Ootd.objects.create(user_id=row[0], description=row[1])

csv_path = './csv_data/products_ootds.csv'
with open(csv_path) as csv_file:
    rows = csv.reader(csv_file, delimiter=',')
    next(rows)
    for row in rows:
        ProductOotd.objects.create(product_id=row[0], ootd_id=row[1])

csv_path = './csv_data/tags.csv'
with open(csv_path) as csv_file:
    rows = csv.reader(csv_file, delimiter=',')
    next(rows)
    for row in rows:
        Tag.objects.create(tag_name=row[0])

csv_path = './csv_data/ootds_tags.csv'
with open(csv_path) as csv_file:
    rows = csv.reader(csv_file, delimiter=',')
    next(rows)
    for row in rows:
        OotdTag.objects.create(ootd_id=row[0], tag_id=row[1])

csv_path = './csv_data/ootd_image_urls.csv'
with open(csv_path) as csv_file:
    rows = csv.reader(csv_file, delimiter=',')
    next(rows)
    for row in rows:
        OotdImageUrl.objects.create(ootd_id=row[0], image_url=row[1])


csv_path = './csv_data/likes.csv'
with open(csv_path) as csv_file:
    rows = csv.reader(csv_file, delimiter=',')
    next(rows)
    for row in rows:
        Like.objects.create(ootd_id=row[0], user_id=row[1])

csv_path = './csv_data/comments.csv'
with open(csv_path) as csv_file:
    rows = csv.reader(csv_file, delimiter=',')
    next(rows)
    for row in rows:
        if row[3] == '':
            row[3] = None
        Comment.objects.create(user_id=row[0], ootd_id=row[1], content=row[2], parent_id=row[3])

csv_path = './csv_data/follows.csv'
with open(csv_path) as csv_file:
    rows = csv.reader(csv_file, delimiter=',')
    next(rows)
    for row in rows:
        Follow.objects.create(follower_id=row[0], followee_id=row[1])

print('데이터베이스에 데이터를 추가하였습니다.')
