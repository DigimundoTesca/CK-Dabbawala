from django.contrib.auth.models import AbstractUser
from django.core.validators import RegexValidator
from django.db import models


class User(AbstractUser):
    # User Rol
    ADMIN = 'AD'
    CEO = 'CE'
    MANAGER = 'MA'
    CHEF = 'CH'
    STORER = 'ST'
    DELIVERY_MAN = 'DM'
    CUSTOMER = 'CU'

    USER_ROL = (
        (ADMIN, 'Admin'),
        (STORER, 'Almacenista'),
        (CEO, 'CEO'),
        (CHEF, 'Chef'),
        (CUSTOMER, 'Cliente'),
        (MANAGER, 'Gerente'),
        (DELIVERY_MAN, 'Repartidor'),
    )

    user_rol = models.CharField(choices=USER_ROL, default=CUSTOMER, max_length=2)

    class Meta(AbstractUser.Meta):
        swappable = 'AUTH_USER_MODEL'


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
