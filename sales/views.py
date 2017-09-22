import json
from datetime import datetime, date, timedelta

from django.contrib.auth.decorators import login_required, permission_required
from django.http import JsonResponse, HttpResponse
from django.shortcuts import render, get_object_or_404
from django.utils import timezone
from django.views.generic import TemplateView
from openpyxl import Workbook
from openpyxl.styles import Alignment

from cloudkitchen.settings.base import PAGE_TITLE
from products.models import Cartridge, PackageCartridge, PackageCartridgeRecipe
from sales.models import TicketBase, TicketDetail, TicketPOS
from users.models.users import User as UserProfile
from helpers.sales_helper import TicketPOSHelper
from helpers.products_helper import ProductsHelper
from helpers.helpers import Helper


# -------------------------------------  Sales -------------------------------------
class SalesReport(TemplateView):

    def get(self, request, *args, **kwargs):
        all_tickets_details = TicketDetail.objects.select_related('ticket', 'cartridge', 'package_cartridge')
        all_packages_recipes = PackageCartridgeRecipe.objects.select_related('package_cartridge', 'cartridge')
        all_cartridges = Cartridge.objects.all()

        count = 4
        workbook = Workbook()
        ws1 = workbook.active
        ws1.title = 'Reporte de Tickets'
        ws1['B1'] = 'Reporte General de Ventas'
        ws1['B1'].alignment = Alignment(horizontal='center')
        ws1.merge_cells('B1:R1')

        ws1['A3'] = 'Subticket ID'
        ws1['B3'] = 'Ticket Padre ID'
        ws1['C3'] = 'Núm. Orden'
        ws1['D3'] = 'Fecha'
        ws1['E3'] = 'Hora'
        ws1['F3'] = 'Horas'
        ws1['G3'] = 'Paquete ID'
        ws1['H3'] = 'Paquete'
        ws1['I3'] = 'Roti'
        ws1['J3'] = 'Ensalada'
        ws1['K3'] = 'Licuados'
        ws1['L3'] = 'Fruta'
        ws1['M3'] = 'Jugo'
        ws1['N3'] = 'Agua'
        ws1['O3'] = 'Cantidad'
        ws1['P3'] = 'Tipo de Pago'
        ws1['Q3'] = 'Precio Unitario'
        ws1['R3'] = 'Total'

        # Styles
        """
        for ticket_details in all_tickets_details:
            if ticket_details.package_cartridge:
                aux = count
                for cartridge_recipe in all_packages_recipes:

                    if cartridge_recipe.package_cartridge == ticket_details.package_cartridge:

                        cartridge_name = cartridge_recipe.cartridge.name
                        subcategory = cartridge_recipe.cartridge.subcategory
                        ws1.cell(row=count, column=1, value=ticket_details.id)
                        ws1.cell(row=count, column=2, value=ticket_details.ticket.id)
                        ws1.cell(row=count, column=3, value=ticket_details.ticket.order_number)
                        ws1.cell(row=count, column=4, value=ticket_details.ticket.created_at)
                        ws1.cell(row=count, column=4).number_format = 'DD-MM-YYYY'
                        ws1.cell(row=count, column=5, value=ticket_details.ticket.created_at)
                        ws1.cell(row=count, column=5).number_format = 'h:mm AM/PM'
                        ws1.cell(row=count, column=6, value=ticket_details.ticket.created_at)
                        ws1.cell(row=count, column=6).number_format = 'hh AM/PM'
                        ws1.cell(row=count, column=7, value=ticket_details.package_cartridge.id)
                        ws1.cell(row=count, column=8, value=ticket_details.package_cartridge.name)
                        ws1.cell(row=count, column=9, value=cartridge_name if subcategory == 'RO' else None)
                        ws1.cell(row=count, column=12, value=cartridge_name if subcategory == 'FR' else None)
                        ws1.cell(row=count, column=13, value=cartridge_name if subcategory == 'JU' else None)
                        ws1.cell(row=count, column=14, value=cartridge_name if subcategory == 'WA' else None)
                        ws1.cell(row=count, column=15, value=cartridge_name if subcategory == 'WA' else None)
                        ws1.cell(row=count, column=16, value=cartridge_name if subcategory == 'WA' else None)
                        ws1.cell(row=count, column=17, value=cartridge_name if subcategory == 'WA' else None)
                        ws1.cell(row=count, column=18, value=cartridge_name if subcategory == 'WA' else None)
                        count += 1
                ws1.merge_cells(start_row=aux, start_column=1, end_row=count-1, end_column=1)

            else:
                cartridge_name = ticket_details.cartridge.name
                subcategory = ticket_details.cartridge.subcategory
                ws1.cell(row=count, column=1, value=ticket_details.id)
                ws1.cell(row=count, column=2, value=ticket_details.ticket.id)
                ws1.cell(row=count, column=3, value=ticket_details.ticket.order_number)
                ws1.cell(row=count, column=4, value=ticket_details.ticket.created_at)
                ws1.cell(row=count, column=4).number_format = 'DD-MM-YYYY'
                ws1.cell(row=count, column=5, value=ticket_details.ticket.created_at)
                ws1.cell(row=count, column=5).number_format = 'h:mm AM/PM'
                ws1.cell(row=count, column=6, value=ticket_details.ticket.created_at)
                ws1.cell(row=count, column=6).number_format = 'hh AM/PM'
                ws1.cell(row=count, column=9, value=cartridge_name if subcategory == 'RO' else None)
                ws1.cell(row=count, column=10, value=cartridge_name if subcategory == 'SA' else None)
                ws1.cell(row=count, column=11, value=cartridge_name if subcategory == 'SM' else None)
                ws1.cell(row=count, column=12, value=cartridge_name if subcategory == 'FR' else None)
                ws1.cell(row=count, column=13, value=cartridge_name if subcategory == 'JU' else None)
                ws1.cell(row=count, column=14, value=cartridge_name if subcategory == 'WA' else None)

                count += 1
        """

        for ticket_detail in all_tickets_details:
            ws1.cell(row=count, column=1).value = ticket_detail

        file_name = 'Reporte_General_De_Ventas_{0}.xlsx'.format(datetime.now().strftime("%I-%M%p_%d-%m-%Y"))
        response = HttpResponse(content_type='application/ms-excel')
        content = 'attachment; filename={0}'.format(file_name)
        response['Content-Disposition'] = content
        workbook.save(response)

        return response

    def get_context_data(self, **kwargs):
        context = super(SalesReport, self).get_context_data(**kwargs)
        print(context)
        return context


@permission_required('users.can_see_sales')
def sales(request):
    sales_helper = TicketPOSHelper()
    helper = Helper()

    if request.method == 'POST':
        if request.POST['type'] == 'sales_day':
            """
            Returns a list with objects:
            Each object has the following characteristics
            """
            sales_day_list = []
            start_day = helper.naive_to_datetime(datetime.strptime(request.POST['date'], '%d-%m-%Y').date())
            end_date = helper.naive_to_datetime(start_day + timedelta(days=1))
            tickets_objects = sales_helper.get_all_tickets().filter(ticket__created_at__range=[start_day, end_date])

            for ticket_pos in tickets_objects:
                """
                Filling in the sales list of the day
                """
                earnings_sale_object = {
                    'id_ticket': ticket_pos.ticket.id,
                    'datetime': timezone.localtime(ticket_pos.ticket.created_at),
                    'earnings': 0
                }
                for ticket_detail in sales_helper.get_all_tickets_details():
                    if ticket_detail.ticket == ticket_pos.ticket:
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

            for ticket_pos in sales_helper.get_all_tickets():
                for ticket_detail in sales_helper.get_all_tickets_details():
                    if ticket_detail.ticket == ticket_pos.ticket:
                        ticket_object = {
                            'ID': ticket_pos.ticket.id,
                            'Fecha': timezone.localtime(ticket_pos.ticket.created_at).date(),
                            'Hora': timezone.localtime(ticket_pos.ticket.created_at).time(),
                            'Vendedor': ticket_pos.cashier.username,
                        }
                        if ticket_pos.ticket.payment_type == 'CA':
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
        return JsonResponse({'result': 'success'})


@permission_required('users.can_sell')
def new_sale(request):
    helper = Helper()
    sales_helper = TicketPOSHelper()
    products_helper = ProductsHelper()
    if request.method == 'POST':
        if request.POST['ticket']:
            """
            Gets the tickets in the week and returns n + 1
            where n is the Ticket.order_number biggest for the current weeks
            """
            username = request.user
            user_profile_object = get_object_or_404(UserProfile, username=username)
            ticket_detail_json_object = json.loads(request.POST.get('ticket'))
            payment_type = ticket_detail_json_object['payment_type']
            new_ticket_object = TicketBase(
                payment_type=payment_type,
                order_number=sales_helper.get_new_order_number())
            new_ticket_object.save()
            new_ticket_pos = TicketPOS(
                ticket=new_ticket_object,
                cashier=user_profile_object,
            )
            new_ticket_pos.save()

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
def test_sales_update(request):
    template = 'sales/test.html'
    tickets = TicketBase.objects.all()
    ticket_pos = TicketPOS.objects.all()
    context = {
        'tickets': tickets,
        'ticket_pos': ticket_pos,
    }

    for ticket in tickets:
        exists = False
        for pos in ticket_pos:
            if ticket == pos.ticket:
                exists = True

        if not exists:
            new_ticket_pos = TicketPOS(
                ticket=ticket,
                cashier=ticket.seller,
            )
            new_ticket_pos.save()

