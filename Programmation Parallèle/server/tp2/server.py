import socket
import sys
import threading

HOST = '127.0.0.1'
PORT = 46000
client_lock = threading.Lock()
conn_client = {}  # Dictionnaire des connexions clients
running = True  # Flag pour arrêter proprement le serveur

class ThreadClient(threading.Thread):
    """Derivation d'un objet thread pour gerer la connexion avec un client"""
    def __init__(self, conn):
        threading.Thread.__init__(self)
        self.connexion = conn

    def run(self):
        nom = self.name
        print(f"Thread {nom} démarré pour gérer le client.")
        while running:
            try:
                msgClient = self.connexion.recv(1024).decode("Utf8")
                if not msgClient or msgClient.upper() == "FIN":
                    break

                message = f"{nom}> {msgClient}"
                with client_lock:
                    for cle in conn_client:
                        if cle != nom:
                            conn_client[cle].send(message.encode("Utf8"))
            except Exception as e:
                print(f"Erreur avec le client {nom}: {e}")
                break

        print(f"Fermeture de la connexion pour le client {nom}.")
        self.connexion.close()
        with client_lock:
            del conn_client[nom]
        print(f"Client {nom} déconnecté.")

def server_control():
    global running
    while running:
        command = input("Tapez 'STOP' pour arrêter le serveur : ").strip()
        if command.upper() == "STOP":
            print("Arrêt du serveur...")
            running = False
            mySocket.close()  # Ferme le socket principal

# Initialisation du serveur
mySocket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
try:
    mySocket.bind((HOST, PORT))
    mySocket.listen(5)
    print(f"Serveur démarré sur {HOST}:{PORT}, en attente de connexions...")
except socket.error as e:
    print(f"Erreur : La liaison du socket a échoué - {e}")
    sys.exit()

# Lancer un thread pour les commandes du serveur
thread_control = threading.Thread(target=server_control, daemon=True)
thread_control.start()

while running:
    try:
        connexion, adresse = mySocket.accept()
        th = ThreadClient(connexion)
        th.start()
        it = th.name
        with client_lock:
            conn_client[it] = connexion
        print(f"Client {it} connecté, adresse IP {adresse[0]}, port {adresse[1]}.")
        connexion.send("Vous êtes connecté. Envoyez vos messages.".encode("Utf8"))
    except Exception as e:
        if not running:  # Arrêt via commande "STOP"
            break
        print(f"Erreur dans la boucle principale : {e}")

print("Serveur arrêté.")
