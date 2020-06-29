from django.contrib import admin

# Register your models here.
from marketplace.models import Image, Post, Location, LocationTag

class LocationInline(admin.TabularInline):
  model = LocationTag
  extra = 1

class ImageAdmin(admin.ModelAdmin):
  list_display = ['photographer', 'date_taken']
admin.site.register(Image, ImageAdmin)

class PostAdmin(admin.ModelAdmin):
  list_display = ['price', 'image']
admin.site.register(Post, PostAdmin)

class LocationAdmin(admin.ModelAdmin):
  list_display = ['name']
  inlines = (LocationInline,)
admin.site.register(Location, LocationAdmin)


class LocationTagAdmin(admin.ModelAdmin):
  list_display = ['image','location']
admin.site.register(LocationTag, LocationTagAdmin)
