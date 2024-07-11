from django.db import models

from apps.clientes.models import Clientes
from apps.empresa.models import Empresa

# Create your models here.


class MaeFactura(models.Model):
    empresa = models.ForeignKey(Empresa, on_delete=models.CASCADE)
    numero = models.IntegerField()
    fehca_creacion = models.DateTimeField(auto_now_add=True)
    cliente = models.ForeignKey(Clientes, on_delete=models.CASCADE)
    observaciones = models.CharField(max_length=300)
    total = models.DecimalField(max_digits=20, decimal_places=2)
    fecha_auditoria = models.DateTimeField(auto_now=True)

    class Meta:
        ordering = ['numero']

    def __str__(self):
        return self.observaciones
