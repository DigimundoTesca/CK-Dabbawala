from django.conf.urls import url

from kitchen import views

app_name = 'kitchen'

urlpatterns = [
    # Warehouse
    # url(r'warehouse/$', views.supplies, name='supplies'),

    # Kitchen
    url(r'kitchen/assembly/$', views.assembly, name='assembly'),
    url(r'kitchen/(?P<kitchen>\w{3,4})/$', views.kitchen, name='kitchen'),
]
