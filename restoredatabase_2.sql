RESTORE DATABASE [MicrosofteShopOnWebIdentity] FROM  DISK = N'/SQL/MicrosofteShopOnWebIdentity.bak'
WITH  FILE = 1,
MOVE N'MicrosofteShopOnWebIdentity' TO N'/SQL/data/MicrosofteShopOnWebIdentity.mdf',
MOVE N'MicrosofteShopOnWebIdentity_log' TO N'/SQL/log/MicrosofteShopOnWebIdentity_log.ldf',
NOUNLOAD,  STATS = 1
