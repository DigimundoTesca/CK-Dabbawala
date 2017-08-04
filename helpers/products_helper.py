from products.models import Cartridge, CartridgeRecipe, PackageCartridge, \
    PackageCartridgeRecipe, Supply


class ProductsHelper(object):
    def __init__(self):
        super(ProductsHelper, self).__init__()
        self.__all_cartridges = None
        self.__all_packages_cartridges = None
        self.__all_supplies = None
        self.__all_extra_ingredients = None
        self.__all_cartridges_recipes = None
        self.__all_tickets_details = None
        self.__elements_in_warehouse = None
        self.__predictions = None
        self.__required_supplies_list = None
        self.__today_popular_cartridge = None
        self.__all_packages_cartridges_recipes = None
        self.__always_popular_cartridge = None

    def get_all_supplies(self):
        """
        :rtype: django.db.models.query.QuerySet
        """
        if self.__all_supplies is None:
            self.set_all_supplies()
        return self.__all_supplies

    @property
    def all_cartridges(self):
        """
        :rtype: django.db.models.query.QuerySet
        """
        if self.__all_cartridges is None:
            self.set_all_cartridges()
        return self.__all_cartridges

    def get_all_packages_cartridges(self):
        """
        :rtype: django.db.models.query.QuerySet
        """
        if self.__all_packages_cartridges is None:
            self.set_all_packages_cartridges()
        return self.__all_packages_cartridges

    def get_all_extra_ingredients(self):
        """
        :rtype: django.db.models.query.QuerySet
        """
        if self.__all_extra_ingredients is None:
            self.set_all_extra_ingredients()

        return self.__all_extra_ingredients

    def get_all_cartridges_recipes(self):
        """
        :rtype: django.db.models.query.QuerySet
        """
        if self.__all_cartridges_recipes is None:
            self.set_all_cartridges_recipes()

        return self.__all_cartridges_recipes

    def get_all_packages_cartridges_recipes(self):
        """
        :rtype: django.db.models.query.QuerySet
        """
        if self.__all_packages_cartridges_recipes is None:
            self.set_all_package_cartridges_recipes()

        return self.__all_packages_cartridges_recipes

    def get_all_elements_in_warehouse(self):
        """
        :rtype: django.db.models.query.QuerySet
        """
        if self.__elements_in_warehouse is None:
            self.set_elements_in_warehouse()
        return self.__elements_in_warehouse

    def get_required_supplies(self):
        """
        :rtype: list
        """
        required_supplies_list = []
        all_cartridges = self.all_cartridges()
        predictions = self.get_predictions_supplies()
        supplies_on_stock = self.get_all_elements_in_warehouse().filter(status="ST")

        ingredients = self.get_all_cartridges_recipes()

        for prediction in predictions:
            for cartridge in all_cartridges:
                if prediction['cartridge'] == cartridge:

                    ingredientes = ingredients.filter(cartridge=cartridge)

                    for ingredient in ingredientes:

                        supply = ingredient.supply
                        name = ingredient.supply.name
                        cost = ingredient.supply.presentation_cost
                        measurement_unit = ingredient.supply.unit_conversion(ingredient.quantity)
                        measurement_quantity = ingredient.supply.measurement_conversion(ingredient.quantity)
                        supplier_unit = ingredient.supply.unit_conversion(ingredient.supply.measurement_quantity)
                        supplier_quantity = ingredient.supply.measurement_conversion(
                            ingredient.supply.measurement_quantity)
                        quantity = ingredient.quantity
                        supplier = ingredient.supply.supplier

                        count = 0

                        required_supply_object = {
                            'supply': supply,
                            'name': name,
                            'cost': cost,
                            'measurement_unit': measurement_unit,
                            'measurement_quantity': measurement_quantity,
                            'supplier_unit': supplier_unit,
                            'supplier_quantity': supplier_quantity,
                            'quantity': quantity,
                            'supplier': supplier,
                            'stock': 0,
                            'required': 0,
                            'full_cost': 0,
                        }

                        if len(required_supplies_list) == 0:
                            count = 1
                        else:
                            for required_supplies in required_supplies_list:
                                if required_supplies['name'] == name:
                                    required_supplies['quantity'] += quantity
                                    count = 0
                                    break
                                else:
                                    count = 1
                        if count == 1:
                            required_supplies_list.append(required_supply_object)

        for required_supply in required_supplies_list:
            if len(supplies_on_stock) > 0:
                for supply_on_stock in supplies_on_stock:
                    if supply_on_stock.supply == required_supply['supply']:
                        required_supply['stock'] = supply_on_stock.quantity
                        required_supply['required'] = max(0, required_supply['quantity'] - required_supply['stock'])
                        required_supply['full_cost'] = \
                            required_supply['cost'] * \
                            math.ceil(required_supply['required'] / required_supply['measurement_quantity'])
                        break
                    else:
                        required_supply['required'] = max(0, required_supply['quantity'] - required_supply['stock'])
                        required_supply['full_cost'] = \
                            required_supply['cost'] * \
                            math.ceil(required_supply['required'] / required_supply['measurement_quantity'])
                        required_supply['full_cost'] = \
                            required_supply['cost'] * \
                            math.ceil(required_supply['required'] / required_supply['measurement_quantity'])

            else:
                required_supply['required'] = max(0, required_supply['quantity'] - required_supply['stock'])
                required_supply['full_cost'] = \
                    required_supply['cost'] * \
                    math.ceil(required_supply['required'] / required_supply['measurement_quantity'])

        return required_supplies_list

    def get_always_popular_cartridge(self):
        """
        :rtype: django.db.models.query.QuerySet
        """
        if self.__always_popular_cartridge is None:
            self.set_always_popular_cartridge()
        return self.__always_popular_cartridge

    def get_predictions_supplies(self):
        """ :rtype: list """
        if self.__predictions is None:
            self.set_predictions()
        return self.__predictions

    def get_supplies_on_stock_list(self):
        """ :rtype: list """
        stock_list = []
        all_elements = self.__elements_in_warehouse.filter(status='ST')
        if all_elements.count() > 0:
            for element in all_elements:
                stock_object = {
                    'name': element.supply.name,
                    'quantity': element.quantity,
                }
                stock_list.append(stock_object)

        return stock_list

    def get_today_popular_cartridge(self):
        if self.__today_popular_cartridge is None:
            self.set_today_popular_cartridge()
        return self.__always_popular_cartridge

    def set_all_supplies(self):
        self.__all_supplies = Supply.objects. \
            select_related('category'). \
            select_related('supplier'). \
            select_related('location').order_by('name')

    def set_all_cartridges(self):
        self.__all_cartridges = Cartridge.objects.order_by('subcategory', 'name')

    def set_all_packages_cartridges(self):
        self.__all_packages_cartridges = PackageCartridge.objects.all()

    def set_all_cartridges_recipes(self):
        self.__all_cartridges_recipes = CartridgeRecipe.objects. \
            select_related('cartridge'). \
            select_related('supply'). \
            all()

    def set_all_package_cartridges_recipes(self):
        self.__all_packages_cartridges_recipes = PackageCartridgeRecipe.objects. \
            select_related('package_cartridge'). \
            select_related('cartridge'). \
            all()

    def set_all_extra_ingredients(self):
        self.__all_extra_ingredients = ExtraIngredient.objects. \
            select_related('ingredient'). \
            select_related('cartridge'). \
            all()

    def set_predictions(self):
        sales_helper = SalesHelper()
        all_tickets_details = sales_helper.get_all_tickets_details()

        prediction_list = []

        for ticket_details in all_tickets_details:
            cartridge_object = {
                'cartridge': ticket_details.cartridge,
                'cantidad': 1,
            }

            prediction_list.append(cartridge_object)

        self.__predictions = prediction_list

    def set_all_tickets_details(self):
        self.__all_tickets_details = TicketDetail.objects.select_related(
            'ticket').select_related('cartridge').select_related('package_cartridge').all()

    def set_always_popular_cartridge(self):
        sales_helper = SalesHelper()
        cartridges_frequency_dict = {}
        for cartridge in self.all_cartridges():
            cartridges_frequency_dict[cartridge.id] = {
                'frequency': 0,
                'name': cartridge.name,
            }
        for ticket_detail in sales_helper.get_all_tickets_details():
            if ticket_detail.cartridge:
                ticket_detail_id = ticket_detail.cartridge.id
                ticket_detail_frequency = ticket_detail.quantity
                cartridges_frequency_dict[ticket_detail_id]['frequency'] += ticket_detail_frequency

        for element in cartridges_frequency_dict:
            if self.__always_popular_cartridge is None:
                """ Base case """
                self.__always_popular_cartridge = {
                    'id': element,
                    'name': cartridges_frequency_dict[element]['name'],
                    'frequency': cartridges_frequency_dict[element]['frequency'],
                }
            else:
                if cartridges_frequency_dict[element]['frequency'] > self.__always_popular_cartridge['frequency']:
                    self.__always_popular_cartridge = {
                        'id': element,
                        'name': cartridges_frequency_dict[element]['name'],
                        'frequency': cartridges_frequency_dict[element]['frequency'],
                    }

    def set_elements_in_warehouse(self):
        self.__elements_in_warehouse = Warehouse.objects.select_related('supply').all().order_by('supply__name')

    def set_today_popular_cartridge(self):
        sales_helper = SalesHelper()
        cartridges_frequency_dict = {}
        helper = Helper()
        start_date = helper.naive_to_datetime(date.today())
        limit_day = helper.naive_to_datetime(start_date + timedelta(days=1))
        filtered_ticket_details = sales_helper.get_tickets_details(start_date, limit_day)

        for cartridge in self.all_cartridges():
            cartridges_frequency_dict[cartridge.id] = {
                'frequency': 0,
                'name': cartridge.name,
            }

        for ticket_detail in filtered_ticket_details:
            if ticket_detail.cartridge:
                ticket_detail_id = ticket_detail.cartridge.id
                ticket_detail_frequency = ticket_detail.quantity
                cartridges_frequency_dict[ticket_detail_id]['frequency'] += ticket_detail_frequency

        for element in cartridges_frequency_dict:
            if self.__today_popular_cartridge is None:
                """ Base case """
                self.__today_popular_cartridge = {
                    'id': element,
                    'name': cartridges_frequency_dict[element]['name'],
                    'frequency': cartridges_frequency_dict[element]['frequency'],
                }
            else:
                if cartridges_frequency_dict[element]['frequency'] > self.__today_popular_cartridge['frequency']:
                    self.__today_popular_cartridge = {
                        'id': element,
                        'name': cartridges_frequency_dict[element]['name'],
                        'frequency': cartridges_frequency_dict[element]['frequency'],
                    }
