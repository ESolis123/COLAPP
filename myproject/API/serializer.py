from rest_framework import serializers
from .models import *
#Account
from django.contrib.auth import get_user_model
User = get_user_model()

class PersonaSerializer(serializers.ModelSerializer):

    class Meta:
        model = Persona
        fields = '__all__'

class TipotelefonoSerializer(serializers.ModelSerializer):

    class Meta:
        model = Tipotelefono
        fields = '__all__'

class TelefonoSerializer(serializers.ModelSerializer):

    class Meta:
        model = Telefono
        fields = '__all__'

class ClienteSerializer(serializers.ModelSerializer):

    class Meta:
        model = Cliente
        fields = '__all__'

class DepartamentoSerializer(serializers.ModelSerializer):

    class Meta:
        model = Departamento
        fields = '__all__'

class CargoSerializer(serializers.ModelSerializer):

    class Meta:
        model = Cargo
        fields = '__all__'

class SucursalSerializer(serializers.ModelSerializer):

    class Meta:
        model = Sucursal
        fields = '__all__'

class EmpleadoSerializer(serializers.ModelSerializer):

    class Meta:
        model = Empleado
        fields = '__all__'

class TipoproductoSerializer(serializers.ModelSerializer):

    class Meta:
        model = Tipoproducto
        fields = '__all__'

class ProductoSerializer(serializers.ModelSerializer):

    class Meta:
        model = Producto
        fields = '__all__'

class ProveedorSerializer(serializers.ModelSerializer):

    class Meta:
        model = Proveedor
        fields = '__all__'

class FacturaSerializer(serializers.ModelSerializer):

    class Meta:
        model = Factura
        fields = '__all__'

class DetalleSerializer(serializers.ModelSerializer):

    class Meta:
        model = Detalle
        fields = '__all__'