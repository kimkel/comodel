class Territori {
    static SugarSpace sp;

    int files;
    int cols;
    Hectarea[][] territori;
    int emisferi_nord;//Estació de l'emisferi nord
    int emisferi_sud;
    color color_emisferi_nord;
    color color_emisferi_sud;
    color color_sense_emisferi;
 

    public Territori(int _files, int _cols, int escala) {
        files = _files;
        cols = _cols;
        emisferi_nord = Regla.ESTIU;
        emisferi_sud = Regla.HIVERN;
        territori = new Hectarea[files][cols];
       /* for(int i = 0; i<files;i++){
            for(int c = cols; c<cols;c++){
                territori[i][c] = null;
            }
        }
        */
         for(int i = 0; i<files;i++){
            for(int c = 0; c<cols;c++){
                int nivell = (int) random(1, 3);// random.nextInt(2) + 1;
                //setAt(i,c, new Hectarea(new PVector(i,c),null, escala, 1));
                setAt(i, c, Factory.getHectareaBuida(i, c,  escala));
            }
        }
    }
    
    void canviEstacio(){
        if(emisferi_nord == Regla.HIVERN){
            emisferi_nord = Regla.ESTIU;
            emisferi_sud = Regla.HIVERN;
            color_emisferi_nord = #208323;
            color_emisferi_sud = #3F6CAC;
        }else{
            emisferi_nord = Regla.HIVERN;
            emisferi_sud = Regla.ESTIU;
            color_emisferi_nord = #3F6CAC;
            color_emisferi_sud = #208323;
        }
    }


    void setAt(int fila, int col, Hectarea h){
        territori[fila][col] = h;
    }

    void setAgentAt(int fila, int col, Agent a){
        territori[fila][col].ocupat = a;
        //territori[fila][col].inquili = 1;
    }
    
    Hectarea getAt(int fila, int col){
        return territori[fila][col];
    }

    public Hectarea[][] getTerritori() {
        return territori;
    }
    
    /**
    * Retorna una posició lliure
    */
    public PVector getFreeHectarea(){
      do{
        int fila = (int) random(0, files);
        int col = (int) random(0, cols);
        //Si la posició està lliure
      }while(getAt(fila, col).isOcupat());
      return new PVector(col, fila);
    }

    /**
    * Treu el Agent a de la seva posició actual i el coloca 
    * en la Hectarea desti.
    * <pre> La Hectarea desti està buida
    */
    public boolean mou(Agent a, PVector desti){
        //Treu el agent de la posició actual
        territori[a.location.y][a.location.x].setInquili(null);
        //Posem l'agent en la nova posició
        a.setLocation(desti);
        territori[desti.y][desti.x].setInquili(a);
        //Agafa el sucre del nou lloc
        a.addRiquesa( territori[desti.y][desti.x].getNivell());
        return true;
    }

    /**
    * Treu el Agent del territori
    */
    public boolean treu(Agent a){
        //Treu el agent de la posició actual
        territori[a.location.y][a.location.x].setInquili(null);
        return true;
    }
    
    private void _text(int k){
        String t = str(k%10);
        float tw = textWidth(t);
        fill(0);
        text(t, (width-tw), (10*k)-2);
    }

    public void display(){
      int ocupats = 0;
      int lliures = 0;
      color actual = color_emisferi_nord;
      for(int i=0;i<territori.length;i++){
        for(int c=0;c<territori[i].length;c++){
            if( territori[i][c] != null){
                territori[i][c].display();
               if(territori[i][c].isOcupat()){ocupats++;}else{lliures++;}
            }
        }
        if(i == files/2){ actual = color_emisferi_sud;}
        fill(actual);
        rect( files*10,10*i, 10, 10);
        _text(i);
      }
      _text(i);

      for(int i=0;i<territori[0].length;i++){
        String t = str((i+1)%10);
        float tw = textWidth(t);
        fill(0);
        text(t, 10*(i+1)+2, (10*51)-2);
      }
     //String t = "Ocupats: "+str(ocupats)+" Lliures: "+str(lliures);
     // text(t, 20, (10*51)-2);
    }
    
   public void set(){
      /*  
     for(int i=0;i<territori.length;i++){
        for(int c=0;c<territori[i].length;c++){
            int nivell = (int) random(1, 3);// random.nextInt(2) + 1;
            //territori[i][c] = new Hectarea(new PVector(i,c),null, 10, 1);
            setAt(i, c, Factory.getHectareaBuida(i, c,  escala));
        }
    }
    */
    int _files = Configuracio.PLANTILLA.length;
    for(int i=0;i<_files;i++){
        for(int c=0;c<Configuracio.PLANTILLA[i].length;c++){
            territori[i+25][c].setCapacitat(Configuracio.PLANTILLA[i][c]);
        }
    }
    for(int i=0;i<_files;i++){
        int _cols = Configuracio.PLANTILLA[i].length;
        for(int c=0;c<Configuracio.PLANTILLA[i].length;c++){
            territori[i][c+25].setCapacitat(Configuracio.PLANTILLA[_files - i - 1][_cols - c -1]);
        }
    }
    _files = Configuracio.PLANTILLA2.length;
    for(int i=0;i<_files;i++){
        for(int c=0;c<Configuracio.PLANTILLA2[i].length;c++){
            territori[i][c].setCapacitat(Configuracio.PLANTILLA2[i][c]);
        }
    }

    for(int i=0;i<_files;i++){
        int _cols = Configuracio.PLANTILLA2[i].length;
        for(int c=0;c<_cols;c++){
            territori[i+25][c+25].setCapacitat(Configuracio.PLANTILLA2[_files - i - 1][_cols - c -1]);
        }
    }

   } 

   /**
   * Retorna la posició del vei (Von Newman) apuntat des de la localització location
   * en direcció direc.
   */
   PVector nextVei(int direc, PVector location){
        PVector direccions[] = new PVector[]{
            new PVector(0,1),
            new PVector(0,-1),
            new PVector(-1,0),
            new PVector(1,0)
       };
        PVector dir = PVector.add(direccions[direc], location);
        //Corregim la posició d'acord amb els límits del territori
        dir.y = dir.y >= files ? (dir.y - files): dir.y;
        dir.y = dir.y <= -1 ? (files + dir.y) : dir.y;
        dir.x = dir.x >= cols ? (dir.x - cols): dir.x;
        dir.x = dir.x <= -1 ? (cols + dir.x) : dir.x;
        return dir;
   }


   int getPromigPolucioVeinsVonNewman(int fila, int col){
       PVector direccions[] = new PVector[]{
            new PVector(0,1),
            new PVector(0,-1),
            new PVector(-1,0),
            new PVector(1,0)
       };
        Hectarea explorada = territori[fila][col];
        PVector location = new PVector(col, fila);
        int pol_total = explorada.polucio;
       //Per cada direccio
       for(int j = 0;j < 4; j++){
           //Obtenim la direcció del desplaçament
           /*PVector dir = PVector.add(direccions[j], location);
            //Corregim la posició d'acord amb els límits del territori
            dir.y = dir.y >= files ? (dir.y - files): dir.y;
            dir.y = dir.y <= -1 ? (files + dir.y) : dir.y;
            dir.x = dir.x >= cols ? (dir.x - cols): dir.x;
            dir.x = dir.x <= -1 ? (cols + dir.x) : dir.x;*/
            PVector dir = nextVei(j, location);
            //Obtenim la referència a la posició explorada
            explorada = territori[(int)dir.y][(int)dir.x]; 
            pol_total += explorada.polucio;
            //territori[(int)dir.y][(int)dir.x].polucio = pol_total;
        } 
        return round(pol_total / 5);
   }

   void setPolucioVeinsVonNewman(int fila, int col, int promig){
        Hectarea explorada = territori[fila][col];
        explorada.polucio = promig;
       //Per cada direccio
       for(int j = 0;j < 4; j++){
            PVector dir = nextVei(j, location);
            //Obtenim la referència a la posició explorada
            explorada = territori[(int)dir.y][(int)dir.x];  
            explorada.polucio = promig;
//javascript.appendLabel("monitor_poblacio", "<br>Polució: ("+str(i)+","+str(c)+")"+" "+str(promig));
        } 
   }

   void rule_pollution_diffusion(){
        int promig = 100;
        for(int i=0;i<territori.length;i++){
            for(int c=0;c<territori[i].length;c++){
                //Obté el promig de polució dels veins
                promig = getPromigPolucioVeinsVonNewman(i,c);
                SugarSpace.mgs_log += "<br>Polució: ("+str(i)+","+str(c)+")"+" "+str(promig);
                //Assigna la polució a tots els veins
                setPolucioVeinsVonNewman(i,c,promig);
                territori[i][c].polucio = promig;
            }
        }
    
    }

}
