class Agent {
    static final int VISIO = 1;
    static final int METABOLISME = 2;
    static final int RIQUESA = 3;
    static final int EDAT = 4;
    static final int SEXE = 5;
    
    static final int HOME = 1;
    static final int DONA = 2;
    
    static final int VISIO_INICIAL = 5;
    static Territori model;
    static SugarSpace sp;

    static PVector direccions[] = new PVector[]{
            new PVector(0,1),
            new PVector(0,-1),
            new PVector(-1,0),
            new PVector(1,0)
       };
    PVector location;
    int escala;
    int riquesa;
    int metabolic;
    int visio;
    int edat;
    int inici_edat_fertilitat;
    int final_edat_fertilitat;
    int edat_minima_defuncio;
    int edat_maxima;
    int sexe;

    public Agent(PVector pos, int _escala) {
        location = pos;
        escala = _escala;
        metabolic = (int) random(1, 4);
        riquesa = (int) random(1, 8);
        visio = (int) random(1, Agent.VISIO_INICIAL);
        edat = (int) random(1, 7);
        sexe = (int) random(1,3);
        //sexe = (_sexe == 0)  ? Agent.HOME : Agent.DONA;
        inici_edat_fertilitat = 2;
        final_edat_fertilitat = 6;
        edat_minima_defuncio = 5;
        edat_maxima = 10;
    }

    public Agent(PVector pos, int _escala, int _metabolic, int _riquesa, int _visio) {
        location = pos;
        escala = _escala;
        metabolic = _metabolic;
        riquesa = _riquesa;
        visio = _visio;
        edat = (int) random(1, 7);
        sexe = (int) random(1,3);
        //sexe = (_sexe == 0)  ? Agent.HOME : Agent.DONA;
        inici_edat_fertilitat = 2;
        final_edat_fertilitat = 6;
        edat_minima_defuncio = 5;
        edat_maxima = 10;
    }
    
    public void addRiquesa(int q){
        riquesa += q;
    }

    public void setLocation(PVector pos){
        location.x = pos.x;
        location.y = pos.y;
    }

     /**
     * Executa el metabolisme de l'agent
     * Si la riquesa és superior al consum metabòlic es resta de la riquesa
     * el consum metabòlic.
     * Si el consum és superior s'iguala a zero
     * @return la quantitat consumida per l'agent
     */
    int metabolisme(){
        int consum;
        consum = (metabolic <= riquesa)? metabolic : riquesa + 1;
        riquesa -= consum;
        return consum;
    }
    
    /** Augmenta l'edat i comprova les condicions de vida:
    *   Edat màxima
    *   Riquesa > Consum metabolisme
    */
    boolean continua(){
        edat++;
//return true;
        if(esManteViu()){
            int consumit = metabolisme();
            //Si la regla de polució està activada
            if(sp.config.regla_generar_polucio){ 
                int taxe_contaminacio = 1;
                int polucio_generada = consumit * taxe_contaminacio;
                model.territori[location.y][location.x].addPolucio(polucio_generada);
            }
            //Si té riquesa continua
            return teRiquesa();
        }else {
            return false;
        }
    }
    
    public boolean esManteViu(){
        int periode = Regla.AGENT_EDAT_MAXIMA_DEFUNCIO - Regla.AGENT_EDAT_MINIMA_DEFUNCIO;
        int defuncio = Regla.AGENT_EDAT_MINIMA_DEFUNCIO + (int) random(1, periode);//rnd.nextInt(periode);
        if(edat>=defuncio) Poblacio.msg += "Defuncio";
        //return edat < defuncio;
        return true;
    }

    public boolean teRiquesa(){
       if(riquesa > 0) return true;
         else{
            //Poblacio.msg += "Defuncio per inanició";
            return false;
         }
    }
    

    boolean mou() {
        //if(!continua()) return false;
        //L'agent mira al voltant quines són les posicions que estan lliures
        PVector desti = Regla.R_Moviment_del_Agent(this);//mirar();
        
        //Si hi ha desplaçament
        if(desti != null){
            model.mou(this, desti);
            //model.territori[location.y][location.x].ocupat = null;
            //*model.territori[location.y][location.x].setInquili(null);
            //Posem l'agent en la nova posició
           //*setLocation(desti);
           //*model.territori[desti.y][desti.x].setInquili(this);
            return true;
        }
        return false;
    }

    PVector mirar(){
       Hectarea candidat = null;
       /*PVector direccions[] = new PVector[]{
            new PVector(0,1),
            new PVector(0,-1),
            new PVector(-1,0),
            new PVector(1,0)
       };*/
       int pd = (int) random(0, 4);//Primera direcció aleatòria
       //La matriu que conté les opcions possibles de desplaçament
       //int op[][] = new int[visio*4][6];//Opcions
       //int id = 0;//Index de la matriu op
       String msg = toString()+"<br>Posicions observades:"+str(pd)+"<br> ";
       for(int v=1;v<=visio;v++){
         for(int j=pd;j<(pd+4);j++){//direccio
             //Si la cel·la està lliure
                //Color per marcar les posicions lliures durant el desenvolupament
                fill(115);
                Hectarea explorada;
                //Obtenim la direcció del desplaçament
                PVector dir = PVector.add(direccions[j%4], location);
                //PVector dir = PVector.add(direccions[0], location);
                //Sumem la distancia corresponent a la visió
                PVector distancia;
                for(int k=1;k<v;k++){
                   dir = PVector.add(direccions[j%4], dir);
                }
                //Corregim la posició d'acord amb els límits del territori
                dir.y = dir.y >= model.files ? (dir.y-model.files): dir.y;
                dir.y = dir.y <= -1 ? (model.files+dir.y) : dir.y;
                dir.x = dir.x >=model.cols ? (dir.x-model.cols):dir.x;
                dir.x = dir.x <= -1 ? (model.cols+dir.x) : dir.x;
                //rect((dir.y)*escala, (dir.x)*escala, escala, escala);
                msg += "("+dir.y+","+dir.x+") ";
                //Obtenim la referència a la posició explorada
                explorada = model.getTerritori()[(int)dir.y][(int)dir.x];
                //Si la posició no està ocupada
                if(!explorada.isOcupat()){
                    //Si el candidat al desplaçament té un nivell inferior al explorat
                    if(candidat == null || candidat.nivell < explorada.nivell){
                        //actualitzem el candidat
                        candidat = explorada;
                    }
                    //Marquem la posició en el mode de desenvolupament
                    //rect((dir.y)*escala, (dir.x)*escala, escala, escala);
                    //msg += "Lliure "+explorada.nivell+"<br>";
                }              
             }
          }
          fill(100,145,45);
          //rect((candidat.location.y)*escala, (candidat.location.x)*escala, escala, escala)
          if(candidat==null) return null;
          msg += "<br>Escollit: "+candidat.toString();
          javascript.actualitzaLabel("monitor_agent","Mirant: "+msg);//+(location.x)+" "+(location.y)+" "+msg);
          return candidat.location;
  }
        
    

  void display() {
      //stroke(255);
      fill(255,0,0);
      float x =  ((location.x+1)*escala-escala/2)-1;
      float y = ((location.y+1)*escala-escala/2)-1;
      ellipse(y,x,escala-5,escala-5);
  }

  String toString(){
    String _sexe = sexe==Agent.HOME ? "Home" : "Dona";
    return "-><strong>("+str(location.x+1)+","+str(location.y+1)+")</strong><br>"+"Edat:"+edat+"<br>Sexe: "+_sexe+"<br>Riquesa: "+str(riquesa)+"<br>Metabolisme: "+str(metabolic)+"<br>Visio: "+visio;
  }
}
