/**
 * This file is part of the partial class substrate and defines
 * public methods used to set the substrates parameters.
 * 
 * TODOs:
 * - think about set_params_of(params object[] symbols), because values are set
 * directly, there can come a confusion with the unit. The user has to make
 * sure, that the value he wants to set is measured in the unit, the physValue
 * is saved in the object. Therefore see: init_params_of(params double[] values)
 * - 
 * 
 * Except of that not FINISHED!
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
    //                              !!! PUBLIC SET METHODS !!!
    // -------------------------------------------------------------------------------------
    
    /// <summary>
    /// Set a double value, static method.
    /// Used to set the value of physValues as well, so make sure that
    /// the value you want to set is measured in the unit in which the
    /// physValue is saved in the object. 
    /// Therefore see: init_params_of(params double[] values)
    /// </summary>
    /// <param name="mySubstrate">a substrate</param>
    /// <param name="symbol">"RF"</param>
    /// <param name="value">double value</param>
    /// <exception cref="exception">Unknown parameter</exception>
    public static void set_params_of(substrate mySubstrate, string symbol, double value)
    {
      object[] values= { symbol, value };

      mySubstrate.set_params_of(values);
    }
    
    /// <summary>
    /// Set params of substrate. Syntax: set_params_of( "RF", 5, "RP", 10.3, ... ).
    /// Used to set the value of physValues as well, so make sure that
    /// the value you want to set is measured in the unit in which the
    /// physValue is saved in the object. 
    /// Therefore see: init_params_of(params double[] values)
    /// </summary>
    /// <param name="symbols">"RF", 5, "RP", 10.3, ...</param>
    /// <exception cref="exception">Unknown parameter</exception>
    public override void set_params_of(params object[] symbols)
    {
      for (int iarg= 0; iarg < symbols.Length; iarg= iarg + 2)
      {
        switch ( (string)symbols[iarg] )
        {
          case "id":
            this._id=   (string)symbols[iarg + 1];
            break;
          case "name":
            this._name= (string)symbols[iarg + 1];
            break;

          case "RF":                // raw fiber (Rohfaser) [% TS]
            // TODO: evtl. auch physValue anbieten?
            this.Weender.RF.Value = (double)symbols[iarg + 1];

            // TODO - da NDF ein gemessener Parameter ist, nicht einfach begrenzen
            // if RF is changed during simulation, check if NDF is small enough
            // such that NFC is > 0, ITS OK
            this.Weender.NDF.Value = boundNDF().Value;

            break;
          case "RP":                // raw protein (Rohprotein) [% TS]
            this.Weender.RP.Value=  (double)symbols[iarg + 1];
            break;
          case "RL":                // raw lipids (Rohfett) [% TS]
            this.Weender.RL.Value=  (double)symbols[iarg + 1];
            break;
          case "NDF":               // neutral detergent fiber [% TS]
            this.Weender.NDF.Value= (double)symbols[iarg + 1];
            break;
          case "ADF":               // acid detergent fiber [% TS]
            this.Weender.ADF.Value= (double)symbols[iarg + 1];
            break;
          case "ADL":               // acid detergent lignin [% TS]
            this.Weender.ADL.Value= (double)symbols[iarg + 1];
            break;

          //case "COD":               // total COD [gCOD/l]
          //  this.Phys.COD.Value=    (double)symbols[iarg + 1];
          //  break;
          case "COD_S":             // COD of filtrate [gCOD/l]
            this.Phys.COD_S.Value=  (double)symbols[iarg + 1];
            break;
          case "SIin":             // COD of soluble inerts [gCOD/l]
            this.Phys.SIin.Value = (double)symbols[iarg + 1];
            break;

          //case "c_th":              // specific heat capacity (specific heat) [kWh/(m^3 * K)]
          //  this.Phys.c_th.Value=   (double)symbols[iarg + 1];
          //  break;
          case "pH":                // pH value [-]
            this.Phys.pH.Value=     (double)symbols[iarg + 1];
            break;
          //case "rho":               // density of fresh matter [kg/m^3]
          //  this.Phys.rho.Value=    (double)symbols[iarg + 1];
          //  break;

          case "Sac":               // concentration of acetic acid + acetate [g/l]
            this.Phys.Sac.Value=    (double)symbols[iarg + 1];
            break;
          case "Sbu":               // concentration of butyric acid + butyrate [g/l]
            this.Phys.Sbu.Value=    (double)symbols[iarg + 1];
            break;
          case "Spro":              // concentration of propionic acid + propionate [g/l]
            this.Phys.Spro.Value=   (double)symbols[iarg + 1];
            break;
          case "Sva":               // concentration of valeric acid + valerate [g/l]
            this.Phys.Sva.Value=    (double)symbols[iarg + 1];
            break;

          case "Snh4":              // ammonium nitrogen [g/l]
            this.Phys.Snh4.Value=   (double)symbols[iarg + 1];
            break;
            // Total alkalinity, TODO: sollte man in TA umbenennen
          case "TAC":               // total alcalic carbonate [mmol/l]
            // mg/l CaCO3 (amerikanische Einheit). SI-Einheit: mmol/l. 
            //
            // http://de.wikipedia.org/wiki/Schwimmbecken#Alkalit.C3.A4t
            //
            this.Phys.TAC.Value=    (double)symbols[iarg + 1];
            break;

          case "T":                 // temperature of substrate [°C]
            this.Phys.T.Value=      (double)symbols[iarg + 1];
            break;

            // TODO: löschen
          //case "C":                 // total C in g/kg
          //  this.Phys.C.Value=      (double)symbols[iarg + 1];
          //  break;
          //  // TODO: löschen
          //case "N":                 // total N in g/kg
          //  this.Phys.N.Value=      (double)symbols[iarg + 1];
          //  break;

          case "TS":                // total solids [% FM]
            this.Phys.TS.Value=     (double)symbols[iarg + 1];
            break;
          case "VS":                // volatile solids [% TS]
            this.Phys.VS.Value=     (double)symbols[iarg + 1];

            // if VS is changed during simulation, check if NDF is small enough
            // such that NFC is > 0
            // TODO: da NDF ein gemessener Parameter ist, sollte man den nicht einfach
            // ändern können, die Funktion is OK
            // TODO: who unbounds NDF again? when restriction is not valid (active) anymore. no one!
            // this is a problem!
            this.Weender.NDF.Value= boundNDF().Value;

            // TODO: who unbounds ADL again? when restriction is not valid (active) anymore. no one!
            // this is a problem!
            this.Weender.ADL.Value = boundADL().Value;

            break;

          case "D_VS":              // degradation level (of volatile solids) [100 %]
                                    // 0 <= D_VS <= 1, e.g. D_VS= 0.6 or 0.7
            this.Phys.D_VS.Value=   (double)symbols[iarg + 1];
            break;

          case "cost":              // costs of substrate [€/m³]
            this.cost.Value=        (double)symbols[iarg + 1];
            break;

          case "age":              // age of substrate [d]
            this.age.Value = (double)symbols[iarg + 1];
            break;

          case "substrate_class":   // manure, maize, gps, grass, cereals, ...
            this.substrate_class=   (string)symbols[iarg + 1];
            break;

          case "kdis":              // disintegration rate [1/d]
            this.AD.kdis.Value=     (double)symbols[iarg + 1];
            break;

          case "khyd_ch":           // hydrolysis rate carbohydrates [1/d]
            this.AD.khyd_ch.Value=  (double)symbols[iarg + 1];
            break;
          case "khyd_pr":           // hydrolysis rate proteins [1/d]
            this.AD.khyd_pr.Value=  (double)symbols[iarg + 1];
            break;
          case "khyd_li":           // hydrolysis rate lipids [1/d]
            this.AD.khyd_li.Value=  (double)symbols[iarg + 1];
            break;

          case "km_c4":           // max. uptake rate [1/d]
            this.AD.km_c4.Value = (double)symbols[iarg + 1];
            break;
          case "km_pro":           // max. uptake rate [1/d]
            this.AD.km_pro.Value = (double)symbols[iarg + 1];
            break;
          case "km_ac":           // max. uptake rate [1/d]
            this.AD.km_ac.Value = (double)symbols[iarg + 1];
            break;
          case "km_h2":           // max. uptake rate [1/d]
            this.AD.km_h2.Value = (double)symbols[iarg + 1];
            break;

          default:
            throw new exception(String.Format("set_params: Unknown parameter: {0}!",
                                              (string)symbols[iarg]));
        }
      }
    }

    

  }
}


