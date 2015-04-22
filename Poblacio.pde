public class Poblacio {
    static Territori planeta;
    static String msg = "";
    ArrayList agents;
    ArrayList per_eliminar;

    public Poblacio() {
        agents = new ArrayList();
    }
    
    public void add(Agent nou){
        agents.add(nou);
    }
    
    void draw(){
        for (int i = 0; i < agents.size(); i++){
            Agent a = agents.get(i);
            a.display();
        }
    }   
    
    /*
    * Retorna el nombre d'agents eliminats
    */
    int mou(){
        Poblacio.msg = "Poblaci&oacute; "+ agents.size() +"<br>";
        int moguts = 0;
        int quiets = 0;
        int eliminats = 0;
        per_eliminar = new ArrayList();
        //Per cada agent de la població
        for (int i = 0; i < agents.size(); i++){
            //msg = str(i);
            //javascript.actualitzaLabel("pos_agent",msg);
            //Obtenim l'agent
            Agent a = agents.get(i);
            //Comprovem si continua viu
            if(a.continua()){
                if(a.mou() /* desti != null*/){
                    //sp.planeta.mou(a, desti);
                    moguts++;
                }else{
                    quiets++;
                }
            }else{
                //Posem per eliminar
                eliminats++;
                per_eliminar.add(a);
                //Treiem el agent del planeta
                 planeta.treu(a);
                //Buscar una posició lliure al·leatoriament
                /*PVector pos = sp.planeta.getFreeHectarea();
                //Crear un nou agent
                Agent nou = Factory.getAgent(pos.fila, pos.col, sp.escala);
                agents.add(nou);
                sp.planeta.setAgentAt(fila, col, nou);
                */
            }
        }
        Poblacio.msg += "Moguts: "+str(moguts)+" Quiets: "+str(quiets)+" Eliminats: "+eliminats+"<br>";
        for(Agent a:per_eliminar){
            Poblacio.msg += a.toString();
            
            //Borrem el agent de la població
            agents.remove(a);
        }
        return eliminats;
    }

    String report(){
        int ocupats[][] = new int[50][50];
        for(int fila=0; fila<50;fila++){
            for(int col=0;col<50;col++){
                ocupats[fila][col] = 0;
            }
        }
        String rp = "Poblaci&oacute; "+ agents.size() +"<br>";
        for (int i = 0; i < agents.size(); i++){
             Agent a = agents.get(i);
             if(ocupats[a.location.y][a.location.x] == 0){
                ocupats[a.location.y][a.location.x] = 1;
             }else{
                 rp += str(i)+" ("+str(a.location.x+1)+","+str(a.location.y+1)+") REPETIT<br>";
             }
             rp += str(i)+" ("+str(a.location.x+1)+","+str(a.location.y+1)+") <br>";
        }
        return rp;
    }

    public int getNumAgents(){
        return agents.size();
    }

    public int[] getRiquesa(){
        int[] dis = new int[agents.size()]; 
        Agent a;
        for (int i = 0; i < agents.size(); i++){
            a = agents.get(i);
            dis[i] = a.riquesa;
        }
        return sort(dis);
    }
}

