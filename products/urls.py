from django.conf import settings
from django.conf.urls import url

from . import views
from .views import *

from .views import UpdateCartridge
from .views import DeleteCartridge
from .views import CreateCartridge

app_name = 'products'

urlpatterns = [

    # Supplies
    url(r'^insumos/$', views.supplies, name='supplies'),
    url(r'^insumos/nuevo/$', CreateSupply.as_view(), name='new_supply'),
    url(r'^insumos/(?P<pk>[0-9]+)/$', views.supply_detail, name='supply_detail'),
    url(r'^insumos/modificar/(?P<pk>[0-9]+)/$', UpdateSupply.as_view(), name='supply_modify'),
    url(r'^insumos/eliminar/(?P<pk>[0-9]+)/$', DeleteSupply.as_view(), name='supply_delete'),

    # Cartridges
    url(r'^cartuchos/$', views.cartridges, name='cartridges'),
    url(r'^cartuchos/nuevo/$', CreateCartridge.as_view(), name='new_cartridge'),
    url(r'^cartuchos/(?P<pk>[0-9]+)/$', views.cartridge_detail, name='cartridge_detail'),
    url(r'^cartuchos/modificar/(?P<pk>[0-9]+)/$', UpdateCartridge.as_view(), name='cartridge_modify'),
    url(r'^cartuchos/eliminar/(?P<pk>[0-9]+)/$', DeleteCartridge.as_view(), name='cartridge_delete'),

    # Suppliers
    url(r'^proveedores/$', views.suppliers, name='suppliers'),

    # Categories
    url(r'^categories/$', views.categories, name='categories'),
    url(r'^categories/nuevo/$', views.new_category, name='new_category'),
    url(r'^categories/([A-Za-z]+)/$', views.categories_supplies, name='categories_supplies'),

    # Menu
    url(r'^menu/$', views.menu, name='menu'),
]

# test
if settings.DEBUG:
    urlpatterns.append(url(r'^productos/test/$', views.test, name='test'))
