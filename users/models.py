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
