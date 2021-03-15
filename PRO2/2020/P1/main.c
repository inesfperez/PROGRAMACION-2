/*
* TITLE: PROGRAMMING II LABS
* SUBTITLE: Practical 1
* AUTHOR 1: Inés Faro Pérez LOGIN 1: ines.fperez@udc.es
* AUTHOR 2: Andrea Lama Muiño LOGIN 2: a.lama1@udc.es
* GROUP: 4.4
* DATE: 27/03/20
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <inttypes.h>

#include "types.h"

#define CODE_LENGTH 2

#ifdef STATIC_LIST
#include "static_list.h"
#endif
#ifdef DYNAMIC_LIST
#include "dynamic_list.h"
#endif
#ifdef TEST_LIST
#include "list/list.h"
#endif


void new (tPartyName party, tList *L) {

    tItemL itemL;

    if (findItem(party,*L) == LNULL) { //Si el nombre del partido no está en la lista continúa, si no devuelve error.

        strcpy(itemL.partyName, party); //Asignar el nombre del partido.
        itemL.numVotes = 0; //Inicializamos los votos del partido a 0.

        if (insertItem(itemL, LNULL, L) == true) { //Comprueba que la inserción fue correcta, si no devuelve error.
            printf("* New: party %s ", party);

        } else {
            printf("+ Error: New not possible");
        }
    } else {
        printf("+ Error: New not possible");
    }
}

void vote(tPartyName party, tList *L, int *validVotes, int *votoNulo){
    tPosL p;

    p = findItem(party,*L); //Nos devuelve la posición del partido en la Lista.
    if(p == LNULL){
        printf("+ Error: Vote not possible. Party %s not found. NULLVOTE",party);
        *votoNulo = *votoNulo+1;
    }
    else {
        updateVotes(getItem(p,*L).numVotes+1,p,L);
        printf("* Vote: party %s numvotes %d ",party, getItem(p,*L).numVotes);
        *validVotes = *validVotes +1;
    }

}

void stats(tPartyName party, tList L, int validVotes, int votoNulo){
    tPosL p;
    tItemL itemL;

    int totalVoters=atoi(party);
    if(!(isEmptyList(L))) {
        p = first(L); //Inicializamos con la primera posición.


        while (p != LNULL) { //Recorremos la lista hasta el final.
            itemL = getItem(p, L); //Vamos cogiendo los partidos
            party = itemL.partyName;

            if ((validVotes) == 0) {
                printf("Party %s numvotes %d (0.00%%)\n", party, itemL.numVotes);
            } else {
                printf("Party %s numvotes %d (%2.2f%%) \n", party, itemL.numVotes,
                       (float) itemL.numVotes * 100 / (float)(validVotes ));
            }
            p = next(p, L);
        }
    }
    printf("Null votes %d", votoNulo);

    if (totalVoters == 0){
        printf("\nParticipation: %d votes from %d voters (0.00%%)", (validVotes+votoNulo), totalVoters);
    } else {
        printf("\nParticipation: %d votes from %d voters (%2.2f%%)", (validVotes+votoNulo), totalVoters,(float)((validVotes+votoNulo)*100)/(float)totalVoters);
    }
}

void illegalize(tPartyName party, int *validVotes, int *votoNulo, tList *L) {
    tPosL p;
    p = findItem(party,*L);

    //Buscamos el partido en la lista
    if (findItem(party,*L) == LNULL) {
        printf("+ Error: Illegalize not possible");
    } else { //está en la lista
        *votoNulo = *validVotes; //actualizamos sus votos a nulos
        *validVotes = *validVotes - *votoNulo;
        deleteAtPosition(p, L); //lo borramos
        printf("* Illegalize: party %s", party);
    }
}

void processCommand(char command_number[CODE_LENGTH+1], char command, char param[NAME_LENGTH_LIMIT+1], tList *L, int *validVotes, int *votoNulo) {

    printf("\n********************\n");

    switch(command) {
        case 'N': {
            printf("%s %c: party %s\n", command_number, command, param);
            new(param, L);
            break;
        }
        case 'V': {
            printf("%s %c: party %s \n", command_number, command, param);
            vote(param, L, validVotes, votoNulo);
            break;

        }
        case 'S': {
            printf("%s %c: totalvoters %s \n", command_number, command, param);
            stats(param,*L,*validVotes, *votoNulo);
            break;
        }
        case 'I': {
            printf("%s %c: party %s \n", command_number, command, param);
            illegalize(param,validVotes, votoNulo, L);
            break;
        }
        default: {
            break;
        }
    }
}

void readTasks(char *filename) {
    int validVotes = 0;
    int votoNulo = 0;
    tList L;
    createEmptyList(&L);

    FILE *df;
    char command_number[CODE_LENGTH+1], command, param[NAME_LENGTH_LIMIT+1];

    df = fopen(filename, "r");
    if (df != NULL) {
        while (!feof(df)) {
            char format[16];
            sprintf(format, "%%%is %%c %%%is", CODE_LENGTH, NAME_LENGTH_LIMIT);
            fscanf(df,format, command_number, &command, param);
            processCommand(command_number, command, param,&L, &validVotes, &votoNulo);
        }
        fclose(df);

    } else {
        printf("Cannot open file %s.\n", filename);
    }
}

int main(int nargs, char **args) {

    char *file_name = "new.txt";

    if (nargs > 1) {
        file_name = args[1];
    } else {
#ifdef INPUT_FILE
        file_name = INPUT_FILE;
#endif
    }

    readTasks(file_name);

    return 0;
}


