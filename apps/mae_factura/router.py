from rest_framework import routers

from apps.mae_factura.views import MaeFacturaViewSet

router = routers.DefaultRouter(trailing_slash=False)

router.register(r'', MaeFacturaViewSet)