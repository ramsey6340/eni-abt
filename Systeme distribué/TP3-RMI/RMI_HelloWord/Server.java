import java.net.InetAddress;
import java.net.MalformedURLException;
import java.net.UnknownHostException;
import java.rmi.Naming;
import java.rmi.RMISecurityManager;
import java.rmi.RemoteException;
import java.rmi.registry.LocateRegistry;


public class Server {
    public static void main(String[] args) {
        try {
            //Lancement dynamique du registre de noms RMI REGISTRY sur le port 1099
            LocateRegistry.createRegistry(1099);
            System.out.println("Mise en place de Security Managre ...");
            //Instanciation de l'objet distant
            HelloImpl helloImpl = new HelloImpl();
            //Enregistrement de l'objet distant sur le registre de nom de l'url
            String url = "rmi://" +InetAddress.getLocalHost().getHostAddress() +"/TestRMI"; 
            System.out.println("Enregistrement de l'objet avec l'url :" + url);
            Naming.rebind(url, helloImpl);

            System.out.println("Serveur lance");
          
        } catch (RemoteException e) {
            e.printStackTrace();
        }
        catch (MalformedURLException e) {
            e.printStackTrace();
        }
        catch (UnknownHostException e) {
            e.printStackTrace();
        }
       
    }

}