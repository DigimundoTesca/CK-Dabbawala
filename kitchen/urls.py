from django.conf.urls import url

from kitchen import views

app_name = 'kitchen'

urlpatterns = [
    # Warehouse
    # url(r'warehouse/$', views.supplies, name='supplies'),

    # Kitchen
    url(r'cocina/fria/$', views.cold_kitchen, name='cold_kitchen'),
    url(r'cocina/caliente/$', views.hot_kitchen, name='hot_kitchen'),
    url(r'cocina/ensamblado/$', views.assembly, name='assembly'),
]
