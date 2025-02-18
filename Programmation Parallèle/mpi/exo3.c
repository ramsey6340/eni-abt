#include <stdio.h>
#include <stdlib.h>
#include "mpi.h"

// Déclaration de la fonction creer_nbrs_alea
float* creer_nbrs_alea(int elements_par_proc);

int main(int argc, char* argv[]) {
    int nbr_proc, rang;
    int elements_par_proc = 10; // Exemple : nombre d'éléments par processeur
    float som_globale = 0.0;

    MPI_Init(&argc, &argv);
    MPI_Comm_rank(MPI_COMM_WORLD, &rang);
    MPI_Comm_size(MPI_COMM_WORLD, &nbr_proc);

    float* nbrs_alea = NULL;
    nbrs_alea = creer_nbrs_alea(elements_par_proc);

    // Somme des nombres locaux
    float som_locale = 0.0;
    for (int i = 0; i < elements_par_proc; i++) {
        som_locale += nbrs_alea[i];
    }

    // Afficher les sommes locales dans chaque processeur
    printf("La somme locale pour le processeur %d est : %f\n", rang, som_locale);

    // Réduire (Reduce) toutes les sommes locales en somme globale
    MPI_Reduce(
        &som_locale, &som_globale,
        1, MPI_FLOAT, MPI_SUM,
        0, MPI_COMM_WORLD
    );

    // Afficher le résultat dans le processeur 0
    if (rang == 0) {
        float moy_globale = som_globale / (nbr_proc * elements_par_proc);
        printf("Somme totale = %f, Moyenne totale = %f\n", som_globale, moy_globale);
    }

    free(nbrs_alea); // Libérer la mémoire allouée
    MPI_Finalize();
    return 0;
}

// Implémentation de creer_nbrs_alea
float* creer_nbrs_alea(int elements_par_proc) {
    float* nbrs = malloc(sizeof(float) * elements_par_proc);
    if (nbrs == NULL) {
        fprintf(stderr, "Erreur d'allocation mémoire pour les nombres aléatoires\n");
        exit(1);
    }
    for (int i = 0; i < elements_par_proc; i++) {
        nbrs[i] = (float)rand() / RAND_MAX; // Génère un nombre entre 0 et 1
    }
    return nbrs;
}
