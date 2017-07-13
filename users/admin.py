from django.contrib import admin

from users.models import User as UserProfile, UserMovements


class UserProfileAdmin(admin.ModelAdmin):
	pass


@admin.register(UserMovements)
class UserMovements(admin.ModelAdmin):
    list_display = ('user', 'category', 'creation_date',)
    ordering = ('creation_date',)


admin.site.register(UserProfile, UserProfileAdmin)
