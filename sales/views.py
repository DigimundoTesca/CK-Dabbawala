import json
from datetime import datetime, date, timedelta
from decimal import Decimal

from django.contrib.auth.decorators import login_required, permission_required
from django.http import JsonResponse
from django.shortcuts import render, get_object_or_404
from django.utils import timezone

from branchoffices.models import CashRegister
from cloudkitchen.settings.base import PAGE_TITLE
from products.models import Cartridge, PackageCartridge, PackageCartridgeRecipe
from sales.models import TicketBase, TicketDetail
from users.models import User as UserProfile
from helpers import Helper, SalesHelper, ProductsHelper


# -------------------------------------  Sales -------------------------------------
@permission_required('users.can_see_sales')
def sales(request):
    helper = Helper()
    sales_helper = SalesHelper()
    if request.method == 'POST':
        if request.POST['type'] == 'sales_day':
            """
            Returns a list with objects:
            Each object has the following characteristics
            """
            sales_day_list = []
            start_day = helper.naive_to_datetime(datetime.strptime(request.POST['date'], '%d-%m-%Y').date())
            end_date = helper.naive_to_datetime(start_day + timedelta(days=1))
            tickets_objects = sales_helper.get_all_tickets().filter(created_at__range=[start_day, end_date])

            for ticket in tickets_objects:
                """
                Filling in the sales list of the day
                """
                earnings_sale_object = {
                    'id_ticket': ticket.id,
                    'datetime': timezone.localtime(ticket.created_at),
                    'earnings': 0
                }
                for ticket_detail in sales_helper.get_all_tickets_details():
                    if ticket_detail.ticket == ticket:
                        earnings_sale_object['earnings'] += ticket_detail.price
                sales_day_list.append(earnings_sale_object)
            return JsonResponse({'sales_day_list': sales_day_list})

        if request.POST['type'] == 'ticket_details':
            ticket_id = int(request.POST['ticket_id'])
            ticket_object = {
                'ticket_id': ticket_id,
                'ticket_order': '',
                'cartridges': [],
                'packages': [],
            }

            # Get cartridges details
            for ticket_detail in sales_helper.get_all_tickets_details():
                if ticket_detail.ticket.id == ticket_id:
                    ticket_object['ticket_order'] = ticket_detail.ticket.order_number
                    if ticket_detail.cartridge:
                        cartridge_object = {
                            'name': ticket_detail.cartridge.name,
                            'quantity': ticket_detail.quantity,
                            'total': ticket_detail.price
                        }
                        ticket_object['cartridges'].append(cartridge_object)
                    elif ticket_detail.package_cartridge:
                        cartridges_list = []
                        package_cartridge_recipe = PackageCartridgeRecipe.objects.filter(
                            package_cartridge=ticket_detail.package_cartridge)

                        for cartridge_recipe in package_cartridge_recipe:
                            cartridges_list.append(cartridge_recipe.cartridge.name)
                        package_cartridge_object = {
                            'cartridges': cartridges_list,
                            'quantity': ticket_detail.quantity,
                            'total': ticket_detail.price
                        }
                        ticket_object['packages'].append(package_cartridge_object)

            return JsonResponse({'ticket_details': ticket_object})

        if request.POST['type'] == 'tickets':
            tickets_objects_list = []

            for ticket in sales_helper.get_all_tickets():
                for ticket_detail in sales_helper.get_all_tickets_details():
                    if ticket_detail.ticket == ticket:
                        ticket_object = {
                            'ID': ticket.id,
                            'Fecha': timezone.localtime(ticket.created_at).date(),
                            'Hora': timezone.localtime(ticket.created_at).time(),
                            'Vendedor': ticket.seller.username,
                        }
                        if ticket.payment_type == 'CA':
                            ticket_object['Tipo de Pago'] = 'Efectivo'
                        else:
                            ticket_object['Tipo de Pago'] = 'Crédito'
                        if ticket_detail.cartridge:
                            ticket_object['Producto'] = ticket_detail.cartridge.name
                        else:
                            ticket_object['Producto'] = None
                        if ticket_detail.package_cartridge:
                            ticket_object['Paquete'] = ticket_detail.package_cartridge.name
                        else:
                            ticket_object['Paquete'] = None
                        ticket_object['Cantidad'] = ticket_detail.quantity
                        ticket_object['Total'] = ticket_detail.price
                        ticket_object['Precio Unitario'] = ticket_detail.price / ticket_detail.quantity

                        tickets_objects_list.append(ticket_object)

            return JsonResponse({'ticket': tickets_objects_list})

        if request.POST['type'] == 'sales_week':
            initial_date = request.POST['dt_week'].split(',')[0]
            final_date = request.POST['dt_week'].split(',')[1]
            initial_date = helper.parse_to_datetime(initial_date)
            final_date = helper.parse_to_datetime(final_date) + timedelta(days=1)

            sales = sales_helper.get_sales_list(initial_date, final_date)
            tickets = sales_helper.get_tickets_list(initial_date, final_date)
            data = {
                'sales': sales,
                'tickets': tickets,
                'week_number': helper.get_week_number(initial_date)
            }
            return JsonResponse(data)

    # Any other request method:
    template = 'sales/sales.html'
    title = 'Registro de Ventas'
    context = {
        'title': PAGE_TITLE + ' | ' + title,
        'page_title': title,
        'actual_year': datetime.now().year,
        'sales_week': sales_helper.get_sales_actual_week(),
        'today_name': helper.get_name_day(datetime.now()),
        'today_number': helper.get_number_day(datetime.now()),
        'week_number': helper.get_week_number(date.today()),
        'tickets': sales_helper.get_tickets_today_list(),
        'dates_range': sales_helper.get_dates_range_json(),

    }
    return render(request, template, context)


@login_required(login_url='users:login')
def delete_sale(request):
    if request.method == 'POST':
        ticket_id = request.POST['ticket_id']
        ticket = TicketBase.objects.get(id=ticket_id)
        ticket.delete()
        return JsonResponse({'result': 'excelente!'})


@permission_required('users.can_sell')
def new_sale(request):
    helper = Helper()
    sales_helper = SalesHelper()
    products_helper = ProductsHelper()
    if request.method == 'POST':
        if request.POST['ticket']:
            """
            Gets the tickets in the week and returns n + 1
            where n is the Ticket.order_number biggest for the current week
            TODO:
            1. Get tickets in the current week range
            2. Search the ticket with the largest order_number attribute
            3. save the 'new_ticket_object' with the new attribute (n + 1)
            4. Save the new object
            """

            username = request.user
            user_profile_object = get_object_or_404(UserProfile, username=username)
            cash_register = CashRegister.objects.first()
            ticket_detail_json_object = json.loads(request.POST.get('ticket'))
            payment_type = ticket_detail_json_object['payment_type']
            new_ticket_object = TicketBase(
                cash_register=cash_register,
                seller=user_profile_object,
                payment_type=payment_type,
                order_number=sales_helper.get_new_order_number())
            new_ticket_object.save()

            """
            Saves the tickets details for cartridges
            """
            for ticket_detail in ticket_detail_json_object['cartridges']:
                cartridge_object = get_object_or_404(Cartridge, id=ticket_detail['id'])
                quantity = ticket_detail['quantity']
                price = ticket_detail['price']
                new_ticket_detail_object = TicketDetail(
                    ticket=new_ticket_object,
                    cartridge=cartridge_object,
                    quantity=quantity,
                    price=price
                )
                new_ticket_detail_object.save()

            for ticket_detail_packages in ticket_detail_json_object['packages']:
                """
                Saves the tickets details for package cartridges
                    1. Iterates each package
                    2. For each package, gets the list of cartridges tha make up each recipe
                    3. Compares the cartridge's list obtained with the corresponding list in the JSON
                    4. Depending on the result on th result creates a new item in the package table and the new
                        ticket or just creates the new ticket
                """
                quantity = ticket_detail_packages['quantity']
                price = ticket_detail_packages['price']
                packages_id_list = ticket_detail_packages['id_list']
                package_id = None
                is_new_package = True
                packages_recipes = PackageCartridge.objects.all()

                for package_recipe in packages_recipes:
                    """
                    Gets the cartridges for each package cartridge and compares
                    each package recipe cartridges if is equal that packages_id_list
                    """
                    cartridges_per_recipe = PackageCartridgeRecipe.objects.select_related(
                        'package_cartridge', 'cartridge').filter(package_cartridge=package_recipe)
                    cartridges_in_package_recipe = []

                    for cartridge_recipe in cartridges_per_recipe:
                        cartridges_in_package_recipe.append(cartridge_recipe.cartridge.id)

                    if helper.are_equal_lists(cartridges_in_package_recipe, packages_id_list):
                        is_new_package = False
                        package_id = package_recipe.id

                if is_new_package:
                    package_name = ticket_detail_packages['name']
                    package_price = ticket_detail_packages['price']
                    new_package_object = PackageCartridge(name=package_name, price=package_price, is_active=True)
                    new_package_object.save()

                    """
                    Creates a new package
                    """
                    for id_cartridge in packages_id_list:
                        cartridge_object = get_object_or_404(Cartridge, id=id_cartridge)
                        new_package_recipe_object = PackageCartridgeRecipe(
                            package_cartridge=new_package_object,
                            cartridge=cartridge_object,
                            quantity=1
                        )
                        new_package_recipe_object.save()

                    """
                    Creates the ticket detail
                    """
                    new_ticket_detail_object = TicketDetail(
                        ticket=new_ticket_object,
                        package_cartridge=new_package_object,
                        quantity=quantity,
                        price=price
                    )
                    new_ticket_detail_object.save()

                else:
                    """
                    Uses an existent package
                    """
                    package_object = get_object_or_404(PackageCartridge, id=package_id)
                    new_ticket_detail_object = TicketDetail(
                        ticket=new_ticket_object,
                        package_cartridge=package_object,
                        quantity=quantity,
                        price=price,
                    )
                    new_ticket_detail_object.save()
            json_response = {
                'status': 'ready',
                'ticket_id': new_ticket_object.id,
                'ticket_order': new_ticket_object.order_number,
            }
            return JsonResponse(json_response)

        return JsonResponse({'status': 'error'})

    else:
        cartridges_list = products_helper.all_cartridges
        package_cartridges = PackageCartridge.objects.all()
        template = 'sales/new_sale.html'
        title = 'Nueva venta'
        context = {
            'page_title': PAGE_TITLE,
            'title': title,
            'cartridges': cartridges_list,
            'package_cartridges': package_cartridges
        }
        return render(request, template, context)


# -------------------------------- Test ------------------------------
def test(request):
    template = 'sales/test.html'

    tickets_details = TicketDetail.objects.select_related('ticket', 'ticket__seller', 'cartridge',
                                                          'package_cartridge').filter()
    tickets = TicketBase.objects.all()
    tickets_list = []

    for ticket in tickets:
        ticket_object = {
            'ticket_parent': ticket,
            'cartridges': [],
            'packages': [],
            'total': Decimal(0.00),
        }

        for ticket_details in tickets_details:
            if ticket_details.ticket == ticket:
                if ticket_details.cartridge:
                    cartridge_object = {
                        'cartridge': ticket_details.cartridge,
                        'quantity': ticket_details.quantity
                    }
                    ticket_object['cartridges'].append(cartridge_object)
                    ticket_object['total'] += ticket_details.price
                elif ticket_details.package_cartridge:
                    package_cartridge_object = {
                        'package': ticket_details.package_cartridge,
                        'quantity': ticket_details.quantity
                    }
                    ticket_object['packages'].append(package_cartridge_object)
                    ticket_object['total'] += ticket_details.price

        tickets_list.append(ticket_object)

    context = {
        'tickets': tickets_list,
    }

    return render(request, template, context)
