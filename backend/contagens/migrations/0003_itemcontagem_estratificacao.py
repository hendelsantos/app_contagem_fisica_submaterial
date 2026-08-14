from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ("contagens", "0002_notarecebimento"),
    ]

    operations = [
        migrations.AddField(
            model_name="itemcontagem",
            name="linha_estoque",
            field=models.DecimalField(
                blank=True, decimal_places=3, max_digits=14, null=True
            ),
        ),
        migrations.AddField(
            model_name="itemcontagem",
            name="containers",
            field=models.JSONField(blank=True, default=list),
        ),
        migrations.AddField(
            model_name="itemcontagem",
            name="cuba_estoque",
            field=models.DecimalField(
                blank=True, decimal_places=3, max_digits=14, null=True
            ),
        ),
        migrations.AddField(
            model_name="itemcontagem",
            name="outros_estoque",
            field=models.DecimalField(
                blank=True, decimal_places=3, max_digits=14, null=True
            ),
        ),
    ]
