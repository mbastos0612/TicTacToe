class Tree {

  Node root;
   ArrayList<Node> cuerpoDelArbol;
  int cantNodos=0;
  int indiceNodosExpandidos=0;
  
  Tree(){
     root = new Node();
   cuerpoDelArbol = new ArrayList<Node>();
  
  }

  public void addNode(int key, int parentKey, int[][] estadoActual) {

    // Create a new Node and initialize it

    Node newNode = new Node(key, parentKey, estadoActual);

    // If there is no root this becomes root

    if (root == null) {

      root = newNode;
    

    } else {

      // Set root as the Node we will start
      // with as we traverse the tree

      Node parentNode = findNode(parentKey);
      parentNode.agregarHijo(newNode);
      

    }
    cantNodos++;
      cuerpoDelArbol.add(newNode);

  }

public Node getNextNode(){
  if(indiceNodosExpandidos<cuerpoDelArbol.size()){
      return cuerpoDelArbol.get(indiceNodosExpandidos++);
  }
  else{
    return null;
  }
}

public Node findNode(int toFindkey){
  boolean encontrado=false;
  Node nodoActual= new Node();
  for(int i=0;i<cuerpoDelArbol.size()&&!encontrado;i++){
   nodoActual=cuerpoDelArbol.get(i);
   int key=nodoActual.getKey();
     if(toFindkey==key){
       encontrado=true;
     }
  }
  return nodoActual;
}


public Node findNode(int[][] estado){
  boolean encontrado=false;
  Node nodoActual= new Node();
  for(int i=0;i<cuerpoDelArbol.size()&&!encontrado;i++){
   nodoActual=cuerpoDelArbol.get(i);
   int [][] estadoNodo=nodoActual.getEstado();
   if(estadosIguales(estado,estadoNodo)){
     encontrado=true;
   }
    
  }
  return nodoActual;
}


boolean estadosIguales(int[][] estadoSource, int[][] estadoTarget){
    boolean estadosIguales=true;
     for(int i=0; i<3&&estadosIguales;i++){
        for(int c=0; c<3&&estadosIguales; c++){
           if(estadoSource[i][c]!=estadoTarget[i][c]){
             estadosIguales=false;
           }
        }
     }
  return estadosIguales;
}



void toScreen(){
  System.out.println();
  Node nodo= new Node();
   for(int i=0;i<cuerpoDelArbol.size();i++){
     nodo=cuerpoDelArbol.get(i);
      System.out.println("Daddy");
      matrizToScreen(3, nodo.getEstado());
       System.out.println("Hijos");
      for(int c=0; c<nodo.nodosHijos.size();c++){
        Node nodoTemp= nodo.nodosHijos.get(c);
        matrizToScreen(3,nodoTemp.getEstado());
         System.out.println("-------------");
        
      }
   }
  
}

void matrizToScreen(int dim, int[][] estado){
  System.out.println();
     for(int i=0; i<dim;i++){
        for(int c=0; c<dim; c++){
             System.out.print(estado[i][c]+" ");
           
           }
           System.out.println();
        }
}

 
}