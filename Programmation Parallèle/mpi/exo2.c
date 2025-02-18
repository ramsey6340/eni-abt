#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include "mpi.h"

int main(int argc, char* argv[]) {
    int nbr_proc, rang;
    int elements_par_proc = 10; // Exemple : Nombre d'éléments par processeur
    float* nbrs_alea = NULL;

    // Initialisation de l'environnement MPI
    MPI_Init(&argc, &argv);
    MPI_Comm_rank(MPI_COMM_WORLD, &rang);
    MPI_Comm_size(MPI_COMM_WORLD, &nbr_proc);

    // Le processeur 0 génère les nombres aléatoires
    if (rang == 0) {
        nbrs_alea = creer_nbrs_alea(elements_par_proc, nbr_proc);
    }

    // Création d’un buffer pour contenir le sous-ensemble des nombres aléatoires
    float* sous_nbrs_alea = malloc(sizeof(float) * elements_par_proc);
    if (sous_nbrs_alea == NULL) {
        fprintf(stderr, "Erreur d'allocation mémoire\n");
        MPI_Abort(MPI_COMM_WORLD, 1);
    }

    // Diviser et envoyer les nombres aléatoires du processeur 0 vers tous les autres processeurs
    MPI_Scatter(
        nbrs_alea, 
        elements_par_proc, 
        MPI_FLOAT,
        sous_nbrs_alea, 
        elements_par_proc, 
        MPI_FLOAT,
        0, 
        MPI_COMM_WORLD
    );

    // Calculer la moyenne des sous-ensembles
    float sous_moy = calculer_moy(sous_nbrs_alea, elements_par_proc);

    // Grouper (Gather) toutes les moyennes dans le processeur 0
    float* sous_moys = NULL;
    if (rang == 0) {
        sous_moys = malloc(sizeof(float) * nbr_proc);
        if (sous_moys == NULL) {
            fprintf(stderr, "Erreur d'allocation mémoire\n");
            MPI_Abort(MPI_COMM_WORLD, 1);
        }
    }

    MPI_Gather(&sous_moy, 1, MPI_FLOAT, sous_moys, 1, MPI_FLOAT, 0,MPI_COMM_WORLD);

    // Afficher les résultats sur le processeur 0
    if (rang == 0) {
        float total_moy = 0.0;
        for (int i = 0; i < nbr_proc; i++) {
            total_moy += sous_moys[i];
        }
        total_moy /= nbr_proc;
        printf("La moyenne globale est : %f\n", total_moy);
        free(nbrs_alea);
        free(sous_moys);
    }

    // Libération de la mémoire allouée
    free(sous_nbrs_alea);
    MPI_Finalize();
    return 0;
}

// Déclare les fonctions utilisées
//float* creer_nbrs_alea(int elements_par_proc, int nbr_proc);
//float calculer_moy(float* sous_nbrs_alea, int elements_par_proc);


// Définition de la fonction creer_nbrs_alea
float* creer_nbrs_alea(int elements_par_proc, int nbr_proc) {
    int total_elements = elements_par_proc * nbr_proc;
    float* data = malloc(sizeof(float) * total_elements);
    if (data == NULL) {
        fprintf(stderr, "Erreur d'allocation mémoire dans creer_nbrs_alea\n");
        MPI_Abort(MPI_COMM_WORLD, 1);
    }
    // Initialiser le générateur de nombres aléatoires
    srand((unsigned int)time(NULL));
    for (int i = 0; i < total_elements; i++) {
        data[i] = (float)rand() / (float)RAND_MAX; // Nombres aléatoires entre 0 et 1
    }
    return data;
}

// Définition de la fonction calculer_moy
float calculer_moy(float* sous_nbrs_alea, int elements_par_proc) {
    float somme = 0.0f;
    for (int i = 0; i < elements_par_proc; i++) {
        somme += sous_nbrs_alea[i];
    }
    return somme / elements_par_proc;
}
