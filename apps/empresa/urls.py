from django.urls import include, re_path

from apps.empresa.router import router

urlpatterns = [
    re_path(r'^', include(router.urls)),
]
