class Configuracio {
    public static int PLANTILLA[][] ={
        { 1,1,1,2,2,2,2,2,2,2,2,3,3,3,3,3,3,3,3,3,3,2,2,2,2},
        { 1,1,2,2,2,2,2,2,2,2,3,3,3,3,3,3,3,3,3,3,3,3,3,2,2},
        { 1,2,2,2,2,2,2,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,2},
        { 2,2,2,2,2,2,3,3,3,3,3,4,4,4,4,3,3,3,3,3,3,3,3,3,2},
        { 2,2,2,2,2,3,3,3,3,4,4,4,4,4,4,4,4,3,3,3,3,3,3,3,3},
        { 2,2,2,2,2,3,3,3,4,4,4,4,4,4,4,4,4,4,3,3,3,3,3,3,3},
        { 2,2,2,2,3,3,3,4,4,4,4,4,4,4,4,4,4,4,3,3,3,3,3,3,3},
        { 2,2,2,2,3,3,3,4,4,4,4,4,4,4,4,4,4,4,4,3,3,3,3,3,3},
        { 2,2,2,2,3,3,3,4,4,4,4,4,4,4,4,4,4,4,4,3,3,3,3,3,3},
        { 2,2,2,2,3,3,3,4,4,4,4,4,4,4,4,4,4,4,4,3,3,3,3,3,3},
        { 2,2,2,2,3,3,3,4,4,4,4,4,4,4,4,4,4,4,4,3,3,3,3,3,3},
        { 2,2,2,2,3,3,3,4,4,4,4,4,4,4,4,4,4,4,4,3,3,3,3,3,3},
        { 2,2,2,2,3,3,3,3,4,4,4,4,4,4,4,4,4,4,3,3,3,3,3,3,2},
        { 2,2,2,2,3,3,3,3,4,4,4,4,4,4,4,4,4,3,3,3,3,3,3,2,2},
        { 2,2,2,2,3,3,3,3,3,3,4,4,4,4,4,4,3,3,3,3,3,3,2,2,2},
        { 2,2,2,2,2,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,2,2,2,2},
        { 2,2,2,2,2,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,2,2,2,2},
        { 2,2,2,2,2,2,3,3,3,3,3,3,3,3,3,3,3,3,3,3,2,2,2,2,2},
        { 2,2,2,2,2,2,2,3,3,3,3,3,3,3,3,3,3,3,3,2,2,2,2,2,2},
        { 1,1,2,2,2,2,2,2,3,3,3,3,3,3,3,3,3,3,2,2,2,2,2,2,2},
        { 1,1,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2},
        { 1,1,1,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,1},
        { 1,1,1,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,1,1},
        { 1,1,1,1,1,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,1,1,1,1},
        { 1,1,1,1,1,1,2,2,2,2,2,2,2,2,2,2,2,2,2,2,1,1,1,1,1}
    };

public static int PLANTILLA2[][] ={
        { 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1},
        { 0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1},
        { 0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1},
        { 0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,2},
        { 0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,2},
        { 0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,2,2},
        { 0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,2,2,2},
        { 0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,2,2,2},
        { 0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,2,2,2,2,2},
        { 0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,2,2,2,2,2},
        { 0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,2,2,2,2,2,2},
        { 0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,2,2,2,2,2,2,2},
        { 0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,2},
        { 0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,2,2},
        { 0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,2,2,2},
        { 0,1,1,1,1,1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,2,2,2,2,2},
        { 1,1,1,1,1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,2,2,2,2,2,2},
        { 1,1,1,1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,2,2,2,2,2,2,2},
        { 1,1,1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2},
        { 1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2},
        { 1,1,1,1,1,1,1,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2},
        { 1,1,1,1,1,1,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2},
        { 1,1,1,1,1,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2},
        { 1,1,1,1,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2},
        { 1,1,1,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2}
    };

    public static SugarSpace sp;
    public static final int D_FILES = 10;
    public static final int D_COLS = 10;

    int regla_reposa_sucre;
    int regla_reposa_agents;
    int poblacio_inicial;
    int posa_agents;
    int zi_fila_inicial;
    int zi_fila_final;
    int zi_col_inicial;
    int zi_col_final;
    int durada_de_les_estacions;
    color color_emisferi_nord = #3F6CAC;
    color clor_emisferi_sud = #208323;
    boolean mostrar_serie_poblacio = true;
    boolean mostrar_distribucio_riquesa = true;
    boolean regla_generar_polucio;
    boolean regla_difusio_polucio;

    Configuracio(int _regla_reposa_sucre, int _regla_reposa_agents, _poblacio_inicial){
        regla_reposa_sucre = _regla_reposa_sucre;
        regla_reposa_agents = _regla_reposa_agents;
        poblacio_inicial = _poblacio_inicial;
        zi_fila_inicial = Regla.FIL_INICI;
        zi_fila_final = Regla.FIL_FINAL;
        zi_col_inicial = Regla.COL_INICI;
        zi_col_final = Regla.COL_FINAL;
        durada_de_les_estacions = Regla.DURADA_DE_LES_ESTACIONS;
        regla_generar_polucio = false;
        regla_difusio_polucio = false;
    }

    String getReposaSucre(){
        switch(regla_reposa_sucre){
            case Regla.Goo_REPOSA_ALIMENT_AL_MOMENT: return " retorna a la seva capacitat al moment.";
            case Regla.G1_REPOSA_ALIMENT_UN_A_UN: return " retorna a la seva capacitat creixent de un en un.";
        }
    }

    void exe_regla_reposicio_sucre(){
        switch(regla_reposa_sucre){
            case Regla.Goo_REPOSA_ALIMENT_AL_MOMENT: Regla.Goo_reposaAliment();break;
            case Regla.G1_REPOSA_ALIMENT_UN_A_UN: Regla.G1_reposaAliment();break;
            case Regla.Saby_REPOSA_ALIMENT_AMB_ESTACIONS: 
                    if(sp.temps % durada_de_les_estacions == 0){
                        sp.planeta.canviEstacio();
                    }
                    Regla.Saby_reposaAlimentEmisferi(Regla.EMISFERI_NORD);
                    Regla.Saby_reposaAlimentEmisferi(Regla.EMISFERI_SUD);
                break;
        }
    }

   String getReposaAgents(){
       switch(regla_reposa_agents){
            case Regla.R_NO_REPOSA_AGENTS_ELIMINATS: return " Quan un agent es mora no el reposa";
            case Regla.R_REPOSA_AGENTS_ELIMINATS: return " Reposa els agents que es moren en una nova posició escollida al atzar.";
        }
    }

    void exe_regla_reposicio_agents(int eliminats){
        switch(regla_reposa_agents){
            case Regla.R_NO_REPOSA_AGENTS_ELIMINATS: return;
            case Regla.R_REPOSA_AGENTS_ELIMINATS: Regla.R_reposaAgents(eliminats);break;
        }
    }

    void exe_regla_polucio(){
        if(config.regla_generar_polucio) 
            sp.planeta.rule_pollution_diffusion();
    }
}
