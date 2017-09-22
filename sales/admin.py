from django.contrib import admin

from actions import export_as_excel
from sales.models import CartridgeTicketDetail, PackageCartridgeTicketDetail, TicketBase, TicketPOS, TicketOrder, \
    TicketExtraIngredient


class CartridgeTicketDetailInline(admin.TabularInline):
    model = CartridgeTicketDetail
    extra = 1


class PackageCartridgeDetailInline(admin.TabularInline):
    model = PackageCartridgeTicketDetail
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
    inlines = [CartridgeTicketDetailInline, PackageCartridgeDetailInline]
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

