from django.conf import settings
from django.conf.urls import url

from . import views
from .views import *

from .views import Update_Cartridge
from .views import Delete_Cartridge
from .views import Create_Cartridge

app_name = 'products'

urlpatterns = [

    # Supplies
    url(r'^supplies/$', views.supplies, name='supplies'),
    url(r'^supplies/new/$', Create_Supply.as_view(), name='new_supply'),
    url(r'^supplies/details/(?P<pk>[0-9]+)/$', views.supply_detail, name='supply_detail'),
    url(r'^supplies/modify/(?P<pk>[0-9]+)/$', Update_Supply.as_view(), name='supply_modify'),
    url(r'^supplies/delete/(?P<pk>[0-9]+)/$', Delete_Supply.as_view(), name='supply_delete'),

    # Presentations
    url(r'^presentation/new/(?P<suppk>[0-9]+)/$', Create_Presentation.as_view(), name='new_presentation'),
    url(r'^presentation/modify/(?P<suppk>[0-9]+)/(?P<pk>[0-9]+)/$', Update_Presentation.as_view(), name='update_presentation'),
    url(r'^presentation/delete/(?P<suppk>[0-9]+)/(?P<pk>[0-9]+)/$', Delete_Presentation.as_view(), name='delete_presentation'),    

    # Cartridges
    url(r'^cartridges/$', views.cartridges, name='cartridges'),
    url(r'^cartridges/new/$', Create_Cartridge.as_view(), name='new_cartridge'),
    url(r'^cartridges/detail/(?P<pk>[0-9]+)/$', views.cartridge_detail, name='cartridge_detail'),
    url(r'^cartridges/modify/(?P<pk>[0-9]+)/$', Update_Cartridge.as_view(), name='cartridge_modify'),
    url(r'^cartridges/delete/(?P<pk>[0-9]+)/$', Delete_Cartridge.as_view(), name='cartridge_delete'),

    # Suppliers
    url(r'^suppliers/$', views.suppliers, name='suppliers'),

    # Categories
    url(r'^categories/$', views.categories, name='categories'),
    url(r'^categories/new/$', views.new_category, name='new_category'),
    url(r'^categories/([A-Za-z]+)/$', views.categories_supplies, name='categories_supplies'),

    # Warehouse
    url(r'^warehouse/$', views.warehouse, name='warehouse'),        
    url(r'^warehouse/analytics$', views.warehouse_analytics, name='warehouse_analytics'),        
    url(r'^warehouse/shoplist/$', views.shop_list, name='shoplist'),
    url(r'^warehouse/new_shoplist/$', views.new_shoplist, name='new_shoplist'),

    # Menu
    url(r'^menu/$', views.menu, name='menu'),
]

# test
if settings.DEBUG:
    urlpatterns.append(url(r'^products/test/$', views.test, name='test'))
