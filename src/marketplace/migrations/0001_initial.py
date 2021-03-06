# Generated by Django 2.2 on 2020-06-28 23:26

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.CreateModel(
            name='Image',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('file', models.ImageField(upload_to='')),
                ('date_taken', models.DateTimeField()),
                ('description', models.TextField()),
                ('photographer', models.ForeignKey(on_delete=django.db.models.deletion.PROTECT, to=settings.AUTH_USER_MODEL)),
            ],
        ),
        migrations.CreateModel(
            name='Location',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.TextField()),
            ],
        ),
        migrations.CreateModel(
            name='Post',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('price', models.DecimalField(decimal_places=2, max_digits=10)),
                ('image', models.ForeignKey(on_delete=django.db.models.deletion.PROTECT, to='marketplace.Image')),
            ],
        ),
        migrations.CreateModel(
            name='LocationTag',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('image', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='marketplace.Image')),
                ('location', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='marketplace.Location')),
            ],
        ),
        migrations.AddField(
            model_name='location',
            name='images',
            field=models.ManyToManyField(related_name='locations', through='marketplace.LocationTag', to='marketplace.Image'),
        ),
    ]
