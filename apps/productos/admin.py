from django.contrib import admin

from apps.productos.models import Productos

# Register your models here.


class ProductoAdmin(admin.ModelAdmin):
    list_display = [field.name for field in Productos._meta.fields]
    search_fields = ['id']


admin.site.register(Productos, ProductoAdmin)
