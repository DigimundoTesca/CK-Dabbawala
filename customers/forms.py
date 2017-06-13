from django import forms
from django.forms import ValidationError
from .models import CustomerProfile


class CustomerProfileForm(forms.ModelForm):
    class Meta:
        model = CustomerProfile
        fields = ['user', 'email', 'phone_number', 'longitude', 'latitude', 'address', 'first_dabba']