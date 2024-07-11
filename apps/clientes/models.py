from django.db import models

from apps.empresa.models import Empresa

TIPO = (
    ('C', 'C'),
    ('N', 'N'),
    ('E', 'E'),
)

ESTADO = (
    ('A', 'A'),
    ('I', 'I'),
)

# Create your models here.


class Clientes(models.Model):
    empresa = models.ForeignKey(Empresa, on_delete=models.CASCADE)
    cliente = models.IntegerField()
    tipo = models.CharField(max_length=1, choices=TIPO)
    nombre = models.CharField(max_length=150)
    telefono = models.CharField(max_length=150)
    correo = models.EmailField(max_length=150)
    direccion = models.CharField(max_length=250)
    paginaweb = models.CharField(max_length=150)
    fecha_creacion = models.DateTimeField(auto_now_add=True)
    estado = models.CharField(max_length=1, choices=ESTADO)

    class Meta:
        ordering = ['nombre']

    def __str__(self):
        return self.nombre
