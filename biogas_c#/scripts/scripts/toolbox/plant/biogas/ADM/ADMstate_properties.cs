/**
 * This file is part of the partial class ADMstate and defines
 * all properties of the class.
 * 
 * TODOs:
 * - _dim_stream, _dim_state, _n_gases are fixed, may they also have different values?
 * 
 * Hinweis: Da es momentan nicht möglich ist, ADM, ADMparams und ADMstate abzuleiten
 * da zu viel mit statischen methoden gearbeitet wird, sollte diese
 * klasse möglichst wenige public parameter definieren um bei einem
 * wechsel des adm modells alles möglichst kompakt in den drei klassen
 * adm, admparams und admstate zu haben. 
 * 
 */

using System;
using System.Collections.Generic;
using System.Text;
using science;
using toolbox;

namespace biogas
{
  /// <summary>
  /// TODO: Implement: calcPHOfADMstate as in MATLAB, 
  /// all other methods are as in MATLAB
  /// s. biogasM.ADMstate
  /// sollte mit math Klasse jetzt möglich sein
  /// 
  /// References:
  /// 
  /// 1) Schoen, M.A., Sperl, D., Gadermaier, M., Goberna, M., Franke-Whittle, I.,
  ///    Insam, H., Ablinger, J., and Wett B.: 
  ///    Population dynamics at digester overload conditions, 
  ///    Bioresource Technology 100, pp. 5648-5655, 2009
  ///
  /// </summary>
  public partial class ADMstate
  {
    
    // -------------------------------------------------------------------------------------
    //                           !!! PROPERTIES !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// dimension of the stream vector = number of elements
    /// 
    /// TODO: Could this also be another number?
    /// </summary>
    private static int _dim_stream= 34;

    /// <summary>
    /// only for MATLAB
    /// TODO - wenn matlab nicht wäre, sollte der nicht public sein
    /// wird auch von ADMstream_sensor genutzt
    /// </summary>
    public static double dim_stream= (double)_dim_stream;

    /// <summary>
    /// position of Q in stream vector
    /// 
    /// Remark: 
    /// pos_Q must always be equal to dim_stream, thus the last element in the stream
    /// </summary>
    public static int pos_Q= _dim_stream;

    /// <summary>
    /// dimension of the state vector = number of elements
    /// 
    /// TODO: Could this also be another number?
    /// </summary>
    private static int _dim_state= 37;

    /// <summary>
    /// only for MATLAB
    /// wird auch von ADMstate_sensor genutzt
    /// </summary>
    public static double dim_state= (double)_dim_state;




    // TODO DELETE !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

    // now it is in class BioGas

    ///// <summary>
    ///// number of gases in the biogas (H2, CH4, CO2)
    ///// 
    ///// TODO: Could this also be another number?
    ///// </summary>
    //private static int _n_gases= 3;

    // only for MATLAB
    //public static double n_gases= (double)_n_gases;

    ///// <summary>
    ///// position of hydrogen in the gaseous phase
    ///// </summary>
    ////public static int pos_h2=  1;
    ///// <summary>
    ///// methane in the gaseous phase
    ///// </summary>
    ////public static int pos_ch4= 2;
    ///// <summary>
    ///// carbon dioxide in the gaseous phase
    ///// </summary>
    ////public static int pos_co2= 3;

    ///// <summary>
    ///// Symbols for the biogas vector
    ///// </summary>
    //public static string[] symGases= { "H2", "CH4", "CO2" };

    // TODO DELETE !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!




    // positions of the components in the state vector
    // from 1 - 33 these are also the positions inside the stream vector
    // TODO
    // durch die unten eingeführte Variable symADMstate wird die Definition
    // der einzelnen Positionen eigentlich nicht mehr benötigt, diese ist
    // über die statische Methode getPosOfADMstatevariable() wird diese zurück geliefert
    // aus Geschwindigkeitsgründen ist es allerdings nicht von Nachteil die Positionen
    // doppelt zu definieren, muss man sehen wie oft die genutzt werden.
    static int pos_Ssu=    1; // monosaccarides
    static int pos_Saa=    2; // amino acids
    static int pos_Sfa=    3; // total LCFA
    static int pos_Sva=    4; // valeric acid + valerate
    static int pos_Sbu=    5; // butyric acid + butyrate
    static int pos_Spro=   6; // propionic acid + propionate
    static int pos_Sac=    7; // acetic acid + acetate
    static int pos_Sh2=    8; // hydrogen
    static int pos_Sch4=   9; // methane
    static int pos_Sco2=  10; // carbon dioxide
    static int pos_Snh4=  11; // ammonium
    static int pos_SI=    12; // soluble inerts
    static int pos_Xc=    13; // composite
    static int pos_Xch=   14; // carbohydrates
    static int pos_Xpr=   15; // proteins
    static int pos_Xli=   16; // lipids
    static int pos_Xsu=   17; // biomass sugar degraders
    static int pos_Xaa=   18; // biomass amino acids degraders
    static int pos_Xfa=   19; // biomass LCFA degraders
    static int pos_Xc4=   20; // biomass valerate, butyrate degraders
    static int pos_Xpro=  21; // biomass propionate degraders
    static int pos_Xac=   22; // biomas acetate degraders
    static int pos_Xh2=   23; // biomass hydrogen degraders
    static int pos_XI=    24; // particulate inerts
    static int pos_Xp=    25; // particulate products arising from biomass decay
    static int pos_Scat=  26; // cations
    static int pos_San=   27; // anions
    static int pos_Sva_=  28; // valerate
    static int pos_Sbu_=  29; // butyrate
    static int pos_Spro_= 30; // propionate
    static int pos_Sac_=  31; // acetate
    static int pos_Shco3= 32; // bicarbonate
    static int pos_Snh3=  33; // ammonia
    static int pos_piSh2= 34; // partial pressure of hydrogen
    static int pos_piSch4=35; // partial pressure of methane
    static int pos_piSco2=36; // partial pressure of carbon dioxide
    public static int pos_pTOTAL=37; // sum of all partial pressures


    ///// <summary>
    ///// defines whether ADM1 state vector component is particular
    ///// !is_x is then is_s, all soluble components
    ///// </summary>
    //public static bool[] is_x = 
    //{ false, false, false, false, false, false, false, false, false, false,
    //  false, false, true,  true,  true,  true,  true,  true,  true,  true, 
    //  true,  true,  true,  true,  true, false, false, false, false, false, 
    //  false, false, false};

    /// <summary>
    /// defines whether ADM1 state vector component is particular
    /// !is_x is then is_s, all soluble components
    /// 
    /// TODO: is_x ist etwas anders definiert als man annehmen möchte
    /// ein paar X komponenten sind nicht enthalten
    /// </summary>
    public static bool[] is_x = 
    { false, false, false, false, false, false, false, false, false, false,
      false, false, true,  true,  true,  true,  true,  true,  true,  true, 
      true,  true,  true,  false, false, false, false, false, false, false, 
      false, false, false};


    /// <summary>
    /// TODO:
    /// Use in the method: ADMstate.getADMstatevariables
    /// </summary>
    public static string[] symADMstate= 
      { "Ssu",   "Saa",    "Sfa", "Sva", "Sbu", "Spro", "Sac", "Sh2",  "Sch4", "Sco2",  
        "Snh4",  "SI",     "Xc",  "Xch", "Xpr", "Xli",  "Xsu", "Xaa",  "Xfa",  "Xc4", 
        "Xpro",  "Xac",    "Xh2", "XI",  "Xp",  "Scat", "San", "Sva_", "Sbu_", "Spro_", 
        "Sac_",  "Shco3",  "Snh3", 
        "piSh2", "piSch4", "piSco2", "pTOTAL" };

    /// <summary>
    /// units of ADM state vector
    /// </summary>
    public static string[] unitsADMstate = 
      { "kgCOD/m^3", "kgCOD/m^3", "kgCOD/m^3", "kgCOD/m^3", "kgCOD/m^3", 
        "kgCOD/m^3", "kgCOD/m^3", "kgCOD/m^3", "kgCOD/m^3", "kmol/m^3",  
        "kmol/m^3",  "kgCOD/m^3", "kgCOD/m^3", "kgCOD/m^3", "kgCOD/m^3", 
        "kgCOD/m^3", "kgCOD/m^3", "kgCOD/m^3", "kgCOD/m^3", "kgCOD/m^3", 
        "kgCOD/m^3", "kgCOD/m^3", "kgCOD/m^3", "kgCOD/m^3", "kgCOD/m^3",  
        "kmol/m^3",  "kmol/m^3",  "kgCOD/m^3", "kgCOD/m^3", "kgCOD/m^3", 
        "kgCOD/m^3", "kmol/m^3",  "kmol/m^3", 
        "bar",       "bar",       "bar",       "bar" };
    


  }
}


