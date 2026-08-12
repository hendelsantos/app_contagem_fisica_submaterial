from django.contrib import admin

from .models import Contagem, ItemContagem


class ItemContagemInline(admin.TabularInline):
    model = ItemContagem
    extra = 0
    fields = (
        "material_codigo",
        "fornecedor",
        "material_descricao",
        "estoque_anterior",
        "recebimento_total",
        "estoque_contado",
        "status",
    )


@admin.register(Contagem)
class ContagemAdmin(admin.ModelAdmin):
    list_display = (
        "sessao_app_id",
        "operador_nome",
        "operador_matricula",
        "data_inicio",
        "status",
        "total_itens",
    )
    search_fields = ("sessao_app_id", "operador_nome", "operador_matricula")
    list_filter = ("status", "data_inicio")
    inlines = [ItemContagemInline]


@admin.register(ItemContagem)
class ItemContagemAdmin(admin.ModelAdmin):
    list_display = (
        "material_codigo",
        "fornecedor",
        "material_descricao",
        "estoque_anterior",
        "recebimento_total",
        "estoque_contado",
        "status",
    )
    search_fields = ("material_codigo", "material_descricao", "fornecedor")
    list_filter = ("fornecedor", "status")
