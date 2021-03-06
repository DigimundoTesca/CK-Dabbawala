import json
from django.contrib.auth import authenticate
from django.contrib.auth import login as login_django
from django.contrib.auth import logout as logout_django
from django.contrib.auth.decorators import login_required
from django.contrib.auth.forms import AuthenticationForm
from django.http import HttpResponse, JsonResponse
from django.shortcuts import render, redirect, get_object_or_404

from .forms import UserForm
from .forms import CustomerUserProfileForm, CustomerProfileForm

from .models.users import UserMovements, User
from .models.customers import CustomerProfile

from cloudkitchen.settings.base import PAGE_TITLE


# HOME
# ---------------------------------------------------------------------------------------------------------------------
def home(request):
    template = 'home.html'
    context = {}
    return render(request, template, context)


def temporal_index(request):
    template = 'temporal-index.html'
    context = {}
    return render(request, template, context)


# AUTH
# ---------------------------------------------------------------------------------------------------------------------
def login(request):
    if request.user.is_authenticated():
        if request.user.has_perm('users.can_see_sales'):
            return redirect('sales:sales')
        elif request.user.has_perm('users.can_sell'):
            return redirect('sales:new_sale')
        elif request.user.has_perm('users.can_see_commands'):
            return redirect('kitchen:cold_kitchen')
        elif request.user.has_perm('users.can_assemble'):
            return redirect('kitchen:assembly')
        else:
            return redirect('users:index')

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


def login_customer(request):
    if request.user.is_authenticated():
        return redirect('orders:new_order')
    template = 'customers/login.html'

    form = AuthenticationForm(None, request.POST or None)

    if request.method == 'POST':
        if form.is_valid():
            username = request.POST['username']
            password = request.POST['password']
            access = authenticate(username=username, password=password)

            if access is not None:
                login_django(request,access)
                return redirect('orders:new_order')

    context = {
        'title': 'Bienvenido a Dabbawala. Inicia Sesión',
        'form': form,
    }
    return render(request, template, context)


@login_required(login_url='users:login')
def logout(request):
    logout_django(request)
    return redirect('users:login')


@login_required(login_url='users:login')
def logout_customer(request):
    logout_django(request)
    return redirect('orders:new_order')


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


# CUSTOMERS
# ---------------------------------------------------------------------------------------------------------------------
def register(request):
    if request.user.is_authenticated:
        return redirect('users:profile')
    customer_form = CustomerUserProfileForm(request.POST or None)
    if request.method == 'POST':
        if customer_form.is_valid():
            new_customer = customer_form.save(commit=False)
            new_customer.set_password(customer_form.cleaned_data['password'])
            new_customer.save()

            # if request.session.has_key('cart'):
                # request.session['first_session'] = True
                # return redirect('orders:login_customer')
            return redirect('users:login_customer')

    template = 'customers/register.html'
    context = {
        'form': customer_form,
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

    template = 'customers/customers_list.html'
    customers = CustomerProfile.objects.all().order_by('first_dabba')
    title = 'Clientes registrados'

    context = {
        'title': PAGE_TITLE + ' | ' + title,
        'page_title': title,
        'customers': customers,
    }

    return render(request, template, context)


@login_required(login_url='users:login_customer')
def profile(request):
    template = 'customers/profile.html'
    customer_form = CustomerProfileForm(request.POST or None)

    context = {}

    try:
        user_profile = CustomerProfile.objects.get(user_ptr=request.user)
        context['user_profile'] = user_profile
    except CustomerProfile.DoesNotExist:
        context['customer_form'] = customer_form
        return render(request, template, context)

    return render(request, template, context)


# TEST
# ---------------------------------------------------------------------------------------------------------------------
def test(request):
    form_user = CustomerUserProfileForm(request.POST or None)

    if request.method == 'POST':
        if form_user.is_valid():
            new_user = form_user.save(commit=False)
            new_user.set_password(form_user.cleaned_data['password'])
            new_user.save()
            form_user = None
            return HttpResponse('EXITO')

    template = 'test.html'
    context = {
        'form': form_user,
    }
    return render(request, template, context)
