import json

from django.contrib.auth.decorators import login_required
from django.core import serializers
from django.http import JsonResponse, Http404
from django.shortcuts import render, redirect

# -------------------------------------  Kitchen -------------------------------------
from cloudkitchen.settings.base import PAGE_TITLE
from helpers.products_helper import ProductsHelper
from helpers.sales_helper import TicketPOSHelper
from kitchen.models import ProcessedProduct
from products.models import PackageCartridgeRecipe
from sales.models import TicketBase


@login_required(login_url='users:login')
def kitchen(request, kitchen_type):
    tickets = TicketBase.objects.all()
    sales_helper = TicketPOSHelper()

    def get_processed_products(json_type=False):
        processed_products_list = []
        processed_objects = ProcessedProduct.objects.filter(status='PE')

        for processed in processed_objects:
            processed_product_object = {
                'ticket_order': processed.ticket.order_number,
                'cartridges': [],
                'packages': []
            }

            # Cartridge Ticket Detail
            for cartridge_ticket_detail in sales_helper.get_cartridges_tickets_details().filter(
                    ticket_base=processed.ticket):
                if cartridge_ticket_detail.ticket_base == processed.ticket:
                    if json_type:
                        cartridge = {
                            'quantity': cartridge_ticket_detail.quantity,
                            'cartridge': json.loads(
                                serializers.serialize('json', [cartridge_ticket_detail.cartridge, ]))
                        }
                    else:
                        cartridge = {
                            'quantity': cartridge_ticket_detail.quantity,
                            'cartridge': cartridge_ticket_detail.cartridge
                        }
                    processed_product_object['cartridges'].append(cartridge)

            # Package Ticket Detail
            for package_ticket_detail in sales_helper.get_packages_tickets_details().filter(
                    ticket_base=processed.ticket):
                if package_ticket_detail.ticket_base == processed.ticket:

                    package = {
                        'quantity': package_ticket_detail.quantity,
                        'package_recipe': []
                    }
                    package_recipe = \
                        PackageCartridgeRecipe.objects.filter(package_cartridge=package_ticket_detail.package_cartridge)

                    for recipe in package_recipe:
                        if json_type:
                            package['package_recipe'].append(
                                json.loads(serializers.serialize('json', [recipe.cartridge, ])))
                        else:
                            package['package_recipe'].append(recipe.cartridge)

                    processed_product_object['packages'].append(package)

            processed_products_list.append(processed_product_object)

        return processed_products_list

    if request.method == 'GET':
        if kitchen_type == 'fria':
            template = 'cold.html'
            title = 'Cocina Fría'

        elif kitchen_type == 'caliente':
            template = 'hot.html'
            title = 'Cocina Caliente'
        else:
            raise Http404

        context = {
            'title': PAGE_TITLE + ' | ' + title,
            'page_title': title,
            'products': get_processed_products(),
            'tickets': tickets,
        }

        return render(request, template, context)

    elif request.method == 'POST':
        pendiente_products = {
            'data': get_processed_products(True)
        }

        return JsonResponse(pendiente_products)


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
