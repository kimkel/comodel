class Hectarea {
    static SugarSpace sp;

    PVector location;
    Agent ocupat;
    int inquili;
    int escala;
    int nivell;
    int capacitat;
    int polucio;

    public Hectarea(PVector _location, Agent _ocupat, int _escala) {
        location = _location;
        ocupat = _ocupat;
        escala = _escala;
        nivell = 1;
    }
    
    public Hectarea(PVector _location, int _inquili, int _escala) {
        location = _location;
        //inquili = _inquili;
        escala = _escala;
        nivell = 1;
    }
    public Hectarea(PVector _location, Agent _ocupat, int _escala, int _nivell) {
        location = _location;
        ocupat = _ocupat; 
        escala = _escala;
        if(ocupat != null){
            ocupat.location = _location ;
            ocupat.escala = _escala;
        }
        nivell =  _nivell;
        capacitat = _nivell;
    }
    
    void setCapacitat(_nivell){
        nivell =  _nivell;
        capacitat = _nivell;
    }

    int getPolucioAlRecollir(int quantitat){
        int taxe_polucio = 1; 
        int polucio_generada = quantitat * taxe_polucio; 
        return polucio_generada;
    }

    /**
    * Retorna el rati de polució
    */
    float getPollutionRatio(){
        return nivell/( 1 + polucio);
    }

    int checkNivell(){
        return getPollutionRatio();
        //return nivell;
    }
    
    int getNivell(){
        int sucre = nivell;
        if(sp.config.regla_generar_polucio){
            polucio_generada = getPolucioAlRecollir(sucre);
            addPolucio(polucio_generada);
        }
        nivell = 0;
        return sucre;
    }

    void addPolucio(int polucio_generada){
        polucio += polucio_generada;
    }


    boolean isOcupat(){
        return ocupat == null ? false : true;
    }

    void setInquili(Agent a){
        ocupat = a;
    }

   /**
   * Augment el nivell de sucre en la quantitat indicada en el paràmetre
   */
   public void creix(int augment){
        if(capacitat > nivell){
            nivell += augment;
        }
   }

    void display(){ 
        if(ocupat != null){
            fill(255);
        }else{
            fill(255);
        }
        rect( (location.y ) * escala,(location.x ) * escala, (escala - 2), (escala - 2));
        int radi = escala - 1;
        switch(nivell){
            case 4: fill(255,255,0);break;
            case 3: fill(255,255,30);radi -= 2; break;
            case 2: fill(255,255,100);radi -= 3;break;
            case 1: fill(255,255,130);radi -= 6;break;
            case 0: fill(255);break;
            //default: fill(255,255,0);
        }
        noStroke();
       
        float x =  ((location.x+1)*escala-escala/2)-1;
        float y = ((location.y+1)*escala-escala/2)-1;
        //ellipse(location.y* escala,location.x* escala,radi,radi);
        ellipse(y,x,radi,radi);
        if(ocupat != null){
            ocupat.display();
        }
        
    }

    String toString(){
        /*noStroke();
        float x =  ((location.x+1)*escala-escala/2)-1;
        float y = ((location.y+1)*escala-escala/2)-1;
        ellipse(y,x,15,15);*/
        String a = "Buit";
        if(ocupat != null){
            a = "O("+str(location.x+1)+","+str(location.y+1)+")"+ocupat.toString();
        }
        return "H("+str(location.x+1)+","+str(location.y+1)+")Polucio:"+str(polucio)+"->"+str(nivell)+"a:"+a;
    }
    
}
