from django.shortcuts import get_object_or_404, render, redirect

from django.contrib.auth.decorators import login_required

from branchoffices.models import Supplier
from cloudkitchen.settings.base import PAGE_TITLE
from products.forms import SupplyForm, SuppliesCategoryForm, CartridgeForm
from products.models import Cartridge, Supply, SuppliesCategory, KitchenAssembly
from kitchen.models import Presentation, ShopList, ShopListDetail
from helpers.products_helper import ProductsHelper
from django.views.generic import UpdateView
from django.views.generic import DeleteView
from django.views.generic import CreateView
from .forms import PresentationForm


class CreateSupply(CreateView):
    model = Supply
    fields = ['name','category','barcode','supplier','storage_required','presentation_unit','presentation_cost',
        'measurement_quantity','measurement_unit','optimal_duration','optimal_duration_unit','location','image']
    template_name = 'new_supply.html'

    def form_valid(self, form):
        self.object = form.save()
        return redirect('/supplies/')


class Update_Supply(UpdateView):
    model = Supply
    fields = ['name','category','barcode','supplier','storage_required','presentation_unit','presentation_cost',
        'measurement_quantity','measurement_unit','optimal_duration','optimal_duration_unit','location','image']
    template_name = 'new_supply.html'

    def form_valid(self, form):
        self.object = form.save()
        return redirect('/supplies/')


class Delete_Supply(DeleteView):
    model = Supply
    template_name = 'delete_supply.html'

    def delete(self, request, *args, **kwargs):
        self.object = self.get_object()
        self.object.delete()
        return redirect('/supplies/')


class CreateCartridge(CreateView):
    model = Cartridge
    fields = ['name', 'price', 'category', 'image']
    template_name = 'new_cartridge.html'

    def form_valid(self, form):
        self.object = form.save()
        return redirect('/cartridges/')


class UpdateCartridge(UpdateView):
    model = Cartridge
    fields = ['name', 'price', 'category', 'image']
    template_name = 'new_cartridge.html'

    def form_valid(self, form):
        self.object = form.save()
        return redirect('/cartridges/')


class DeleteCartridge(DeleteView):
    model = Cartridge
    template_name = 'delete_cartridge.html'

    def delete(self, request, *args, **kwargs):
        self.object = self.get_object()
        self.object.delete()
        return redirect('/cartridges/')


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
    template = 'supplies/supply_detail.html'
    title = 'DabbaNet - Detalles del insumo'
    context = {'page_title': PAGE_TITLE, 'supply': supply, 'title': title}
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


@login_required(login_url='users:login')
def warehouse(request):
    products_helper = ProductsHelper()
    warehouse_list = products_helper.get_elements_in_warehouse()

    if request.method == 'POST':

        if request.POST['type'] == 'save_to_assembly':

            quantity = json.loads(request.POST.get('quantity_available'))
            warehouse_id = json.loads(request.POST.get('warehouse_id'))

            # Retirar del almacen
            selected_warehouse = Warehouse.objects.get(id=warehouse_id)
            selected_warehouse.quantity -= quantity
            selected_warehouse.save()

            # Agregar al almacen
            try:
                itemstock = Warehouse.objects.get(
                    supply=selected_warehouse.supply, status="AS")
                itemstock.quantity += quantity
                itemstock.save()
            except Warehouse.DoesNotExist:
                itemstock = Warehouse(
                    supply=selected_warehouse.supply,
                    status="AS",
                    quantity=quantity,
                    measurement_unit=selected_warehouse.measurement_unit)
                itemstock.save()

    template = 'catering/warehouse.html'
    title = 'Movimientos de Almacen'
    context = {
        'warehouse_list': warehouse_list,
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
                    'id':
                    ele_shoplist.id,
                    'nombre':
                    ele_shoplist.presentation.supply.name,
                    'cantidad':
                    ele_shoplist.quantity,
                    'medida':
                    ele_shoplist.presentation.measurement_quantity,
                    'unidad':
                    ele_shoplist.presentation.measurement_unit,
                    'costo':
                    ele_shoplist.presentation.presentation_cost *
                    ele_shoplist.quantity,
                    'status':
                    ele_shoplist.status
                }

                shop_list_array.append(list_object)

            list_naive_array = {'shop_list': shop_list_array}
            return JsonResponse(list_naive_array)

        if request.POST['type'] == 'load_list_detail':
            element = json.loads(request.POST.get('load_list_detail'))
            list_sl = ShopListDetail.objects.get(id=element)
            list_sl.status = "DE"
            list_sl.deliver_day = datetime.now()
            list_sl.save()

            try:
                itemstock = Warehouse.objects.get(
                    supply=list_sl.presentation.supply, status="ST")
                itemstock.quantity += list_sl.quantity * list_sl.presentation.measurement_quantity
                itemstock.save()
            except Warehouse.DoesNotExist:
                itemstock = Warehouse(
                    supply=list_sl.presentation.supply,
                    status="ST",
                    quantity=list_sl.quantity *
                    list_sl.presentation.measurement_quantity,
                    measurement_unit=list_sl.presentation.measurement_unit)
                itemstock.save()

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

    shop_list = ShopList.objects.all()

    supply_list = []

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
                sel_pre = Presentation.objects.get(pk=item['pre_pk'])
                ShopListDetail.objects.create(
                    shop_list=new_shop_list,
                    presentation=sel_pre,
                    quantity=item['Cantidad'])

            return redirect('/warehouse/shoplist')

    else:
        form = PresentationForm()

    for sup in supps:
        print(sup)
        element_object = {
            'pk': sup.pk,
            'name': sup.name,
            'imagen': sup.image.url,
        }
        supp_presentations = all_presentations.filter(supply=sup)
        supp_pres = []

        for supp_pre in supp_presentations:
            supp_pres.append(supp_pre)

        element_object['presentations'] = supp_pres
        supply_list.append(element_object)

    template = 'catering/new_shoplist.html'
    title = 'Lista de Compras'
    context = {
        'shop_list': shop_list,
        'form': form,
        'title': title,
        'supply_list': supply_list,
        'page_title': PAGE_TITLE
    }
    return render(request, template, context)