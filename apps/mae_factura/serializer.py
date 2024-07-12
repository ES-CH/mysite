from rest_framework import serializers

from apps.clientes.serializer import ClienteSerializer
from apps.empresa.serializer import EmpresaSerializer
from apps.mae_factura.models import MaeFactura


class MaeFacturaListSerializer(serializers.ModelSerializer):
    empresa = EmpresaSerializer(read_only=True)
    cliente = ClienteSerializer(read_only=True)
    fehca_creacion = serializers.DateTimeField(
        format='%Y-%m-%d %H:%M', read_only=True)
    fecha_auditoria = serializers.DateTimeField(
        format='%Y-%m-%d %H:%M', read_only=True)

    class Meta:
        model = MaeFactura
        fields = '__all__'


class MaeFacturaSerializer(serializers.ModelSerializer):
    empresa = EmpresaSerializer(read_only=True)
    cliente = ClienteSerializer(read_only=True)
    fehca_creacion = serializers.DateTimeField(
        format='%Y-%m-%d', read_only=True)
    fecha_auditoria = serializers.DateTimeField(
        format='%Y-%m-%d', read_only=True)

    class Meta:
        model = MaeFactura
        fields = '__all__'


class MaeFacturaCreateSerializer(serializers.ModelSerializer):

    class Meta:
        model = MaeFactura
        fields = '__all__'
