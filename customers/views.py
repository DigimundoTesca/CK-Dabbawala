import json

from django.contrib.auth.decorators import login_required
from django.http import JsonResponse
from django.shortcuts import render, redirect

from customers.models import CustomerProfile
from .forms import CustomerProfileForm


from cloudkitchen.settings.base import PAGE_TITLE


# -------------------------------------  Customers -------------------------------------
def new_customer(request):
    form_customer = CustomerProfileForm(request.POST or None)
    if request.method == 'POST':
        print(request.POST)
        if form_customer.is_valid():
            customer = form_customer.save(commit=False)
            customer.save()
            return redirect('customers:thanks')

    template = 'register/new_customer.html'
    title = 'Dabbawala - Bienvenido a Dabbawala. Registrare y obtén un desayuno gratis. '
    context = {
        'form_customer': form_customer,
        'title': title,
    }

    return render(request, template, context)


def register(request):
    form_customer = CustomerProfileForm(request.POST or None)
    if request.method == 'POST':
        if form_customer.is_valid():
            customer = form_customer.save(commit=False)
            customer.save()
            return redirect('customers:thanks')

    template = 'register/register.html'
    title = 'Bienvenido a Dabbawala.'
    context = {
        'form_customer': form_customer,
        'title': title,
    }
    if request.method == 'POST':
        if 'newuser' in request.POST:
            if request.POST['type'] == 'regist_user':
                new_user = request.POST['newuser']
                print(new_user)

    return render(request, template, context)



def thanks(request):
    if request.method == 'POST':
        form = CustomerProfileForm(request.POST, request.FILES)
        if form.is_valid():
            customer = form.save(commit=False)
            customer.save()
            return redirect('customers:new_customer')
    else:
        form = CustomerProfileForm()

    template = 'register/thanks.html'
    title = 'Dabbawala - Registro de clientes'

    context = {
        'form': form,
        'title': title,
    }

    return render(request, template, context)



@login_required(login_url='users:login')
def customers_list(request):
    if request.method == 'POST':
        customer_json_object = json.loads(request.POST.get('customer'))

        customer_object = CustomerProfile.objects.get(id=customer_json_object['id'])
        customer_object.first_dabba = True
        customer_object.save()
        data = {
            'status': 'ready'
        }
        return JsonResponse(data)

    template = 'register/customers_list.html'
    customers = CustomerProfile.objects.all().order_by('first_dabba')
    title = 'Clientes registrados'

    context = {
        'title': title,
        'page_title': PAGE_TITLE,
        'customers': customers,
    }

    return render(request, template, context)


