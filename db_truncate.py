import os
import sys

import django

os.environ.setdefault("DJANGO_SETTINGS_MODULE", "stylecode.settings")

django.setup()

from django.db import connection

with connection.cursor() as cursor:
    cursor.execute('set foreign_key_checks=0')
    cursor.execute('truncate brands')
    cursor.execute('truncate carts')
    cursor.execute('truncate colors')
    cursor.execute('truncate comments')
    cursor.execute('truncate coupons')
    cursor.execute('truncate first_categories')
    cursor.execute('truncate likes')
    cursor.execute('truncate ootd_follow')
    cursor.execute('truncate ootd_image_urls')
    cursor.execute('truncate ootds')
    cursor.execute('truncate ootds_tags')
    cursor.execute('truncate order_informations')
    cursor.execute('truncate order_requests')
    cursor.execute('truncate order_statuses')
    cursor.execute('truncate orders')
    cursor.execute('truncate product_image_urls')
    cursor.execute('truncate products')
    cursor.execute('truncate products_colors')
    cursor.execute('truncate products_ootds')
    cursor.execute('truncate products_sizes')
    cursor.execute('truncate second_categories')
    cursor.execute('truncate shipping_companies')
    cursor.execute('truncate shipping_numbers')
    cursor.execute('truncate sizes')
    cursor.execute('truncate stocks')
    cursor.execute('truncate tags')
    cursor.execute('truncate third_categories')
    cursor.execute('truncate genders')
    cursor.execute('truncate users')
    cursor.execute('truncate users_coupons')
    cursor.execute('set foreign_key_checks=1')

print('데이터 베이스 초기화가 완료되었습니다.')
