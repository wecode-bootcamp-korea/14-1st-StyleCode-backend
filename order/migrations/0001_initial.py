from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        ('user', '0001_initial'),
        ('cart', '0001_initial'),
    ]

    operations = [
        migrations.CreateModel(
            name='Order',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('address', models.CharField(max_length=50)),
                ('order_number', models.CharField(max_length=20)),
                ('orderer_name', models.CharField(max_length=10)),
                ('orderer_phone_number', models.CharField(max_length=20)),
                ('orderer_email', models.EmailField(max_length=254)),
                ('recipient_name', models.CharField(max_length=10)),
                ('recipient_phone_number', models.CharField(max_length=20)),
                ('self_request', models.CharField(max_length=50, null=True)),
                ('coupon', models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, to='cart.coupon')),
            ],
            options={
                'db_table': 'orders',
            },
        ),
        migrations.CreateModel(
            name='OrderRequest',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('request', models.CharField(max_length=50, null=True)),
            ],
            options={
                'db_table': 'order_requests',
            },
        ),
        migrations.CreateModel(
            name='OrderStatus',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('order_status', models.CharField(max_length=30)),
            ],
            options={
                'db_table': 'order_statuses',
            },
        ),
        migrations.CreateModel(
            name='ShippingCompany',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=20)),
            ],
            options={
                'db_table': 'shipping_companies',
            },
        ),
        migrations.CreateModel(
            name='ShippingNumber',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('shipping_number', models.CharField(max_length=50)),
                ('order', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='order.order')),
                ('shipping_company', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='order.shippingcompany')),
            ],
            options={
                'db_table': 'shipping_numbers',
            },
        ),
        migrations.CreateModel(
            name='OrdererInformation',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('orderer_name', models.CharField(max_length=10)),
                ('orderer_email', models.EmailField(max_length=254)),
                ('orderer_phone_number', models.CharField(max_length=20)),
                ('user', models.OneToOneField(on_delete=django.db.models.deletion.CASCADE, to='user.user')),
            ],
            options={
                'db_table': 'order_informations',
            },
        ),
        migrations.AddField(
            model_name='order',
            name='order_request',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, to='order.orderrequest'),
        ),
        migrations.AddField(
            model_name='order',
            name='order_status',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, to='order.orderstatus'),
        ),
        migrations.AddField(
            model_name='order',
            name='user',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='user.user'),
        ),
    ]
