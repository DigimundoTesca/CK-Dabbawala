from django.conf import settings
from django.conf.urls import url

from sales import views

app_name = 'sales'

urlpatterns = [
    # sales
    url(r'^sales/$', views.sales, name='sales'),
    url(r'^sales/new/$', views.new_sale, name='new_sale'),
    url(r'^sales/delete/$', views.delete_sale, name='delete-sale'),

]

if settings.DEBUG:
    # NEW SALES UPGRADE
    urlpatterns.append(url('^test/sales/$', views.test_sales, name='test_sales'))
    urlpatterns.append(url('^test/sales/update/$', views.test_sales_update, name='test_sales_update'))
    urlpatterns.append(url('^test/sales/new/$', views.test_sales_new, name='test_sales_new'))
    urlpatterns.append(url('^test/sales/delete/$', views.test_sales_delete, name='test_sales_delete'))
