--Création d'un data link entre le client et le serveur
CREATE EXTENSION IF NOT EXISTS dblink; -- ajout de l'extension dblink
SELECT dblink_connect('dbname=db_eniabt host=192.168.109.1 port=5432 user=Serveur password=S20232024');