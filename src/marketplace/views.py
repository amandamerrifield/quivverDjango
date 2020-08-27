from django.shortcuts import render
from django.views.generic.list import ListView
# Create your views here.
from django.views.generic import TemplateView

from marketplace.models import Image


class Welcome(TemplateView):
    template_name = "jinja2/home.html"


class About(TemplateView):
    template_name = "jinja2/about.html"


class Team(TemplateView):
    template_name = 'jinja2/team.html'


class Contact(TemplateView):
    template_name = 'jinja2/contact.html'


class Gallery(ListView):
    template_name = 'jinja2/gallery.html'
    model = Image
    paginate_by = 10


class Login(TemplateView):
    template_name = 'jinja2/login.html'