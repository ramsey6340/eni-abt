#include <iostream>
#include <omniORB4/CORBA.h>
#include "HelloApp.hh"  // Ce fichier est généré par omniidl à partir de votre IDL

int main(int argc, char* argv[]) {
    try {
        // Initialiser l'ORB
        CORBA::ORB_var orb = CORBA::ORB_init(argc, argv);

        // Récupérer la référence du service de nommage
        CORBA::Object_var nsObj = orb->resolve_initial_references("NameService");

        // Convertir l'objet en NamingContextExt
        CosNaming::NamingContextExt_var nce = CosNaming::NamingContextExt::_narrow(nsObj);

        if (CORBA::is_nil(nce)) {
            std::cerr << "Impossible d'obtenir une référence valide du service de nommage." << std::endl;
            return 1;
        }

        // Résoudre le nom du service
        const char* serviceName = "HelloServices";
        CosNaming::Name name(1);
        name.length(1);
        name[0].id = CORBA::string_dup(serviceName);

        HelloApp::Hello_var helloObj;
        try {
            helloObj = HelloApp::Hello::_narrow(nce->resolve(name));
        } catch (const CosNaming::NamingContext::NotFound& e) {
            std::cerr << "Erreur lors de la recherche du service HelloServices." << std::endl;
            return 1;
        }

        if (CORBA::is_nil(helloObj)) {
            std::cerr << "Le service HelloServices est introuvable." << std::endl;
            return 1;
        }

        // Appeler la méthode distante
        std::string response = helloObj->sayHello();
        std::cout << "Réponse du serveur: " << response << std::endl;

        // Fermer l'ORB
        orb->destroy();

    } catch (const CORBA::Exception& e) {
        std::cerr << "Exception CORBA: " << e._name() << std::endl;
        return 1;
    }

    return 0;
}
