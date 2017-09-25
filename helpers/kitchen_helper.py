from helpers.sales_helper import TicketPOSHelper
from kitchen.models import ProcessedProduct
from products.models import PackageCartridgeRecipe


class KitchenHelper(object):
    def __init__(self):
        super(KitchenHelper, self).__init__()
        self.__processed_products = None

    @property
    def processed_products(self):
        """
        :rtype: django.db.models.query.QuerySet
        """
        if self.__processed_products is None:
            self.set_processed_cartridges()
        return self.__processed_products

    def set_processed_cartridges(self):
        self.__processed_products = ProcessedProduct.objects.select_related('ticket')

    def get_unprocessed_products_list(self):
        """
        :rtype list:
        :return: Unmounted pending products list
        """
        unprocessed_products_list = []
        processed_objects = self.processed_products.filter(status='PE')
        sales_helper = TicketPOSHelper()

        for processed in processed_objects:
            unprocessed_product_object = {
                'ticket_order': processed.ticket.order_number,
                'cartridges': [],
                'packages': []
            }

            # Cartridge Ticket Detail
            for cartridge_ticket_detail in sales_helper.get_cartridges_tickets_details().filter(
                    ticket_base=processed.ticket):
                if cartridge_ticket_detail.ticket_base == processed.ticket:
                    cartridge = {
                        'quantity': cartridge_ticket_detail.quantity,
                        'cartridge': cartridge_ticket_detail.cartridge
                    }
                    unprocessed_product_object['cartridges'].append(cartridge)

            # Package Ticket Detail
            for package_ticket_detail in sales_helper.get_packages_tickets_details().filter(
                    ticket_base=processed.ticket):
                if package_ticket_detail.ticket_base == processed.ticket:

                    package = {
                        'quantity': package_ticket_detail.quantity,
                        'package_recipe': []
                    }
                    package_recipe = \
                        PackageCartridgeRecipe.objects.filter(package_cartridge=package_ticket_detail.package_cartridge)

                    for recipe in package_recipe:
                        package['package_recipe'].append(recipe.cartridge)

                    unprocessed_product_object['packages'].append(package)

            unprocessed_products_list.append(unprocessed_product_object)

        return unprocessed_products_list

