from django.urls import include, re_path

from apps.mae_factura.router import router

urlpatterns = [
    re_path(r'^', include(router.urls)),
]
