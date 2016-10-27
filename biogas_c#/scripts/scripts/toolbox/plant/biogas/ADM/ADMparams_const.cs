/**
 * This file defines the class ADMparams.
 * 
 * TODOs:
 * - At the moment only defines positions of ADM params in the params vector. 
 * - what should it be used for?
 * 
 * 
 * 
 */

using System;
using System.Collections.Generic;
using System.Text;

/**
 * Mainly everything that has to do with biogas is defined in this namespace:
 * 
 * - Anaerobic Digestion Model
 * - CHPs
 * - Digesters
 * - Plant
 * - Substrates
 * - Chemistry used for biogas stuff
 * 
 */
namespace biogas
{
  /// <summary>
  /// 
  /// TODO:
  /// Define what this class should be used for
  /// 
  /// </summary>
  public partial class ADMparams
  {
    /// <summary>
    /// Returns vector of constant ADM params
    /// </summary>
    /// <param name="T">temperature in °C</param>
    /// <returns></returns>
    public static double[] getConstParams(double T)
    { 
      double[] p_const= new double[48];

      // N_aa N content proteins [k mole N/kg COD] (Quelle S. 25)
      // [mol N / g COD]
      // 1 mol N = 14 g
      // Alanin: 14 gN / 96 gCOD
      // Arginin: 4*14 gN / 176 gCOD
      // ...
      // Summe über alle Aminosäuren:
      // ( 14 / 96 + 4*14 / 176 + 2*14 / 96 + 14 / 96 + ... ) = 0.098 gN / gCOD
      // N_aa= 0.098 gN / gCOD = 0.098 / 14 mol N / gCOD
      p_const[0]= 0.098/14;

      // C_Xch C content Xch [k mole C/kg COD]
      p_const[1]= 0.0313;

      // C_Xpr C content Xpr [k mole C/kg COD]
      p_const[2]= 0.03;                   

      // C_Xli C content Xli [k mole C/ kg COD]
      p_const[3]= 0.022;      

      // dummy_C_su equal to C_Xch [-]   
      // Monosaccharide : C_6H_{12}O_6
      // 1 mol SU = 192 gCOD
      // C_su= 6 mol C / 192 gCOD = 0.0313 mol C / gCOD
      p_const[4]= 0.313;

      // dummy_Caa equal to C_Xpr [-] (Quelle S. 25)
      // für Aminosäuren gilt:
      // mittlere CSB =
      // (96+176+2*96+80+2*144+48+160+2*240+224+176+320+176+80+128+368+304+192)/20
      // = 174.4 gCOD
      // mittlere mol C = (3+6+2*4+3+2*5+2+4*6+5+9+5+3+4+11+9+5) / 20 = 5.35 mol C
      // 5.35 mol C / 174.4 gCOD = 0.0307 mol C / gCOD
      p_const[5]= 0.03;  

      // fFA_Xli fraction Sfa from Xli [-]  
      p_const[6]= 0.95;        

      // C_Sfa Carbon content Sfa [k mole C/kg COD] (Quelle S. 25)
      // Gesamte CSB von den 3 Fettsäuren Palmitin-, Öl-, Stearinsäure beträgt:
      // 2384 gCOD
      // die Säuren enthalten in Summe: 16 + 18 + 18 mol C = 52 mol C
      // 52 mol C / 2384 gCOD = 0.0218 mol C / gCOD
      p_const[7]= 0.0217;

      // fH2_SU - [-]    
      // Berechnung der nächsten vier Parameter s. S. 27, es gibt leichte
      // Abweichungen zu den berechneten Werten
      p_const[8]= 0.19;

      // fBU_SU - [-] 
      p_const[9]= 0.13;

      // fPRO_SU - [-]   
      p_const[10]= 0.27; 

      // dummy_fAC_SU residual to 1 [-]  
      p_const[11]= 0.41;        

      // N_XB N content Biomass [k mole N/kg CSB] 
      // Biomasse (Quelle s. ADM1 report S. 8, passt nicht ganz der Wert)
      p_const[12]= 0.08/14;                 

      // C_Sbu C content Sbu [k mole C/kg COD]
      // Buttersäure C_3H_7COOH
      // 1 mol Bu = 160 gCOD/mol
      // 1 mol Bu = 4 mol C
      // 4 mol C / 160 gCOD = 0.025 molC / gCOD
      p_const[13]= 0.025;    

      // C_Spro C content Spro [k mole C/kg COD] 
      // Propionsäure C_2H_5COOH
      // 1 mol Pro = 112 gCOD/mol
      // 1 mol Pro = 3 mol C
      // 3 mol C / 112 gCOD = 0.0268 molC / gCOD
      p_const[14]= 0.0268;                           

      // C_Sac C content Sac [k mole C/kg COD]
      // Essigsäure CH_3COOH
      // 1 mol Ac = 64 gCOD/mol
      // 1 mol Ac = 2 mol C
      // 2 mol C / 64 gCOD = 0.0313 molC / gCOD
      p_const[15]= 0.0313;  

      // C_XB C content biomass [k mole C/kg COD] (Quelle s. ADM1 report S. 8)
      p_const[16]= 0.0313;                          

      // fH2_AA - [-] 
      // Berechnung der nächsten fünf Parameter s. S. 27
      p_const[17]= 0.06;      

      // fVA_AA - [-]   
      p_const[18]= 0.23;          

      // fBU_AA - [-]   
      p_const[19]= 0.26;      

      // fPRO_AA - [-]    
      p_const[20]= 0.05;

      // dummy_fAC_AA residual to 1 [-]   
      p_const[21]= 0.4;        

      // C_Sva C content Sva [k mole C / kg COD]
      // Valeriansäure C_4H_9COOH
      // 1 mol Va = 208 gCOD/mol
      // 1 mol Va = 5 mol C
      // 5 mol C / 208 gCOD = 0.024 molC / gCOD
      p_const[22]= 0.024;                          

      // fH2_FA - [-] 
      // Berechnung siehe S. 25       
      p_const[23]= 0.3;                           

      // fH2_VA - [-]  
      // Berechnung siehe S. 24
      p_const[24]= 0.15;

      // fPRO_VA - [-] 
      // Berechnung siehe S. 24
      p_const[25]= 0.54;         

      // fH2_BU - [-]  
      // Berechnung siehe S. 24
      p_const[26]= 0.2;                            

      // fH2_PRO - [-]
      // Berechnung siehe S. 24
      p_const[27]= 0.43;                           

      // C_Sch4 C content Sch4 [k mole C/kg COD]
      // Methan CH_4
      // 1 mol Ch4 = 64 gCOD/mol
      // 1 mol ch4 = 1 mol C
      // 1 mol C / 64 gCOD = 0.0156 molC / gCOD
      p_const[28]= 0.0156;                         

      // Kw - [-]    
      //
      // Berechnung: exp ( 55900 / ( R * 100) * ( 1 / T_base - 1 / T_op ) ) * 10^{-14}
      // T_base= 298.15 K
      // R= 0.083145
      // T_op= T + 273.15;
      // bei 40 °C stimmt der Wert offensichtlich nicht genau, genau wäre 2.94 *
      // 10^-14
      p_const[29]= 2.08e-14;                       

      // Kava , 10^-4.86 [k mole /m3]   
      p_const[30]= 1.38e-5;   

      // Kabu , 10^-4.82 [-] 
      p_const[31]= 1.51e-5;          

      // Kapro , 10^-4.88 [-]   
      p_const[32]= 1.32e-5;          

      // Kaac , 10^-4.76 [-]   
      p_const[33]= 1.74e-5; 

      // Kaco2 10^-6.35*exp(7646/(R*100)*(1/Tbase - 1/T)) [-]
      p_const[34]= 4.94e-7;  
      //Kaco2= 5.94e-7;  

      // Kain 10^-9.25*exp(51965/(R*100)*(1/Tbase - 1/T)) [-]  
      p_const[35]= 1.11e-9;                             

      // kA_Bva rate coefficient for acid-base (valerate) [k mole/d]
      p_const[36]= 1e8;                            

      // kA_Bbu - [-]       
      p_const[37]= 1e8;                                                                    

      // kA_Bpro - [-]      
      p_const[38]= 1e8;                                                                    

      // kA_Bac - [-]     
      p_const[39]= 1e8;                                                                      

      // kA_Bco2 - [-]    
      p_const[40]= 1e8;                                                                      

      // kA_Bin - [-]          
      p_const[41]= 1e8;                                                                        

      // klaH2 - [-]    
      // Gas-liquid transfer coefficient for H2 [200]
      p_const[42]= 200;                                                                        

      // klaCH4 - [-] 
      // Gas-liquid transfer coefficient for CH4 [200]
      p_const[43]= 200;                                                                          

      // klaCO2 - [-] 
      // Gas-liquid transfer coefficient for CO2 [200]
      p_const[44]= 200;                                                                          

      // KH_CO2 Henry constant [mol/bar m^3]  
      // in 06 Aspects on ADM1 Implementation within the BSM2 Framework.pdf gibt
      // es für die nächsten 3 Parameter andere Gleichungen, allerdings auch
      // andere Einheiten
      //
      // TODO, added 5
      p_const[45]= 1/(0.0271*0.08314*(T+273.15));                        

      // KH_CH4 Henry constant [mol/bar m^3] 
      p_const[46]= 1/(0.00116*0.08314*(T+273.15));                        

      // KH_H2 Henry constant [mol/bar m^3] 
      p_const[47]= 1/(7.38e-4*0.08314*(T+273.15));    

      return p_const;
    }



  }
}


