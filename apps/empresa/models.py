from django.db import models


# Create your models here.
class Empresa(models.Model):
    empresa = models.IntegerField()
    nombre = models.CharField(max_length=150)
    estado = models.CharField(max_length=1)

    class Meta:
        ordering = ['nombre']

    def __str__(self):
        return self.nombre
