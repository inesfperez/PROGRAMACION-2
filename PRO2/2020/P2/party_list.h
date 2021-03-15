/*
 * TITLE: PROGRAMMING II LABS
 * SUBTITLE: Practical 2
 * AUTHOR 1: Inés Faro Pérez LOGIN 1: ines.fperez@udc.es
 * AUTHOR 2: Andrea Lama Muiño LOGIN 2: a.lama1@udc.es
 * GROUP: 4.4
 * DATE: 08 / 04 / 20
 */



#ifndef PARTY_LIST_H
#define PARTY_LIST_H

#define LNULL NULL

#include <stdbool.h>
#include <stdlib.h>
#include <string.h>

#include "types.h"
typedef struct tNode* tPosL;
struct tNode {
    tItemL data;
    tPosL next;
}tNode;
typedef tPosL tList;

bool createNode(tPosL *p);
/*
 * Objetivo:
    - Crear un nodo
 * Entradas:
    - puntero al nodo
 * Salidas:
    - true si fue creado correctamente, false en caso contrario
 */

void createEmptyList(tList *L);
/*
 * Objetivo:
    - Crear una lista vacía
 * Entradas:
    - Una lista
 * Salidas:
    - LUna lista vacía
 * Precondiciones:
    - La existencia de una lista
 * Postcondiciones:
    - La lista quede inicializada y no contenga ningún elemento
 */

bool isEmptyList(tList L);
/*
 * Objetivo:
    - Comprobar si la lista está vacía
 * Entradas:
    - La lista
 * Salidas:
    - True si está vacía, false en caso contrario
 * Postcondiciones:
    - La lista se mantenga como estaba inicialmente
 */

tPosL first(tList L);
/*
 * Objetivo:
    - Obtener la posición del primer elemento de la lista
 * Entradas:
    - La lista
 * Salidas:
    - La posición del primer elemento
 * Precondiciones:
    - Que la lista no esté vacía
 * Postcondiciones:
    - La lista se mantenga como estaba inicialmente
 */

tPosL last(tList L);
/*
 * Objetivo:
    - Obtener la posición del último
 * Entradas:
    - La lista
 * Salidas:
    - La posición del último elemento
 * Precondiciones:
    - La lista no esté vacía
 * Postcondiciones:
    - La lista se mantenga como estaba inicialmente
 */

tPosL next(tPosL p, tList L);
/*
 * Objetivo:
    - Obtener la posición siguiente
 * Entradas:
    - La lista y una posición
 * Salidas:
    - El elemento siguiente a la posición dada o LNULL si no hay siguiente
 * Precondiciones:
    - La posición indicada sea válida
    - La lista no esté vacía
 * Postcondiciones:
    - La lista se mantenga como estaba inicialmente
 */

tPosL previous(tPosL p, tList L);
/*
 * Objetivo:
    - Obtener la posición anterior
 * Entradas:
    - Una posición y la lista
 * Salidas:
    - El elemento anterior a la posición indicada o LNULL si la posición no tiene anterior
 * Precondiciones:
    - La lista no esté vacía
    - La posición indicada sea válida
 * Postcondiciones:
    - La lista se mantenga como estaba inicialmente
 */

bool insertItem(tItemL d, tList *L);
/*
 * Objetivo:
    - Insertar un elemento en la lista
 * Entradas:
    - El elemento a insertar y la lista
 * Salidas:
    - True si se realizó correctamente, false en caso contrario
 * Precondiciones:
    - La lista no esté vacía
 * Postcondiciones:
    - Las posiciones de los elementos de la lista posteriores al insertado
    pueden cambiar de valor.
 */

tItemL getItem(tPosL p, tList L);
/*
 * Objetivo:
    - Obtener el elemento situado en la posición dada
 * Entradas:
    - La posición y una lista
 * Salidas:
    - El elemento deseado.
 * Precondiciones
    - La lista no esté vacía.
    - La posición dada sea una posición válida
 */

void updateVotes(tNumVotes numVotes, tPosL p, tList L);
/*
 * Objetivo:
    - Actualizar el numero de votos
 * Entradas:
    - Número de votos, la posición y la lista
 * Salidas:
    - La lista con el numero de votos modificado
 * Precondiciones:
    - La lista no esté vacía
    - La posición indicada sea una posición válida
 */

tPosL findItem(tPartyName d, tList L);
/*
 * Objetivo:
    - La posición del elemento buscado
 * Entradas:
    - Nombre del partido y la lista
 * Salidas:
    - Posición del elemento de la lista donde esté el partido o LNULL si no se encuentra dicho elemento
 * Precondiciones:
    - La lista no esté vacía
 * Postcondiciones:

 */


#endif
