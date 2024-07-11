from django.contrib import admin

from apps.det_factura.models import DetFactura


# Register your models here.
class DetFacturaAdmin(admin.ModelAdmin):
    list_display = [field.name for field in DetFactura._meta.fields]
    search_fields = ['id']


admin.site.register(DetFactura, DetFacturaAdmin)
