RESTORE DATABASE [MicrosofteShopOnWebCatalogDb] FROM  DISK = N'/SQL/MicrosofteShopOnWebCatalogDb.bak'
WITH  FILE = 1,
MOVE N'MicrosofteShopOnWebCatalogDb' TO N'/SQL/data/MicrosofteShopOnWebCatalogDb.mdf',
MOVE N'MicrosofteShopOnWebCatalogDb_log' TO N'/SQL/log/MicrosofteShopOnWebCatalogDb_log.ldf',
NOUNLOAD,  STATS = 1
