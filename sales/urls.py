from django.conf import settings
from django.conf.urls import url

from sales import views
from sales.views import SalesReport

app_name = 'sales'

urlpatterns = [
    # sales
    url(r'^ventas/$', views.sales, name='sales'),
    url(r'^nueva-venta/$', views.new_sale__, name='sales_new'),
    url(r'^ventas/eliminar/$', views.delete_sale, name='sales_delete'),
    url(r'^ventas/reporte/$', SalesReport.as_view(), name='sales_report'),

    # New features
    url(r'^ventas/nueva-venta/$', views.new_sale, name='sales__new_sale')

]

if settings.DEBUG:
    # NEW SALES UPGRADE
    urlpatterns.append(url('^test/sales/update/$', views.test_sales_update, name='test_sales_update'))
