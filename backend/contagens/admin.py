from django.contrib import admin

from .models import Contagem, ItemContagem, NotaRecebimento


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


class NotaRecebimentoInline(admin.TabularInline):
    model = NotaRecebimento
    extra = 0
    fields = ("numero", "quantidade", "data_recebimento", "foto_path")


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
    inlines = [NotaRecebimentoInline]


@admin.register(NotaRecebimento)
class NotaRecebimentoAdmin(admin.ModelAdmin):
    list_display = ("numero", "quantidade", "item")
    search_fields = ("numero", "item__material_codigo", "item__material_descricao")
