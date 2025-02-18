package HelloApp;

import java.io.*;

public class HelloImpl extends HelloPOA {
    private static final String FILENAME = "groupe1.txt";  // Fichier partagé
    private static int nextClientId = 1;                     // Identifiant auto-incrémenté



// Constructeur pour initialiser le fichier
public HelloImpl() {
    try {
        File file = new File(FILENAME);
        if (!file.exists()) {
            file.createNewFile(); // Crée le fichier s'il n'existe pas
            createFile("append");
            System.out.println("Fichier partagé créé : " + FILENAME);
        }
    } catch (IOException e) {
        System.err.println("Erreur lors de la création du fichier : " + e.getMessage());
    }
}


    // Méthode pour enregistrer un client et lui attribuer un identifiant
    @Override
    public synchronized String registerClient() {
        int clientId = nextClientId++; // Génération de l'identifiant auto-incrémenté
        System.out.println("Un nouveau client a été enregistré avec l'identifiant : " + clientId);
        return "Client-" + clientId;  // Retourner l'identifiant formaté
    }

    @Override
    public synchronized float addition(float a, float b) {
        return a + b;
    }

    @Override
    public synchronized float soustraction(float a, float b) {
        return a - b;
    }

    @Override
    public synchronized float multiplication(float a, float b) {
        return a * b;
    }

    @Override
    public synchronized float division(float a, float b) {
        if (b == 0) {
            //throw new ArithmeticException("Division par zéro impossible");
            System.out.println("Division par zéro impossible");
            return 0;
        }
        else {
            return a / b;
        }
    }

    @Override
    public synchronized void createFile(String content) {
        try (FileWriter writer = new FileWriter(FILENAME, true)) {
            writer.write(content + "\n");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @Override
    public synchronized String readFile() {
        StringBuilder fileContent = new StringBuilder();
        try (BufferedReader reader = new BufferedReader(new FileReader(FILENAME))) {
            String line;
            while ((line = reader.readLine()) != null) {
                fileContent.append(line).append("\n");
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return fileContent.toString();
    }
}
