import java.rmi.RemoteException;
import java.rmi.server.UnicastRemoteObject;

public class HelloImpl extends UnicastRemoteObject implements Hello {
    private static final long serialVersionUID = 2674880711467464646L;

    protected HelloImpl() throws RemoteException {
        super();
    }

    @Override
    public int addNumbers(int num1, int num2) throws RemoteException {
        System.out.println("Invocation de la méthode addNumbers()");
        return num1 + num2;
    }
}
