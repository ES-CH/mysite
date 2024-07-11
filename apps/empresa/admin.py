from django.contrib import admin

from apps.empresa.models import Empresa


# Register your models here.
class EmpresaAdmin(admin.ModelAdmin):
    list_display = [field.name for field in Empresa._meta.fields]
    search_fields = ['id']


admin.site.register(Empresa, EmpresaAdmin)
