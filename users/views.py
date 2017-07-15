import json
from django.conf import settings
from django.contrib.auth.decorators import login_required
from django.http import HttpResponse, JsonResponse
from django.shortcuts import render, redirect

from django.contrib.auth import authenticate
from django.contrib.auth import login as login_django
from django.contrib.auth import logout as logout_django

from users.forms import UserForm
from users.models import UserMovements, CustomerProfile

from .forms import CustomerProfileForm

from cloudkitchen.settings.base import PAGE_TITLE


# -------------------------------------  Index -------------------------------------

def test(request):
    return HttpResponse('Yours tests here')


# -------------------------------------  Index -------------------------------------
def home(request):
    template = 'home.html'
    context = {}
    return render(request, template, context)


def temporal_index(request):
    template = 'temporal-index.html'
    context = {}
    return render(request, template, context)


# -------------------------------------  Auth -------------------------------------
def login(request):
    if request.user.is_authenticated():
        # login(request.user)
        return redirect('sales:sales')
    tab = 'login'
    error_message = None
    success_message = None
    template = 'auth/login.html'

    form_user = UserForm(request.POST or None)

    if request.method == 'POST':
        if 'form-register' in request.POST:
            tab = 'register'
            if form_user.is_valid():
                new_user = form_user.save(commit=False)
                new_user.set_password(form_user.cleaned_data['password'])
                new_user.save()
                tab = 'register'
                success_message = 'Usuario creado. Necesita ser activado por un administrador'
                form_user = None

        elif 'form-login' in request.POST:
            form_user = UserForm(None)
            username_login = request.POST.get('username_login')
            password_login = request.POST.get('password_login')
            user = authenticate(username=username_login, password=password_login)

            if user is not None:
                login_django(request, user)
                login_check(user.username)
                return redirect('sales:sales')

            else:
                error_message = 'Usuario o contraseña incorrecto'

    context = {
        'tab': tab,
        'title': 'Bienvenido a CloudKitchen. Inicia Sesión o registrate.',
        'error_message': error_message,
        'success_message': success_message,
        'form_user': form_user,
    }
    return render(request, template, context)


@login_required(login_url='users:login')
def logout(request):
    logout_django(request)
    return redirect('users:login')


@login_required(login_url='users:login')
def login_register(request):

    objects = UserMovements.objects.all()

    template = 'auth/login_register.html'
    title = 'Tabla de Usuarios'
    context={
    'titie' : title,
    'objects' : objects
    }
    return render(request, template, context)


def login_check(user):
    movement = UserMovements.objects.create(category='LogIn',user=user)
    movement.save()


@login_required(login_url='users:login')
def logout_check(user):
    movement = UserMovements.objects.create(category='LogOut',user=user)
    movement.save()


# -------------------------------------  Customers -------------------------------------
def new_customer(request):
    form_customer = CustomerProfileForm(request.POST or None)
    if request.method == 'POST':
        print(request.POST)
        if form_customer.is_valid():
            customer = form_customer.save(commit=False)
            customer.save()
            return redirect('users:thanks')

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
            if request.session.has_key('cart'):
                request.session['first_session'] = True
                return redirect('orders:pay')
            return redirect('orders:new_order')

    template = 'register/register.html'
    title = 'Bienvenido a Dabbawala.'
    context = {
        'form_customer': form_customer,
        'title': title,
    }

    return render(request, template, context)



def thanks(request):
    if request.method == 'POST':
        form = CustomerProfileForm(request.POST, request.FILES)
        if form.is_valid():
            customer = form.save(commit=False)
            customer.save()
            return redirect('users:new_customer')
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
