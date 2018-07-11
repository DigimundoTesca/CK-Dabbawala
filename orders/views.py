import json

from django.conf import settings
from django.shortcuts import render, get_object_or_404, redirect
from django.http import JsonResponse
from django.views.decorators.csrf import ensure_csrf_cookie
from products.models import Cartridge
from sales.models import TicketBase, TicketOrder
from users.models.customers import User as UserProfile
from helpers_origin import CartHelper
from helpers.sales_helper import TicketPOSHelper


@ensure_csrf_cookie
def new_order(request):
    return redirect('users:home')
    if not settings.DEBUG:
        # return redirect('users:index')
        pass
    if 'cart' in request.session:
        # return redirect('orders:pay')
        pass
    sales_helper = TicketPOSHelper()
    template = 'new_order.html'
    all_products = Cartridge.objects.all()

    if request.method == 'POST':
        if request.POST['type'] == 'new_order':
            request.session.clear()
            # Checks if the cart is empty
            cart = json.loads(request.POST['cart'])
            cart_helper = CartHelper(cart)
            request.session['cart'] = cart
            return JsonResponse({'result': 'cart_filled'})

        username = request.user
        user_profile_object = get_object_or_404(UserProfile, username=username)
        ticket_detail_json_object = json.loads(request.POST.get('cart'))
        new_ticket_object = TicketBase(
            seller=user_profile_object,
            payment_type='CA',
            order_number=sales_helper.get_new_order_number())
        # new_ticket_object.save()

        """
        Saves the tickets details for cartridges
        """
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


@ensure_csrf_cookie
def pay(request):
    if 'cart' not in request.session:
        return redirect('orders:new_order')

    if request.method == 'POST':
        if request.POST['type'] == 'cancelPay':
            request.session.pop('cart')
            return JsonResponse({'code': 1})
    all_products = Cartridge.objects.all()
    template = 'pay.html'
    first_session = 'first_session' in request.session
    context = {
        'products': all_products,
        'first_session': first_session,
    }

    return render(request, template, context)


def customer_orders(request):
    template = 'customers/customer_orders.html'
    context = {}
    return render(request, template, context)
