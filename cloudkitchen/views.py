from django.http import HttpResponse
from django.shortcuts import render


def index(request):
      template = 'dabbawala/base.html'
      context = {}
      return render(request, template, context)
