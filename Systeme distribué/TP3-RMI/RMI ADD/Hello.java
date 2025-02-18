import java.rmi.*;

public interface Hello extends Remote {
    int addNumbers(int num1, int num2) throws RemoteException;
}
