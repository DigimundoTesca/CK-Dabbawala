from django.conf import settings
from django.conf.urls import url

from . import views


app_name = 'customers'

urlpatterns = [
    # New Customer
    url(r'^register-old/$', views.new_customer, name='new_customer'),
    url(r'^register/$', views.register, name='register'),
    url(r'^register/thanks/$', views.thanks, name='thanks'),
    url(r'^customers/register/list/$', views.customers_list, name='customers_list'),
]

# Test
if settings.DEBUG:
    # urlpatterns.append( url(r'^customers/test/$', views.test, name='customers_test'))
    pass
