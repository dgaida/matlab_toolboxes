/**
 * This file defines private methods for the partial class ADM.
 * 
 * TODOs:
 * - maybe add further private methods
 * 
 * Except for that FINISHED!
 * 
 */

using System;
using System.Collections.Generic;
using System.Text;
using toolbox;

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
  /// Class defining the Anaerobic Digestion Model
  /// 
  /// At the moment is defines two things:
  /// - the ADM parameters
  /// - handle of the MATLAB gui for the ADM block
  /// 
  /// TODO:
  /// Using the child class ADM1DE different ADM models should
  /// be implementable, but this won't work, because in ADMstate
  /// static properties such as dim_state, dim_stream are defined,
  /// which cannot be overwritten. We need the static props in MATLAB.
  /// 
  /// </summary>
  public partial class ADM
  {

    // -------------------------------------------------------------------------------------
    //                            !!! PRIVATE METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// Set default values of ADM parameters
    /// </summary>
    /// <param name="T">digester temperature in °C</param>
    private void setDefaultParams(double T)
    {
      // get constant ADM params
      double[] pconst= ADMparams.getConstParams(T);

      double[] p= {                                        
      // Die folgenden 6 Parameter sind variabel, sowie variabel auch über
      // den Simulationszeitraum, falls mit nicht konstanter Substratzufuhr
      // simuliert wird
      0.1,                         //fSI_XC fraction SI from XC [-]                             
      0.15,                         //dummy_fXI_XC - [-]                                         
      0.2,                         //fCH_XC fraction Xch from XC [-]    0.2                        
      0.2,                         //fPR_XC fraction Xpr from XC [-]    0.2                        
      0.3,                         //fLI_XC fraction Xli from XC [-]    0.3                        
      0.05,                         //fXP_XC fraction Xp from XC [-]     
      //
      // Dieser Parameter N_Xc müsste auch von Substrat abhängen, also variabel,
      // variabel
      0.0376/14,                      //N_Xc N content Xc [k mole N/kg COD]   
      // variabel, aber konstant über Simulationszeitraum, evtl. in Optimierung
      // mit rein nehmen
      0.06/14,                        //N_I Nitrogen content inerts [k mole N/kg COD]              
      pconst[0], //0.098/14,           //N_aa N content proteins [k mole N/kg COD]   
      // Dieser Parameter C_Xc müsste auch von Substrat abhängen, also variabel,
      // variabel
      0.03,                           //C_Xc C content Xc [k mole C/kg COD]    
      // variabel, aber konstant über Simulationszeitraum, evtl. in Optimierung
      // mit rein nehmen
      0.03,                           //C_SI C content SI [k mole C/kg COD]                        
      pconst[1], //0.0313,             //C_Xch C content Xch [k mole C/kg COD]                      
      pconst[2], //0.03,               //C_Xpr C content Xpr [k mole C/kg COD]                      
      pconst[3], //0.022,              //C_Xli C content Xli [k mole C/ kg COD]  
      // variabel, aber konstant über Simulationszeitraum, evtl. in Optimierung
      // mit rein nehmen
      0.03,                           //C_XI C content XI [k mole C/ kg COD]                       
      pconst[4], //0.313,              //dummy_C_su equal to C_Xch [-]                              
      pconst[5], //0.03,               //dummy_Caa equal to C_Xpr [-]                               
      pconst[6], //0.95,               //fFA_Xli fraction Sfa from Xli [-]                          
      pconst[7], //0.0217,             //C_Sfa Carbon content Sfa [k mole C/kg COD]                 
      pconst[8], //0.19,               //fH2_SU - [-]                                               
      pconst[9], //0.13,              //fBU_SU - [-]                                               
      pconst[10], //0.27,              //fPRO_SU - [-]                                              
      pconst[11], //0.41,              //dummy_fAC_SU residual to 1 [-]                             
      pconst[12], //0.08/14,           //N_XB N content Biomass [k mole N/kg CSB]                   
      pconst[13], //0.025,             //C_Sbu C content Sbu [k mole C/kg COD]                      
      pconst[14], //0.0268,            //C_Spro C content Spro [k mole C/kg COD]                    
      pconst[15], //0.0313,            //C_Sac C content Sac [k mole C/kg COD]                      
      pconst[16], //0.0313,            //C_XB C content biomass [k mole C/kg COD]
      // variabel, aber konstant über Simulationszeitraum, evtl. in Optimierung
      // mit rein nehmen
      0.1,                            //Ysu Yield uptake sugars [-]                                
      pconst[17], //0.06,              //fH2_AA - [-]                                               
      pconst[18], //0.23,              //fVA_AA - [-]                                               
      pconst[19], //0.26,              //fBU_AA - [-]                                               
      pconst[20], //0.05,              //fPRO_AA - [-]                                              
      pconst[21], //0.4,               //dummy_fAC_AA residual to 1 [-]                             
      pconst[22], //0.024,             //C_Sva C content Sva [k mole C / kg COD]  
      // variabel, aber konstant über Simulationszeitraum, evtl. in Optimierung
      // mit rein nehmen
      0.08,                           //Yaa Yield uptake amino acids [-]                           
      pconst[23], //0.3,               //fH2_FA - [-]              
      // variabel, aber konstant über Simulationszeitraum, evtl. in Optimierung
      // mit rein nehmen
      0.06,                           //Yfa Yield uptake LCFA [-]                                  
      pconst[24], //0.15,              //fH2_VA - [-]                                               
      pconst[25], //0.54,              //fPRO_VA - [-]                                              
      pconst[26], //0.2,               //fH2_BU - [-]   
      // variabel, aber konstant über Simulationszeitraum, evtl. in Optimierung
      // mit rein nehmen
      0.06,                           //Yc4 Yield uptake of buterate and valerate [-]              
      pconst[27], //0.43,              //fH2_PRO - [-]     
      // variabel, aber konstant über Simulationszeitraum, evtl. in Optimierung
      // mit rein nehmen
      0.04,                           //Ypro Yield uptake propionate [-]                           
      pconst[28], //0.0156,            //C_Sch4 C content Sch4 [k mole C/kg COD]   
      // variabel, aber konstant über Simulationszeitraum, evtl. in Optimierung
      // mit rein nehmen
      0.05,                           //Yac Yield uptake acetate [-]    
      // variabel, aber konstant über Simulationszeitraum, evtl. in Optimierung
      // mit rein nehmen
      //0.10,//TODO: default ist 0.06, warum 0.10???
      0.06,   //default                        //Yh2 Yield uptake hydrogen [-]  
      //
      //
      //// TODO
      // Hydrolysis- und Disintegrationsraten hängen von den genutzten Substraten
      // ab, diese sollten mindestens als Mittelwert über die verwendeten
      // Substrate bestimmt werden. Bei sehr unterschiedlichen Substraten ist die
      // Mittelwertbildung dennoch sehr abenteuerlich. Deshalb sollte man evtl.
      // langsam abbaubare Kohlenhydrate mit in den Zustandsvektor aufnehmen
      // (Cellulose] und damit zwischen schnell und langsam abbaubaren
      // kohlenhydraten unterscheiden
      //
      // die nächsten 4 sind
      // variabel, aber konstant über Simulationszeitraum, evtl. in Optimierung
      // mit rein nehmen
      //// TODO
      // parameter sind abhängig von substrat und damit substratgemisch, d.h. die
      // parameter sind eenfalls variable über simulationszeitraum, falls sich das
      // substratgemisch ändert. hier müssten die mittelwerte der substrate
      // berechnet werden, und bei optimierung müste parameter des substrats
      // optimiert werden und nicht der mittelwert, da substrat bei
      // parameteroptimierung variiert. die vier substrate befinden sich in der
      // substratdatenbank
      0.25,//p_opt.(fermenter_id](1,1],       //kdis disintegration rate [1/d]  
      //p_opt.kdis,//0.25,//0.25                      //kdis disintegration rate [1/d] 
      10,//p_opt.(fermenter_id](2,1],      //khyd_ch
      //p_opt.khyd_ch,//10,             //khyd_ch Hydrolysis rate carbohydrates [1/d]  
      10,//p_opt.(fermenter_id](3,1],      //khyd_pr
      //p_opt.khyd_pr,//10,             //khyd_pr hydrolysis rate propionate [1/d]    
      10,//p_opt.(fermenter_id](4,1],      //khyd_li
      //p_opt.khyd_li,//10,             //khyd_li hydrolysis rate lipids [1/d]    
      //
      //
      ////
      // die nächsten 12 sind
      // variabel, aber konstant über Simulationszeitraum, evtl. in Optimierung
      // mit rein nehmen
      1e-4,                           //KS_IN half saturation coefficient inorganic N [k mole N/m3]
      30,                             //km_su Uptake rate sugars [1/d]                             
      0.5,                            //KS_su half saturation constant substate [kg COD/m3]        
      5.5,                            //pHUL_a upper pH limit for p5..10 [-]                       
      4,                              //pHLL_a lower pH limit for p5..10 [-]                       
      50,                             //km_aa max. uptake rate amino acids [1/d]                   
      0.3,                            //KS_aa half saturation coefficient amino acids [kg COD/ m3] 
      6,                              //km_fa max. uptake rate Sfa [1/d]                           
      0.4,                            //KS_fa half saturation coeff. Sfa [kg COD/m3]               
      5e-6,                           //KI_H2_fa half sat. coeff. H2 for p7 [kg COD/m3]            
      20,//p_opt.(fermenter_id](9,1],  //20,  //km_c4 max. uptake rate valerate and butyrate [1/d]         
      //TODO: default: 0.2, warum 0.3???, Quelle ist unten gegeben, also ok
      0.3,//p_opt.(fermenter_id](10,1], //0.3, //KS_c4 
      //
      ////
      // alle weiteren variablen sind
      // variabel, aber konstant über Simulationszeitraum, evtl. in Optimierung
      // mit rein nehmen
      //
      ////
      // Quelle: Eignung des Anaerobic Digestion Model No.1 (ADM 1] zur
      // Prozesssteuerung landwirtschaftlicher Biogasanlagen, Gülzower Gespräche
      //
      //0.2,                           //KS_c4 half. sat. coeff. valerate and butyrate [kg COD/m3]  
      1e-5,//p_opt.(fermenter_id](16,1], //1e-5, //KI_H2_c4 half. sat. coeff. H2 for p8,9 [kg COD/m3]         
      13,//p_opt.(fermenter_id](5,1],  //4,  //km_pro Maissilage
      // Quelle: Eignung des Anaerobic Digestion Model No.1 (ADM 1] zur
      // Prozesssteuerung landwirtschaftlicher Biogasanlagen, Gülzower Gespräche
      //
      //13,                            //km_pro max. uptake rate propionate [1/d]                   
      0.1,//p_opt.(fermenter_id](6,1],      //0.1,    //KS_pro half sat. coeff. propionate [kg COD/m3]             
      3.5e-6,//p_opt.(fermenter_id](15,1],     //3.5e-6, //KI_H2_pro half sat. coeff. H2 in p10 [kg COD/m3]           
      //4.1,                           //km_ac Maissilage
      8,//p_opt.(fermenter_id](7,1],      //km_ac Maissilage + Rindergülle (Mittelwert]
      // Quelle: Eignung des Anaerobic Digestion Model No.1 (ADM 1] zur
      // Prozesssteuerung landwirtschaftlicher Biogasanlagen, Gülzower Gespräche
      //
      //8,                             //km_ac max. uptake rate acetate [1/d]                       
      0.15,//p_opt.(fermenter_id](8,1],      //0.15, //KS_ac half sat. coeff. acetate [kg COD/m3]                 
      //...//0.0018,                         //KI_NH3 half. sat. coeeff. NH3 in p11 [k mole N/m3] 
      0.002,//p_opt.(fermenter_id](17,1],     //0.002, // KI_NH3 
      // Quelle: 
      // 09 monofermentation of grass silage under mesophilic conditions -
      // measurements and mathematical modeling with adm 1.pdf
      // 
      7,//p_opt.(fermenter_id](18,1],     //7, //pHUL_ac upper pH limit p11 [-]                             
      6,//p_opt.(fermenter_id](19,1],     //6, //pHLL_ac lower pH limit for p11 [-]                         
      35, //65 - für 65 habe ich keine Quelle, //5                             //km_h2 Maissilage
      // Quelle: Eignung des Anaerobic Digestion Model No.1 (ADM 1] zur
      // Prozesssteuerung landwirtschaftlicher Biogasanlagen, Gülzower Gespräche
      //
      //35,                            //km_h2 max. uptake rate hydrogen [-]                        
      7e-6,//p_opt.(fermenter_id](14,1],     //7e-6, //KS_h2 half sat. coeff. H2 for p12 [kg COD/m3]              
      6,                              //pHUL_h2 upper pH limit p12 [-]                             
      5,                              //pHLL_h2 lower pH limit p12 [-]                             
      0.02,//p_opt.(fermenter_id](11,1],     //0.02, //kdec_Xsu decay rate Xsu [1/d]                              
      0.02,                           //kdec_Xaa decay rate Xaa [1/d]                              
      0.02,                           //kdec_Xfa decay rate Xfa [1/d]                              
      0.02,                           //kdec_Xc4 decay rate  Xc4 [1/d]                             
      0.02,                           //kdec_Xpro decay rate Xpro [1/d]                            
      0.02,//p_opt.(fermenter_id](12,1],     //0.02, //kdec_Xac decay rate Xac [1/d]                              
      0.02,//p_opt.(fermenter_id](13,1],     //0.02, //kdec_Xh2 decay rate Xh2 [1/d]                              
      pconst[29], //2.08e-14,          //Kw - [-]                                                   
      pconst[30], //1.38e-5,           //Kava , 10^-4.86 [k mole /m3]                               
      pconst[31], //1.51e-5,           //Kabu , 10^-4.82 [-]                                        
      pconst[32], //1.32e-5,           //Kapro , 10^-4.88 [-]                                       
      pconst[33], //1.74e-5,           //Kaac , 10^-4.76 [-]                                        
      pconst[34], //4.94e-7,           //Kaco2 10^-6.35*exp(7646/(R*100]*(1/Tbase - 1/T]] [-]       
      pconst[35], //1.11e-9,           //Kain 10^-9.25*exp(51965/(R*100]*(1/Tbase - 1/T]] [-]       
      pconst[36], //1e8,               //kA_Bva rate coefficient for acid-base (valerate] [k mole/d]
      pconst[37], //1e8,               //kA_Bbu - [-]                                               
      pconst[38], //1e8,               //kA_Bpro - [-]                                              
      pconst[39], //1e8,               //kA_Bac - [-]                                               
      pconst[40], //1e8,               //kA_Bco2 - [-]                                              
      pconst[41], //1e8,               //kA_Bin - [-]                                               
      pconst[42], //200,               //klaH2 - [-]                                                
      pconst[43], //200,               //klaCH4 - [-]                                               
      pconst[44], //200,               //klaCO2 - [-]                                               
      pconst[45], //1/(0.0271*0.08314*(T+273.15]],  //KH_CO2 Henry constant [mol/bar m^3]                        
      pconst[46], //1/(0.00116*0.08314*(T+273.15]], //KH_CH4 Henry constant [mol/bar m^3]                        
      pconst[47], //1/(7.38e-4*0.08314*(T+273.15]], //KH_H2 Henry constant [mol/bar m^3]                         
      0.03,                           //C_Xp C content of XP [k mole C/ kg COD]                    
      0.06/14,                        //N_Xp N content of Xp [k mole N/kg COD]                     
      0.08};                          //fP Fraction of biomass leading to particulate products [-] 

      _parameters = p;
    }



  }
}


