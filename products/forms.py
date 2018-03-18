from django import forms

from kitchen.models import Presentation
from products.models import Supply, SuppliesCategory, Cartridge


class SupplyForm(forms.ModelForm):

    class Meta:
        model = Supply
        fields = '__all__'


class SuppliesCategoryForm(forms.ModelForm):

    class Meta:
        model = SuppliesCategory
        fields = '__all__'


class CartridgeForm(forms.ModelForm):

    class Meta:
        model = Cartridge
        fields = '__all__'


class PresentationForm(forms.ModelForm):
    class Meta:
        model = Presentation
        fields = '__all__'
