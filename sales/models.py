from django.db import models
from django.db.models import Avg, Sum
from django.utils import timezone

from branchoffices.models import CashRegister
from products.models import Cartridge, PackageCartridge, ExtraIngredient
from users.models import User as UserProfile, CustomerProfile


class TicketBase(models.Model):
    # Payment Type
    CASH = 'CA'
    CREDIT = 'CR'

    PAYMENT_TYPE = (
        (CASH, 'Efectivo'),
        (CREDIT, 'Crédito'),
    )

    created_at = models.DateTimeField(editable=True)
    seller = models.ForeignKey(
        UserProfile, default=1, on_delete=models.CASCADE)
    cash_register = models.ForeignKey(
        CashRegister, on_delete=models.CASCADE, default=1)
    payment_type = models.CharField(
        choices=PAYMENT_TYPE, default=CASH, max_length=2)
    order_number = models.IntegerField(default=1, blank=False, null=False)
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
        verbose_name = 'Ticket '
        verbose_name_plural = 'Tickets'


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
        return '%s Ticket POS' %  self.ticket


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

class TicketDetail(models.Model):
    ticket = models.ForeignKey(TicketBase, on_delete=models.CASCADE)
    cartridge = models.ForeignKey(
        Cartridge, on_delete=models.CASCADE, blank=True, null=True)
    package_cartridge = models.ForeignKey(
        PackageCartridge, on_delete=models.CASCADE, blank=True, null=True)
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

class TicketExtraIngredient(models.Model):
    ticket_detail = models.ForeignKey(TicketDetail, null=True)
    extra_ingredient = models.ForeignKey(ExtraIngredient, on_delete=models.CASCADE, blank=True, null=True)
    price = models.DecimalField(default=0, max_digits=12, decimal_places=2)

    def __str__(self):
        return '%s' % self.extra_ingredient
