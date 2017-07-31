from django.conf import settings
from django.conf.urls import url

from . import views


app_name = 'orders'

urlpatterns = [
    # New Customer
    url(r'^arma-tu-dabba/$', views.new_order, name='new_order'),
    url(r'^pagar/$', views.pay, name='pay'),
    url(r'^ordenes/pendientes/$', views.customer_orders, name='customer_orders'),
]

# Test
if settings.DEBUG:
    # urlpatterns.append( url(r'^customers/test/$', views.test, name='customers_test'))
    pass
