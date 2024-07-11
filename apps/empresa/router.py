from rest_framework import routers

from apps.empresa.views import EmpresaViewSet

router = routers.DefaultRouter(trailing_slash=False)

router.register(r'', EmpresaViewSet)
