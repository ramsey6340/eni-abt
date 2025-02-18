import java.rmi.RemoteException;
import java.rmi.server.UnicastRemoteObject;

public class HelloImpl extends UnicastRemoteObject implements Hello {
private static final long serialVersionUID = 2674880711467464646L;
    public HelloImpl() throws RemoteException {
        super();
    }

    @Override
    public String sayHello() throws RemoteException {
        //implémentation de la métjode de l'objet distant
        System.out.println("Invocation de la methode sayHello()");
        return "Hello, World!";
    }
}