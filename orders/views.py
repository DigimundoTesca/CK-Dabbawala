import json

from django.shortcuts import render
from django.http import JsonResponse

from products.models import Cartridge


def new_order(request):
    template = 'new_order.html'
    all_products = Cartridge.objects.all()

    if request.method == 'POST':
        try:
            ticket = json.loads(request.POST['ticket'])
            return JsonResponse({'hola': 'amigo'})
        except Exception as e:
            print('error:')
            print(e)

    context = {
        'products': all_products,
    }

    return render(request, template, context)


def pay(request):
    all_products = Cartridge.objects.all()
    template = 'pay.html'

    context = {
        'products': all_products,
    }

    return render(request, template, context)
