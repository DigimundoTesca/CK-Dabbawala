from __future__ import unicode_literals
from django.contrib import admin
from actions import export_as_excel

from .models import PackageCartridge, PackageCartridgeRecipe, CartridgeRecipe, Supply, SupplyLocation, \
    SuppliesCategory, Cartridge, ExtraIngredient, KitchenAssembly


@admin.register(SuppliesCategory)
class AdminSuppliesCategory(admin.ModelAdmin):
    list_display = ('name', 'image',)


@admin.register(KitchenAssembly)
class AdminKitchenAssembly(admin.ModelAdmin):
    list_display = ('id', 'name',)
    list_display_links = ('id', 'name',)


@admin.register(SupplyLocation)
class AdminSupplyLocation(admin.ModelAdmin):
    list_display = ('location', 'branch_office',)


@admin.register(Supply)
class AdminSupply(admin.ModelAdmin):
    list_display = ('id', 'name', 'category', 'supplier',)
    list_display_links = ('id', 'name')
    ordering = ['name']


class CartridgeRecipeInline(admin.TabularInline):
    model = CartridgeRecipe
    extra = 0


class ExtraIngredientInline(admin.TabularInline):
    model = ExtraIngredient
    extra = 0


@admin.register(Cartridge)
class AdminCartridge(admin.ModelAdmin):
    list_display = ('id', 'name', 'description', 'price', 'category', 'subcategory', 'kitchen_assembly', 'is_active',
                    'created_at','get_image', 'image')
    list_display_links = ('id', 'name')
    list_editable = ('price', 'image', 'category', 'subcategory', 'is_active')
    inlines = [CartridgeRecipeInline, ExtraIngredientInline]
    ordering = ['name']
    actions = (export_as_excel,)


class PackageCartridgeRecipeInline(admin.TabularInline):
    model = PackageCartridgeRecipe
    extra = 0

    def formfield_for_foreignkey(self, db_field, request, **kwargs):
        if db_field.name == 'cartridge':
            kwargs['queryset'] = Cartridge.objects.order_by('name')
        return super(PackageCartridgeRecipeInline, self).formfield_for_foreignkey(db_field, request, **kwargs)


@admin.register(PackageCartridge)
class AdminPackageCartridge(admin.ModelAdmin):
    list_display = ('id', 'name', 'description', 'price', 'is_active', 'package_recipe')
    list_display_links = ('id', 'name')
    list_editable = ('price', 'is_active')
    inlines = [PackageCartridgeRecipeInline]
    ordering = ['name']
