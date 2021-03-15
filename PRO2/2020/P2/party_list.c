/*
 * TITLE: PROGRAMMING II LABS
 * SUBTITLE: Practical 2
 * AUTHOR 1: Inés Faro Pérez LOGIN 1: ines.fperez@udc.es
 * AUTHOR 2: Andrea Lama Muiño LOGIN 2: a.lama1@udc.es
 * GROUP: 4.4
 * DATE: 08 / 04 / 20
 */


#include "party_list.h"

bool createNode(tPosL *p){
    *p = malloc(sizeof(struct tNode));
    return *p != LNULL;
}

void createEmptyList(tList *L){
    *L = LNULL;
}

bool isEmptyList(tList L){
    return L == LNULL;
}

tPosL first(tList L){
    return L;
}

tPosL last(tList L){
    tPosL p;
    p = L;
    while(p -> next != LNULL){
        p = p -> next;
    }
    return p;
}

tPosL next(tPosL p, tList L){
    return p -> next;
}

tPosL previous(tPosL p, tList L){
     tPosL q;
     if(p == L){
         q = LNULL;
     }
     else {
         q = L;
         while(q -> next != p){
             q = q -> next;
         }
     }
     return q;
}

 tPosL findItem(tPartyName d, tList L){
    tPosL p;
    if(isEmptyList(L)) {
        return LNULL;
    } else {
       if (strcmp(d,first(L)->data.partyName)<0) {
            return LNULL;
        } else {
            for (p = L; (p != LNULL) && (strcmp(p->data.partyName, d) < 0); p = p -> next);
            if ((p != LNULL) && (strcmp(p->data.partyName, d) == 0)) {
                return p;
            } else {
                return LNULL;
            }
        }
    }
}

tPosL findPosition(tList L, tPartyName d){
    tPosL p;
    p = L;
    while((p -> next != LNULL) && (strcmp(p ->next-> data.partyName,d)<0))
        p = p->next;

    return p;
}

bool insertItem(tItemL d, tList *L) {

    tPosL q, p;

    if (!createNode(&q)) {
        return false;
    } else {
        q->data = d;
        q->next = LNULL;
        if (*L == LNULL) {
            *L = q;
        } else if (strcmp(d.partyName,(*L)->data.partyName)<0) {
            q->next = *L;
            *L = q;
        } else {
            p = findPosition(*L, d.partyName);
            q->next = p->next;
            p->next = q;
        }
        return true;
    }
}


tItemL getItem(tPosL p, tList L){
    return p -> data;
}

void updateVotes(tNumVotes numVotes, tPosL p, tList L){
    p -> data.numVotes = numVotes;
}

