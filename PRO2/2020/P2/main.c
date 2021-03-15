/*
* TITLE: PROGRAMMING II LABS
* SUBTITLE: Practical 2
* AUTHOR 1: Inés Faro Pérez LOGIN 1: ines.fperez@udc.es
* AUTHOR 2: Andrea Lama Muiño LOGIN 2: a.lama1@udc.es
* GROUP: 4.4
* DATE: 8/05/20
*/


#include <stdio.h>
#include "types.h"
#include "center_list.h"
#include "party_list.h"

#define CODE_LENGTH 2


void CreateCenter (tCenterName centerName, tNumVotes totalvoters, tListC *C){

    tItemC itemC;

    if (findItemC(centerName,*C) == NULLC){ //Si el nombre del centro no está en la lista lo insertamos

        itemC.totalVoters = totalvoters;
        itemC.nullVotes = 0;
        itemC.validVotes = 0;
        createEmptyList(&itemC.partyList);

        strcpy(itemC.centerName, centerName); //Asignamos el nombre del centro

        if (insertItemC(itemC, C) == true){
            printf("* Create: center %s totalvoters %d", centerName, totalvoters);

        } else {
            printf("+ Error: Create not possible");
        }

    } else {
        printf("+ Error: Create not possible");
    }
}


void new (tCenterName centerName, tPartyName party, tListC *C) {
    tItemL itemL;
    tPosC c;
    tPosL p;
    tList L;

    c = findItemC(centerName, *C);

    if (c != NULLC) {
        L = getItemC(c,*C).partyList;
        p = findItem(party,L);

        if (p == LNULL) { //Si el nombre del partido no está en la lista continúa, si no devuelve error.
            strcpy(itemL.partyName, party); //Asignar el nombre del partido.
            itemL.numVotes = 0; //Inicializamos los votos del partido a 0.

            if (insertItem(itemL, &L) == true) { //Comprueba que la inserción fue correcta, si no devuelve error.
                updateListC(L,c,C);
                printf("* New: center %s party %s", centerName, party);
            } else {
                printf("+ Error: New not possible");
            }
        } else {
            printf("+ Error: New not possible");
        }
    } else{
            printf("+ Error: New not possible");
    }

}
void stats(tCenterName centerName, tPartyName party, tListC *C){
    tPosC c=0;
    tPosL p;
    tItemL itemL;
    tList L;
    tItemC itemC;

      for(c = firstC(*C); c<= C->index;c++){ //Inicializamos la primera posición de la lista de centros
          itemC = getItemC(c, *C);
          centerName = itemC.centerName;
          printf("\nCenter %s\n", centerName);

          L = getItemC(c, *C).partyList;
          p = first(L); //Inicializamos la primera posición de la lista de partidos.

                while (p != LNULL) { //Recorremos la lista hasta el final.
                    itemL = getItem(p, L); //Vamos cogiendo los partidos.
                    party = itemL.partyName;
                        if ((itemC.validVotes) == 0) {
                            printf("Party %s numvotes %d (0.00%%)\n", party, itemL.numVotes);
                        } else {
                            printf("Party %s numvotes %d (%2.2f%%) \n", party, itemL.numVotes,
                               (float) itemL.numVotes * 100 / (float) (itemC.validVotes));
                        }
                        p = next(p, L);
                }
                printf("Null votes %d", itemC.nullVotes);
                if (itemC.totalVoters == 0) {
                    printf("\nParticipation: %d votes from %d voters (0.00%%)", (itemC.validVotes + itemC.nullVotes),
                            itemC.totalVoters);
                } else {
                    printf("\nParticipation: %d votes from %d voters (%2.2f%%)", (itemC.validVotes + itemC.nullVotes),
                       itemC.totalVoters,
                       (float) ((itemC.validVotes + itemC.nullVotes) * 100) / (float) itemC.totalVoters);
                }
      }
}

void vote(tCenterName centerName, tPartyName party, tListC *C){
    tPosL p;
    tPosC c;
    tItemC itemC;

    c = findItemC(centerName, *C); //posición del centro en la lista.

   if (c != NULLC) {

       p = findItem(party,getItemC(c,*C).partyList); //posición del partido en la lista.

       if (p == LNULL) {

           printf("+ Error: Vote not possible. Party %s not found in center %s. NULLVOTE", party, centerName);
           updateNullVotesC(getItemC(c,*C).nullVotes+ 1, c, C);

       } else {
           updateVotes(getItem(p, itemC.partyList).numVotes + 1, p, itemC.partyList);
           updateValidVotesC(getItemC(c,*C).validVotes+1, c, C);
            printf("* Vote: center %s party %s numvotes %d", centerName, party, getItem(p, itemC.partyList).numVotes);
       }
   } else {
       printf("+ Error: Vote not possible");
   }
}

void Remove(tCenterName center, tListC *C) {
tItemC itemC;
tPosC c;

    for(c = firstC(*C); c <= C->index;c++){  //Recorremos la lista de centros
        itemC = getItemC(c, *C);
        center = itemC.centerName;
        if(itemC.validVotes == 0){ //Si los votos válidos son cero, eliminará el centro y lo notificará
            printf("* Remove: center %s", center);
            deleteAtPositionC(c, C);
        }
    }
    if(itemC.validVotes != 0){ //Si no hay ningún centro con los votos válidos a 0 entonces no eliminará ninguno.
        printf("* Remove: no centers removed");
    }
}

void processCommand(char commandNumber[CODE_LENGTH+1], char command, char param1[NAME_LENGTH_LIMIT+1], char param2[NAME_LENGTH_LIMIT+1], tListC *C) {

    printf("\n********************\n");

    switch(command) {
        case 'C': {
            printf("%s %c: center %s totalvoters %s\n", commandNumber, command, param1, param2);
            CreateCenter(param1,atoi(param2),C);
            break;
        }
        case 'N':{
            printf("%s %c: center %s party %s\n", commandNumber, command, param1, param2);
            new(param1,param2,C);
            break;
        }
        case 'V': {
            printf("%s %c: center %s party %s\n", commandNumber, command, param1, param2);
            vote(param1, param2,C);
            break;
        }
        case 'R':{
            printf("%s %c \n", commandNumber, command);
            Remove(param1,C);
            break;
        }
        case 'S':{
            printf("%s %c\n", commandNumber, command);
            stats(param1, param2, C);
            break;
        }
        default: {
            break;
        }
    }
}

void readTasks(char *filename) {
    FILE *df;
    tListC C;

    createEmptyListC(&C);

    char commandNumber[CODE_LENGTH+1], command, param1[NAME_LENGTH_LIMIT+1], param2[NAME_LENGTH_LIMIT+1];

    df = fopen(filename, "r");
    if (df != NULL) {
        while (!feof(df)) {
            char format[16];
            sprintf(format, "%%%is %%c ", CODE_LENGTH);
            fscanf(df, format, commandNumber, &command);
            if (command == 'S' || command == 'R') {
                param1[0] = '\0';
                param2[0] = '\0';
            } else {
                sprintf(format, "%%%is %%%is", NAME_LENGTH_LIMIT, NAME_LENGTH_LIMIT);
                fscanf(df, format, param1, param2);
            }
            processCommand(commandNumber, command, param1, param2, &C);
        }
        fclose(df);
    } else {
        printf("Cannot open file %s.\n", filename);
    }
}

int main(int nargs, char **args) {

    char *filename = "new.txt";

    if (nargs > 1) {
        filename = args[1];
    } else {
        #ifdef INPUT_FILE
        filename = INPUT_FILE;
        #endif
    }

    readTasks(filename);

    return 0;
}