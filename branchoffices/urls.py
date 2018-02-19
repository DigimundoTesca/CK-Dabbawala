from django.conf.urls import url

from branchoffices import views

app_name = 'branch_offices'

urlpatterns = [
    url(r'^branchoffices/$', views.branch_offices, name='branch_offices'),
    url(r'^contact/$', views.contact, name='contact'),
    url(r'^job/$', views.job, name='job')
]
