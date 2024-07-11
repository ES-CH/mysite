from rest_framework import viewsets

from apps.productos.models import Productos
from apps.productos.serializer import ProductoSerializer


class ProductoViewSet(viewsets.ModelViewSet):
    queryset = Productos.objects.all()
    serializer_class = ProductoSerializer

    def get_serializer_class(self):
        if self.action == 'list':
            return ProductoSerializer
        if self.action == 'create' or self.action == 'update':
            return ProductoSerializer
