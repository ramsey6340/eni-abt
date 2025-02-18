package HelloApp;

import org.omg.PortableServer.*;
import org.omg.CORBA.*;
import org.omg.CosNaming.*;

public class HelloServeur {
    public static void main(String[] args) throws Exception {
        // Initialisation de l'ORB
        ORB orb = ORB.init(args, null);

        // Récupérer la référence du RootPOA et activer le POAManager
        POA rootpoa = POAHelper.narrow(orb.resolve_initial_references("RootPOA"));
        rootpoa.the_POAManager().activate();

        // Création de l'objet distant
        HelloImpl helloImpl = new HelloImpl();

        // Enregistrement de l'objet dans le POA
        org.omg.CORBA.Object ref = rootpoa.servant_to_reference(helloImpl);
        Hello href = HelloHelper.narrow(ref);

        // Accès au service de nommage
        org.omg.CORBA.Object refNServ = orb.resolve_initial_references("NameService");
        NamingContextExt nce = NamingContextExtHelper.narrow(refNServ);

        // Inscription de l'objet dans le service de nommage
        String serviceName = "HelloServices";
        NameComponent nc[] = nce.to_name(serviceName);
        nce.rebind(nc, href);

        // Lancement du serveur
        System.out.println("Serveur en attente des requetes des clients...");
        orb.run();
    }
}
