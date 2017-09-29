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

class PredictionSale:
    def __init__(self):
        super(PredictionSale, self).__init__()
        self.__id_prediction_cartridge = None
        self.__all_sales_cartridges_prediction = None
        self.__all_sales_cartridges_real = None
        self.__all_sales_cartridges_simulated = None
        self.__sd_cartridge = None
        self.__mean_cartridge = None
        self.__estimated_amount = None
        self.__simulated_sale = None

    def set_id_prediction_cartridge(self):
        pass

    def set_all_sales_cartridges_prediction(self):
        self.__all_sales_cartridges_prediction = get_all_sales_cartridges_real() + get_all_sales_cartridges_simulated()

    def set_all_sales_cartridges_real(self):
        self.__all_sales_cartridges_real = Cartridge.object. \
            filter(cartridge__id=self.__id_prediction_cartridge). \
            filter(simulated_quantity=0)

    def set_all_sales_cartridges_simulated(self):
        self.__all_sales_cartridges_real = Cartridge.object. \
            filter(cartridge__id=self.__id_prediction_cartridge). \
            exclude(simulated_quantity=0)

    def set_mean_cartridge(self):
        self.__mean_cartridge = stats.mean(self.get_all_sales_cartridge_prediction())

    def set_sd_cartridge(self):
        self.__sd_cartridge = stats.pstdev(self.get_all_sales_cartridge_prediction())

    def set_estimated_amount(self):
        self.__estimated_amount =
            get_mean_cartridge()+(2*get_sd_cartridge())

    def get_id_prediction_cartridge(self):
        if self.__id_prediction_cartridge is None:
            self.set_id_prediction_cartridge()
        return self.__id_prediction_cartridge

    def get_all_sales_cartridges_prediction(self):
        if self.__all_sales_cartridges_prediction is None:
            self.set_all_sales_cartridges_prediction()
        return self.__all_sales_cartridges_prediction

    def get_all_sales_cartridges_real(self):
        if self.__all_sales_cartridges_real is None:
            self.set_all_sales_cartridges_real()
        return self.__all_sales_cartridges_real

    def get_all_sales_cartridges_simulated(self):
        if self.__all_sales_cartridges_simulated is None:
            self.set_all_sales_cartridges_simulated()
        return self.__all_sales_cartridges_simulated

    def get_mean_cartridge(self):
        if self.__mean_cartridge is None:
            self.set_mean_cartridge()
        return self.__mean_cartridge

    def get_sd_cartridge(self):
        if self.__sd_cartridge is None:
            self.set_sd_cartridge()
        return self.__sd_cartridge

    def get_estimated_amount(self):
        if self.__estimated_amount is None:
            self.set_estimated_amount()
        return self.__estimated_amount

    def add_simuleted_sale(self):
        if self.get_estimated_amount >=  self.get_all_sales_cartridges_real:
            return True
        else:
            return False
