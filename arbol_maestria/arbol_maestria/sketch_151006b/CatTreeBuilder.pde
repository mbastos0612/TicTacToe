class CatTreeBuilder { 
  
  Tree arbolJugadas;
  int[][] estadoActual;
  int globalNodeKey;
  
  
    void prueba(){
     
       System.out.println("Builder"); //<>//
       
  }
  
  CatTreeBuilder(){
      arbolJugadas = new Tree();
      estadoActual=null;
       globalNodeKey=0;
       System.out.println("Builder");
       
  }
  
  void crearArbol(){ //<>//
      estadoActual= new int[3][3];
      boolean masjugadas=true;
       ArrayList<int[][]> listaDeProximasJugadas;
       for(int i=0; i<3;i++){
        for(int c=0; c<3; c++){
          estadoActual[i][c]=-1;
        }
       }
       arbolJugadas.addNode(globalNodeKey++,-1,estadoActual);
       Node nodoAExpandir=arbolJugadas.getNextNode();
       
       while(nodoAExpandir!=null){
         
         estadoActual=nodoAExpandir.getEstado();
         listaDeProximasJugadas= calcualdorDeProxJugadas(estadoActual,1);
         Node nodo= arbolJugadas.findNode(estadoActual);
          agregarJugadasAlArbol(listaDeProximasJugadas,nodo.getKey());
          
          listaDeProximasJugadas= calcualdorDeProxJugadas(estadoActual,0);
          nodo= arbolJugadas.findNode(estadoActual);
          agregarJugadasAlArbol(listaDeProximasJugadas,nodo.getKey());
          nodoAExpandir=arbolJugadas.getNextNode();
       }
       
       arbolJugadas.toScreen();
      
      
    
  }
  
  
   ArrayList<int[][]> calcualdorDeProxJugadas(int [][] estado, int jugador){ //Calcula las proximas jugadas para un estado dado que el siguiente jugador es 1=x o 0=O
      ArrayList<int[][]> listaDeProximasJugadas=new ArrayList<int[][]>();
      int[][] estadoTemp= new int[3][3];
    for(int i=0; i<3;i++){
      for(int c=0; c<3; c++){
        if(estado[i][c]==-1){
          estadoTemp=estado;
          estadoTemp[i][c]=jugador;
          listaDeProximasJugadas.add(estadoTemp);
        }
      }
    }
    return listaDeProximasJugadas;
  }
 
    
  
   void agregarJugadasAlArbol( ArrayList<int[][]> listaDeProximasJugadas, int parentKey){
     int[][] estadoNuevo;
     for(int i=0;i<listaDeProximasJugadas.size();i++){
       estadoNuevo= listaDeProximasJugadas.get(i);
       Node nodo=arbolJugadas.findNode(estadoNuevo);
       if(!(nodo!=null)){
         arbolJugadas.addNode(globalNodeKey++,parentKey,estadoNuevo);
       }
     }
 }   
 
} 