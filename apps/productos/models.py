from django.db import models

from apps.empresa.models import Empresa

# Create your models here.

TIPO = (
    ('M', 'M'),
    ('T', 'T'),

)

ESTADO = (
    ('A', 'A'),
    ('I', 'I'),
)


class Productos(models.Model):
    empresa = models.ForeignKey(Empresa, on_delete=models.CASCADE)
    producto = models.CharField(max_length=30)
    nombre = models.CharField(max_length=150)
    tipo = models.CharField(max_length=1, choices=TIPO)
    fotoproducto = models.ImageField(
        upload_to='productos')
    fecha_creacion = models.DateTimeField(auto_now_add=True)
    estado = models.CharField(max_length=1, choices=ESTADO)

    class Meta:
        ordering = ['nombre']

    def __str__(self):
        return self.nombre
