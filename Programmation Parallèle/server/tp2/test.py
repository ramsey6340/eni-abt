import socket

HOST = '127.0.0.1'
PORT = 46000

print("Hello 1")
try:
    mySocket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    print("Socket créé.")
    mySocket.bind((HOST, PORT))
    print("Socket lié.")
    mySocket.listen(5)
    print("En écoute...")
except Exception as e:
    print(f"Erreur : {e}")
