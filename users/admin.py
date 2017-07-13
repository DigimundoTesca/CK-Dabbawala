from django.contrib import admin

from .models import User as UserProfile, UserMovements, CustomerProfile


@admin.register(UserProfile)
class UserProfileAdmin(admin.ModelAdmin):
	pass


@admin.register(UserMovements)
class UserMovements(admin.ModelAdmin):
    list_display = ('user', 'category', 'creation_date',)
    ordering = ('creation_date',)


@admin.register(CustomerProfile)
class CustomerProfileAdmin(admin.ModelAdmin):
    list_display = ('user', 'address', 'latitude', 'longitude', 'first_dabba',)
    list_editable = ('first_dabba',)
    ordering = ('first_dabba',)
