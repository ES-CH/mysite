from django.contrib import admin

from apps.clientes.models import Clientes

# Register your models here.


class ClienteAdmin(admin.ModelAdmin):
    list_display = [field.name for field in Clientes._meta.fields]
    search_fields = ['id']


admin.site.register(Clientes, ClienteAdmin)
