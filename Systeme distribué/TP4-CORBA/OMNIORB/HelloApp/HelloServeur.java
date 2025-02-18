package HelloApp;

import org.omg.CORBA.*;
import org.omg.PortableServer.*;
import org.omg.CosNaming.*;

public class HelloServeur {
    public static void main(String[] args) throws Exception {
        // Initialisation de l’ORB
        ORB orb = ORB.init(args, null);

        // Récupérer la référence du RootPOA et activer le POAManager
        POA rootpoa = POAHelper.narrow(orb.resolve_initial_references("RootPOA"));
        rootpoa.the_POAManager().activate();

        // Création de l’objet distant
        HelloImpl helloImpl = new HelloImpl();

        // Conversion (narrow) de l’objet en son interface
        org.omg.CORBA.Object ref = rootpoa.servant_to_reference(helloImpl);
        Hello href = HelloHelper.narrow(ref);

        // Récupération du service de nommage
        org.omg.CORBA.Object refNServ = orb.resolve_initial_references("NameService");
        NamingContextExt nce = NamingContextExtHelper.narrow(refNServ);

        // Inscrire l’interface de l’objet dans le service de nommage "HelloServices"
        String serviceName = "HelloServices";
        NameComponent nc[] = nce.to_name(serviceName);
        nce.rebind(nc, href);

        // Démarrer le service et attendre les requêtes des clients
        System.out.println("Serveur pret et en attente des requetes des clients...");
        orb.run();
    }
}
