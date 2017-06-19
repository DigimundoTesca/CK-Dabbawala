from django.contrib import admin
from .models import CustomerProfile

@admin.register(CustomerProfile)
class CustomerProfileAdmin(admin.ModelAdmin):
    list_display = ('user', 'address', 'latitude', 'longitude', 'first_dabba',)
    list_editable = ('first_dabba',)
    ordering = ('first_dabba',)
