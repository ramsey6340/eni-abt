import java.net.MalformedURLException;
import java.rmi.Naming;
import java.rmi.RMISecurityManager;
import java.rmi.RemoteException;
import java.rmi.Remote;
import java.rmi.NotBoundException;


public class Client {
    public static void main(String[] args) {
        System.out.println("Lancement du client");
        try {
            //recherche dans le registre de noms et retour du stub s'il est existant
            Remote r=Naming.lookup("rmi://127.0.0.1/TestRMI");
            System.out.println(r);
            if (r instanceof Hello) {
                //invocation distance de la méthode
                String s=((Hello) r).sayHello();
                System.out.println("chaine renvoyee =" + s);
            }
            
        } catch (MalformedURLException e) {
            e.printStackTrace();
        } catch (RemoteException e) {
            e.printStackTrace();
        } catch (NotBoundException e) {
            e.printStackTrace();
        System.out.println("Fin du client");
        }
    }
}