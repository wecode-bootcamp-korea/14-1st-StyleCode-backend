from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        ('ootd', '0001_initial'),
    ]

    operations = [
        migrations.CreateModel(
            name='Brand',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=30)),
                ('image_url', models.URLField()),
            ],
            options={
                'db_table': 'brands',
            },
        ),
        migrations.CreateModel(
            name='Color',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=20)),
            ],
            options={
                'db_table': 'colors',
            },
        ),
        migrations.CreateModel(
            name='FirstCategory',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=15)),
            ],
            options={
                'db_table': 'first_categories',
            },
        ),
        migrations.CreateModel(
            name='Product',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('title', models.CharField(max_length=45)),
                ('price', models.DecimalField(decimal_places=2, max_digits=10)),
                ('model_name', models.CharField(max_length=45)),
                ('description', models.TextField()),
                ('discount_rate', models.DecimalField(decimal_places=2, max_digits=3, null=True)),
                ('sales_product', models.IntegerField(default=0)),
                ('created_at', models.DateTimeField(auto_now_add=True)),
                ('main_image_url', models.URLField()),
                ('like', models.IntegerField(default=0)),
                ('sales_product', models.IntegerField(default=0)),
                ('brand', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='product.brand')),
            ],
            options={
                'db_table': 'products',
            },
        ),
        migrations.CreateModel(
            name='SecondCategory',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=15)),
                ('first_category', models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, to='product.firstcategory')),
            ],
            options={
                'db_table': 'second_categories',
            },
        ),
        migrations.CreateModel(
            name='Size',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=10)),
            ],
            options={
                'db_table': 'sizes',
            },
        ),
        migrations.CreateModel(
            name='ThirdCategory',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=15)),
                ('second_category', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='product.secondcategory')),
            ],
            options={
                'db_table': 'third_categories',
            },
        ),
        migrations.CreateModel(
            name='Stock',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('stock_count', models.IntegerField()),
                ('color', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='product.color')),
                ('product', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='product.product')),
                ('size', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='product.size')),
            ],
            options={
                'db_table': 'stocks',
            },
        ),
        migrations.CreateModel(
            name='ProductSize',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('product', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='product.product')),
                ('size', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='product.size')),
            ],
            options={
                'db_table': 'products_sizes',
            },
        ),
        migrations.CreateModel(
            name='ProductOotd',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('ootd', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='ootd.ootd')),
                ('product', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='product.product')),
            ],
            options={
                'db_table': 'products_ootds',
            },
        ),
        migrations.CreateModel(
            name='ProductImageUrl',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('image_url', models.URLField(max_length=300)),
                ('product', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='product.product')),
            ],
            options={
                'db_table': 'product_image_urls',
            },
        ),
        migrations.CreateModel(
            name='ProductColor',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('color', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='product.color')),
                ('product', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='product.product')),
            ],
            options={
                'db_table': 'products_colors',
            },
        ),
        migrations.AddField(
            model_name='product',
            name='color',
            field=models.ManyToManyField(through='product.ProductColor', to='product.Color'),
        ),
        migrations.AddField(
            model_name='product',
            name='first_category',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='product.firstcategory'),
        ),
        migrations.AddField(
            model_name='product',
            name='ootd',
            field=models.ManyToManyField(through='product.ProductOotd', to='ootd.Ootd'),
        ),
        migrations.AddField(
            model_name='product',
            name='second_category',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='product.secondcategory'),
        ),
        migrations.AddField(
            model_name='product',
            name='size',
            field=models.ManyToManyField(through='product.ProductSize', to='product.Size'),
        ),
        migrations.AddField(
            model_name='product',
            name='third_category',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='product.thirdcategory'),
        ),
    ]
