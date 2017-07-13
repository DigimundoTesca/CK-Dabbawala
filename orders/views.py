import json

from django.shortcuts import render, get_object_or_404, redirect
from django.http import JsonResponse

from branchoffices.models import CashRegister
from products.models import Cartridge
from sales.models import TicketBase, TicketDetail
from users.models import User as UserProfile
from helpers import SalesHelper


def new_order(request):
    sales_helper = SalesHelper()
    print(request.session)
    template = 'new_order.html'
    all_products = Cartridge.objects.all()


    if request.method == 'POST':
        if not request.user.is_authenticated:
            return JsonResponse({'result': 'not_authenticated'})

        ticket = json.loads(request.POST['ticket'])
        username = request.user
        user_profile_object = get_object_or_404(UserProfile, username=username)
        cash_register = CashRegister.objects.first()
        ticket_detail_json_object = json.loads(request.POST.get('ticket'))
        new_ticket_object = TicketBase(
            cash_register=cash_register,
            seller=user_profile_object,
            payment_type='CA',
            order_number=sales_helper.get_new_order_number())
        # new_ticket_object.save()

        """
        Saves the tickets details for cartridges
        """
        print(ticket_detail_json_object)
        for ticket_detail in ticket_detail_json_object['cartridges']:
            cartridge_object = get_object_or_404(Cartridge, id=ticket_detail)
            quantity = ticket_detail_json_object['cartridges'][ticket_detail]['quantity']
            cost = ticket_detail_json_object['cartridges'][ticket_detail]['cost']
            new_ticket_detail_object = TicketDetail(
                ticket=new_ticket_object,
                cartridge=cartridge_object,
                quantity=quantity,
                price=cost
            )
            # new_ticket_detail_object.save()

        return JsonResponse({'hola': 'amigo'})
        # return redirect('users:login')

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
