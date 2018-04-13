from django.db import models
from django.utils import timezone

from products.models import Cartridge, PackageCartridge, ExtraIngredient
from users.models.users import User as UserProfile
from users.models.customers import CustomerProfile


class TicketBase(models.Model):
    # Payment Type
    CASH = 'CA'
    CREDIT = 'CR'
    UBER = 'UB'
    RAPPIDIGITAL = 'RD'
    RAPPITARJETA = 'RT'
    SINDELANTALEFECTIVO = 'SE'
    SINDELANTALTARJETA = 'ST'

    PAYMENT_TYPE = (
        (CASH, 'Efectivo'),
        (CREDIT, 'Crédito'),
        (UBER, 'UBER'),
        (RAPPIDIGITAL,'Rappi Digital'),
        (RAPPITARJETA, 'Rappi Tarjeta'),
        (SINDELANTALEFECTIVO, 'SinDelantal Efectivo'),
        (SINDELANTALTARJETA, 'SinDelantal Tarjeta'),
    )

    order_number = models.IntegerField(default=1)
    created_at = models.DateTimeField(editable=True)
    payment_type = models.CharField(
        choices=PAYMENT_TYPE, default=CASH, max_length=2)
    is_active = models.BooleanField(default=True)

    def __str__(self):
        return '%s' % self.id

    def save(self, *args, **kwargs):
        """ On save, update timestamps"""
        if not self.id:
            self.created_at = timezone.now()
        return super(TicketBase, self).save(*args, **kwargs)

    def total(self):
        cartridge_tickets_details = CartridgeTicketDetail.objects.filter(ticket_base=self.id)
        package_tickets_details = PackageCartridgeTicketDetail.objects.filter(ticket_base=self.id)
        total = 0

        for c in cartridge_tickets_details:
            total += c.price

        for p in package_tickets_details:
            total += p.price
        return total

    def ticket_details(self):
        cartridge_tickets_details = CartridgeTicketDetail.objects.filter(ticket_base=self.id)
        package_tickets_details = PackageCartridgeTicketDetail.objects.filter(ticket_base=self.id)
        options = []

        for cartridge_ticket_detail in cartridge_tickets_details:
                options.append(("<option value=%s selected>%s</option>" %
                                (cartridge_ticket_detail, cartridge_ticket_detail.cartridge)))

        for package_ticket_detail in package_tickets_details:
                options.append(("<option value=%s selected>%s</option>" %
                                (package_ticket_detail, package_ticket_detail.package_cartridge)))

        return """<select multiple>%s</select>""" % str(options)

    ticket_details.allow_tags = True

    class Meta:
        ordering = ('-created_at',)
        verbose_name = 'Ticket Base'
        verbose_name_plural = 'Tickets Base'


class TicketPOS(models.Model):
    ticket = models.OneToOneField(
        TicketBase,
        on_delete=models.CASCADE,
        primary_key=True,
    )
    cashier = models.ForeignKey(
        UserProfile, default=1, on_delete=models.CASCADE)

    def __str__(self):
        return 'P%s' %  self.ticket

    def order_number(self):
        return self.ticket.order_number

    def created_at(self):
        return self.ticket.created_at

    def payment_type(self):
        return self.ticket.payment_type

    def total(self):
        total = 0
        cartridge_tickets_details = CartridgeTicketDetail.objects.filter(ticket_base=self.ticket.id)
        package_tickets_details = PackageCartridgeTicketDetail.objects.filter(ticket_base=self.ticket.id)

        for x in cartridge_tickets_details:
            total += x.price

        for x in package_tickets_details:
            total += x.price

        return total

    def is_active(self):
        return self.ticket.is_active

    def cartridges(self):
        tickets_details = CartridgeTicketDetail.objects.filter(ticket_base=self.ticket)
        options = []

        for ticket_detail in tickets_details:
                options.append(("<option value=%s selected>%s</option>" %
                                (ticket_detail, ticket_detail.cartridge)))
        return """<select multiple disabled>%s</select>""" % str(options)

    cartridges.allow_tags = True

    def packages(self):
        tickets_details = PackageCartridgeTicketDetail.objects.filter(ticket_base=self.ticket)
        options = []

        for ticket_detail in tickets_details:
            options.append(("<option value=%s selected>%s</option>" %(ticket_detail, ticket_detail.package_cartridge)))

        return """<select multiple disabled>%s</select>""" % str(options)

    packages.allow_tags = True

    class Meta:
        ordering = ('-ticket__created_at',)
        verbose_name = 'Ticket POS '
        verbose_name_plural = 'Tickets POS'


class TicketOrder(models.Model):
    ticket = models.OneToOneField(
        TicketBase,
        on_delete=models.CASCADE,
        primary_key=True,
    )
    customer = models.OneToOneField(
        CustomerProfile,
        on_delete=models.CASCADE,
    )

    def __str__(self):
        return '%s Ticket Order' % self.ticket

    def ticket_details(self):
        tickets_details = TicketCartridgeDetail.objects.filter(ticket=self.ticket)
        options = []

        for ticket_detail in tickets_details:
            if ticket_detail.cartridge:
                options.append(("<option value=%s>%s</option>" %
                                (ticket_detail, ticket_detail.cartridge)))
            elif ticket_detail.package_cartridge:
                options.append(("<option value=%s>%s</option>" %
                                (ticket_detail, ticket_detail.package_cartridge)))
        tag = """<select>%s</select>""" % str(options)
        return tag

    ticket_details.allow_tags = True

    class Meta:
        ordering = ('-ticket__created_at',)
        verbose_name = 'Ticket Order '
        verbose_name_plural = 'Tickets Order'


class CartridgeTicketDetail(models.Model):
    cartridge = models.ForeignKey(Cartridge, on_delete=models.CASCADE)
    ticket_base = models.ForeignKey(TicketBase, on_delete=models.CASCADE)
    quantity = models.IntegerField(default=1)
    price = models.DecimalField(default=0, max_digits=12, decimal_places=2)

    class Meta:
        verbose_name = 'Detalle del Ticket para Cartuchos'
        verbose_name_plural = 'Detalles de Tickets para Cartuchos'

    def __str__(self):
        return '%s' % self.ticket_base


class PackageCartridgeTicketDetail(models.Model):
    ticket_base = models.ForeignKey(TicketBase, on_delete=models.CASCADE)
    package_cartridge = models.ForeignKey(PackageCartridge, on_delete=models.CASCADE)
    quantity = models.PositiveSmallIntegerField(default=1)
    price = models.DecimalField(default=0, max_digits=12, decimal_places=2)

    class Meta:
        verbose_name = 'Detalle del Ticket para Paquetes'
        verbose_name_plural = 'Detalles de Tickets para Paquetes'

    def __str__(self):
        return '%s' % self.ticket_base


class TicketExtraIngredient(models.Model):
    cartridge_ticket_detail = models.ForeignKey(CartridgeTicketDetail, on_delete=models.CASCADE, null=True, blank=True)
    extra_ingredient = models.ForeignKey(ExtraIngredient, on_delete=models.CASCADE, default=1)
    quantity = models.PositiveSmallIntegerField(default=1)
    price = models.DecimalField(default=0, max_digits=12, decimal_places=2)

    def __str__(self):
        return '%s' % self.extra_ingredient
