"""pruebaback URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/4.1/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import include, path

urlpatterns = [
    path('det-factura/', include('apps.det_factura.urls')),
    path('mae-factura/', include('apps.mae_factura.urls')),
    path('productos/', include('apps.productos.urls')),
    path('clientes/', include('apps.clientes.urls')),
    path('empresas/', include('apps.empresa.urls')),
    path('admin/', admin.site.urls),
]
