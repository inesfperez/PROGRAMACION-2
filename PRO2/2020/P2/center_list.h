/*
* TITLE: PROGRAMMING II LABS
* SUBTITLE: Practical 2
* AUTHOR 1: Inés Faro Pérez LOGIN 1: ines.fperez@udc.es
* AUTHOR 2: Andrea Lama Muiño LOGIN 2: a.lama1@udc.es
* GROUP: 4.4
* DATE: 8/05/20
*/


#ifndef CENTER_LIST_H
#define CENTER_LIST_H
#define NULLC -1
#define MAX 10

#include "types.h"
#include <stddef.h>
#include <stdbool.h>
#include <string.h>

#include "party_list.h"

typedef int tPosC; //Posicion de un centro de la lista
typedef struct {
    tCenterName centerName;
    tNumVotes totalVoters;
    tNumVotes validVotes;
    tNumVotes nullVotes;
    tList partyList;
}tItemC;
typedef struct {
    tItemC data[MAX];
    tPosC index;
}tListC;



void createEmptyListC (tListC *L);
/*
 * Objetivo:
    - Crear una lista vacía de centros
 * Entradas:
    - La lista
 * Salidas:
    - La lista vacía
 * Precondiciones:
    - La existencia de una lista
 * Postcondiciones:
    - La lista queda inicializada y no contiene elementos
 */
bool isEmptyListC (tListC L);
/*
 * Objetivo:
    - Determinar si la lista de centros está vacía
 * Entradas:
    - La lista de centros
 * Salidas:
    - True si la lista está vacía, false en caso contrario
 * Precondiciones:
    - No existe precondición
 * PostcondicioneS:
    - La lista se mantega como estaba inicialmente
 */
tPosC firstC (tListC L);
/*
 * Objetivo:
    - Obtener la primera posición de la lista de centros
 * Entradas:
    - La lista de centros
 * Salidas:
    - La posición del primer elemento de la lista de centros
 * Precondiciones
    - La lista no está vacía
 */
tPosC lastC (tListC L);
/*
 * Objetivo:
    - Obtener la posición del último elemento de la lista de centros
 * Entradas:
    - La lista de centros
 * Salidas:
    - La posición del último elemento de la lista de centros
 * Precondiciones
    - Lista no esté vacía
 * Postcondiciones:
    - La lista se mantenga como estaba inicialmente
 */
tPosC nextC (tPosC p, tListC L);
/*
 * Objetivo:
    -  Obtener la posición en la lista del elemento siguiente al de la posición indicada (o
        LNULL si la posición no tiene siguiente)
 * Entradas:
    - La lista de centros y una posición
 * Salidas:
    - La siguiente posición a la posición dada como entrada o LNULL si no hay siguiente.
 * Precondiciones
    - Lista previamente inicializada
    - La posición dada es una posición válida en la lista
 */
tPosC previousC (tPosC p, tListC L);
/*
 * Objetivo:
    -  Obtener la posición en la lista del elemento anterior al de la posición indicada (o
        LNULL si la posición no tiene anterior)
 * Entradas:
    - Una posición y la lista de centros
 * Salidas:
    - La posición anterior a la posición dada como entrada o LNULL si no tiene anterior
 * Precondiciones
    - Lista previamente inicializada
    - La posición dada es una posición válida en la lista
 */
bool insertItemC (tItemC d, tListC *L);
/*
 * Objetivo:
    - Insertar un elemento de forma ordenada en función del campo centername en la lista de centros.
 * Entradas:
    - El elemento a insertar y la lista de centros
 * Salidas:
    - True si la lista está vacía, false en caso contrario
 * Precondiciones
    - Lista previamente inicializada
 * Postcondiciones:
    - Las posiciones de los elementos de la lista posteriores al insertado
    pueden cambiar de valor.
 */
void updateListC (tList A, tPosC p, tListC *L);
/*
 * Objetivo:
    - Modifica la lista de partidos del elemento situado en la posición indicada.
 * Entradas:
    - La lista de partidos, la posición de la lista de los partidos y la lista de centros
 * Salidas:
    - La lista con los partidos modificados
 * Precondiciones
    - Lista previamente inicializada
    - La posición indicada es una posición válida en la lista.
 */

void deleteAtPositionC (tPosC p, tListC *L);
/*
 * Objetivo:
    -  Eliminar de la lista una posición
 * Entradas:
    - La posición a eliminar y la lista de centros
 * Salidas:
    - La lista sin el elemento de esa posicion
 * Precondiciones
    - Lista previamente inicializada
    - La posición indicada es una posición válida en la lista
 * Postcondiciones:
    - Tanto la posición del elemento eliminado como aquellas de los elementos de la lista
    a continuación del mismo pueden cambiar de valor
 */
tItemC getItemC (tPosC p, tListC L);
/*
 * Objetivo:
    - Obtener el contenido del elemento de la lista que ocupa la posición indicada
 * Entradas:
    - La posición del elemento y la lista de centros
 * Salidas:
    - El elemento de la posición dada
 * Precondiciones
    - Lista previamente inicializada
    - La posición indicada es una posición válida en la lista
 */
void updateValidVotesC (tNumVotes num, tPosC p, tListC *L);
/*
 * Objetivo:
    - Modifica el número de votos válidos del elemento situado en la posición indicada.
 * Entradas:
    - Numero de votos, posición de la lista a la que añadir votos y la lista.
 * Salidas:
    - La lista con el numero de votos válidos actualizado
 * Precondiciones
    - Lista previamente inicializada
    - La posición indicada es una posición válida en la lista.
 * Postcondiciones:
    - El orden de los elementos de la lista no se ven modificados
 */
void updateNullVotesC (tNumVotes num, tPosC p, tListC *L);
/*
 * Objetivo:
    - Modifica el número de votos nulos del elemento situado en la posición indicada.
 * Entradas:
    - Numero de votos, posición a la que añadir votos y la lista
 * Precondiciones
    - Lista previamente inicializada
    - La posición indicada es una posición válida en la lista.
 * Postcondiciones:
    - El orden de los elementos de la lista no se ven modificados
 */

tPosC findItemC (tCenterName d, tListC L);
/*
 * Objetivo:
    -   Obtener la posición del primer elemento de la lista cuyo nombre de centro se
 corresponda con el indicado (o NULLC si no existe tal elemento).
 * Entradas:
    - El centro buscado y la lista de centros
 * Salidas:
    - La posición del elemento buscado o LNULL si no se encuentra dicho elemento
 * Precondiciones
    - Lista previamente inicializada
 */

#endif
