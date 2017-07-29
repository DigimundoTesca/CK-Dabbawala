from decimal import Decimal
from django.contrib.auth.models import AbstractUser
from django.core.validators import RegexValidator
from django.db import models
from django.utils.translation import ugettext as _


class User(AbstractUser):

    coins = models.DecimalField(max_digits=20, decimal_places=4, default=Decimal('0.0'))

    class Meta(AbstractUser.Meta):
        swappable = 'AUTH_USER_MODEL'

        permissions = (
            ('can_sell', _('Puede Vender')),
            ('can_see_sales', _('Puede Ver Ventas')),
            ('can_see_commands', _('Puede Ver Comandas')),
            ('can_assemble', _('Puede Ensamblar')),
            ('can_see_suplies', _('Puede Ver Insumos')),
            ('can_see_cartrdiges', _('Puede Ver Cartuchos')),
            ('can_see_packages', _('Puede Ver Paquetes')),
            ('can_see_storage_analytics', _('Puede Ver Estadísticas de Almacén')),
            ('can_see_suggestions', _('Puede Ver Comentarios')),
            ('can_see_suggestions_analytics', _('Puede Ver Estadísticas de Comentarios')),
        )


class UserMovements(models.Model):
    user = models.CharField(max_length=20,default='None')
    category = models.CharField(max_length=20,default='None')
    creation_date = models.DateField(auto_now=True)

    def __str__(self):
        return self.user


class CustomerProfile(User):
    phone_regex = RegexValidator(
        regex=r'^\d{10}$',
        message="Debe ingresar un número telefónico de 10 dígitos.")
    phone_number = models.CharField(
        max_length=10,
        validators=[phone_regex],
        blank=True,
        error_messages={
            'unique': "Este número ya está registrado.",
        },
    )

    address = models.CharField(max_length=255, default='')
    longitude = models.CharField(default='0.0', max_length=30, blank=True)
    latitude = models.CharField(default='0.0', max_length=30, blank=True)
    first_dabba = models.BooleanField(default=True)
    references = models.CharField(max_length=255, default='')

    class Meta:
        verbose_name = 'Perfil de Usuario'
        verbose_name_plural = 'Perfiles de Usuarios'
