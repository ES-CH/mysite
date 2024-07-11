from rest_framework import status, viewsets
from rest_framework.response import Response

from apps.det_factura.models import DetFactura
from apps.det_factura.serializer import (DetFacturaCreateSerializer,
                                         DetFacturaSerializer)


class DetFacturaViewSet(viewsets.ModelViewSet):
    queryset = DetFactura.objects.all()
    serializer_class = DetFacturaSerializer

    def get_serializer_class(self):
        if self.action == 'list' or self.action == 'retrieve':
            return DetFacturaSerializer
        else:
            return DetFacturaCreateSerializer

    def create(self, request, *args, **kwargs):
        serializer = DetFacturaCreateSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        else:
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
