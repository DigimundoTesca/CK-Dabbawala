from django.conf.urls import url

from kitchen import views

app_name = 'kitchen'

urlpatterns = [
    # Kitchen
    url(r'kitchen/assembly/$', views.assembly, name='assembly'),
    url(r'kitchen/(?P<kitchen_type>\w{3,4})/$', views.kitchen, name='kitchen'),
]
