Proyecto creado usando Django y Python

## Instalar proyecto

Para instalar el proyecto de manera segura primero se necesita instalar las dependencias usando el comando:

```bash
python -m pip install -r requirements.txt
```

Despues de instalar las dependencias, ejecutar el siguiente comando para inicializar la base de datos y crear un super usuario

```bash
python manage.py migrate

python manage.py createsuperuser`
```

## Iniciar proyecto

Una vez instalado el proyecto ya se puede iniciar usando el siguiente comando:

```bash
python manage.py runserver
```

Adicional en la raiz del proyecto se encuentra el archiv sql_postgresql.bak contiene la base de datos proporciona ajustada para un entorno postgresql
y un archivo base_de_datos.sql con los datos utilizados en el desarrollo
