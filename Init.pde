class SugarSpace{
  static String mgs_log;
  int files;
  int cols;
  int escala;
  int temps;
  int estat; // 0 No iniciat, 1 Play, 2 Pause, 3 Step by step
  int poblacio_inicial;
  Territori planeta;
  Poblacio poblacio;
  Estadistiques estadistiques;
  boolean mostrar_serie_poblacio = false;
  boolean mostrar_distribucio_riquesa = true;
  //Opcions de configuració
  String config_reposa_aliment;
  Configuracio config; 
  int periodes_a_executar = -1;
  int periodes_executats = 0;

  static final boolean DEBUG_MODE = false;
  static final int NO_INICIAT = 0;
  static final int PLAY = 1;
  static final int PAUSE = 2;
  static final int STEP_BY_STEP = 3;
  static final int RESET = 4;
  static final int COMMUTA_MOSTRAR_SERIE_POBLACIO = 5;
  static final int MOSTRA_DISTRIBUCIO_RIQUESA = 6;
  static final int MOSTRA_CONFIGURACIO = 7;
  
  SugarSpace(){
    if(!DEBUG_MODE){
        initSugarSpace();
        reset_sugarspace();
    }else{
        initDebugMode();
        reset_sugarspace();
    }
  }
  
void initDebugMode(){
    poblacio_inicial = 15;
    temps = 0;
    escala = Regla.ESCALA;
    estat = SugarSpace.NO_INICIAT;
    files = Configuracio.D_FILES;
    cols = Configuracio.D_FILES;
    
}


void initSugarSpace(){
    poblacio_inicial = Regla.POBLACIO_INICIAL;
    temps = 0;
    escala = Regla.ESCALA;
    estat = SugarSpace.NO_INICIAT;
    files = Regla.FILES;//height/escala;
    cols = Regla.COLS;//width/escala;
    //
/*
    planeta = Factory.getTerritori(files, cols, escala);
    Agent.model = planeta;
    Agent.sp = this;
    Hectarea.sp = this;
    Territori.sp = this;
    Poblacio.planeta = planeta;
     planeta.color_emisferi_nord = Regla.COLOR_SENSE_EMISFERI;
     planeta.color_emisferi_sud = Regla.COLOR_SENSE_EMISFERI;
    //Configuració de les regles
    config = new Configuracio(
                Regla.G1_REPOSA_ALIMENT_UN_A_UN, 
                Regla.R_REPOSA_AGENTS_ELIMINATS,
                Regla.POBLACIO_INICIAL);
*/
   //setRandomAgents(pobacio_inicial);
    
 
    //estadistiques = new Estadistiques();
    //estadistiques.addRegistre(new Registre(0,poblacio_inicial));
    

}

void reset_sugarspace(){
    if(!DEBUG_MODE){
        planeta = Factory.getTerritori(files, cols, escala);
    } else{
        planeta = Factory.getTerritoriDebug(files, cols, escala);
    }
    Agent.model = planeta;
    Agent.sp = this;
    Hectarea.sp = this;
    Territori.sp = this;
    Poblacio.planeta = planeta;
     planeta.color_emisferi_nord = Regla.COLOR_SENSE_EMISFERI;
     planeta.color_emisferi_sud = Regla.COLOR_SENSE_EMISFERI;

    //Configuració de les regles
    config = new Configuracio(
                Regla.G1_REPOSA_ALIMENT_UN_A_UN, 
                Regla.R_REPOSA_AGENTS_ELIMINATS,
                Regla.POBLACIO_INICIAL);
    if(DEBUG_MODE){
        config.zi_col_inicial = 1; 
        config.zi_col_final = 10;
        config.zi_fila_inicial = 1 ;
        config.zi_fila_final = 10;
    }
    Regla.sp = this;
    Configuracio.sp = this;
    poblacio = Factory.getPoblacio();
    //Col·loca els agents inicials en el territori de forma aleatoria
    Regla.R_reposaAgents(poblacio_inicial);
    textFont(createFont("Arial",9));
    estadistiques = new Estadistiques();
    estadistiques.addRegistre(new Registre(0,poblacio_inicial));
}

  void reset(){
    planeta = Factory.getTerritori(files, cols, escala);
    Agent.model = planeta;
    Poblacio.planeta = planeta;
    Agent.sp = this;
    Hectarea.sp = this;
    Territori.sp = this;
    planeta.color_emisferi_nord = Regla.COLOR_SENSE_EMISFERI;
    planeta.color_emisferi_sud = Regla.COLOR_SENSE_EMISFERI;
    //Configuració de les regles
    config = new Configuracio(
                Regla.G1_REPOSA_ALIMENT_UN_A_UN, 
                Regla.R_REPOSA_AGENTS_ELIMINATS,
                Regla.POBLACIO_INICIAL);
   // readConfig();
    Regla.sp = this;
    Configuracio.sp = this;
    poblacio = Factory.getPoblacio();
 
//setRandomAgents(pobacio_inicial);
    Regla.R_reposaAgents(pobacio_inicial);
    textFont(createFont("Arial",9));  
  
    estadistiques = new Estadistiques();
    estadistiques.addRegistre(new Registre(0,poblacio_inicial));
     
  }

  void display() {
    //if(temps%5==0)
    planeta.display();
    //poblacio.draw();
  }
  
  
  void un_step(){
    SugarSpace.mgs_log = "";
    //Executa la regla de reposició de sucre
    config.exe_regla_reposicio_sucre();
    //Incrementa el temps i el mostra
    temps++;
    javascript.showTemps(temps);
    
    //Executa la regla de moviment dels agents
    int eliminats = poblacio.mou();
    
    //Recull la informació del període
    estadistiques.addRegistre(
            new Registre(temps, poblacio.getNumAgents(), poblacio.getRiquesa())
    );
    //Actualitza la informació en la consola
    //javascript.actualitzaLabel("monitor_poblacio", Poblacio.msg+" "+temps);
    //javascript.actualitzaLabel("vista_poblacio", estadistiques.toString());
    
    //Mostra els gràfics d'acord amb la configuració
    if(config.mostrar_serie_poblacio) 
        javascript.setCanvas(str(temps), estadistiques.getSeriePoblacio());
    
    if(config.mostrar_distribucio_riquesa){ 
        
        int[] dades = estadistiques.getDadesRiquesa(temps);
        javascript.actualitzaLabel("monitor_poblacio", temps+"-> "+dades[dades.length-1]);
        javascript.setGraficDistribucioRiquesa(estadistiques.getDadesRiquesa(temps));
    }

    //Executa la regla de reposició d'agents
    config.exe_regla_reposicio_agents(eliminats);
    
    //Si la polució està activada
   if(config.regla_difusio_polucio){ 
        planeta.rule_pollution_diffusion();
        javascript.appendLabel("monitor_poblacio", SugarSpace.mgs_log);
   }
  }
  
  void step() {
    if(estat == SugarSpace.PLAY && periodes_executats < periodes_a_executar){
        un_step();
        periodes_executats++;
    }else if(periodes_executats == periodes_a_executar){
        estat = SugarSpace.PAUSE;
        javascript.showTemps(temps);
        javascript.playPause();
        javascript.enabledButton("step_by_step");
        periodes_a_executar = -1;
    }
  }

void setTerritori(){
 // hectareas = planeta.getTerritori();
    for(int i=0;i<planeta.territori.length;i++){
        for(int c=0;c<planeta.territori[i].length;c++){
            int nivell = (int) random(1, 3);// random.nextInt(2) + 1;
            planeta.setAt(i, c, new Hectarea(new PVector(i,c),null, escala, 1));
        }
    }
 
    int _files = Configuracio.PLANTILLA.length;
    for(int i=0;i<_files;i++){
        for(int c=0;c<Configuracio.PLANTILLA[i].length;c++){
            planeta.territori[i+25][c].setCapacitat(Configuracio.PLANTILLA[i][c]);
        }
    }
    for(int i=0;i<_files;i++){
        int _cols = Configuracio.PLANTILLA[i].length;
        for(int c=0;c<Configuracio.PLANTILLA[i].length;c++){
            planeta.territori[i][c+25].setCapacitat(Configuracio.PLANTILLA[_files - i - 1][_cols - c -1]);
        }
    }
    _files = Configuracio.PLANTILLA2.length;
    for(int i=0;i<_files;i++){
        for(int c=0;c<Configuracio.PLANTILLA2[i].length;c++){
            planeta.territori[i][c].setCapacitat(Configuracio.PLANTILLA2[i][c]);
        }
    }

    for(int i=0;i<_files;i++){
        int _cols = Configuracio.PLANTILLA2[i].length;
        for(int c=0;c<_cols;c++){
            planeta.territori[i+25][c+25].setCapacitat(Configuracio.PLANTILLA2[_files - i - 1][_cols - c -1]);
        }
    }

  }

void setRandomAgents(int num){ 
    //Mentre el nombre de colocats sigui inferior a num
    for(int colocats = 0;colocats<num;){
        int fila = (int) random(0, files);//random.nextInt(files);
        int col = (int) random(0, cols);//random.nextInt(cols);
        //Si la posició està lliure
        if(!planeta.getAt(fila, col).isOcupat()){
            //Creem un nou agent localitzat en fila col
            agent = Factory.getAgent(fila, col, escala);
            //Afegim l'agent a la població
            poblacio.add(agent);
            //Col·loquem l'agent en el territoti
            planeta.setAgentAt(fila, col, agent);
            colocats++;
        }
    }
  }

  String getConfiguracio(){
    String str1 = str(files)+","+str(cols)+","+str(Regla.POBLACIO_INICIAL)+","+str(config.regla_reposa_sucre)+","+str(config.regla_reposa_agents);

    return str1;
  }

  /**
  * Llegeix del formulari Configuració, la configuració.
  */
  void readConfig(){
        int xy[] = javascript.getConfigPoblacioInicial();
        config.regla_reposa_agents = javascript.getConfigReglaR(); 
        config.regla_reposa_sucre = javascript.getConfigReglaG();
        
        //Configuració amb estacions
        planeta.color_emisferi_nord = Regla.COLOR_SENSE_EMISFERI;
        planeta.color_emisferi_sud = Regla.COLOR_SENSE_EMISFERI;
        if(config.regla_reposa_sucre == Regla.Saby_REPOSA_ALIMENT_AMB_ESTACIONS){
           int est[] = javascript.getConfigEstacions();
           config.durada_de_les_estacions = est[0];
           planeta.color_emisferi_nord = Regla.COLOR_EMISFERI_NORD;
           planeta.color_emisferi_sud = Regla.COLOR_EMISFERI_SUD;
        }
        config.poblacio_inicial = xy[0];
        pobacio_inicial = config.poblacio_inicial;
        //Afegir la configuració de la distribució de la població inicial
        config.zi_fila_inicial =  int(xy[1]);
        config.zi_fila_final = int(xy[2]);
        config.zi_col_inicial = int(xy[3]);
        config.zi_col_final = int(xy[4]);

        //Opcions de contaminació
        config.regla_generar_polucio = javascript.getConfigPolucio();
        config.regla_difusio_polucio = javascript.getConfigDifusioPolucio();
  }

  void log(String  msg){
       javascript.appendLabel("monitor_poblacio", msg);
  }

}//Final classe SugarSpace
////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////
SugarSpace sp;

interface JavaScript {
    void showTemps(int temps);
    void setButtonPlay();
    void disabledButton(String id);
    void enabledButton(String id);
    void actualitzaLabel(String id, String text);
    void appendLabel(String id, String text);
    void actualitzaInput(String id, String valor);
    void setCanvas(String temps, String dades);
    void setCanvasGrafic2(String temps, String dades);
    void setConfiguracio(String config);
    int getPeriodes();
    void playPause();
    void mostra_grafics();
    int getConfigReglaR();
    int getConfigReglaG();
    int getConfigPoblacioInicial();
    int getConfigEstacions();
    boolean getConfigPolucio();
    boolean getConfigDifusioPolucio();
}
 
 void bindJavascript(JavaScript js) {
    javascript = js;
}

int getConfigPoblacioInicial(){
    return Regla.POBLACIO_INICIAL;
}

/**
* Retorna la configuració inicial en una matriu.
* Aquesta funció es crida des de setFormConfig per inicilitzar
* el contingut del formulari html Configuració
*/
int[] getConfig(){
    int[] cnf = {
        sp.config.zi_fila_inicial,
        sp.config.zi_fila_final,
        sp.config.zi_col_inicial,
        sp.config.zi_col_final,
        Regla.AGENT_VISIO,
        0,
        Regla.AGENT_METABOLISME};
   return cnf;
}

void mostraPosicionsPoblacio(){
    String s = sp.poblacio.report();
    actualitzaLabel("monitor_poblacio", "Mostrar localitzaci&oacute; de la poblaci&oacute;<br>"+s);
   
}

boolean isChecked(){
    return true;
}

void command(int command){
    switch(command){
      case SugarSpace.STEP_BY_STEP:  
        if(javascript != null){
           sp.estat = SugarSpace.STEP_BY_STEP;
           //Llegir la configuracio
           sp.readConfig();
           sp.un_step();
           //sp.temps++;
           javascript.mostra_grafics();
           javascript.showTemps(sp.temps);
           //javascript.setCanvasGrafic2(sp.temps, "Grafic 2");
           //javascript.setCanvas(sp.temps, "Grafic 2");
           //mostraPosicionsPoblacio();
        };break;
      case SugarSpace.RESET:
        if(javascript != null){
           sp.estat = SugarSpace.RESET;
           sp.estat = SugarSpace.NO_INICIAT;
           sp.temps = 0;
           //sp.reset();
           sp.reset_sugarspace();
           sp.readConfig();
           javascript.showTemps(sp.config.zi_col_inicial+" "+ sp.config.zi_col_final);
           javascript.setButtonPlay();
           javascript.enabledButton("step_by_step");
           //log(sp.config.zi_col_inicial+" "+ sp.config.zi_col_final);
        };
        break;
      case SugarSpace.PLAY:
        if(javascript != null){
           sp.estat = SugarSpace.PLAY;
           javascript.showTemps(sp.temps);
           javascript.disabledButton("step_by_step");
           sp.periodes_a_executar = javascript.getPeriodes();
           sp.periodes_executats = 0;
           javascript.mostra_grafics();
        };
        break;
      case SugarSpace.PAUSE:
        if(javascript != null){
           sp.estat = SugarSpace.PAUSE;
           javascript.showTemps(sp.temps);
           javascript.enabledButton("step_by_step");
        };
        break;
      case SugarSpace.COMMUTA_MOSTRAR_SERIE_POBLACIO:
            sp.mostrar_serie_poblacio = sp.mostrar_serie_poblacio ? false:true;
        break;
      case SugarSpace.MOSTRA_DISTRIBUCIO_RIQUESA:
            sp.mostrar_distribucio_riquesa = sp.mostrar_distribucio_riquesa ? false:true;
        break;
      case SugarSpace.MOSTRA_CONFIGURACIO:
            javascript.setConfiguracio(sp.getConfiguracio());
        break;
    }
}

void one_step(){
    sp.temps++; 
    String msg = str(sp.temps)+" Agents moguts: ";
    for(int i=0; i< sp.poblacio.agents.size(); i++){
        Agent a = sp.poblacio.agents.get(i);
        msg += " "+str(i)+" ("+a.location.x+","+a.location.y+")=>";
        if(a != null){
            //a.mou();
             Hectarea desti = a.mirar();
            //Si hi ha desplaçament
            if(desti != null){
                javascript.actualitzaLabel("pos_agent","Desplaçat: "+str(i));
                sp.planeta.mou(a, desti);
                //redraw();
            }else{javascript.showTemps(str(i)+"Null");}
            javascript.showTemps(str(i)+"*"+str(sp.poblacio.agents.size()));
        }
        msg += " ("+a.location.y+","+a.location.x+")<br>";
    }
    javascript.showTemps("-"+sp.temps+"-");
    javascript.actualitzaLabel("monitor_poblacio",msg);
    //System.gc(); 
}

void mouseClicked() {
    //redraw();
    int col = (int)(mouseX/sp.escala);
    int fila = (int)(mouseY/sp.escala);
    Hectarea h = sp.planeta.getAt(col, fila);
    Agent a = h.ocupat;
    String txt = h.nivell;
    //if(a != null){txt="Ocu";}else{txt="Res.";}
    if(a != null){
         txt =str(fila+1)+"/"+str(col+1);
        //txt = str(fila)+"/"+str(col)+" "+a.escala+" - ";
    }

    //javascript.actualitzaLabel("pos_agent",txt);
    javascript.actualitzaInput("pos_agent",txt);
    javascript.actualitzaLabel("monitor_poblacio",h.toString()+"*<br>*");
    
}

void reset(String t){
   //float twidth = textWidth(t);
   //text(t, (width - twidth)/2, height/2);
    setup();
}
void play(String t){
   float twidth = textWidth(t);
   text(t, (width - twidth)/2, height/2);
}


void setup() {
  //size(1000,600);
  sp = new SugarSpace();
  size((sp.cols+1)*sp.escala,(sp.files+1)*sp.escala);
  background(255);

}



void draw() {
  sp.step();
  sp.display();
}



