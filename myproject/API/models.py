from django.db import models
from django.core.validators import MinValueValidator, MaxValueValidator
from datetime import date

class Persona(models.Model):
 
    nombre = models.CharField(max_length=60)
    apellido = models.CharField(max_length=60)
    cedula = models.CharField(max_length=25)
    direccion = models.CharField(max_length=60)
    fec_creacion = models.DateField(default=date.today)
    usuario = models.CharField(max_length=60)
    correo = models.CharField(max_length=60)

class Tipotelefono(models.Model):
   
    nombre = models.CharField(max_length=60)

class Telefono(models.Model):

    numero_telefono = models.CharField(max_length=20)
    id_persona = models.ForeignKey('Persona', on_delete=models.CASCADE)
    id_tipo = models.ForeignKey('Tipotelefono', on_delete=models.CASCADE)

class Cliente(models.Model):

    id_persona = models.ForeignKey('Persona', on_delete=models.CASCADE)

class Departamento(models.Model):

    nombre = models.CharField(max_length=60)
    activo = 'Activo'
    no_activo = 'No activo'
    cat_choices = [
        (activo, 'Activo'),
        (no_activo, 'No activo'),
    ]
    status = models.CharField(choices=cat_choices, default=activo, max_length=10)

class Cargo(models.Model):
    nombre = models.CharField(max_length=60)
    id_departamento = models.ForeignKey('Departamento', on_delete=models.CASCADE)
    activo = 'Activo'
    no_activo = 'No activo'
    cat_choices = [
        (activo, 'Activo'),
        (no_activo, 'No activo'),
    ]
    status = models.CharField(choices=cat_choices, default=activo, max_length=10)

class Sucursal(models.Model):

    nombre = models.CharField(max_length=60)
    direccion = models.CharField(max_length=60)
    telefono= models.CharField(max_length=60)
    activo = 'Activo'
    no_activo = 'No activo'
    cat_choices = [
        (activo, 'Activo'),
        (no_activo, 'No activo'),
    ]
    status = models.CharField(choices=cat_choices, default=activo, max_length=10)

class Empleado(models.Model):

    id_persona = models.ForeignKey('Persona', on_delete=models.CASCADE)
    id_cargo = models.ForeignKey('Cargo', on_delete=models.CASCADE)
    id_sucursal = models.ForeignKey('Sucursal', on_delete=models.CASCADE)

class Tipoproducto(models.Model):

    nombre = models.CharField(max_length=60, null=False)
    descripcion = models.CharField(max_length=60, null=False)

class Producto(models.Model):

    nombre = models.CharField(max_length=60)
    descripcion = models.CharField(max_length=60, null=True)
    fec_elaboracion = models.DateField()
    fec_vencimiento= models.DateField()
    fec_compra = models.DateField(default=date.today)
    precio_compra= models.DecimalField(max_digits=5,decimal_places=2)
    precio_venta= models.DecimalField(max_digits=5,decimal_places=2)
    stock= models.PositiveIntegerField(default=0)
    id_tipo_producto = models.ForeignKey('Tipoproducto', on_delete=models.CASCADE)
    activo = 'Activo'
    no_activo = 'No activo'
    cat_choices = [
        (activo, 'Activo'),
        (no_activo, 'No activo'),
    ]
    status = models.CharField(choices=cat_choices, default=activo, max_length=10)

class Proveedor(models.Model):

    nombre = models.CharField(max_length=60)
    telefono = models.CharField(max_length=60)
    direccion = models.CharField(max_length=60)
    descripcion = models.CharField(max_length=60)
    activo = 'Activo'
    no_activo = 'No activo'
    cat_choices = [
        (activo, 'Activo'),
        (no_activo, 'No activo'),
    ]
    status = models.CharField(choices=cat_choices, default=activo, max_length=10)

class Factura(models.Model):

    id_departamento = models.ForeignKey('Departamento', on_delete=models.CASCADE)
    id_cliente = models.ForeignKey('Cliente', on_delete=models.CASCADE)
    id_empleado = models.ForeignKey('Empleado', on_delete=models.CASCADE)
    id_sucursal = models.ForeignKey('Sucursal', on_delete=models.CASCADE)
    fec_creacion = models.DateField(default=date.today)

class Detalle(models.Model):

    id_factura = models.ForeignKey('Factura', on_delete=models.CASCADE)
    id_producto = models.ForeignKey('Producto', on_delete=models.CASCADE)
    id_cliente = models.ForeignKey('Cliente', on_delete=models.CASCADE)
    id_empleado = models.ForeignKey('Empleado', on_delete=models.CASCADE)
    cantidadVendida = models.PositiveIntegerField()
    precioVenta= models.DecimalField(max_digits=5, decimal_places=2)