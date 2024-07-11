from django.contrib import admin

from apps.mae_factura.models import MaeFactura


# Register your models here.
class MaeFacturaAdmin(admin.ModelAdmin):
    list_display = [field.name for field in MaeFactura._meta.fields]
    search_fields = ['id']


admin.site.register(MaeFactura, MaeFacturaAdmin)
