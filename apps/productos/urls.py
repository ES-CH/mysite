from django.urls import include, re_path

from apps.productos.router import router

urlpatterns = [
    re_path(r'^', include(router.urls)),
]
