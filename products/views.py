# -*- encoding: utf-8 -*-
from __future__ import unicode_literals
import json

from django.shortcuts import get_object_or_404, render, redirect
from datetime import timedelta, datetime, date
from django.contrib.auth.decorators import login_required
from branchoffices.models import Supplier
from cloudkitchen.settings.base import PAGE_TITLE
from products.forms import SupplyForm, SuppliesCategoryForm, CartridgeForm
from products.models import Cartridge, Supply, SuppliesCategory, KitchenAssembly, PackageCartridge, PackageCartridgeRecipe, Presentation, ShopList, ShopListDetail
from django.urls import reverse
from django.http import HttpResponseRedirect
from django.urls import reverse_lazy
from helpers.products_helper import ProductsHelper
from helpers.sales_helper import TicketPOSHelper
from helpers.helpers import Helper
from django.views.generic import UpdateView
from django.views.generic import DeleteView
from django.views.generic import CreateView
from .forms import PresentationForm
from django.db.models import Count, Sum
from sales.models import TicketBase, CartridgeTicketDetail, PackageCartridgeTicketDetail
from django.db.models.functions import TruncMonth, TruncYear
from django.http import JsonResponse
import calendar


class Create_Supply(CreateView):
    model = Supply
    fields = ['name','category','barcode','supplier','storage_required','optimal_duration','optimal_duration_unit','location','image']
    template_name = 'supplies/new_supply.html'

    def form_valid(self, form):
        self.object = form.save()
        return redirect('/supplies/')


class Update_Supply(UpdateView):
    model = Supply
    fields = ['name','category','barcode','supplier','storage_required','optimal_duration','optimal_duration_unit','location','image']
    template_name = 'supplies/new_supply.html'

    def form_valid(self, form):
        self.object = form.save()
        return redirect('/supplies/')


class Delete_Supply(DeleteView):
    model = Supply
    template_name = 'supplies/delete_supply.html'

    def delete(self, request, *args, **kwargs):
        self.object = self.get_object()
        self.object.delete()
        return redirect('/supplies/')


class Create_Cartridge(CreateView):
    model = Cartridge
    fields = ['name', 'price', 'category', 'image']
    template_name = 'cartridges/new_cartridge.html'

    def form_valid(self, form):
        self.object = form.save()
        return redirect('/cartridges/')


class Update_Cartridge(UpdateView):
    model = Cartridge
    fields = ['name', 'price', 'category', 'image']
    template_name = 'cartridges/new_cartridge.html'

    def form_valid(self, form):
        self.object = form.save()
        return redirect('/cartridges/')


class Delete_Cartridge(DeleteView):
    model = Cartridge
    template_name = 'cartridges/delete_cartridge.html'

    def delete(self, request, *args, **kwargs):
        self.object = self.get_object()
        self.object.delete()
        return redirect('/cartridges/')


class Create_Presentation(CreateView):
    model = Presentation
    print(model)
    fields = [
        'supply', 'measurement_quantity', 'measurement_unit',
        'presentation_unit', 'presentation_cost'
    ]
    template_name = 'presentations/new_presentation.html'

    def form_valid(self, form):
        self.object = form.save()
        return redirect('/supplies/details/'+self.kwargs['suppk'])


class Update_Presentation(UpdateView):
    model = Presentation
    fields = [
        'supply', 'measurement_quantity', 'measurement_unit',
        'presentation_unit', 'presentation_cost'
    ]
    template_name = 'presentations/new_presentation.html'

    def form_valid(self, form):
        self.object = form.save()
        return redirect('/supplies/details/' + self.kwargs['suppk'])


class Delete_Presentation(DeleteView):
    model = Presentation
    template_name = 'presentations/delete_presentation.html'

    def delete(self, request, *args, **kwargs):
        self.object = self.get_object()
        self.object.delete()
        return redirect('/supplies/details/' + self.kwargs['suppk'])



def test(request):
    template = 'cartridges_test/test.html'
    cartridges = Cartridge.objects.all()
    kitchen_assembly_cold = KitchenAssembly.objects.get(name='CO')
    kitchen_assembly_hot = KitchenAssembly.objects.get(name='HO')
    for cartridge in cartridges:
        if cartridge.category == 'FD':
            cartridge.kitchen_assembly = kitchen_assembly_hot
        else:
            cartridge.kitchen_assembly = kitchen_assembly_cold
        cartridge.save()
    context = {'cartridges': cartridges}
    return render(request, template, context)


# -------------------------------------  Menu -------------------------------------
def menu(request):
    all_products = Cartridge.objects.all()
    suppliers_list = Supplier.objects.order_by('id')
    template = 'all_products/menu.html'
    title = 'Menú'
    context = {
        'suppliers': suppliers_list,
        'products': all_products,
        'title': title,
        'page_title': PAGE_TITLE
    }
    return render(request, template, context)


# -------------------------------------  Providers -------------------------------------
@login_required(login_url='users:login')
def suppliers(request):
    suppliers_list = Supplier.objects.order_by('id')
    template = 'suppliers/suppliers.html'
    title = 'Proveedores'
    context = {
        'suppliers': suppliers_list,
        'title': title,
        'page_title': PAGE_TITLE
    }
    return render(request, template, context)

# -------------------------------------  Supplies -------------------------------------
@login_required(login_url='users:login')
def supplies(request):
    supplies_objects = Supply.objects.order_by('id')
    template = 'supplies/supplies.html'
    title = 'Insumos'
    context = {
        'supplies': supplies_objects,
        'title': title,
        'page_title': PAGE_TITLE
    }
    return render(request, template, context)


@login_required(login_url='users:login')
def new_supply(request):
    if request.method == 'POST':
        form = SupplyForm(request.POST, request.FILES)
        if form.is_valid():
            supply = form.save(commit=False)
            supply.save()
            return redirect('/supplies/')
    else:
        form = SupplyForm()

    template = 'supplies/new_supply.html'
    title = 'DabbaNet - Nuevo insumo'
    categories_list = SuppliesCategory.objects.order_by('name')
    suppliers_list = Supplier.objects.order_by('name')
    context = {
        'categories': categories_list,
        'suppliers': suppliers_list,
        'form': form,
        'title': title,
        'page_title': PAGE_TITLE
    }
    return render(request, template, context)


@login_required(login_url='users:login')
def supply_detail(request, pk):
    supply = get_object_or_404(Supply, pk=pk)
    presentations = Presentation.objects.all().filter(supply=supply);
    template = 'supplies/supply_detail.html'
    title = 'DabbaNet - Detalles del insumo'
    context = {
        'page_title': PAGE_TITLE,
        'supply': supply,
        'title': title,
        'presentations': presentations,
    }
    return render(request, template, context)


@login_required(login_url='users:login')
def supply_modify(request, pk):
    supply = get_object_or_404(Supply, pk=pk)

    if request.method == 'POST':
        form = SupplyForm(request.POST, request.FILES)

        if form.is_valid():
            nuevo = form.save(commit=False)
            supply.name = nuevo.name
            supply.category = nuevo.category
            supply.barcode = nuevo.barcode
            supply.supplier = nuevo.suppliter
            supply.storage_required = nuevo.storage_required
            supply.presentation_unit = nuevo.presentation_unit
            supply.presentation_cost = nuevo.presentation_cost
            supply.measurement_quantity = nuevo.measurement_quantity
            supply.measurement_unit = nuevo.measurement_unit
            supply.optimal_duration = nuevo.optimal_duration
            supply.optimal_duration_unit = nuevo.optimal_duration_unit
            supply.location = nuevo.location
            supply.image = nuevo.image
            supply.save()

            return redirect('/supply')

    else:
        dic = {
            'name': supply.name,
            'category': supply.category,
            'barcode': supply.barcode,
            'supplier': supply.supplier,
            'storage_required': supply.storage_required,
            'presentation_unit': supply.presentation_unit,
            'presentation_cost': supply.presentation_cost,
            'quantity': supply.measurement_quantity,
            'measurement_unit': supply.measurement_unit,
            'optimal_duration': supply.optimal_duration,
            'optimal_duration_unit': supply.optimal_duration_unit,
            'location': supply.location,
            'image': supply.image,
        }
        form = SupplyForm(initial=dic)

    template = 'supplies/new_supply.html'
    title = 'Modificar Insumo'
    context = {
        'form': form,
        'supply': supply,
        'title': title,
        'page_title': PAGE_TITLE
    }
    return render(request, template, context)


# ------------------------------------- Categories -------------------------------------
@login_required(login_url='users:login')
def categories(request):
    supplies_categories = SuppliesCategory.objects.order_by('id')
    template = 'categories/categories.html'
    title = 'Categorias'
    context = {
        'supplies_categories': supplies_categories,
        'title': title,
        'page_title': PAGE_TITLE
    }
    return render(request, template, context)


@login_required(login_url='users:login')
def new_category(request):
    if request.method == 'POST':
        form = SuppliesCategoryForm(request.POST, request.FILES)
        if form.is_valid():
            category = form.save(commit=False)
            category.save()
            return redirect('/categories')
    else:
        form = SuppliesCategoryForm()

    template = 'categories/new_category.html'
    title = 'Nueva Categoria'
    context = {'form': form, 'title': title, 'page_title': PAGE_TITLE}
    return render(request, template, context)


@login_required(login_url='users:login')
def categories_supplies(request, categ):
    supplies_categories = SuppliesCategoryForm.objects.filter(name=categ)
    supply = Supply.objects.filter(category=supplies_categories)
    template = 'supplies/supplies.html'
    title = categ
    context = {'supply': supply, 'title': title, 'page_title': PAGE_TITLE}
    return render(request, template, context)


# -------------------------------------  Cartridges -------------------------------------
@login_required(login_url='users:login')
def cartridges(request):
    cartridges_list = Cartridge.objects.order_by('id')
    template = 'cartridges/cartridges.html'
    title = 'Cartuchos'
    context = {
        'cartridges': cartridges_list,
        'title': title,
        'page_title': PAGE_TITLE
    }
    return render(request, template, context)


@login_required(login_url='users:login')
def new_cartridge(request):
    if request.method == 'POST':
        form = CartridgeForm(request.POST, request.FILES)
        if form.is_valid():
            cartridge = form.save(commit=False)
            cartridge.save()
            return redirect('/cartridges')
    else:
        form = CartridgeForm()

    template = 'cartridges/new_cartridge.html'
    title = 'Nuevo Cartucho'
    context = {'form': form, 'title': title, 'page_title': PAGE_TITLE}
    return render(request, template, context)


@login_required(login_url='users:login')
def cartridge_detail(request, pk):
    cartridge = get_object_or_404(Cartridge, pk=pk)
    template = 'cartridges/cartridge_detail.html'
    title = 'DabbaNet - Detalles del Producto'
    context = {
        'page_title': PAGE_TITLE,
        'cartridge': cartridge,
        'title': title
    }
    return render(request, template, context)


def cartridge_modify(request, pk):
    cartridge = get_object_or_404(Cartridge, pk=pk)

    if request.method == 'POST':
        form = CartridgeForm(request.POST, request.FILES)

        if form.is_valid():
            nuevo = form.save(commit=False)
            cartridge.name = nuevo.name
            cartridge.price = nuevo.price
            cartridge.category = nuevo.category
            cartridge.save()
            return redirect('/cartridges')

    else:
        dic = {
            'name': cartridge.name,
            'price': cartridge.price,
            'category': cartridge.category,
            'image': cartridge.image
        }
        form = CartridgeForm(initial=dic)

    template = 'cartridges/new_cartridge.html'
    title = 'Modificar Cartucho'
    context = {
        'form': form,
        'cartridge': cartridge,
        'title': title,
        'page_title': PAGE_TITLE
    }
    return render(request, template, context)

# -------------------------------------  Warehouse -------------------------------------

@login_required(login_url='users:login')
def warehouse(request):
    products_helper = ProductsHelper()
    presentations = Presentation.objects.all()
    supps = products_helper.get_all_supplies()

    if request.method == 'POST':

        if request.POST['type'] == 'save_to_assembly':

            quantity = json.loads(request.POST.get('quantity'))
            presentation_pk = json.loads(request.POST.get('presentation_pk'))
                
            # Retirar del almacen
            presentation = Presentation.objects.get(pk=presentation_pk)
            presentation.on_warehouse -= quantity
            presentation.on_assembly += quantity
            presentation.save()
            
            return JsonResponse({'shop_list': "nothing"})


    template = 'catering/warehouse.html'
    title = 'Movimientos de Almacen'
    context = {
        'presentations': presentations,
        'supps':supps,
        'title': title,
        'page_title': PAGE_TITLE
    }
    return render(request, template, context)


@login_required(login_url='users:login')
def shop_list(request):
    shop_list = ShopList.objects.all()

    if request.method == 'POST':

        if request.POST['type'] == 'load_list':
            element = json.loads(request.POST.get('load_list'))
            list_sl = ShopListDetail.objects.filter(shop_list_id=element)

            shop_list_array = []

            for ele_shoplist in list_sl:
                list_object = {
                    'pk':ele_shoplist.pk,
                    'nombre':ele_shoplist.presentation.supply.name,
                    'cantidad':ele_shoplist.quantity,
                    'medida':ele_shoplist.presentation.measurement_quantity,
                    'unidad':ele_shoplist.presentation.measurement_unit,
                    'costo':ele_shoplist.presentation.presentation_cost * ele_shoplist.quantity,
                    'status':ele_shoplist.status
                }

                shop_list_array.append(list_object)

            list_naive_array = {'shop_list': shop_list_array}
            return JsonResponse(list_naive_array)

        if request.POST['type'] == 'load_list_detail':
            element = json.loads(request.POST.get('ele_pk'))
            list_sl = ShopListDetail.objects.get(id=element)

            pres = Presentation.objects.get(pk=list_sl.presentation.pk)
            pres.on_warehouse += list_sl.quantity
            pres.save()

            list_sl.status = "DE"
            list_sl.deliver_day = datetime.now()
            list_sl.save()


        if request.POST['type'] == 'load_date':
            element = json.loads(request.POST.get('detail_list_id'))
            list_sl = ShopListDetail.objects.get(id=element)
            date = list_sl.deliver_day

            return HttpResponse(date)

    template = 'catering/shoplist.html'
    title = 'Lista de Compras'
    context = {
        'shop_list': shop_list,
        'title': title,
        'page_title': PAGE_TITLE
    }
    return render(request, template, context)


@login_required(login_url='users:login')
def new_shoplist(request):
    products_helper = ProductsHelper()
    supps = products_helper.get_all_supplies()
    all_presentations = Presentation.objects.all()

    if request.method == 'POST':
        form = PresentationForm(request.POST, request.FILES)
        if form.is_valid():
            presentation = form.save(commit=False)
            presentation.save()
            return redirect('/warehouse/new_shoplist')

        if request.POST['type'] == 'shop_list':
            shop_l = json.loads(request.POST.get('shop_list'))

            new_shop_list = ShopList.objects.create()
            new_shop_list.save()

            for item in shop_l:
                sel_pre = Presentation.objects.get(pk=item[5])
                ShopListDetail.objects.create(
                    shop_list=new_shop_list,
                    presentation=sel_pre,
                    quantity=item[6])

            return redirect('/warehouse/shoplist')

    else:
        form = PresentationForm()

    template = 'catering/new_shoplist_2.html'
    title = 'Lista de Compras'
    context = {
        'form': form,
        'title': title,
        'supplies':supps,
        'presentations':all_presentations,
    }
    return render(request, template, context)


@login_required(login_url='users:login')
def warehouse_analytics(request):

    sales_helper = TicketPOSHelper()
    helper = Helper()
    products_helper = ProductsHelper()
    today = datetime.today()
    current_year = today.year
    current_month = today.month
    category = "select"

    resultado = products_helper.get_cartridges_sales_by_date(
        current_year, current_month, category)

    sales_data = resultado['sales_data']
    json_sales_data_by_date = resultado['json_sales_data_by_date']

    if request.method == 'POST':
        if request.POST['type'] == 'load_date':
            selected_year = request.POST['year']
            selected_month = request.POST['month']
            selected_category = request.POST['category']

            resultado = products_helper.get_cartridges_sales_by_date(
                int(selected_year), int(selected_month), selected_category)

            sales_data = resultado['sales_data']
            json_sales_data_by_date = resultado['json_sales_data_by_date']

            return JsonResponse({
                'sales_data':
                sales_data,
                'json_sales_data_by_date':
                json_sales_data_by_date
            })

    template = 'catering/analytics.html'
    title = 'Almacen - Analytics'
    context = {
        'sales_data_by_date': json_sales_data_by_date,
        'sales_data': sales_data,
        'today': today,
        'title': title,
        'page_title': PAGE_TITLE
    }
    return render(request, template, context)