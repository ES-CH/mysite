from rest_framework import viewsets

from apps.clientes.models import Clientes
from apps.clientes.serializer import ClienteSerializer


class ClienteViewSet(viewsets.ModelViewSet):
    queryset = Clientes.objects.all()
    serializer_class = ClienteSerializer

    def get_serializer_class(self):
        if self.action == 'list':
            return ClienteSerializer
        if self.action == 'create' or self.action == 'update':
            return ClienteSerializer
        else:
            return ClienteSerializer
