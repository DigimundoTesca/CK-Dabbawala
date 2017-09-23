from django.core.validators import MinLengthValidator
from django.db import models

from users.models.users import User as UserProfile


class BranchOffice(models.Model):
    name = models.CharField(max_length=90, default='')
    address = models.CharField(max_length=255, default='')
    manager = models.ForeignKey(UserProfile, on_delete=models.CASCADE)
    is_activate = models.BooleanField(default=False)

    def __str__(self):
        return self.name

    class Meta:
        ordering = ('id',)
        verbose_name = 'Sucursal'
        verbose_name_plural = 'Sucursales'


class Supplier(models.Model):
    name = models.CharField(validators=[MinLengthValidator(4)], max_length=255, unique=True)
    image = models.ImageField(blank=False, upload_to='media/suppliers')

    def __str__(self):
        return self.name

    class Meta:
        ordering = ('id',)
        verbose_name = 'Proveedor'
        verbose_name_plural = 'Proveedores'