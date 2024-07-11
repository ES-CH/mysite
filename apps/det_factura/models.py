from django.db import models

from apps.empresa.models import Empresa
from apps.mae_factura.models import MaeFactura
from apps.productos.models import Productos

# Create your models here.


class DetFactura(models.Model):
    empresa = models.ForeignKey(Empresa, on_delete=models.CASCADE)
    consecutivo = models.IntegerField()
    id_factura = models.ForeignKey(MaeFactura, on_delete=models.CASCADE)
    id_producto = models.ForeignKey(Productos, on_delete=models.CASCADE)
    cantidad = models.DecimalField(max_digits=20, decimal_places=2)
    precio = models.DecimalField(max_digits=20, decimal_places=2)
    subtotal = models.DecimalField(max_digits=20, decimal_places=2)

    class Meta:
        ordering = ['consecutivo']

    def __str__(self):
        return self.empresa.nombre
