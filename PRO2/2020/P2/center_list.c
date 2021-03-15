/*
* TITLE: PROGRAMMING II LABS
* SUBTITLE: Practical 2
* AUTHOR 1: Inés Faro Pérez LOGIN 1: ines.fperez@udc.es
* AUTHOR 2: Andrea Lama Muiño LOGIN 2: a.lama1@udc.es
* GROUP: 4.4
* DATE: 8/05/20
*/

#include "types.h"
#include "party_list.h"
#include "center_list.h"

void createEmptyListC (tListC *L){
    L->index = NULLC;
}

bool isEmptyListC (tListC L){
    return L.index == NULLC;
}

tPosC firstC (tListC L){
    return 0;
}

tPosC lastC (tListC L){
    return L.index;
}

tPosC nextC (tPosC p, tListC L){
    if (p == lastC(L)) {
        return NULLC;
    } else {
        return ++p;
    }
}

tPosC previousC (tPosC p, tListC L){
    return --p;
}
bool insertItemC(tItemC d, tListC *C){
    tPosC i;

    if (C -> index == MAX-1){ //comprobamos si el array está lleno
        return false;
    } else{
        if (isEmptyListC(*C) || strcmp(d.centerName,(*C).data[C->index].centerName)> 0) {
            C->index++;
            C->data[C->index] = d;
        }else{
            C -> index++;
            for(i=C->index; (i>0) && strcmp(d.centerName,C->data[i-1].centerName)<0;i--)
                C -> data[i] = C -> data[i-1];
            C -> data[i] = d;
        }
        return true;
    }
}
void updateListC (tList A, tPosC p, tListC *L){
    L->data[p].partyList = A; //Reescribimos la lista de partidos
}

void deleteAtPositionC (tPosC p, tListC *L){
    tPosC i;
    L->index --;
    for(i=p; i<=L->index; i++)
        L->data[i] = L->data[i+1];

}

tItemC getItemC (tPosC p, tListC L){
    return L.data[p];
}

void updateValidVotesC (tNumVotes num, tPosC p, tListC *L){
    L->data[p].validVotes = num;
}

void updateNullVotesC (tNumVotes num, tPosC p, tListC *L){
    L->data[p].nullVotes = num;
}

tPosC findItemC(tCenterName d, tListC L){
    tPosC p;

    if(L.index == NULLC)
        return NULLC;
    else if ((strcmp(d, L.data[0].centerName)<0)||(strcmp(d, L.data[L.index].centerName)>0))
        return NULLC;
    else{
        for(p = 0; (p<L.index)&& strcmp(L.data[p].centerName,d)<0;p++);
        if(strcmp(L.data[p].centerName,d)==0)
            return p;
        else
            return NULLC;
    }
}
