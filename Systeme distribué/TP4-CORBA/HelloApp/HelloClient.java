package HelloApp;

import org.omg.CORBA.*;
import org.omg.CosNaming.*;
import java.util.Scanner;

public class HelloClient {
    public static void main(String[] args) throws Exception {
        // Initialisation de l'ORB
        ORB orb = ORB.init(args, null);

        // Récupérer la référence du service de nommage
        org.omg.CORBA.Object nsRef = orb.resolve_initial_references("NameService");
        NamingContextExt nce = NamingContextExtHelper.narrow(nsRef);

        // Recherche de l'objet distant dans le service de nommage
        String serviceName = "HelloServices";
        Hello hRef = HelloHelper.narrow(nce.resolve_str(serviceName));

        // Enregistrer le client et recevoir un identifiant unique
        String clientId = hRef.registerClient();
        System.out.println("Bienvenue ! Votre identifiant est : " + clientId);

        // Scanner pour interagir avec l'utilisateur
        Scanner scanner = new Scanner(System.in);
        int clientCount = 0;

        while (clientCount < 5) {
            System.out.println("Veuillez choisir une operation:");
            System.out.println("1. Addition");
            System.out.println("2. Soustraction");
            System.out.println("3. Multiplication");
            System.out.println("4. Division");
            System.out.println("5. Lire le fichier");
            System.out.println("6. Ecrire dans le fichier");
            System.out.println("0. Quitter");

            int choice = scanner.nextInt();

            if (choice == 0) break;

            switch (choice) {
                case 1: case 2: case 3: case 4:
                    System.out.print("Entrez le premier nombre: ");
                    float a = scanner.nextFloat();
                    System.out.print("Entrez le deuxième nombre: ");
                    float b = scanner.nextFloat();

                    if (choice == 1) System.out.println("Résultat: " + hRef.addition(a, b));
                    if (choice == 2) System.out.println("Résultat: " + hRef.soustraction(a, b));
                    if (choice == 3) System.out.println("Résultat: " + hRef.multiplication(a, b));
                    if (choice == 4) {
                        try {
                            System.out.println("Résultat: " + hRef.division(a, b));
                        } catch (Exception e) {
                            System.out.println("Erreur: " + e.getMessage());
                        }
                    }
                    break;
                    case 5:
                    System.out.println("Contenu du fichier:");
                    System.out.println(hRef.readFile());
                    break;

                case 6:
                    System.out.println("Entrez le texte à ajouter:");
                    scanner.nextLine(); // Consommer la ligne restante
                    String content = scanner.nextLine();
                    hRef.createFile(content);
                    System.out.println("Texte ajouter au fichier.");
                    break;

                

                default:
                    System.out.println("Option invalide.");
            }
            clientCount++;
        }

        scanner.close();
    }
}
