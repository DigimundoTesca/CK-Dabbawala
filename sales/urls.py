from django.conf import settings
from django.conf.urls import url

from sales import views
from sales.views import SalesReport

app_name = 'sales'

urlpatterns = [
    # sales
    url(r'^sales/$', views.sales, name='sales'),
    url(r'^sales/new/$', views.new_sale, name='sales_new'),
    url(r'^sales/delete/$', views.delete_sale, name='sales_delete'),
    url(r'^sales/report/$', SalesReport.as_view(), name='sales_report')
]

if settings.DEBUG:
    # NEW SALES UPGRADE
    urlpatterns.append(url('^test/sales/update/$', views.test_sales_update, name='test_sales_update'))
