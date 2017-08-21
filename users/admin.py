from django.contrib import admin

from .models.users import User as UserProfile, UserMovements
from .models.customers import CustomerProfile


@admin.register(UserProfile)
class UserProfileAdmin(admin.ModelAdmin):
    list_display = ('username', 'email', 'is_active', 'is_staff','is_superuser')
    list_editable = ('email', 'is_active',)
    ordering = ('username', )


@admin.register(UserMovements)
class UserMovements(admin.ModelAdmin):
    list_display = ('user', 'category', 'creation_date',)
    ordering = ('creation_date',)


@admin.register(CustomerProfile)
class CustomerProfileAdmin(admin.ModelAdmin):
    list_display = ('username', 'email', 'address', 'is_active', 'first_dabba',)
    ordering = ('username',)
