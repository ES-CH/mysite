from rest_framework import routers

from apps.det_factura.views import DetFacturaViewSet

router = routers.DefaultRouter(trailing_slash=False)

router.register(r'', DetFacturaViewSet)
