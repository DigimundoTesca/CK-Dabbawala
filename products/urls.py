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
    url(r'^supplies/$', views.supplies, name='supplies'),
    url(r'^supplies/new/$', CreateSupply.as_view(), name='new_supply'),
    url(r'^supplies/(?P<pk>[0-9]+)/$', views.supply_detail, name='supply_detail'),
    url(r'^supplies/modify/(?P<pk>[0-9]+)/$', Update_Supply.as_view(), name='supply_modify'),
    url(r'^supplies/delete/(?P<pk>[0-9]+)/$', Delete_Supply.as_view(), name='supply_delete'),

    # Cartridges
    url(r'^cartridges/$', views.cartridges, name='cartridges'),
    url(r'^cartridges/new/$', CreateCartridge.as_view(), name='new_cartridge'),
    url(r'^cartridges/(?P<pk>[0-9]+)/$', views.cartridge_detail, name='cartridge_detail'),
    url(r'^cartridges/modify/(?P<pk>[0-9]+)/$', UpdateCartridge.as_view(), name='cartridge_modify'),
    url(r'^cartridges/delete/(?P<pk>[0-9]+)/$', DeleteCartridge.as_view(), name='cartridge_delete'),

    # Suppliers
    url(r'^suppliers/$', views.suppliers, name='suppliers'),

    # Categories
    url(r'^categories/$', views.categories, name='categories'),
    url(r'^categories/new/$', views.new_category, name='new_category'),
    url(r'^categories/([A-Za-z]+)/$', views.categories_supplies, name='categories_supplies'),

    # Warehouse
    url(r'^warehouse/$', views.warehouse, name='warehouse'),        
    url(r'^warehouse/shoplist/$', views.shop_list, name='shoplist'),
    url(r'^warehouse/new_shoplist/$', views.new_shoplist, name='new_shoplist'),

    # Menu
    url(r'^menu/$', views.menu, name='menu'),
]

# test
if settings.DEBUG:
    urlpatterns.append(url(r'^products/test/$', views.test, name='test'))
