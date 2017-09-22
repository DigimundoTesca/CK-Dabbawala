from django.db import models
from django.db.models.signals import post_save
from django.dispatch import receiver

from products.models import Supply
from sales.models import TicketBase


class ProcessedProduct(models.Model):
    # Status
    PENDING = 'PE'
    ASSEMBLED = 'AS'

    STATUS = (
        (PENDING, 'Pendiente'),
        (ASSEMBLED, 'Ensamblado'),
    )

    ticket = models.OneToOneField(TicketBase, on_delete=models.CASCADE)
    created_at = models.DateTimeField(auto_now_add=True)
    prepared_at = models.DateTimeField(editable=True, null=True, blank=True)
    status = models.CharField(max_length=10, choices=STATUS, default=ASSEMBLED)

    def __str__(self):
        return '%s' % self.created_at

    @receiver(post_save, sender=TicketBase)
    def create_processed_product(sender, instance, **kwargs):
        ticket = TicketBase.objects.get(id=instance.id)
        processed_product = ProcessedProduct.objects.filter(ticket=ticket).exists()

        if not processed_product:
            status = 'PE'
            processed_product = ProcessedProduct.objects.create(
                ticket=ticket,
                status=status,
            )

            processed_product.save()

    class Meta:
        ordering = ('id',)
        verbose_name = 'Productos'
        verbose_name_plural = 'Productos Procesados'


class Warehouse(models.Model):
    PROVIDER = 'PR'
    STOCK = 'ST'
    ASSEMBLED = 'AS'
    SOLD = 'SO'
    STATUS = (
        (PROVIDER, 'Provider'),
        (STOCK, 'Stock'),
        (ASSEMBLED, 'Assembled'),
        (SOLD, 'Sold'),
    )

    supply = models.ForeignKey(Supply, default=1, on_delete=models.CASCADE)
    status = models.CharField(choices=STATUS, default=PROVIDER, max_length=15)
    created_at = models.DateField(editable=False, auto_now_add=True)
    expiry_date = models.DateField(editable=True, auto_now_add=True)
    cost = models.FloatField(default=0)
    quantity = models.FloatField(default=0)
    waste = models.FloatField(default=0)

    def __str__(self):
        return '%s' % self.id

    class Meta:
        ordering = ('id',)
        verbose_name = 'Insumo en Almacén'
        verbose_name_plural = 'Insumos en el Almacén'
