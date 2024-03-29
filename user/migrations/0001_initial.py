from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        ('cart', '0001_initial'),
        ('ootd', '0001_initial'),
        ('product', '0001_initial'),
    ]

    operations = [
        migrations.CreateModel(
            name='Gender',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=10)),
            ],
            options={
                'db_table': 'genders',
            },
        ),
        migrations.CreateModel(
            name='User',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('login_id', models.CharField(max_length=20)),
                ('password', models.CharField(max_length=150)),
                ('email', models.EmailField(max_length=254)),
                ('birth_date', models.DateField()),
                ('nickname', models.CharField(max_length=20)),
                ('profile_image_url', models.URLField(null=True)),
                ('description', models.TextField(null=True)),
                ('country', models.CharField(max_length=20, null=True)),
                ('website_url', models.URLField(null=True)),
                ('address', models.CharField(max_length=50, null=True)),
                ('point', models.IntegerField(default=0)),
                ('cart', models.ManyToManyField(through='cart.Cart', to='product.Product')),
                ('coupon', models.ManyToManyField(through='cart.UserCoupon', to='cart.Coupon')),
                ('follow', models.ManyToManyField(related_name='_user_follow_+', through='ootd.Follow', to='user.User')),
                ('gender', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='user.gender')),
                ('ootd_like', models.ManyToManyField(related_name='like_user', through='ootd.Like', to='ootd.Ootd')),
            ],
            options={
                'db_table': 'users',
            },
        ),
    ]
