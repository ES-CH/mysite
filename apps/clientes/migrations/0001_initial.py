# Generated by Django 4.1.5 on 2024-07-10 19:27

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        ('empresa', '0001_initial'),
    ]

    operations = [
        migrations.CreateModel(
            name='Clientes',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('cliente', models.IntegerField()),
                ('tipo', models.CharField(choices=[('C', 'C'), ('N', 'N'), ('E', 'E')], max_length=1)),
                ('nombre', models.CharField(max_length=150)),
                ('telefono', models.CharField(max_length=150)),
                ('correo', models.EmailField(max_length=150)),
                ('direccion', models.CharField(max_length=250)),
                ('paginaweb', models.CharField(max_length=150)),
                ('fecha_creacion', models.DateTimeField(auto_now_add=True)),
                ('estado', models.CharField(choices=[('A', 'A'), ('I', 'I')], max_length=1)),
                ('empresa', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='empresa.empresa')),
            ],
            options={
                'ordering': ['nombre'],
            },
        ),
    ]