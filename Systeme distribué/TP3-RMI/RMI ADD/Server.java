import java.net.InetAddress;
import java.net.UnknownHostException;
import java.rmi.Naming;
import java.rmi.RemoteException;
import java.rmi.registry.LocateRegistry;

public class Server {
    public static void main(String[] args) {
        try {
            // Lancement du registre de noms RMI sur le port 1099
            LocateRegistry.createRegistry(1099);
            System.out.println("Registre RMI lancé sur le port 1099");

            // Instanciation de l'objet distant
            HelloImpl helloImpl = new HelloImpl();

            // Récupérer l'adresse IP locale
            String hostAddress = InetAddress.getLocalHost().getHostAddress();
            String url = "rmi://" + hostAddress + "/TestRMI";
            System.out.println("Enregistrement de l'objet distant avec l'URL : " + url);

            // Enregistrement de l'objet dans le registre RMI
            Naming.rebind(url, helloImpl);

            System.out.println("Serveur prêt à recevoir les requêtes...");
        } catch (UnknownHostException e) {
            System.err.println("Erreur lors de l'obtention de l'adresse IP : " + e.getMessage());
            e.printStackTrace();
        } catch (RemoteException e) {
            System.err.println("Erreur lors de la communication RMI : " + e.getMessage());
            e.printStackTrace();
        } catch (Exception e) {
            System.err.println("Erreur inconnue : " + e.getMessage());
            e.printStackTrace();
        }
    }
}
