# Generated by Django 2.2.6 on 2020-04-23 10:10

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('API', '0013_proveedor_status'),
    ]

    operations = [
        migrations.AlterField(
            model_name='proveedor',
            name='status',
            field=models.CharField(choices=[('Activo', 'Activo'), ('No activo', 'No activo')], default='Activo', max_length=10),
        ),
    ]
