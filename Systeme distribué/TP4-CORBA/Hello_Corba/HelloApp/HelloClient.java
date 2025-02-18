package HelloApp;

import org.omg.CORBA.*;
import org.omg.CosNaming.*;
import org.omg.CosNaming.NamingContextExt;
import org.omg.CosNaming.NamingContextExtHelper;

public class HelloClient {
    public static void main(String[] args) throws Exception {
        // Initialisation de l'ORB
        ORB orb = ORB.init(args, null);

        // Récupérer la référence du service de nommage
        org.omg.CORBA.Object nsRef = orb.resolve_initial_references("NameService");

        // Convertir (narrow) la référence en NamingContextExt
        NamingContextExt nce = NamingContextExtHelper.narrow(nsRef);

        // Générer un objet Stub par une recherche dans le service de nommage
        String serviceName = "HelloServices";
        Hello hRef = HelloHelper.narrow(nce.resolve_str(serviceName));

        // Appeler la méthode distante
        System.out.println("Reponse du serveur : " + hRef.sayHello());
    }
}
