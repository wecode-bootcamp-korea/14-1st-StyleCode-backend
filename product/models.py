from django.db import models

class FirstCategory(models.Model):
    name = models.CharField(max_length=15)

    class Meta:
        db_table = 'first_categories'

class SecondCategory(models.Model):
    name           = models.CharField(max_length=15)
    first_category = models.ForeignKey('FirstCategory', on_delete=models.CASCADE)

    class Meta:
        db_table= 'second_categories'

class ThirdCategory(models.Model):
    name            = models.CharField(max_length=15)
    second_category = models.ForeignKey('SecondCategory', on_delete=models.CASCADE)

    class Meta:
        db_table = 'third_categories'

class Brand(models.Model):
    name            = models.CharField(max_length=30)
    brand_image_url = models.URLField(max_length=300, null=True)

    class Meta:
        db_table = 'brands'

class Color(models.Model):
    name = models.CharField(max_length=20)

    class Meta:
        db_table = 'colors'

class ProductColor(models.Model):
    product = models.ForeignKey('Product', on_delete=models.CASCADE)
    color   = models.ForeignKey('Color', on_delete=models.CASCADE)

    class Meta:
        db_table = 'products_colors'

class Size(models.Model):
    name = models.CharField(max_length=10)

    class Meta:
        db_table = 'sizes'

class ProductSize(models.Model):
    size    = models.ForeignKey('Size', on_delete=models.CASCADE)
    product = models.ForeignKey('Product', on_delete=models.CASCADE)

    class Meta:
        db_table = 'products_sizes'

class ProductImageUrl(models.Model):
    image_url = models.URLField(max_length=300)
    product   = models.ForeignKey('Product', on_delete=models.CASCADE)

    class Meta:
        db_table = 'product_image_urls'

class Stock(models.Model):
    stock_count = models.IntegerField()
    product     = models.ForeignKey('Product', on_delete=models.CASCADE)
    size        = models.ForeignKey('Size' , on_delete=models.CASCADE)
    color       = models.ForeignKey('Color', on_delete=models.CASCADE)

    class Meta:
        db_table = 'stocks'

class Product(models.Model):
    title           = models.CharField(max_length=45)
    price           = models.IntegerField()
    model_name      = models.CharField(max_length=45)
    description     = models.TextField()
    discount_rate   = models.DecimalField(max_digits=3, decimal_places=2, null= True)
    sales           = models.IntegerField(default=0)
    brand           = models.ForeignKey('Brand' , on_delete=models.CASCADE)
    color           = models.ManyToManyField('Color', through='ProductColor')
    size            = models.ManyToManyField('Size', through='ProductSize')
    cart            = models.ForeignKey('cart.Cart', on_delete=models.CASCADE, null=True, related_name='cart_product')
    second_category = models.ForeignKey('SecondCategory', on_delete=models.CASCADE)
    third_category  = models.ForeignKey('ThirdCategory', on_delete=models.CASCADE)
    ootd            = models.ManyToManyField('ootd.Ootd', through='ProductOotd')

    class Meta:
        db_table = 'products'


class ProductOotd(models.Model):
    ootd    = models.ForeignKey('ootd.Ootd', on_delete=models.CASCADE)
    product = models.ForeignKey('Product', on_delete=models.CASCADE)

    class Meta:
        db_table = 'products_ootds'
