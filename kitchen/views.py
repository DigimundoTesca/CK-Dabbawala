from django.contrib.auth.decorators import login_required
from django.shortcuts import render, redirect

# -------------------------------------  Kitchen -------------------------------------
from cloudkitchen.settings.base import PAGE_TITLE
from helpers.kitchen_helper import KitchenHelper
from helpers.products_helper import ProductsHelper
from helpers.sales_helper import TicketPOSHelper
from kitchen.models import ProcessedProduct
from products.models import PackageCartridgeRecipe, Cartridge, PackageCartridge
from sales.models import TicketBase


@login_required(login_url="users:login")
def kitchen(request, kitchen=None):
    if kitchen == 'cold':
        template = 'cold.html'
        title = 'Cocina Fría'
    else:
        title = 'Cocina Caliente'
        template = 'hot.html'

    kitchen_helper = KitchenHelper()
    tickets= TicketBase.objects.all()

    context = {
        'title': PAGE_TITLE + ' | ' + title,
        'page_title': title,
        'products': kitchen_helper.get_unprocessed_products_list(),
        'tickets': tickets,
    }
    return render(request, template, context)


def assembly(request):
    if request.method == 'POST':
        if request.POST['order_id']:
            order = ProcessedProduct.objects.get(ticket=request.POST['order_id'])
            order.status = 'AS'
            order.save()
        return redirect('kitchen:assembly')

    else:
        template = 'assembly.html'
        title = 'Ensamblado'
        sales_helper = TicketPOSHelper()
        products_helper = ProductsHelper()
        pending_orders = ProcessedProduct.objects.filter(status='PE')[:10]
        orders_list = []

        for order in pending_orders:
            order_object = {
                'ticket_id': order.ticket,
                'ticket_order': order.ticket.order_number,
                'products': [],
                'packages': [],
            }

            # Cartridge Ticket Detail
            for cartridge_ticket_detail in sales_helper.get_cartridges_tickets_details().filter(
                    ticket_base=order.ticket):
                for cartridge in products_helper.cartridges:
                    if cartridge_ticket_detail.cartridge == cartridge:
                        product_object = {
                            'name': cartridge_ticket_detail.cartridge.name,
                            'quantity': cartridge_ticket_detail.quantity,
                        }
                        order_object['products'].append(product_object)

            # Package Ticket Detail
            for package_ticket_detail in sales_helper.get_packages_tickets_details().filter(
                    ticket_base=order.ticket):
                for package in products_helper.packages_cartridges:
                    if package_ticket_detail.package_cartridge == package:
                        package_object = {
                            'name': package_ticket_detail.package_cartridge.name,
                            'quantity': package_ticket_detail.quantity,
                        }
                        order_object['packages'].append(package_object)

            orders_list.append(order_object)

        context = {
            'title': PAGE_TITLE + ' | ' + title,
            'page_title': title,
            'orders': orders_list
        }

        return render(request, template, context)
