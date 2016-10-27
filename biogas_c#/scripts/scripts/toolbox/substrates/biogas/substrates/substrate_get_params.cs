/**
 * This file is part of the partial class substrate and defines
 * public methods used to get the substrates parameters.
 * 
 * TODOs:
 * - 
 * 
 * Apart from that FINISHED!
 * 
 */

using System;
using System.Collections.Generic;
using System.Text;
using science;
using toolbox;
using System.Xml;
using System.IO;

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
  /// Defines the physicochemical characteristics of a substrate used on biogas plants.
  /// </summary>
  public partial class substrate : set_get_interface
  {

    // -------------------------------------------------------------------------------------
    //                              !!! PUBLIC GET METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// Returns the index of the substrate_class in the classes list.
    /// The returned index is 1-based: 1,2,3,...
    /// </summary>
    /// <param name="substrate_class">e.g. maize, manure, grass, ...
    /// seit dem EEG 2012 sind Substratklassen anders bezeichnet</param>
    /// <returns>index</returns>
    public static int getIndexOfSubstrateClass(string substrate_class)
    {
      int index= 0;

      for (index= 0; index < classes.Count; index++)
      {
        if ( classes[index] == substrate_class)
          return index + 1;
      }

      return index + 1;
    }

    /// <summary>
    /// Returns the variable specified by symbol out of the given substrate as object
    /// </summary>
    /// <param name="mySubstrate">a substrate</param>
    /// <param name="variable">object</param>
    /// <param name="symbol">"RF"</param>
    /// <exception cref="exception">Unknown parameter</exception>
    public static void get_params_of(substrate mySubstrate,
                                     out object variable, string symbol)
    {
      object[] variables;
      string[] symbols= { symbol };

      mySubstrate.get_params_of(out variables, symbols);

      variable= variables[0];
    }
    
    /// <summary>
    /// Returns variables as objects. 
    /// Syntax: get_params_of("RF", "RL")
    /// </summary>
    /// <param name="variables">values</param>
    /// <param name="symbols">"RF", "RL"</param>
    /// <exception cref="exception">Unknown parameter</exception>
    /// <exception cref="exception">No input argument</exception>
    public override void get_params_of(out object[] variables, params string[] symbols)
    {
      int nargin= symbols.Length;

      if (nargin > 0)
      {
        variables= new object[nargin];

        for (int iarg= 0; iarg < nargin; iarg++)
        {
          switch( symbols[iarg] )
          {
            case "id":
              variables[iarg]= this.id;
              break;
            case "name":                    // name of substrate
              variables[iarg]= this.name;
              break;
            case "RF":                      // raw fiber (Rohfaser) [% TS]
              variables[iarg]= this.Weender.RF;
              break;
            case "RP":
              variables[iarg]= this.Weender.RP;
              break;
            case "RL":
              variables[iarg]= this.Weender.RL;
              break;
            case "NfE":   // kann man ohne RF nicht berechnen
              variables[iarg]= calcNfE();
              break;
            case "NDF":
              variables[iarg]= this.Weender.NDF;
              break;
            case "ADF":
              variables[iarg]= this.Weender.ADF;
              break;
            case "ADL":
              variables[iarg]= this.Weender.ADL;
              break;
            case "HemCell":
              variables[iarg]= calcHemCell();
              break;
            case "Cell":
              variables[iarg]= calcCell();
              break;
            case "NFC":
              variables[iarg]= calcNFC();
              break;
            case "TKN":
              variables[iarg]= calcTKN();
              break;

            //case "COD":
            //  variables[iarg]= this.Phys.COD;
            //  break;
            case "COD_S":   // COD of filtrate
              variables[iarg]= this.Phys.COD_S;
              break;
            case "SIin":   // COD of soluble inerts
              variables[iarg] = this.Phys.SIin;
              break;
            case "Xc":   // Xc of substrate, this is particulate COD
              variables[iarg] = calcXc();
              break;
            case "COD_SX":   // particulate disintegrated COD COD_SX= COD_S - soluble COD
              variables[iarg] = calcCOD_SX();
              break;
            case "Xbacteria":   // biomass of hydrolysis, acidogenesis, acetogenesis
              variables[iarg] = calcXbacteria();
              break;
            case "Xmethan":   // biomass of methanogenesis
              variables[iarg] = calcXmethan();
              break;
            case "XcIN":   // XcIN of substrate
              variables[iarg] = calcXcIN();
              break;

            //case "aScod":
            //  variables[iarg]= calc_aScod();
            //  break;

            case "c_th":
              variables[iarg]= calcSpecificHeat();//this.Phys.c_th;
              break;

            case "pH":
              variables[iarg]= this.Phys.pH;
              break;

            case "rho":
              variables[iarg]= calcDensity();//this.Phys.rho;
              break;

              // TODO - man könnte noch um Shac etc. erweitern, dazu Methoden schreiben
              // calcShac()
            case "Sac":
              variables[iarg]= this.Phys.Sac;
              break;
            case "Sac_":
              variables[iarg] = calcSac_();
              break;
            case "Sbu":
              variables[iarg]= this.Phys.Sbu;
              break;
            case "Sbu_":
              variables[iarg] = calcSbu_();
              break;
            case "Spro":
              variables[iarg]= this.Phys.Spro;
              break;
            case "Spro_":
              variables[iarg] = calcSpro_();
              break;
            case "Sva":
              variables[iarg]= this.Phys.Sva;
              break;
            case "Sva_":
              variables[iarg] = calcSva_();
              break;

            case "Svfa":        // total concentration of volatile fatty acids [g/l]
              variables[iarg]= calcVFA();
              break;

            case "C":
              variables[iarg]= calcC();
              break;
            case "N":
              variables[iarg] = calcN();
              break;
            case "C/N":
              variables[iarg]= calcCtoNratio();
              break;

            case "Snh4":
              variables[iarg]= this.Phys.Snh4;
              break;
            case "Snh3":
              variables[iarg]= calcSnh3();
              break;
            case "TAC":
              variables[iarg]= this.Phys.TAC;
              break;
            case "Shco3":
              variables[iarg] = calcShco3();
              break;
            case "Sco2":
              variables[iarg] = calcSco2();
              break;

              // TODO, vielleicht mal auf was anderes als wie 0 setzen
              // d.h. als Substratparameter definieren
            case "San":       // anions, wird bei Shco3 Berechnung benötigt
              variables[iarg] = new physValue("San", 0, "kmol/m^3", "anions");
              break;
            case "Scat":       // cations, wird bei Shco3 Berechnung benötigt
              variables[iarg] = new physValue("Scat", 0, "kmol/m^3", "cations");
              break;

            case "T":
              variables[iarg]= this.Phys.T;
              break;

            case "TS":
              variables[iarg]= this.Phys.TS;
              break;
            case "VS":
              variables[iarg]= this.Phys.VS;
              break;

            case "D_VS":
              variables[iarg]= this.Phys.D_VS;
              break;
            case "d":
              variables[iarg] = calc_d();
              break;

            case "Ash":
              variables[iarg]= calcAsh();
              break;
            case "Water":
              variables[iarg]= calcWater();
              break;

            case "ThOD":
              variables[iarg]= calcTheoreticalOxygenDemand();
              break;
            case "BMP":
              variables[iarg]= calcBMP();
              break;

            case "fCh_Xc":
              variables[iarg]= calcfCh_Xc();
              break;
            case "fPr_Xc":
              variables[iarg]= calcfPr_Xc();
              break;
            case "fLi_Xc":
              variables[iarg]= calcfLi_Xc();
              break;
            case "fXI_Xc":
              variables[iarg]= calcfXI_Xc();
              break;
            case "fSI_Xc":
              variables[iarg]= calcfSI_Xc();
              break;
            case "fXp_Xc":
              variables[iarg]= calcfXp_Xc();
              break;

            case "fSIN_Xc":
              variables[iarg] = calcfSIN_Xc();
              break;
            
            case "cost":
              variables[iarg]= this.cost;
              break;
            case "age":
              variables[iarg] = this.age;
              break;

            case "substrate_class":
              variables[iarg]= this.substrate_class;
              break;

            case "kdis":
              variables[iarg] = this.AD.kdis;
              break;
            case "khyd_ch":
              variables[iarg] = this.AD.khyd_ch;
              break;
            case "khyd_pr":
              variables[iarg] = this.AD.khyd_pr;
              break;
            case "khyd_li":
              variables[iarg] = this.AD.khyd_li;
              break;
            case "km_c4":
              variables[iarg] = this.AD.km_c4;
              break;
            case "km_pro":
              variables[iarg] = this.AD.km_pro;
              break;
            case "km_ac":
              variables[iarg] = this.AD.km_ac;
              break;
            case "km_h2":
              variables[iarg] = this.AD.km_h2;
              break;

            default:
              throw new exception(String.Format("Unknown parameter: {0}!", symbols[iarg]));
          }
        }
      }
      else
        throw new exception("You did not give an argument!");
    }



  }
}


