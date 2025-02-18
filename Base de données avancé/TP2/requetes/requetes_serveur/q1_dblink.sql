--Création d'un data link entre le serveur et le client
CREATE EXTENSION IF NOT EXISTS dblink; -- ajout de l'extension dblink
SELECT dblink_connect('dbname=db_enetp host=192.168.109.128 port=5432 user=Client password=C20232024');