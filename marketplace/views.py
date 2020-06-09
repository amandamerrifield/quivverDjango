from django.shortcuts import render

# Create your views here.
from django.views.generic import TemplateView


class Welcome(TemplateView):
    template_name = "jinja2/home.html"


class About(TemplateView):
    template_name = "jinja2/about.html"


class Team(TemplateView):
    template_name = 'jinja2/team.html'


class Contact(TemplateView):
    template_name = 'jinja2/contact.html'


class Gallery(TemplateView):
    template_name = 'jinja2/gallery.html'


class Login(TemplateView):
    template_name = 'jinja2/login.html'