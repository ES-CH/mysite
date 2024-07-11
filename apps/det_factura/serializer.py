from rest_framework import serializers

from apps.det_factura.models import DetFactura
from apps.empresa.serializer import EmpresaSerializer
from apps.mae_factura.serializer import MaeFacturaSerializer
from apps.productos.serializer import ProductoSerializer


class DetFacturaSerializer(serializers.ModelSerializer):
    empresa = EmpresaSerializer(read_only=True)
    id_factura = MaeFacturaSerializer(read_only=True)
    id_producto = ProductoSerializer(read_only=True)

    class Meta:
        model = DetFactura
        fields = '__all__'


class DetFacturaCreateSerializer(serializers.ModelSerializer):

    class Meta:
        model = DetFactura
        fields = '__all__'
