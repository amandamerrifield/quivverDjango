"""quivver URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/3.0/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.conf import settings
from django.contrib import admin
from django.urls import path
import marketplace.views
from django.conf.urls.static import static

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', marketplace.views.Welcome.as_view(), name='home'),
    path('about/', marketplace.views.About.as_view(), name='about'),
    path('contact/', marketplace.views.Contact.as_view(), name='contact'),
    path('team/', marketplace.views.Team.as_view(), name='team'),
    path('gallery/', marketplace.views.Gallery.as_view(), name='gallery'),
    path('login/', marketplace.views.Login.as_view(), name='login')

] + static(settings.MEDIA_URL, document_root = settings.MEDIA_ROOT)
