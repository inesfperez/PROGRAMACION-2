/*
* TITLE: PROGRAMMING II LABS
* SUBTITLE: Practical 1
* AUTHOR 1: Inés Faro Pérez LOGIN 1: ines.fperez@udc.es
* AUTHOR 2: Andrea Lama Muiño LOGIN 2: a.lama1@udc.es
* GROUP: 4.4
* DATE: 27/03/20
*/

#include "types.h"
#include <stddef.h>
#include <stdbool.h>
#include <string.h>

#define LNULL NULL

#ifndef DYNAMIC_LIST_H
#define DYNAMIC_LIST_H

typedef struct tItemL;
typedef struct tNode*  tPosL;
typedef tPosL tList;
struct tNode {
    tItemL data;
    tPosL next;
}tNode;

void createEmptyList(tList *L);
/*
 * Objetivo:
    - Crear una lista vacía
 * Entradas:
    - La lista a crear
 * Salidas:
    - La lista vacía
 * Postcondiciones:
    - La lista queda inicializada y no contiene elementos
 */
bool isEmptyList(tList L);
/*
 * Objetivo:
    - Determinar si la lista está vacía
 * Entradas:
    - La lista
 * Salidas:
    - True si la lista está vacía, false en caso contrario
 */
tPosL first(tList L);
/*
 * Objetivo:
    - Devuelve la primera posición de la lista
 * Entradas:
    - La lista
 * Salidas:
    - La posición del primer elemento de la lista
 * Precondiciones
    - La lista no está vacía
 */
tPosL next(tPosL p, tList L);
/*
 * Objetivo:
    -  Devuelve la posición en la lista del elemento siguiente al de la posición indicada (o
        LNULL si la posición no tiene siguiente)
 * Entradas:
    - Una posición y la lista
 * Salidas:
    - La siguiente posición a la posición dada como entrada.
 * Precondiciones
    - Lista previamente inicializada
    - La posición dada es una posición válida en la lista
 */
tPosL last(tList L);
/*
 * Objetivo:
    - Devolver la posición del último elemento de la lista
 * Entradas:
    - La lista
 * Salidas:
    - La posición del último elemento de la lista
 * Precondiciones
    - Lista previamente inicializada
 */
tPosL previous(tPosL p, tList L);
/*
 * Objetivo:
    -  Devuelve la posición en la lista del elemento anterior al de la posición indicada (o
        LNULL si la posición no tiene anterior)
 * Entradas:
    - Una posición y la lista
 * Salidas:
    - La posición anterior a la posición dada como entrada.
 * Precondiciones
    - Lista previamente inicializada
    - La posición dada es una posición válida en la lista
 */
bool createNode(tPosL *p);
bool insertItem(tItemL d, tPosL p, tList *L);
/*
 * Objetivo:
    - Inserta un elemento en la lista antes de la posición indicada. Si la posición es LNULL,
    entonces se añade al final. Devuelve un valor true si el elemento fue insertado;
    false en caso contrario
 * Entradas:
    - El elemento a insertar, una posición y la lista
 * Salidas:
    - True si la lista está vacía, false en caso contrario
 * Precondiciones
    - Lista previamente inicializada
    - La posición indicada es una posición válida en la lista o bien nula (LNULL)
 * Postcondiciones:
    - Las posiciones de los elementos de la lista posteriores al insertado
    pueden cambiar de valor
 */
void deleteAtPosition(tPosL p, tList* L);
/*
 * Objetivo:
    -  Elimina de la lista el elemento que ocupa la posición indicada
 * Entradas:
    - La posición a eliminar y la lista
 * Precondiciones
    - Lista previamente inicializada
    - La posición indicada es una posición válida en la lista
 * Postcondiciones:
    - Tanto la posición del elemento eliminado como aquellas de los elementos de la lista
    a continuación del mismo pueden cambiar de valor
 */
tItemL getItem(tPosL p, tList L);
/*
 * Objetivo:
    - Devuelve el contenido del elemento de la lista que ocupa la posición indicada
 * Entradas:
    - La posición del elemento y la lista
 * Salidas:
    - El elemento de la posición dada
 * Precondiciones
    - Lista previamente inicializada
    - La posición indicada es una posición válida en la lista
 */
void updateVotes(tNumVotes numVotes, tPosL p, tList *L);
/*
 * Objetivo:
    - Modifica el número de votos del elemento situado en la posición indicada
 * Entradas:
    - Numero de votos, posición a la que añadir votos y la lista
 * Precondiciones
    - Lista previamente inicializada
    - La posición indicada es una posición válida en la lista
 * Postcondiciones:
    - El orden de los elementos de la lista no se ven modificados
 */
tPosL findItem(tPartyName d, tList L);
/*
 * Objetivo:
    - Devuelve la posición del elemento de la lista cuyo nombre de partido se corresponde con el indicado
    (o LNULL si no existe tal elemento)
 * Entradas:
    - El partido buscado y la lista
 * Salidas:
    - La posición del partido buscado
 * Precondiciones
    - Lista previamente inicializada
 */

#endif


