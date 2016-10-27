/**
 * This file is part of the partial class substrate and defines
 * private methods used for initialization.
 * 
 * TODOs:
 * 
 * 
 * FINISHED!
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
  public partial class substrate
  {
    
    // -------------------------------------------------------------------------------------
    //                              !!! PRIVATE METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// This method defines what the units are in which the values of the params
    /// are saved in the substrate object. In this method the physValues of this class
    /// are initialized. You have to pass 28 double values. there meaning are:
    /// RF, RP, RL, NDF, ADF, ADL               6
    /// COD, COD_S, c_th, pH, rho               5
    /// Sac, Sbu, Spro, Sva, Snh4, TAC          6
    /// T, C, N, TS, VS, D_VS                   6
    /// cost, kdis, khyd_ch, khyd_pr, khyd_li   5
    /// </summary>
    /// <param name="values">must be 28 double values</param>
    /// <exception cref="exception">values.Length != 28</exception>
    private void init_params_of(params double[] values)
    {
      if (values.Length != 28)
        throw new exception(String.Format(
              "You may only call this method with 28 parameters and not with {0} parameters!",
              values.Length));

      this.Weender.RF=  new physValue("RF",      values[ 0], "% TS");
      this.Weender.RP=  new physValue("RP",      values[ 1], "% TS");
      this.Weender.RL=  new physValue("RL",      values[ 2], "% TS");
      this.Weender.NDF= new physValue("NDF",     values[ 3], "% TS");
      this.Weender.ADF= new physValue("ADF",     values[ 4], "% TS");
      this.Weender.ADL= new physValue("ADL",     values[ 5], "% TS");

      //this.Phys.COD=    new physValue("COD",     values[ 6], "gCOD/l");
      this.Phys.COD_S=  new physValue("COD_S",   values[ 7], "gCOD/l");
      this.Phys.SIin = new physValue("SIin", 0, "gCOD/l");

      //this.Phys.c_th=   new physValue("c_th",    values[ 8], "kWh/(m^3 * K)");
      this.Phys.pH=     new physValue("pH",      values[ 9], "-");
      //this.Phys.rho=    new physValue("rho",     values[10], "kg/m^3");

      this.Phys.Sac=    new physValue("Sac",     values[11], "g/l");
      this.Phys.Sbu=    new physValue("Sbu",     values[12], "g/l");
      this.Phys.Spro=   new physValue("Spro",    values[13], "g/l");
      this.Phys.Sva=    new physValue("Sva",     values[14], "g/l");

      this.Phys.Snh4=   new physValue("Snh4",    values[15], "g/l");
      this.Phys.TAC=    new physValue("TAC",     values[16], "mmol/l");

      this.Phys.T=      new physValue("T",       values[17], "°C");

      // TODO löschen
      //this.Phys.C=      new physValue("C",       values[18], "g/kg");
      //this.Phys.N=      new physValue("N",       values[19], "g/kg");

      this.Phys.TS=     new physValue("TS",      values[20], "% FM");
      this.Phys.VS=     new physValue("VS",      values[21], "% TS");

      this.Phys.D_VS=   new physValue("D_VS",    values[22], "100 %");

      this.cost=        new physValue("cost",    values[23], "€/m^3");

      this.AD.kdis=     new physValue("kdis",    values[24], "1/d");
      this.AD.khyd_ch=  new physValue("khyd_ch", values[25], "1/d");
      this.AD.khyd_pr=  new physValue("khyd_pr", values[26], "1/d");
      this.AD.khyd_li=  new physValue("khyd_li", values[27], "1/d");

      this.AD.km_c4  = new physValue("km_c4", 20, "1/d");
      this.AD.km_pro = new physValue("km_pro", 13, "1/d");
      this.AD.km_ac  = new physValue("km_ac", 8, "1/d");
      this.AD.km_h2  = new physValue("km_h2", 35, "1/d");
    }

    /// <summary>
    /// Sets substrate params to default values and calls init_params_of().
    /// After the call the physValues in the substrate object exist and 
    /// have default values.
    /// 
    /// As references see:
    /// 
    /// Koch, K., Lübken, M., Gehring, T., Wichern, M., and Horn, H.: 
    /// Biogas from grass silage – Measurements and modeling with ADM1, 
    /// Bioresource Technology 101, pp. 8158-8165, 2010.
    /// 
    /// </summary>
    /// <returns>returns true on success, else false on error</returns>
    private bool set_params_to_default()
    {
      // initialization

      double RF= 18.31;
      double RP= 8.31;
      double RL= 2.55;
      double NDF= 43.64;
      double ADF= 21.86;
      double ADL= 2.15;

      //not used double Xc= 200;
      double COD_S= 100;

      // not used anymore
      //double rho= 950;      // "kg/m^3", see in init_params_of() above

      // we assume that the substrate has the same specific heat (spezifische
      // Wärme) as water. c_water= 4.184 kJ / (kg * K) = 4.184 kWs/(kg * K)
      //
      // 4.184 kWs/(kg * K) * 1 h / 3600 s * kg/m^3= kWh/(m^3 * K)
      //
      //double c_th = 4.184 * rho / 3600;    // not used anymore
      double pH= 7;         // 

      double T= 20;         // °C

      double TS= 30;        // can be calculated out of COD
      double VS= 90;        // % TS

      double D_VS= 0.6;     // 100 %

      double cost= 10;      // €/m^3

      //

      // RF, RP, RL, NDF, ADF, ADL, ...
      // COD, COD_S, ...
      // c_th, pH, rho, ...
      // Sac, Sbu, Spro, Sva, ...
      // Snh4, TAC, T, ...
      // TS, VS, D_VS, ...
      // cost, ismanure, ...
      // kdis, khyd_ch, khyd_pr, khyd_li
      //
      double[] values= {RF, RP, RL, NDF, ADF, ADL, 
                        0, COD_S, 
                        0, pH, 0, 
                        0, 0, 0, 0, 
                        0.1, 0.1, T, 
                        0, 0,
                        TS, VS, D_VS, 
                        cost, 
                        0.25, 10, 10, 10 
                       };

      try
      {
        this.init_params_of(values);
      }
      catch(exception e)
      {
        Console.WriteLine(e.Message);

        return false;
      }

      return true;
    }
    
    

  }
}


