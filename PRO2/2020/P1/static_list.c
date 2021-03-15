/*
* TITLE: PROGRAMMING II LABS
* SUBTITLE: Practical 1
* AUTHOR 1: Inés Faro Pérez LOGIN 1: ines.fperez@udc.es
* AUTHOR 2: Andrea Lama Muiño LOGIN 2: a.lama1@udc.es
* GROUP: 4.4
* DATE: 27/03/20
*/

#include "static_list.h"

void createEmptyList(tList *L){
    L->lastPos = LNULL;
}

bool isEmptyList(tList L){
    return L.lastPos == LNULL;
}

tPosL first(tList L){
    return 0;
}

tPosL last(tList L) {
    return L.lastPos;
}

tPosL previous(tPosL p, tList L) {
    return --p;
}

tPosL next(tPosL p, tList L) {
    if (p == last(L)) {
        return LNULL;
    } else {
        return ++p;
    }
}
bool insertItem(tItemL d, tPosL p, tList* L){
    tPosL i;

    if(L -> lastPos == MAX-1){
        return false;
    }
    else{
        L->lastPos++;
        if (p == LNULL){
            L->data[L->lastPos] = d;
        }
        else{
            for (i = L->lastPos; i >= p + 1; i--){
                L->data[i] = L->data[i - 1];
            }
            L->data[p] = d;
        }
        return true;
    }
}
void deleteAtPosition(tPosL p, tList *L){
    tPosL i;
    L->lastPos --;
    for(i=p; i<=L->lastPos; i++)
        L->data[i] = L->data[i+1];
}

tItemL getItem(tPosL p, tList L){
    return L.data[p];
}

void updateVotes(tNumVotes num, tPosL p, tList *L){
    L->data[p].numVotes = num;
}

tPosL findItem(tPartyName d, tList L) {
    tPosL p;

    if (isEmptyList(L)){
        return LNULL;
    }
    else {
        p = 0;
    }
    for (p; (p <= L.lastPos) && (strcmp(L.data[p].partyName,d)!=0); p++);

    if(p > L.lastPos){
        return LNULL;
    }
    else {
        return p;
    }
}