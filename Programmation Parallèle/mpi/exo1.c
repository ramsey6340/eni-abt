#include <stdio.h>
#include <mpi.h>

int main (int argc, char * argv[]) {
    printf("Hello, world!\n");
    return 0;
}

int main (int argc, char * argv[]) {
    double debut_temps, fin_temps;
    int nom_long, nbr_proc, rang ;
    char nom_proc [MPI_MAX_PROCESSOR_NAME] ;
    MPI_Init (& argc, & argv) ;
    debut_temps = MPI_Wtime();
    MPI_Comm_rank (MPI_COMM_WORLD, &rang);
    MPI_Comm_size (MPI_COMM_WORLD, &nbr_proc);
    MPI_Get_processor_name (nom_proc, &nom_long);
    printf("processeur numero %d sur la machine %s parmi %d processeurs \n", rang, nom_proc, nbr_proc);

    if (nbr_proc != 4) fprintf (stderr, "il faut avoir 4 processeurs \n");
    fin_temps = MPI_Wtime() ;
    printf ("temps ecoule sur %d = %f \n", nbr_proc, (fin_temps-debut_temps));
    MPI_Finalize () ;
    return 0;
}
