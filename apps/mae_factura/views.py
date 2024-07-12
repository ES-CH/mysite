from rest_framework import status, viewsets
from rest_framework.response import Response

from apps.mae_factura.models import MaeFactura
from apps.mae_factura.serializer import (MaeFacturaCreateSerializer, MaeFacturaListSerializer,
                                         MaeFacturaSerializer)

# Create your views here.


class MaeFacturaViewSet(viewsets.ModelViewSet):
    queryset = MaeFactura.objects.all()
    serializer_class = MaeFacturaSerializer

    def get_serializer_class(self):
        if self.action == 'list':
            return MaeFacturaListSerializer
        if self.action == 'retrieve':
            return MaeFacturaSerializer
        else:
            return MaeFacturaCreateSerializer

    def create(self, request, *args, **kwargs):
        serializer = MaeFacturaCreateSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        else:
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    def update(self, request, *args, **kwargs):
        instance = self.get_object()
        serializer = MaeFacturaCreateSerializer(instance, data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_200_OK)
        else:
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
