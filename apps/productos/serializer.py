from rest_framework import serializers

from apps.empresa.serializer import EmpresaSerializer
from apps.productos.models import Productos


class ProductoSerializer(serializers.ModelSerializer):
    empresa = EmpresaSerializer(read_only=True)
    fecha_creacion = serializers.DateTimeField(
        format='%Y-%m-%d %H:%M', read_only=True)

    class Meta:
        model = Productos
        fields = '__all__'
