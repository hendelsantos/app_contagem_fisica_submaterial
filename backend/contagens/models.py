from decimal import Decimal

from django.db import models


class Contagem(models.Model):
    sessao_app_id = models.CharField(max_length=80, unique=True)
    operador_nome = models.CharField(max_length=160)
    operador_matricula = models.CharField(max_length=60)
    data_inicio = models.DateTimeField()
    data_fim_real = models.DateTimeField(null=True, blank=True)
    status = models.CharField(max_length=40, default="recebida")
    versao_cadastro = models.CharField(max_length=80, blank=True)
    aparelho = models.CharField(max_length=120, blank=True)
    total_itens = models.PositiveIntegerField(default=0)
    total_contado = models.DecimalField(max_digits=14, decimal_places=3, default=0)
    total_recebido = models.DecimalField(max_digits=14, decimal_places=3, default=0)
    payload_original = models.JSONField(default=dict)
    criada_em = models.DateTimeField(auto_now_add=True)
    atualizada_em = models.DateTimeField(auto_now=True)

    class Meta:
        ordering = ["-data_inicio"]

    def __str__(self):
        return f"{self.sessao_app_id} - {self.operador_nome}"


class ItemContagem(models.Model):
    contagem = models.ForeignKey(
        Contagem, related_name="itens", on_delete=models.CASCADE
    )
    material_codigo = models.CharField(max_length=80)
    fornecedor = models.CharField(max_length=120, blank=True)
    material_descricao = models.CharField(max_length=240, blank=True)
    estoque_anterior = models.DecimalField(max_digits=14, decimal_places=3, default=0)
    estoque_contado = models.DecimalField(max_digits=14, decimal_places=3, default=0)
    linha_estoque = models.DecimalField(
        max_digits=14, decimal_places=3, null=True, blank=True
    )
    containers = models.JSONField(default=list, blank=True)
    cuba_estoque = models.DecimalField(
        max_digits=14, decimal_places=3, null=True, blank=True
    )
    outros_estoque = models.DecimalField(
        max_digits=14, decimal_places=3, null=True, blank=True
    )
    recebimento_total = models.DecimalField(max_digits=14, decimal_places=3, default=0)
    soma_nf = models.DecimalField(max_digits=14, decimal_places=3, default=0)
    status = models.CharField(max_length=40)
    justificativa = models.TextField(blank=True)
    observacao = models.TextField(blank=True)
    foto_path = models.CharField(max_length=500, blank=True)
    timestamp_item = models.DateTimeField(null=True, blank=True)
    payload_original = models.JSONField(default=dict)

    class Meta:
        ordering = ["fornecedor", "material_descricao", "material_codigo"]
        unique_together = [("contagem", "material_codigo")]

    @property
    def consumo_estimado(self):
        return self.estoque_anterior + self.recebimento_total - self.estoque_contado

    @property
    def tem_estratificacao(self):
        return (
            self.linha_estoque is not None
            or any(Decimal(str(v or 0)) != 0 for v in (self.containers or []))
            or self.cuba_estoque is not None
            or self.outros_estoque is not None
        )

    @property
    def estratificacao_resumo(self):
        partes = []
        if self.linha_estoque is not None:
            partes.append(f"Linha: {self.linha_estoque}")
        for i, value in enumerate(self.containers or [], start=1):
            decimal_value = Decimal(str(value or 0))
            if decimal_value != 0:
                partes.append(f"C{i}: {decimal_value}")
        if self.cuba_estoque is not None:
            partes.append(f"Cuba: {self.cuba_estoque}")
        if self.outros_estoque is not None:
            partes.append(f"Outros: {self.outros_estoque}")
        return " | ".join(partes)

    def __str__(self):
        return f"{self.material_codigo} - {self.status}"


class NotaRecebimento(models.Model):
    item = models.ForeignKey(
        ItemContagem, related_name="notas", on_delete=models.CASCADE
    )
    numero = models.CharField(max_length=120)
    quantidade = models.DecimalField(max_digits=14, decimal_places=3, default=0)
    data_recebimento = models.DateTimeField(null=True, blank=True)
    foto_path = models.CharField(max_length=500, blank=True)

    class Meta:
        ordering = ["numero"]

    def __str__(self):
        return f"{self.numero} - {self.quantidade}"
