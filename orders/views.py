from django.shortcuts import render

from products.models import Cartridge

def new_order(request):
  all_products = Cartridge.objects.all()
  template = 'new_order.html'
  
  context = {
    'products': all_products,
  }
  
  return render(request, template, context)
