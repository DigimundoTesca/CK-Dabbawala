from django.db import models
from django.utils import timezone

from branchoffices.models import CashRegister
from products.models import Cartridge, PackageCartridge, ExtraIngredient
from users.models.users import User as UserProfile
from users.models.customers import CustomerProfile


class TicketBase(models.Model):
    # Payment Type
    CASH = 'CA'
    CREDIT = 'CR'

    PAYMENT_TYPE = (
        (CASH, 'Efectivo'),
        (CREDIT, 'Crédito'),
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
        tickets_details = TicketDetail.objects.filter(ticket=self.id)
        total = 0
        for x in tickets_details:
            total += x.price
        return total

    def ticket_details(self):
        tickets_details = TicketDetail.objects.filter(ticket=self.id)
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
    sale_point = models.ForeignKey(
        CashRegister, on_delete=models.CASCADE, default=1)

    def __str__(self):
        return 'P%s' %  self.ticket

    def order_number(self):
        return self.ticket.order_number

    def created_at(self):
        return self.ticket.created_at

    def payment_type(self):
        return self.ticket.payment_type

    def total(self):
        tickets_details = TicketDetail.objects.filter(ticket=self.ticket.id)
        total = 0
        for x in tickets_details:
            total += x.price
        return total

    def is_active(self):
        return self.ticket.is_active

    def ticket_details(self):
        tickets_details = TicketDetail.objects.filter(ticket=self.ticket)
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
        return '%s Ticket Order' %  self.ticket

    def ticket_details(self):
        tickets_details = TicketDetail.objects.filter(ticket=self.ticket)
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


# Deprecated class to new pre-release
class TicketDetail(models.Model):
    ticket = models.ForeignKey(TicketBase, on_delete=models.CASCADE)
    cartridge = models.ForeignKey(Cartridge, on_delete=models.CASCADE, blank=True, null=True)
    package_cartridge = models.ForeignKey(PackageCartridge, on_delete=models.CASCADE, blank=True, null=True)
    quantity = models.IntegerField(default=0)
    price = models.DecimalField(default=0, max_digits=12, decimal_places=2)

    def created_at(self):
        return self.ticket.created_at

    def __str__(self):
        return '%s' % self.id

    def extra_ingredients(self):
        ingredients = TicketExtraIngredient.objects.filter(ticket_detail=self.id)
        options = []

        for ingredient in ingredients:
            options.append(("<option value=%s selected>%s</option>" %
                                (ingredient, ingredient)))
        tag = """<select multiple disabled>%s</select>""" % str(options)
        return tag

    extra_ingredients.allow_tags = True

    class Meta:
        ordering = ('id',)
        verbose_name = 'Ticket Details'
        verbose_name_plural = 'Tickets Details'


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
    package_cartridge = models.ForeignKey(PackageCartridge)
    quantity = models.PositiveSmallIntegerField(default=1)
    price = models.DecimalField(default=0, max_digits=12, decimal_places=2)
    
    class Meta:
        verbose_name = 'Detalle del Ticket para Paquetes'
        verbose_name_plural = 'Detalles de Tickets para Paquetes'

    def __str__(self):
        return '%s' % self.ticket_base


class TicketExtraIngredient(models.Model):
    ticket_detail = models.ForeignKey(TicketDetail)  # Will be deleted the next pre-release
    cartridge_ticket_detail = models.ForeignKey(CartridgeTicketDetail, on_delete=models.CASCADE)
    extra_ingredient = models.ForeignKey(ExtraIngredient, on_delete=models.CASCADE)
    quantity = models.PositiveSmallIntegerField(default=1)
    price = models.DecimalField(default=0, max_digits=12, decimal_places=2)

    def __str__(self):
        return '%s' % self.extra_ingredient
