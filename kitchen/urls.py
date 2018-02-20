from django.conf.urls import url

from kitchen import views

app_name = 'kitchen'

urlpatterns = [
    # Warehouse
    # url(r'warehouse/$', views.supplies, name='supplies'),

    # Kitchen
    url(r'cocina/ensamblado/$', views.assembly, name='assembly'),
    url(r'cocina/(?P<kitchen_type>\w{4,10})/$', views.kitchen, name='kitchen')
]
