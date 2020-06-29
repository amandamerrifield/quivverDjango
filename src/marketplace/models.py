from django.db import models
from django.contrib.auth.models import User
# Create your models here.
class Image(models.Model):
    file = models.ImageField()
    date_taken = models.DateTimeField()
    description = models.TextField()
    photographer = models.ForeignKey(User, on_delete=models.PROTECT)
    def __str__(self): return self.file.name + self.photographer.first_name + self.photographer.last_name

class Post(models.Model):
    price = models.DecimalField(decimal_places=2, max_digits=10)
    image = models.ForeignKey(Image, on_delete=models.PROTECT)




class Location(models.Model):
    name = models.TextField()
    images = models.ManyToManyField(Image, related_name='locations', through='LocationTag')


class LocationTag(models.Model):
    location = models.ForeignKey(Location, on_delete=models.CASCADE)
    image = models.ForeignKey(Image, on_delete=models.CASCADE)
