from django.contrib import admin

from branchoffices.models import BranchOffice, Supplier


@admin.register(BranchOffice)
class AdminBranchOffice(admin.ModelAdmin):
    list_display = ('name', 'manager', 'address',)


@admin.register(Supplier)
class AdminProvider(admin.ModelAdmin):
    list_display = ('name', 'image',)
