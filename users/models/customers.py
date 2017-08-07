from django.core.validators import RegexValidator
from django.db import models

from users.models.users import User


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
