# -*- encoding: utf-8 -*-
from __future__ import unicode_literals

from django.contrib.auth.models import AbstractUser
from django.contrib.auth.validators import UnicodeUsernameValidator, ASCIIUsernameValidator
from django.db import models
from django.utils import six


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

    def __str__(self):
        return self.category


class CustomerProfile(models.Model):
    username_validator = UnicodeUsernameValidator() if six.PY3 else ASCIIUsernameValidator()

    user = models.CharField(
        max_length=150,
        unique=True,
        validators=[username_validator],
        error_messages={
            'unique': "Ya existe un usuario con este nickname",
            'invalid': 'Máximo 50 caracteres. Letras, números y @/./+/-/_ únicamente.',
        },
    )
    phone_number = models.CharField(
        max_length=13,
        unique=True,
        error_messages={
            'unique': "Este número ya está registrado",
        },
    )
    email = models.EmailField(
        unique=True,
        error_messages={
            'unique': "Ya existe un usuario con este email",
        },
    )
    address = models.CharField(
        max_length=255,
        error_messages={
            'unique': "Ya existe un usuario con este email",
        },
    )
    longitude = models.CharField(default='0.0', max_length=30, blank=True)
    latitude = models.CharField(default=0.0, max_length=30, blank=True)
    first_dabba = models.BooleanField(default=False)

    class Meta:
        verbose_name = 'Perfil de Usuario'
        verbose_name_plural = 'Perfiles de Usuarios'
