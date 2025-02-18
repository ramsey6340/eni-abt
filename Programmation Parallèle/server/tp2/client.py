import socket, sys, threading

host = '127.0.0.1'
port = 46000


class ThreadReception(threading.Thread):
    """Objet thread gerant la reception des messages"""
    def __init__(self, conn, stop_event):
        threading.Thread.__init__(self)
        self.connexion = conn  # Référence du socket de connexion
        self.stop_event = stop_event  # Événement de signalisation pour arrêter

    def run(self):
        while not self.stop_event.is_set():
            message_recu = self.connexion.recv(1024).decode("Utf8")
            print("*" + message_recu + "*")
            if not message_recu or message_recu.upper() == "FIN":
                break
        print("Client arrete. Connexion interrompue.")
        self.connexion.close()

class ThreadEmission(threading.Thread):
    """Objet thread gerant l'emission des messages"""
    def __init__(self, conn, stop_event):
        threading.Thread.__init__(self)
        self.connexion = conn  # Référence du socket de connexion
        self.stop_event = stop_event  # Événement de signalisation pour arrêter

    def run(self):
        while not self.stop_event.is_set():
            message_emis = input()
            self.connexion.send(message_emis.encode("Utf8"))

# Programme principal - Établissement de la connexion :
connexion = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
try:
    connexion.connect((host, port))
except socket.error:
    print("La connexion a echoue.")
    sys.exit()

print("Connexion etablie avec le serveur.")

# Créer un événement pour signaler l'arrêt des threads
stop_event = threading.Event()

# Dialogue avec le serveur : on lance deux threads pour gérer l'émission et la réception des messages :
th_E = ThreadEmission(connexion, stop_event)
th_R = ThreadReception(connexion, stop_event)
th_E.start()
th_R.start()

