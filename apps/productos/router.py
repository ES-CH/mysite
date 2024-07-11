from rest_framework import routers

from apps.productos.views import ProductoViewSet

router = routers.DefaultRouter(trailing_slash=False)

router.register(r'', ProductoViewSet)
