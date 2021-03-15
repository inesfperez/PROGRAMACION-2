struct nodo {
  void *elem; 
  struct nodo *sig;
};

typedef struct nodo *posicion;
typedef struct nodo *lista;
lista crearlista();
int eslistavacia(lista l);
void insertar(void *e, posicion p);
posicion buscar(lista l, void *e, int (*comp)(const void *x, const void *y)); 
void borrar(lista l, void *e, int (*comp)(const void *x, const void *y));
posicion primero(lista l);
posicion siguiente(posicion p);
int esfindelista(posicion p);
void *elemento(posicion p);
