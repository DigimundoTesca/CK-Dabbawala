from django.contrib import admin

from sales.models import *
from actions import export_as_excel


class TicketDetailInline(admin.TabularInline):
    model = TicketDetail
    extra = 1


@admin.register(TicketBase)
class TicketBaseAdmin(admin.ModelAdmin):
    list_display = (
        'id',
        'order_number',
        'created_at',
        'ticket_details',
        'payment_type',
        'total',
        'is_active'
    )
    list_filter = ('created_at', 'payment_type',)
    list_display_links = ('id', 'order_number',)
    list_editable = ('created_at',)
    ordering = ('-created_at', )
    date_hierarchy = 'created_at'
    inlines = [TicketDetailInline, ]
    actions = (export_as_excel,)


@admin.register(TicketPOS)
class TicketPOSAdmin(admin.ModelAdmin):
    list_display = (
        'ticket',
        'order_number',
        'created_at',
        'cartridges',
        'packages',
        'payment_type',
        'total',
        'is_active',
        'cashier',
    )
    list_display_links = ('ticket', 'cashier',)


@admin.register(TicketOrder)
class TicketOrderAdmin(admin.ModelAdmin):
    list_display = ('ticket', 'customer',)
    list_display_links = ('ticket', 'customer',)


class TicketExtraIngredientInline(admin.TabularInline):
    model = TicketExtraIngredient
    extra = 0


@admin.register(TicketDetail)
class TicketDetailAdmin(admin.ModelAdmin):
    list_display = ('id', 'ticket', 'created_at', 'cartridge',
                    'package_cartridge', 'extra_ingredients', 'quantity', 'price',)
    list_display_links = ('id', 'ticket', 'created_at')
    list_filter = ('ticket',)
    ordering = ('-ticket__created_at', )
    search_fields = ('ticket__created_at',)
    actions = (export_as_excel,)
    inlines = [TicketExtraIngredientInline, ]
