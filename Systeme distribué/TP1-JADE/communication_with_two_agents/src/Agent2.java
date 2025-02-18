import jade.core.Agent;
import jade.lang.acl.ACLMessage;

public class Agent2 extends Agent{

    @Override
    protected void setup() {
        System.out.println("Agent2 ==> "+getLocalName()+" est prêt");
        ACLMessage message = blockingReceive();

        if(message != null) {
            int number = Integer.parseInt(message.getContent());
            System.out.println("Agent2 ==> Le nombre réçu est "+number);
            String result = isPrimeNumber(number) ? "Le nombre "+number+" est premier" : "Le nombre "+number+" n'est pas premier";

            // Répondre au message de l'Agent1
            ACLMessage reply = message.createReply();
            reply.setContent(result);
            send(reply);
        }
    }

    private boolean isPrimeNumber(int n) {
        if (n <= 1) return false;
        for (int i = 2; i < n; i++) {
            if (n % i == 0) return false;
        }
        return true;
    }
}
