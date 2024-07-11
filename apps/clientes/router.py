from rest_framework import routers

from apps.clientes.views import ClienteViewSet

router = routers.DefaultRouter(trailing_slash=False)

router.register(r'', ClienteViewSet)
