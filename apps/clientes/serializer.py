from rest_framework import serializers

from apps.clientes.models import Clientes
from apps.empresa.serializer import EmpresaSerializer


class ClienteSerializer(serializers.ModelSerializer):
    empresa = EmpresaSerializer(read_only=True)

    class Meta:
        model = Clientes
        fields = '__all__'
