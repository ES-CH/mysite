from rest_framework import viewsets

from apps.empresa.models import Empresa
from apps.empresa.serializer import EmpresaSerializer

# Create your views here.


class EmpresaViewSet(viewsets.ModelViewSet):
    queryset = Empresa.objects.all()
    serializer_class = EmpresaSerializer

    search_fields = ['empresa', 'nombre', 'estado']

    def get_serializer_class(self):
        if self.action == 'list' or self.action == 'retrieve':
            return EmpresaSerializer
