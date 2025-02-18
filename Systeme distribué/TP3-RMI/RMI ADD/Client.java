import java.rmi.Naming;
import java.rmi.NotBoundException;
import java.rmi.Remote;
import java.rmi.RemoteException;
import java.util.Scanner;

public class Client {
    public static void main(String[] args) {
        System.out.println("Lancement du client RMI...");
        try {
            // Recherche dans le registre RMI
            Remote r = Naming.lookup("rmi://127.0.0.1/TestRMI");
            System.out.println("Objet RMI trouvé : " + r);

            if (r instanceof Hello) {
                // Demander à l'utilisateur d'entrer deux nombres
                Scanner scanner = new Scanner(System.in);
                System.out.print("Client: Entrez le premier nombre: ");
                int num1 = scanner.nextInt();
                System.out.print("Client: Entrez le deuxième nombre: ");
                int num2 = scanner.nextInt();

                // Invocation distante de la méthode addNumbers
                int result = ((Hello) r).addNumbers(num1, num2);
                System.out.println("Résultat de l'addition: " + result);
            }
        } catch (NotBoundException e) {
            System.err.println("L'objet n'est pas lié au registre RMI : " + e.getMessage());
            e.printStackTrace();
        } catch (RemoteException e) {
            System.err.println("Erreur RMI : " + e.getMessage());
            e.printStackTrace();
        } catch (Exception e) {
            System.err.println("Erreur inconnue : " + e.getMessage());
            e.printStackTrace();
        }
        System.out.println("Client terminé");
    }
}
