from django.conf import settings
from django.conf.urls import url

from users import views

app_name = 'users'

urlpatterns = [
    # index
    url(r'^home/$', views.index, name='index'),

    # auth
    url(r'^auth/$', views.login, name='login'),
    url(r'^auth/logout/$', views.logout, name='logout'),
    url(r'^auth/login_register/$', views.login_register, name='login_register'), 

    # profile
    # url(r'^profiles/$', views.ProfileVIew, name='profiles'),

    # test
]

if settings.DEBUG:
    urlpatterns.append(url(r'^customers/test', views.test, name='cutomers_test'))