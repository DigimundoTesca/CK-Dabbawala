import json
import math
import pytz
from datetime import datetime, date, timedelta, time
from decimal import Decimal
from django.db.models import Min, Max
from diners.models import AccessLog, Diner, SatisfactionRating, ElementToEvaluate
from kitchen.models import Warehouse, ProcessedProduct
from products.models import Supply, Cartridge, PackageCartridge, CartridgeRecipe, PackageCartridgeRecipe, \
    ExtraIngredient
from sales.models import TicketBase, TicketDetail, TicketExtraIngredient


class LeastSquares(object):
    def __init__(self, x: list, y: list):
        super(LeastSquares, self).__init__()
        if len(x) != len(y):
            raise NameError('Las listas deben tener misma longitud.')

        self.__x = x
        self.__y = y
        self.__periodic_list = []
        self.__n = len(self.__x)
        self.set_periodic_list()

    def get_sum_x(self):
        return sum(self.__x)

    def get_sum_y(self):
        return sum(self.__y)

    def get_x_average(self):
        return math.ceil(self.get_sum_x() / len(self.__x))

    def get_y_average(self):
        return math.ceil(self.get_sum_y() / len(self.__y))

    def get_sum_x_pow(self):
        auxiliary_list = []
        count = 0

        for _ in self.__x:
            auxiliary_list.append(self.__x[count] ** 2)
            count += 1
        return sum(auxiliary_list)

    def get_sum_y_pow(self):
        auxiliary_list = []
        count = 0

        for _ in self.__y:
            auxiliary_list.append(self.__y[count] ** 2)
            count += 1
        return sum(auxiliary_list)

    def get_sum_x_y_prod(self):
        count = 0
        auxiliary_list = []

        for _ in self.__x:
            auxiliary_list.append(self.__x[count] * self.__y[count])
            count += 1

        return sum(auxiliary_list)

    def set_periodic_list(self):
        difference_list = []
        count = 0
        is_periodic = True

        for _ in self.__x:
            if count != 0:
                difference_list.append(self.__x[count] - self.__x[count - 1])

            count += 1

        count = 0

        for _ in difference_list:
            if count != 0:
                if difference_list[count] != difference_list[count - 1]:
                    is_periodic = False
                    break
            count += 1

        if is_periodic:
            count = 0
            periodic_value = difference_list[0]

            for _ in self.__x:
                self.__periodic_list.append(self.__x[len(self.__x) - 1] + periodic_value * (count + 1))
                count += 1
        else:
            raise NameError('Tu lista de Periodo no es continua')

    def get_a(self):
        return math.ceil(self.get_y_average() - self.get_b() * self.get_x_average())

    def get_b(self):
        return math.ceil((self.get_sum_x_y_prod() - (self.get_sum_x() * self.get_sum_y() / self.__n)) / (
            self.get_sum_x_pow() - (self.get_sum_x() ** 2) / self.__n))

    def get_forecast(self):
        forecast_list = []
        count = 0

        for _ in self.__x:
            forecast_list.append(self.get_a() + self.get_b() * self.__periodic_list[count])
            count += 1

        return forecast_list


class KitchenHelper(object):
    def __init__(self):
        super(KitchenHelper, self).__init__()
        self.__all_processed_products = None
        self.__all_warehouse = None

    def get_all_processed_products(self):
        """
        rtype: django.db.models.query.QuerySet
        """
        if self.__all_processed_products is None:
            self.set_all_processed_products()
        return self.__all_processed_products

    def get_all_warehouse(self):
        """
        :rtype: django.db.models.query.QuerySet
        """
        if self.__all_warehouse is None:
            self.set_all_processed_products()
        return self.__all_warehouse

    def get_processed_products(self):
        processed_products_list = []
        sales_helper = SalesHelper()
        products_helper = ProductsHelper()

        for processed in self.get_all_processed_products().filter(status='PE')[:15]:
            processed_product_object = {
                'ticket_id': processed.ticket,
                'cartridges': [],
                'packages': [],
                'ticket_order': processed.ticket.order_number
            }

            for ticket_detail in sales_helper.get_all_tickets_details():
                if ticket_detail.ticket == processed.ticket:
                    if ticket_detail.cartridge:
                        cartridge = {
                            'quantity': ticket_detail.quantity,
                            'cartridge': ticket_detail.cartridge,
                        }
                        for extra_ingredient in sales_helper.get_all_extra_ingredients():
                            if extra_ingredient.ticket_detail == ticket_detail:
                                try:
                                    cartridge['name'] += extra_ingredient['extra_ingredient']
                                except Exception as e:
                                    cartridge['name'] = ticket_detail.cartridge.name
                                    cartridge['name'] += ' con ' + extra_ingredient.extra_ingredient.ingredient.name
                        processed_product_object['cartridges'].append(cartridge)

                    elif ticket_detail.package_cartridge:
                        package = {
                            'quantity': ticket_detail.quantity,
                            'package_recipe': []
                        }
                        package_recipe = products_helper.get_all_packages_cartridges_recipes().filter(
                            package_cartridge=ticket_detail.package_cartridge)

                        for recipe in package_recipe:
                            package['package_recipe'].append(recipe.cartridge)
                        processed_product_object['packages'].append(package)

            processed_products_list.append(processed_product_object)
        return processed_products_list

    def set_all_warehouse(self):
        self.__all_warehouse = Warehouse.objects.select_related('supply').all()

    def set_all_processed_products(self):
        self.__all_processed_products = ProcessedProduct.objects. \
            select_related('ticket'). \
            all()


class CartHelper(object):
    def __init__(self, cart:dict):
        super(CartHelper, self).__init__()
        self.__cart = cart

    def is_empty(self):
        """
        Checks if the json cart is empty
        :rtype: bool
        """
        return not bool(self.__cart['cartridges']) or bool(self.__cart['packages'])

    @property
    def cart(self):
        return self.__cart

    @cart.setter
    def cart(self, cart):
        if 'cartridges' in cart or 'packages' in cart:
            if not cart['cartridges'] or not cart['packages']:
                self.__cart = {}
            else:
                self.__cart = cart
        else:
            self.__cart = {}


class PIDControl(object):
    def __init__(self):
        super(PIDControl, self).__init__()
        self.k1 = 1
        self.k2 = 1
        self.k3 = 1

    def get_pid_control(self):
        """
        Controlador PID
        TODO: Obtener el Control Proporcional, Integral y Derivativo
        La fórmula está dada por:
            ( (K1 * (Sp + Mp + Ap) ) + (K2 * ( Sum(Ts) - Sum(Tp) ) / Dr) + Dp ) / 3
        En donde
            K1 = Constante Proporcional
            K2 =  Constante Integral
            K3 = Constante Derivativa
            Sp = Promedio por día de la Semana
            Mp = Promedio por dia del Mes
            Ap = Promedio por día del Año
            Ts = Suma del total de elementos en los días de la semana
            Tp = Suma del total de elementos promedios en todas las semanas registradas
            Dr = Días restantes -> 7 - Ts
            Dp = Promedio derivativo ( Mínimos cuadrados )

            *** K1, K2, K3 Son constantes que se van ajustando manualmente al final de la
            predicción inicial, de acuerdo a los valores reales obtenidos ***

        Inicialmente, K1 = k2 = k3 = 1

        Mientras se vayan obteniendo los resultados y se comparen con los valores reales, entonces
        se hacen los ajustes pertinentes a las constantes.

        Ejemplo:
            obtuvimos los siguientes valores para cada control:
            get_control_proporcional() = 5
            get_control_integral() =  7
            get_control_derivativo() = 13


            Pero el valor real para el día siguiente de la gelatina fue de 7
            por lo tanto se hace un ajuste a la primer constante k1, para que
            5 * k1 nos de un valor aproximado a 7
            los mismo para las siguientes constantes
            de manera que:

                k1 * 5  = 7; 	k1 > 1
                k2 * 7  = 1; 	k2 = 1 ... aquí se mantuvo :D
                k3 * 13 = 13; 	k3 < 1

                Ejemplo:
                De k3 ...
                si k3 > 1 entonces:
                    k3 > 13 ... por lo tanto k3 * 13 > 7... y eso no nos sirve, ya que
                    la venta real fue de 7, entonces nos estaríamos alejando más...
                    la idea es realizarle ajustes a la constante para que el valor se acerque a 7 :D

        Debemos enviarle un dato, el cual es el día que queremos calcular la predicción.
        Imaginando que hoy es DOMINGO 21 de mayo, por lo tanto enviamos el día a predecir. Es decir el Lunes 22 de mayo
        """

        day_to_predict = datetime.today() + timedelta(days=1)
        control_p = self.get_control_proporcional(day_to_predict)

    @staticmethod
    def get_control_proporcional(day_to_predict: datetime, product_object: Cartridge):
        """
        Este metodo nos retornará un PROMEDIO, pero qué promedios???

        1. Por DÍA [Lunes, Martes, Miercoles...]
        2. Por Número de día de cada MES [1, 2, 3, 4... 30, 31]
        3. Por día del AÑO [1, 2, 3, 4, 5, ... 363, 364, 365]

        La Suma de estos tres valores nos indicarán el Control Proporcional

        Ejemplo:
            Hoy estamos a Lunes 15 de Mayo de 2017
            Sp
            Espera... me surgió una duda ...
            no recuerdo si aquí debería ser el promedio de TODOS los días que hay registro o
            el promedio de ventas de TODOS los lunes de los que se tiene registro ...

            Mp
            Calcular el promedio de todos los días 15 de TODOS los meses, por ejemplo 15 de enero,
            15 de febrero, 15 de marzo... etc
            Ap
            Calcular el promedio de ventas de todos los días X de todos los años
            enero tiene 31...
            febero... 28 ? :v
            marzo 31...
            abril .. 30
            mayo ... -> 15

            por lo tanto, 31 + 28 + 31 + 30 +15 = 135 -> Mayo es el día 135 del año
            Ap sería el promedio de todos los días 135 de todos los años que se tenga registro

        Primero debemos hacer las consultas pertinentes

        En esta parte nos auxiliaremos de isoweekday que nos proveé python...
        https://docs.python.org/3/library/datetime.html#datetime.date.isoweekday

        nos retornará un numero del 1 al 7 dependiendo de cada día
        siendo 1 lunes y 7 domingo
        así que una vez obtenidos todos los tickets, iteraremos su fecha de creacion
        y validaremos uno a uno los que cumplan a condicion requerida...

        Recordar: ya tenemos un método en helpers que nos retorna el numero de un día,
        pero nos retorna numero del 0 al 6, siendo lunes el 0 y 6 domingo

        Le tenemos que enviar el día del cual queremos obtener el numero
        correspondiente para hacer las validaciones

        :rtype int
        """
        helper = Helper()
        number_day = helper.get_number_day(day_to_predict) + 1  # Este metodo ya incorpora isoweekday
        #  Como day_to_predict es Lunes 22 de mayo, nos retornará un 0, así que le sumamos uno, para que tenga sentido

        all_tickets_details = TicketDetail.objects.select_related('ticket').all()
        tickets_details_list = []
        total_days_dict = {}
        #  Ahora sí, vamos a iterar los tickets y a cada uno igual hay que convertir su atributo a entero

        for ticket_detail in all_tickets_details:
            if ticket_detail.ticket.created_at.isoweekday() == number_day:
                'Por lo tanto, ese ticket detail es de un día lunes :D'
                tickets_details_list.append(ticket_detail)
            """ Aquí obtendremos el total de lunes """
            total_days_dict[ticket_detail.ticket.created_at.strftime('%d-%m-%Y')] = True
        # Es obvio que si ya existe un ticket detail con la misma fecha no importa, ya que
        # sólo indicaremos que si existen tickets en ese día ...

        """
        Ahora obtendremos el promedio de todos esos días, como son tickets details
        entonces ya incluye el producto vendido y obvio, el precio base y el total, pero necesitamos conocer el
        id de la gelatina, por lo tanto debemos pasarlo por argumento en la funcion
        en este caso pasaremos el objecto como tal...
        Una vez encontrado el ticket detail correspondiente podremos añadir las elementos que se
        vendieron en ese movimiento
        """

        total_elements = 0

        for ticket_detail in tickets_details_list:
            if ticket_detail.cartridge.id == product_object.id:
                'significa que es un ticket detail que vendio una gelatina'
                total_elements += ticket_detail.quantity

        # Y listo, ahora total_elements nos indicará los elementos vendidos en todos los tiempos
        #  en los cuales haya sido una venta en un día lunes :3 -> Procedemos a promediar

        day_average = total_elements / len(total_days_dict)
        # Promedio de dia = cantidad de elementos vendidos entre total de dias obtenidos

        """ Necesitamos calcular los días totales :D ¿Cómo los calcularias?
        TIP: Te puedes guiar usando los tickets_details_list <- Contiene los datos que sí nos sirven

        TODO: Obtener la cantidad de lunes en TODOS los tiempos en los que se haya vendido la gelatina

        Solución:
            recordar que un diccionario tiene llaves irrepetibles, entonces podemos usar cada datetime como una llave
            por lo tanto iteramos todos los tickets details list ( que son los que ya están filtrados)
            y almacenamos cada llava y obviamente, cada que se encuentre otro ticket detail con la misma
            fecha (date, no confundir con datetime) entonces ya no será necesario crear otro espacio en el diccionario
            al final solo queda obtener el tamaño del diccionario y ya
        """

        # Aquí debe estar la lógica para obtener la variable Mp

        # Aquí debe estar la lógica para obtener la variable Ap

    @staticmethod
    def get_control_integral():
        """
        Este método retornará la suma del total de ventas de un producto en un
        día 'n' de la semana menos el promedio de ventas en una semana del producto,
        dividido entre la diferencia de los días de la semana menos la cantidad
        de días evaluados.

            Ejemplo:
            en el día miercoles se han vendido 20 gelatinas, y sabemos que en promedio
            hasta la fecha de hoy, en una semana cualquiera el promedio es que se vendan
            50 gelatinas, por lo tanto
            Ts = 20
            Tp = 50
            Dr = 7 - 3 = 4

        """


def get_control_derivativo(self):
    """
    Este método nos retornará la derivada del día anterior con respecto a su día anterior
    aquí es donde utilizaremos los mínimos cuadrados...
    hipoteticamente, imaginando que la semana pasada se vendieron en el siguiente
    orden de días la cantidad de gelatinas:
        {'Lunes': 15,
        'Martes': 5,
        'Miércoles': 9:
        'Jueves': 14,
        'Viernes': 12,
        'Sabado': 0,
        'Domingo': 15
        }
    y al realizar las operaciones de los mínimos cuadrados obtuvimos las siguientes "Predicciones":
    (Hipoteticamente)
        {'Lunes': 13,
        'Martes': 7,
        'Miércoles': 8:
        'Jueves': 10,
        'Viernes': 12,
        'Sabado': 0,
        'Domingo': 12
        }
    por lo tanto si hoy es lunes y queremos conocer las ventas de mañana martes utilizaríamos
    el valor correspondiente al martes: 7

    """
