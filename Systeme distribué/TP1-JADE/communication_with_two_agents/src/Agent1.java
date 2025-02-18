import jade.core.AID;
import jade.core.Agent;
import jade.lang.acl.ACLMessage;

import java.util.Random;

public class Agent1 extends Agent {

    @Override
    protected void setup() {

        System.out.println("Agent1 ==> "+getLocalName()+" est prêt");
        doWait(2000); // Attendre 2 secondes

        //  Créer et envoyer un message
        ACLMessage aclMessage = new ACLMessage(ACLMessage.REQUEST);
        aclMessage.addReceiver(new AID("agent2", AID.ISLOCALNAME));

        Random random = new Random();
        int randomNumber = random.nextInt(101); // Génère un nombre entre 0 et 100 inclus

        aclMessage.setContent(String.valueOf(randomNumber));
        send(aclMessage);

        // Attendre une réponse
        ACLMessage reply = blockingReceive();
        if(reply != null) {
            System.out.println("Agent1 ==> Résultat reçus: "+reply.getContent());
        }

    }
}
