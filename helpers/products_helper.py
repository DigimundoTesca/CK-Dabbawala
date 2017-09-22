from kitchen.models import Warehouse
from products.models import Cartridge, CartridgeRecipe, PackageCartridge, \
    PackageCartridgeRecipe, Supply, ExtraIngredient


class ProductsHelper(object):
    def __init__(self):
        super(ProductsHelper, self).__init__()
        self.__cartridges = None
        self.__packages_cartridges = None
        self.__supplies = None
        self.__extra_ingredients = None
        self.__all_cartridges_recipes = None
        self.__elements_in_warehouse = None
        self.__all_packages_cartridges_recipes = None

    def get_all_supplies(self):
        """
        :rtype: django.db.models.query.QuerySet
        """
        if self.__supplies is None:
            self.set_supplies()
        return self.__supplies

    @property
    def cartridges(self):
        """
        :rtype: django.db.models.query.QuerySet
        """
        if self.__cartridges is None:
            self.set_cartridges()
        return self.__cartridges

    @property
    def packages_cartridges(self):
        """
        :rtype: django.db.models.query.QuerySet
        """
        if self.__packages_cartridges is None:
            self.set_packages_cartridges()
        return self.__packages_cartridges

    def get_extra_ingredients(self):
        """
        :rtype: django.db.models.query.QuerySet
        """
        if self.__extra_ingredients is None:
            self.set_extra_ingredients()

        return self.__extra_ingredients

    def get_cartridges_recipes(self):
        """
        :rtype: django.db.models.query.QuerySet
        """
        if self.__all_cartridges_recipes is None:
            self.set_cartridges_recipes()

        return self.__all_cartridges_recipes

    def get_packages_cartridges_recipes(self):
        """
        :rtype: django.db.models.query.QuerySet
        """
        if self.__all_packages_cartridges_recipes is None:
            self.set_package_cartridges_recipes()

        return self.__all_packages_cartridges_recipes

    def get_elements_in_warehouse(self):
        """
        :rtype: django.db.models.query.QuerySet
        """
        if self.__elements_in_warehouse is None:
            self.set_elements_in_warehouse()
        return self.__elements_in_warehouse

    def set_supplies(self):
        self.__supplies = Supply.objects. \
            select_related('category'). \
            select_related('supplier'). \
            select_related('location').order_by('name')

    def set_cartridges(self):
        self.__cartridges = Cartridge.objects.order_by('subcategory', 'name')

    def set_packages_cartridges(self):
        self.__packages_cartridges = PackageCartridge.objects.all()

    def set_cartridges_recipes(self):
        self.__all_cartridges_recipes = CartridgeRecipe.objects. \
            select_related('cartridge'). \
            select_related('supply'). \
            all()

    def set_package_cartridges_recipes(self):
        self.__all_packages_cartridges_recipes = PackageCartridgeRecipe.objects. \
            select_related('package_cartridge'). \
            select_related('cartridge'). \
            all()

    def set_extra_ingredients(self):
        self.__extra_ingredients = ExtraIngredient.objects. \
            select_related('ingredient'). \
            select_related('cartridge'). \
            all()

    def set_elements_in_warehouse(self):
        self.__elements_in_warehouse = Warehouse.objects.select_related('supply').all().order_by('supply__name')
