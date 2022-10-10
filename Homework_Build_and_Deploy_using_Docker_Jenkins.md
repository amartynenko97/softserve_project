#### *Build and Deploy small project from GitHub using Jenkins, MSSQL, Docker on Ubuntu VM*
___

+ *Сделать `backup` базы с `Windows Server` с помощью `SQL Server Managment` и используя утилитку `WinScp` отправить 2 `.bak` на `Ubuntu` машину по протоколу `SSH`* 
+ 
![](/media/photo1.png)

+  *Создать dockerfile согласно которого будет выполняться набор действий для сборки следующих вариаций образов SQL контейнера: Cперва, бэкап будет ресториться и база будет храниться в контейнере, потом включается дженкинс стягивает репу приложения с `Github` делает с помощью написаного `pipeline` на `groovy` делает сборку кода и артефакт кладет в контейнер в котором приложение запускается, в нужном окружении*

```docker
FROM mcr.microsoft.com/mssql/server:2019-latest
ENV ACCEPT_EULA=Y
ENV SA_PASSWORD="ARandomPassword123!"
USER root:root

COPY ./bashscript* /opt/

EXPOSE 1433

ENTRYPOINT ["bash", "/opt/bashscript.sh"]
```

*Ресторим базы данных, данные и логи будут писатся в определенные папки*

```sql
RESTORE DATABASE [MicrosofteShopOnWebCatalogDb] FROM  DISK = N'/SQL/MicrosofteShopOnWebCatalogDb.bak'
WITH  FILE = 1,
MOVE N'MicrosofteShopOnWebCatalogDb' TO N'/SQL/data/MicrosofteShopOnWebCatalogDb.mdf',
MOVE N'MicrosofteShopOnWebCatalogDb_log' TO N'/SQL/log/MicrosofteShopOnWebCatalogDb_log.ldf',
NOUNLOAD,  STATS = 1
```

```sql
RESTORE DATABASE [MicrosofteShopOnWebIdentity] FROM  DISK = N'/SQL/MicrosofteShopOnWebIdentity.bak'
WITH  FILE = 1,
MOVE N'MicrosofteShopOnWebIdentity' TO N'/SQL/data/MicrosofteShopOnWebIdentity.mdf',
MOVE N'MicrosofteShopOnWebIdentity_log' TO N'/SQL/log/MicrosofteShopOnWebIdentity_log.ldf',
NOUNLOAD,  STATS = 1
```

*Ниже файлы которые мы будем запускать и логиниться в базе, будут лежать внутри контейнера*

```sh
#!/bin/bash

while ! "Service Broker manager has started." /var/opt/mssql/log/errorlog*
do
sleep 5s
echo "waiting for SQL sever..."
done

/opt/mssql-tools/bin/sqlcmd -S localhost -U SA P "ARandomPassword123!" -i /SQL/restoredatabase_1.sql
/opt/mssql-tools/bin/sqlcmd -S localhost -U SA P "ARandomPassword123!" -i /SQL/restoredatabase_2.sql
```


```sh
#!/bin/bash
(/opt/bashscript2.sh > bash.log) & /opt/mssql/bin/sqlservr
```

*`Pipeline` для `build` и `deploy`*

*Образ с базой ложим в dockerhub. `Dockerfile` для рантайма можно взять https://github.com/dotnet-architecture/eShopOnWeb или ниже скрин моего*

![](/media/photo2.png)

![](/media/photo3.png)

![](/media/photo4.png)