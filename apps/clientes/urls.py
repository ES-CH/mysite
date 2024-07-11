from django.urls import include, re_path

from apps.clientes.router import router

urlpatterns = [
    re_path(r'^', include(router.urls)),
]
