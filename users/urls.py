from django.conf import settings
from django.conf.urls import url

from users import views

app_name = 'users'

urlpatterns = [
    # temporal-index
    url(r'^$', views.temporal_index, name='index'),

    # home
    url(r'^home/$', views.home, name='home'),

    # auth
    url(r'^auth/$', views.login, name='login'),
    url(r'^auth/logout/$', views.logout, name='logout'),
    url(r'^auth/registro$', views.login_register, name='login_register'),

    # profile
    # url(r'^profiles/$', views.ProfileVIew, name='profiles'),

    # Customers
    url(r'^clientes/$', views.customers_list, name='customers_list'),
    url(r'^login/$', views.login_customer, name='login_customer'),
    url(r'^logout/$', views.logout_customer, name='logout_customer'),
    url(r'^primeravez/$', views.register, name='register'),
    url(r'^perfil/$', views.profile, name='profile')
]

if settings.DEBUG:
    urlpatterns.append(url(r'^register/test', views.test, name='register_test'))
