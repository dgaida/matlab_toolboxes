/**
 * This file is part of the partial class substrate and defines
 * private methods, all are calc methods.
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
  /**
   * Defines the physicochemical characteristics of a substrate used on biogas plants.
   * 
   */
  public partial class substrate
  {
    
    // -------------------------------------------------------------------------------------
    //                              !!! PRIVATE METHODS !!!
    // -------------------------------------------------------------------------------------
        
    ///// <summary>
    ///// Calculate the ratio of soluble COD to total COD: 
    ///// aScod= COD_S / COD
    ///// </summary>
    ///// <returns></returns>
    //private physValueBounded calc_aScod() // const
    //{
    //  return calc_aScod(this);
    //}
    ///// <summary>
    ///// Calculate the ratio of soluble COD to total COD: 
    ///// aScod= COD_S / COD
    ///// </summary>
    ///// <param name="mySubstrate"></param>
    ///// <returns></returns>
    //private static physValueBounded calc_aScod(substrate mySubstrate)
    //{
    //  physValue[] values= new physValue[2];

    //  mySubstrate.get_params_of(out values, "COD", "COD_S");

    //  physValue COD=   values[0];
    //  physValue COD_S= values[1];

    //  return calc_aScod(COD, COD_S);
    //}
    ///// <summary>
    ///// Calculate the ratio of soluble COD to total COD: 
    ///// aScod= COD_S / COD
    ///// </summary>
    ///// <param name="COD">must be measured in gCOD/l</param>
    ///// <param name="COD_S">must be measured in gCOD/l</param>
    ///// <returns></returns>
    //private static physValueBounded calc_aScod(double COD, double COD_S)
    //{
    //  physValue pCOD=   new science.physValue("COD",   COD,   "gCOD/l");
    //  physValue pCOD_S= new science.physValue("COD_S", COD_S, "gCOD/l");

    //  return calc_aScod(COD, COD_S);
    //}
    ///// <summary>
    ///// Calculate the ratio of soluble COD to total COD: 
    ///// aScod= COD_S / COD
    ///// </summary>
    ///// <param name="pCOD"></param>
    ///// <param name="pCOD_S"></param>
    ///// <returns></returns>
    //private static physValueBounded calc_aScod(physValue pCOD, physValue pCOD_S)
    //{
    //  physValue COD=     pCOD.convertUnit("gCOD/l");
    //  physValue COD_S= pCOD_S.convertUnit("gCOD/l");

    //  physValueBounded aScod= new physValueBounded(COD_S / COD);

    //  aScod.Symbol= "aScod";

    //  aScod.setBounds(0, 1);
      
    //  aScod.printIsOutOfBounds();

    //  return aScod;
    //}

    /// <summary>
    /// Calc Ash from VS and TS measured in % FM
    /// </summary>
    /// <returns>ash</returns>
    /// <exception cref="exception">Value out of bounds</exception>
    private physValueBounded calcAsh()
    {
      return calcAsh(this);
    }
    /// <summary>
    /// Calc Ash from VS and TS measured in % FM
    /// </summary>
    /// <param name="mySubstrate">a substrate</param>
    /// <returns>ash</returns>
    /// <exception cref="exception">Value out of bounds</exception>
    private static physValueBounded calcAsh(substrate mySubstrate)
    {
      physValue[] values= new physValue[2];

      try
      {
        mySubstrate.get_params_of(out values, "TS", "VS");
      }
      catch (exception e)
      {
        Console.WriteLine(e.Message);
        return new physValueBounded("error Ash");
      }

      physValue TS= values[0];
      physValue VS= values[1];

      return calcAsh(TS, VS);
    }
    /// <summary>
    /// Calc Ash from VS and TS measured in % FM
    /// </summary>
    /// <param name="TS">must be measured in % FM</param>
    /// <param name="VS">must be measured in % TS</param>
    /// <returns>ash</returns>
    /// <exception cref="exception">Value out of bounds</exception>
    private static physValueBounded calcAsh(double TS, double VS)
    {
      physValue pTS= new science.physValue("TS", TS, "% FM");
      physValue pVS= new science.physValue("VS", VS, "% TS");

      return calcAsh(pTS, pVS);
    }
    /// <summary>
    /// Calc Ash from VS and TS measured in % FM
    /// </summary>
    /// <param name="pTS">TS</param>
    /// <param name="pVS">VS</param>
    /// <returns>ash</returns>
    /// <exception cref="exception">Value out of bounds</exception>
    private static physValueBounded calcAsh(physValue pTS, physValue pVS)
    {
      physValue TS= pTS.convertUnit("% FM");
      physValue VS= pVS.convertUnit("% TS");

      physValueBounded ash= new physValueBounded(
               ( new physValue(100, "% TS") - VS ).convertUnit("100 %") * TS );

      ash.Symbol= "Ash";

      ash.setBounds(0, 100);
      
      ash.printIsOutOfBounds();

      return ash;
    }

    /// <summary>
    /// Calc Water respectively Moisture content of substrate measured in % FM
    /// </summary>
    /// <returns></returns>
    private physValue calcWater()
    {
      return calcWater(this);
    }
    /// <summary>
    /// Calc Water respectively Moisture content of substrate measured in % FM
    /// </summary>
    /// <param name="mySubstrate">a substrate</param>
    /// <returns>water</returns>
    private static physValue calcWater(substrate mySubstrate)
    {
      physValue[] values= new physValue[1];

      try
      {
        mySubstrate.get_params_of(out values, "TS");
      }
      catch (exception e)
      {
        Console.WriteLine(e.Message);
        return new physValueBounded("error H2O");
      }

      physValue TS=  values[0];

      return calcWater(TS);
    }
    /// <summary>
    /// Calc Water respectively Moisture content of substrate measured in % FM
    /// </summary>
    /// <param name="pTS">TS</param>
    /// <returns>water</returns>
    private static physValue calcWater(physValue pTS)
    {
      physValue TS= pTS.convertUnit("% FM");

      physValue water= new science.physValue(100, "% FM") - TS;

      water.Symbol= "water"; // moisture

      return water;
    }
        
    /// <summary>
    /// Calculates the theoretical oxygen demand of the substrate in kgCOD/kg fresh matter
    /// </summary>
    /// <returns>ThOD</returns>
    /// <exception cref="exception">Unit of parameters not as specified in method below</exception>
    private physValue calcTheoreticalOxygenDemand()
    {
      return calcTheoreticalOxygenDemand(this);
    }
    /// <summary>
    /// Calculates the theoretical oxygen demand of the substrate in kgCOD/kg fresh matter
    /// </summary>
    /// <param name="mySubstrate">a substrate</param>
    /// <returns>ThOD</returns>
    /// <exception cref="exception">Unit of parameters not as specified in calling method</exception>
    private static physValue calcTheoreticalOxygenDemand(substrate mySubstrate)
    {
      physValue[] values= new physValue[6];

      try
      {
        mySubstrate.get_params_of(out values, "RF", "RP", "RL",
                                              "ADL", "VS", "TS");
      }
      catch (exception e)
      {
        Console.WriteLine(e.Message);
        return new physValueBounded("error ThCOD");
      }

      physValue RF=  values[0];
      physValue RP=  values[1];
      physValue RL=  values[2];
      physValue ADL= values[3];
      physValue VS=  values[4];
      physValue TS=  values[5];
      
      return calcTheoreticalOxygenDemand(RF, RP, RL, ADL, VS, TS);
    }
    /// <summary>
    /// Calculates the theoretical oxygen demand of the substrate in kgCOD/kg fresh matter
    /// </summary>
    /// <param name="pRF">must be measured in % TS</param>
    /// <param name="pRP">must be measured in % TS</param>
    /// <param name="pRL">must be measured in % TS</param>
    /// <param name="pADL">must be measured in % TS</param>
    /// <param name="pVS">must be measured in % TS</param>
    /// <param name="pTS">must be measured in % FM</param>
    /// <returns>ThOD</returns>
    /// <exception cref="exception">Unit of parameters not as specified</exception>
    private static physValue calcTheoreticalOxygenDemand(
                                   physValue pRF,  physValue pRP, physValue pRL,
                                   physValue pADL, physValue pVS, physValue pTS)
    {
      physValue ThOD;

      // get the theoretical chemical oxygen demand for the basic molecules
      physValue ThODch= biogas.chemistry.ThODch;
      physValue ThODpr= biogas.chemistry.ThODpr;
      physValue ThODli= biogas.chemistry.ThODli;
      physValue ThODl=  biogas.chemistry.ThODl;

      // calc nitrogen-free extract of the substrate
      physValue pNfE;
      
      try
      {
        pNfE= calcNfE(pRF, pRP, pRL, pVS);
      }
      catch (exception e)
      {
        Console.WriteLine(e.Message);
        return new physValue("error ThOD");
      }

      // all numbers are given in % FM respectively % TS, 
      // divide by 100 % FM respectively % TS to get them in 100 %, thus unitless

      if (pTS.Unit != "% FM")
        throw new exception(String.Format("TS must be measured in % FM, not in {0}!", pTS.Unit));

      physValue TS= pTS.convertUnit("100 %");

      if (pRF.Unit != "% TS")
        throw new exception(String.Format("RF must be measured in % TS, not in {0}!", pRF.Unit));
      if (pRP.Unit != "% TS")
        throw new exception(String.Format("RP must be measured in % TS, not in {0}!", pRP.Unit));
      if (pRL.Unit != "% TS")
        throw new exception(String.Format("RL must be measured in % TS, not in {0}!", pRL.Unit));
      if (pNfE.Unit != "% TS")
        throw new exception(String.Format("NfE must be measured in % TS, not in {0}!", pNfE.Unit));
      if (pADL.Unit != "% TS")
        throw new exception(String.Format("ADL must be measured in % TS, not in {0}!", pADL.Unit));

      // TODO - könnten Fehler werfen, aber ausgeschlossen, da Einheiten oben überprüft werden
      physValue RF=   pRF.convertUnit("100 %");
      physValue RP=   pRP.convertUnit("100 %");
      physValue RL=   pRL.convertUnit("100 %");
      physValue NfE= pNfE.convertUnit("100 %");
      physValue ADL= pADL.convertUnit("100 %");

      ThOD= new science.physValue(1, "g*kgCOD/(kg*gCOD)") * TS * (
                      RP * ThODpr +  // proteins
                      RL * ThODli +  // lipids
                     ADL * ThODl  +  // lignin
                     (RF + NfE - ADL) * ThODch // carbohydrates - lignin
                                );

      return ThOD;
    }

    /// <summary>
    /// Calculates the ratio of substrate (particulate) COD converted into COD of methane.
    /// ratio is calculated on a COD basis
    /// </summary>
    /// <returns>COD in CH4 / particulate COD in substrate</returns>
    private double calcCH4tofeedCODratio()
    {
      physValue Xc, rho, ch4_kgCOD_m3;

      try
      {
        // TODO: this is only the particulate COD, soluble COD from SCFAs is missing
        // in principle this is ok, its as on a VS basis
        Xc = calcXc();  // kgCOD/m^3 substrate

        // density
        rho = get_params_of("rho"); // kg/m^3

        // unit should be m^3 ch4 / m^3 substrate / (l/mol) * gCOD/mol = 
        // m^3 ch4 / m^3 substrate / (l ch4/gCOD) * 1000 l / m^3 =
        // 1000 gCOD / m^3 substrate
        // kgCOD / m^3 substrate
        ch4_kgCOD_m3 = calcBMP().convertUnit("m^3/kg") * rho /
                                chemistry.Vm * chemistry.get_COD_of("Sch4") *
                                new physValue(1, "l/m^3 * kgCOD/gCOD");
      }
      catch (exception e)
      {
        Console.WriteLine(e.Message);
        return 0;
      }

      if (Xc.Value == 0)
        return 0;

      // ratio
      return ( ch4_kgCOD_m3 / Xc ).Value;
    }

    /// <summary>
    /// Calculate specific heat capacity of substrate, measured in kWh/(m^3 * K)
    /// </summary>
    /// <returns>specific heat capacity</returns>
    /// <exception cref="exception">Unit of parameters not as specified in method below
    /// </exception>
    private physValue calcSpecificHeat()
    {
      return calcSpecificHeat(this);
    }
    /// <summary>
    /// Calculate specific heat capacity of substrate, measured in kWh/(m^3 * K)
    /// </summary>
    /// <param name="mySubstrate">a substrate</param>
    /// <returns>specific heat capacity</returns>
    /// <exception cref="exception">Unit of parameters not as specified in method below
    /// </exception>
    private static physValue calcSpecificHeat(substrate mySubstrate)
    {
      physValue[] values = new physValue[6];

      try
      {
        mySubstrate.get_params_of(out values, "RF", "RP", "RL",
                                              "VS", "TS", "T");
      }
      catch (exception e)
      {
        Console.WriteLine(e.Message);
        return new physValue("error sh");
      }

      physValue RF = values[0];
      physValue RP = values[1];
      physValue RL = values[2];
      physValue VS = values[3];
      physValue TS = values[4];
      physValue T  = values[5];

      return calcSpecificHeat(RF, RP, RL, VS, TS, T);
    }
    /// <summary>
    /// Calculate specific heat capacity of substrate, measured in kWh/(m^3 * K)
    /// </summary>
    /// <param name="pRF">must be measured in % TS</param>
    /// <param name="pRP">must be measured in % TS</param>
    /// <param name="pRL">must be measured in % TS</param>
    /// <param name="pVS">must be measured in % TS</param>
    /// <param name="pTS">must be measured in % FM</param>
    /// <param name="pT">temperature of substrate</param>
    /// <returns>specific heat capacity</returns>
    /// <exception cref="exception">Unit of parameters not as specified</exception>
    private static physValue calcSpecificHeat(physValue pRF, physValue pRP, physValue pRL,
                                              physValue pVS, physValue pTS, physValue pT)
    {
      physValue specHeat;
      physValue c_ch, c_pr, c_li, c_ash, c_W, pNfE;

      try
      {
        // get the specific heat for the basic molecules in kJ/(m³ * K). 
        c_ch = biogas.chemistry.calcSpecificHeat("Xch", pT);
        c_pr = biogas.chemistry.calcSpecificHeat("Xpr", pT);
        c_li = biogas.chemistry.calcSpecificHeat("Xli", pT);
        c_ash = biogas.chemistry.calcSpecificHeat("Ash", pT);
        c_W = biogas.chemistry.calcSpecificHeat("H2O", pT);

        // calc nitrogen-free extract of the substrate
        pNfE = calcNfE(pRF, pRP, pRL, pVS);
      }
      catch (exception e)
      {
        Console.WriteLine(e.Message);
        return new physValue("error sh");
      }

      // all numbers are given in % FM respectively % TS, 
      // divide by 100 % FM respectively % TS to get them in 100 %, thus unitless

      if (pTS.Unit != "% FM")
        throw new exception(String.Format("TS must be measured in % FM, not in {0}!", pTS.Unit));

      physValue TS=   pTS.convertUnit("100 %");

      if (pRF.Unit != "% TS")
        throw new exception(String.Format("RF must be measured in % TS, not in {0}!", pRF.Unit));
      if (pRP.Unit != "% TS")
        throw new exception(String.Format("RP must be measured in % TS, not in {0}!", pRP.Unit));
      if (pRL.Unit != "% TS")
        throw new exception(String.Format("RL must be measured in % TS, not in {0}!", pRL.Unit));
      if (pNfE.Unit != "% TS")
        throw new exception(String.Format("NfE must be measured in % TS, not in {0}!", pNfE.Unit));
      if (pVS.Unit != "% TS")
        throw new exception(String.Format("VS must be measured in % TS, not in {0}!", pVS.Unit));
      
      // Fehler ausgeschlossen
      physValue RF = pRF.convertUnit("100 %");
      physValue RP = pRP.convertUnit("100 %");
      physValue RL = pRL.convertUnit("100 %");
      physValue NfE = pNfE.convertUnit("100 %");
      physValue VS = pVS.convertUnit("100 %");
      
      // 
      specHeat = TS * (
                        RP * c_pr +  // proteins
                        RL * c_li +  // lipids
                       (RF + NfE) * c_ch + // carbohydrates
                       (1 - VS.Value) * c_ash
                      ) + (1 - TS.Value) * c_W;

      specHeat = specHeat.convertUnit("kWh/(m^3 * K)");

      return specHeat;
    }

    /// <summary>
    /// Calculate density of substrate, measured in kg/m³
    /// </summary>
    /// <returns>density of substrate</returns>
    /// <exception cref="exception">Unit of parameters not as specified in method below
    /// </exception>
    private physValue calcDensity()
    {
      return calcDensity(this);
    }
    /// <summary>
    /// Calculate density of substrate, measured in kg/m³
    /// </summary>
    /// <param name="mySubstrate">a substrate</param>
    /// <returns>density of substrate</returns>
    /// <exception cref="exception">Unit of parameters not as specified in method below
    /// </exception>
    private static physValue calcDensity(substrate mySubstrate)
    {
      physValue[] values = new physValue[6];

      mySubstrate.get_params_of(out values, "RF", "RP", "RL",
                                            "VS", "TS", "T");

      physValue RF = values[0];
      physValue RP = values[1];
      physValue RL = values[2];
      physValue VS = values[3];
      physValue TS = values[4];
      physValue T  = values[5];

      return calcDensity(RF, RP, RL, VS, TS, T);
    }
    /// <summary>
    /// Calculate density of substrate, measured in kg/m³
    /// </summary>
    /// <param name="pRF">must be measured in % TS</param>
    /// <param name="pRP">must be measured in % TS</param>
    /// <param name="pRL">must be measured in % TS</param>
    /// <param name="pVS">must be measured in % TS</param>
    /// <param name="pTS">must be measured in % FM</param>
    /// <param name="pT">temperature of substrate</param>
    /// <returns>density of substrate</returns>
    /// <exception cref="exception">Unit of parameters not as specified</exception>
    private static physValue calcDensity(physValue pRF, physValue pRP, physValue pRL,
                                         physValue pVS, physValue pTS, physValue pT)
    {
      physValue density;
      physValue rho_ch, rho_pr, rho_li, rho_ash, rho_W, pNfE;

      try
      {
        // get density for the basic molecules in kg/m³. 
        rho_ch = biogas.chemistry.calcDensity("Xch", pT);
        rho_pr = biogas.chemistry.calcDensity("Xpr", pT);
        rho_li = biogas.chemistry.calcDensity("Xli", pT);
        rho_ash = biogas.chemistry.calcDensity("Ash", pT);
        rho_W = biogas.chemistry.calcDensity("H2O", pT);

        // calc nitrogen-free extract of the substrate
        pNfE = calcNfE(pRF, pRP, pRL, pVS);
      }
      catch (exception e)
      {
        Console.WriteLine(e.Message);
        //throw new exception();
        return new physValue("error rho");
      }

      // all numbers are given in % FM respectively % TS, 
      // divide by 100 % FM respectively % TS to get them in 100 %, thus unitless

      if (pTS.Unit != "% FM")
        throw new exception(String.Format("TS must be measured in % FM, not in {0}!", pTS.Unit));

      physValue TS = pTS.convertUnit("100 %");

      if (pRF.Unit != "% TS")
        throw new exception(String.Format("RF must be measured in % TS, not in {0}!", pRF.Unit));
      if (pRP.Unit != "% TS")
        throw new exception(String.Format("RP must be measured in % TS, not in {0}!", pRP.Unit));
      if (pRL.Unit != "% TS")
        throw new exception(String.Format("RL must be measured in % TS, not in {0}!", pRL.Unit));
      if (pNfE.Unit != "% TS")
        throw new exception(String.Format("NfE must be measured in % TS, not in {0}!", pNfE.Unit));
      if (pVS.Unit != "% TS")
        throw new exception(String.Format("VS must be measured in % TS, not in {0}!", pVS.Unit));

      // Fehler ausgeschlossen
      physValue RF = pRF.convertUnit("100 %");
      physValue RP = pRP.convertUnit("100 %");
      physValue RL = pRL.convertUnit("100 %");
      physValue NfE = pNfE.convertUnit("100 %");
      physValue VS = pVS.convertUnit("100 %");

      // 
      density = TS * (
                        RP * rho_pr +  // proteins
                        RL * rho_li +  // lipids
                       (RF + NfE) * rho_ch + // carbohydrates
                       (1 - VS.Value) * rho_ash
                      ) + (1 - TS.Value) * rho_W;

      density.Symbol = "rho";

      return density;
    }

    
    /// <summary>
    /// Calculates the factor d.
    /// 
    /// As a reference see:
    /// 
    /// Koch, K., Lübken, M., Gehring, T., Wichern, M., and Horn, H.: 
    /// Biogas from grass silage – Measurements and modeling with ADM1, 
    /// Bioresource Technology 101, pp. 8158-8165, 2010.
    /// 
    /// </summary>
    /// <returns>d</returns>
    /// <exception cref="exception">d &lt; 0 || d &gt; 1</exception>
    private double calc_d()
    {
      return calc_d(this);
    }
    /// <summary>
    /// Calculates the factor d.
    /// 
    /// As a reference see:
    /// 
    /// Koch, K., Lübken, M., Gehring, T., Wichern, M., and Horn, H.: 
    /// Biogas from grass silage – Measurements and modeling with ADM1, 
    /// Bioresource Technology 101, pp. 8158-8165, 2010.
    /// 
    /// </summary>
    /// <param name="mySubstrate">a substrate</param>
    /// <returns>d</returns>
    /// <exception cref="exception">d &lt; 0 || d &gt; 1</exception>
    private static double calc_d(substrate mySubstrate)
    {
      physValue[] values= new physValue[4];

      try
      {
        mySubstrate.get_params_of(out values, "ADL", "NDF", "D_VS", "VS");
      }
      catch (exception e)
      {
        Console.WriteLine(e.Message);
        return -1;
      }

      physValue ADL=  values[0];
      physValue NDF=  values[1];
      physValue D_VS= values[2];
      physValue VS=   values[3];

      return calc_d(ADL, NDF, D_VS, VS);
    }
    /// <summary>
    /// Calculates the factor d.
    /// </summary>
    /// <param name="ADL">must be measured in % TS</param>
    /// <param name="NDF">must be measured in % TS</param>
    /// <param name="D_VS">must be measured in 100 %</param>
    /// <param name="VS">must be measured in % TS</param>
    /// <returns>d</returns>
    /// <exception cref="exception">d &lt; 0 || d &gt; 1</exception>
    private static double calc_d(double ADL, double NDF, double D_VS, double VS)
    {
      physValue pADL=  new science.physValue("ADL",  ADL,  "% TS");
      physValue pNDF=  new science.physValue("NDF",  NDF,  "% TS");
      physValue pD_VS= new science.physValue("D_VS", D_VS, "100 %");
      physValue pVS=   new science.physValue("VS",   VS,   "% TS");

      return calc_d(pADL, pNDF, pD_VS, pVS);
    }
    /// <summary>
    /// Calculates the factor d = (NDF - VS * (1 - D_VS)) / (NDF - ADL).
    /// </summary>
    /// <param name="pADL">acid detergent lignin</param>
    /// <param name="pNDF">neutral detergent fiber</param>
    /// <param name="pD_VS">degradation level</param>
    /// <param name="pVS">volatile solids</param>
    /// <returns>d</returns>
    /// <exception cref="exception">d &lt; 0 || d &gt; 1</exception>
    private static double calc_d(physValue pADL, physValue pNDF, 
                                 physValue pD_VS, physValue pVS)
    {
      physValue ADL=   pADL.convertUnit("% TS");
      physValue NDF=   pNDF.convertUnit("% TS");
      physValue D_VS= pD_VS.convertUnit("100 %");
      physValue VS=     pVS.convertUnit("% TS");
      

      physValue D;

      if (NDF.Value - ADL.Value == 0)
        return 0;

      D= ( NDF - VS * ( new physValue(1, "100 %") - D_VS ) ) / (NDF - ADL);

      double d= D.Value;

      if (d < 0 || d > 1)
        throw new exception(String.Format("0 <= d <= 1: {0}!", d));

      return d;
    }

    /// <summary>
    /// Calculates the ADF content out of 
    /// Cellulose and
    /// ADL : acid detergent lignin (Säure-Detergenz-Lignin)
    ///
    /// For the determination of Acid Detergent Fibre (ADF), feed samples are
    /// boiled in a solution containing sulphuric acid and the detergent, cetyl
    /// trimethyl ammonium bromide. Hemicelluloses and cell wall proteins are
    /// dissolved, with the residue containing cellulose, lignin, lignified nitrogen,
    /// cutin, silica and some pectins.
    /// 
    /// As references see:
    /// 
    /// Koch, K., Lübken, M., Gehring, T., Wichern, M., and Horn, H.: 
    /// Biogas from grass silage – Measurements and modeling with ADM1, 
    /// Bioresource Technology 101, pp. 8158-8165, 2010.
    /// 
    /// http://www.agromedia.ca/ADM_Articles/content/f1a1a1.pdf
    /// 
    /// </summary>
    /// <param name="Cell">must be measured in % TS</param>
    /// <param name="ADL">must be measured in % TS</param>
    /// <returns>ADF</returns>
    /// <exception cref="exception">value out of bounds</exception>
    private static physValueBounded calcADF(double Cell, double ADL)
    {
      physValue pCell= new science.physValue("Cell", Cell, "% TS");
      physValue pADL=  new science.physValue("ADL",  ADL,  "% TS");

      return calcADF(pCell, pADL);
    }
    /// <summary>
    /// calc acid detergent fiber
    /// </summary>
    /// <param name="pCell">cellulose</param>
    /// <param name="pADL">ADL</param>
    /// <returns>ADF</returns>
    /// <exception cref="exception">value out of bounds</exception>
    private static physValueBounded calcADF(physValue pCell, physValue pADL)
    {
      physValue Cell= pCell.convertUnit("% TS");
      physValue ADL=   pADL.convertUnit("% TS");

      // ADF := Cellulose + ADL
      physValueBounded ADF= new physValueBounded(Cell + ADL);

      ADF.Symbol= "ADF";

      ADF.setLB(0);
      
      ADF.printIsOutOfBounds();
            
      return ADF;
    }

    /// <summary>
    /// Calculates the Cellulose content out of 
    /// ADF : acid detergent fiber (Säure-Detergenz-Faser) and
    /// ADL : acid detergent lignin (Säure-Detergenz-Lignin)
    ///
    /// Cellulose is crystalline, strong, and resistant to hydrolysis (see
    /// http://en.wikipedia.org/wiki/Hemicellulose).  
    /// 
    /// As a reference see:
    /// 
    /// Koch, K., Lübken, M., Gehring, T., Wichern, M., and Horn, H.: 
    /// Biogas from grass silage – Measurements and modeling with ADM1, 
    /// Bioresource Technology 101, pp. 8158-8165, 2010.
    /// 
    /// </summary>
    /// <returns>cellulose</returns>
    /// <exception cref="exception">value out of bounds</exception>
    private physValueBounded calcCell()
    {
      physValue[] values= new physValue[2];

      try
      {
        this.get_params_of(out values, "ADF", "ADL");
      }
      catch (exception e)
      {
        Console.WriteLine(e.Message);
        return new physValueBounded();
      }

      physValue ADF= values[0];
      physValue ADL= values[1];

      return calcCell(ADF, ADL);
    }
    /// <summary>
    /// Calculates the Cellulose content out of 
    /// ADF : acid detergent fiber (Säure-Detergenz-Faser) and
    /// ADL : acid detergent lignin (Säure-Detergenz-Lignin)
    ///
    /// Cellulose is crystalline, strong, and resistant to hydrolysis (see
    /// http://en.wikipedia.org/wiki/Hemicellulose).  
    /// 
    /// As a reference see:
    /// 
    /// Koch, K., Lübken, M., Gehring, T., Wichern, M., and Horn, H.: 
    /// Biogas from grass silage – Measurements and modeling with ADM1, 
    /// Bioresource Technology 101, pp. 8158-8165, 2010.
    /// 
    /// </summary>
    /// <param name="ADF">must be measured in % TS</param>
    /// <param name="ADL">must be measured in % TS</param>
    /// <returns>cellulose</returns>
    /// <exception cref="exception">value out of bounds</exception>
    private static physValueBounded calcCell(double ADF, double ADL)
    {
      physValue pADF= new science.physValue("ADF", ADF, "% TS");
      physValue pADL= new science.physValue("ADL", ADL, "% TS");

      return calcCell(pADF, pADL);
    }
    /// <summary>
    /// calc cellulose
    /// </summary>
    /// <param name="pADF">ADF</param>
    /// <param name="pADL">ADL</param>
    /// <returns>cellulose</returns>
    /// <exception cref="exception">value out of bounds</exception>
    private static physValueBounded calcCell(physValue pADF, physValue pADL)
    {
      physValue ADF= pADF.convertUnit("% TS");
      physValue ADL= pADL.convertUnit("% TS");

      // ADF := Cellulose + ADL
      physValueBounded Cell= new physValueBounded(ADF - ADL);

      Cell.Symbol= "Cell";

      Cell.setLB(0);

      Cell.printIsOutOfBounds();

      return Cell;
    }

    /// <summary>
    /// Calculates the Hemicellulose content out of 
    /// NDF : neutral detergent fiber (Neutral-Detergenz-Faser) and 
    /// ADF : acid detergent fiber (Säure-Detergenz-Faser)
    /// 
    /// Hemicellulose has a random, amorphous structure with little
    /// strength. It is easily hydrolyzed by dilute acid or base as well as
    /// myriad hemicellulase enzymes
    /// (see http://en.wikipedia.org/wiki/Hemicellulose). 
    ///
    /// Neutral Detergent Fiber (NDF) is the most common measure of fiber
    /// used for animal feed analysis, but it does not represent a unique
    /// class of chemical compounds. NDF measures most of the structural
    /// components in plant cells (i.e. lignin, hemicellulose and
    /// cellulose), but not pectin (see
    /// http://en.wikipedia.org/wiki/Neutral_Detergent_Fiber). 
    ///
    /// As a reference see:
    /// 
    /// Koch, K., Lübken, M., Gehring, T., Wichern, M., and Horn, H.: 
    /// Biogas from grass silage – Measurements and modeling with ADM1, 
    /// Bioresource Technology 101, pp. 8158-8165, 2010.
    /// 
    /// Van Soest, P.J., Robertson, J.B., and Lewis, B.A.: 
    /// Methods for dietary fiber, neutral detergent fiber, and
    /// nonstarch polysaccharides in relation to animal production, 
    /// Journal of Dairy Science 74, pp. 3583-3597, 1991
    /// </summary>
    /// <returns>hemicellulose</returns>
    /// <exception cref="exception">value out of bounds</exception>
    private physValueBounded calcHemCell()
    {
      physValue[] values= new physValue[2];

      try
      {
        this.get_params_of(out values, "NDF", "ADF");
      }
      catch (exception e)
      {
        Console.WriteLine(e.Message);

        return new physValueBounded();
      }

      physValue NDF= values[0];
      physValue ADF= values[1];

      return calcHemCell(NDF, ADF);
    }
    /// <summary>
    /// calc Hemicellulose
    /// </summary>
    /// <param name="NDF">must be measured in % TS</param>
    /// <param name="ADF">must be measured in % TS</param>
    /// <returns>hemicellulose</returns>
    /// <exception cref="exception">value out of bounds</exception>
    private static physValueBounded calcHemCell(double NDF, double ADF)
    {
      physValue pNDF= new science.physValue("NDF", NDF, "% TS");
      physValue pADF= new science.physValue("ADF", ADF, "% TS");

      return calcCell(pNDF, pADF);
    }
    /// <summary>
    /// calc hemicellulose
    /// </summary>
    /// <param name="pNDF">NDF</param>
    /// <param name="pADF">ADF</param>
    /// <returns>hemicellulose</returns>
    /// <exception cref="exception">value out of bounds</exception>
    private static physValueBounded calcHemCell(physValue pNDF, physValue pADF)
    {
      physValue NDF= pNDF.convertUnit("% TS");
      physValue ADF= pADF.convertUnit("% TS");

      // NDF := ADF + Hemicellulose
      physValueBounded HemCell= new physValueBounded(NDF - ADF);

      HemCell.Symbol= "HemCell";

      HemCell.setLB(0);

      HemCell.printIsOutOfBounds();

      return HemCell;
    }

    /// <summary>
    /// calc NDF
    /// </summary>
    /// <param name="HemCell">must be measured in % TS</param>
    /// <param name="Cell">must be measured in % TS</param>
    /// <param name="ADL">must be measured in % TS</param>
    /// <returns>NDF</returns>
    /// <exception cref="exception">value out of bounds</exception>
    private static physValueBounded calcNDF(double HemCell, double Cell, double ADL)
    {
      physValue pHemCell= new science.physValue("HemCell", HemCell, "% TS");
      physValue pCell=    new science.physValue("Cell",    Cell,    "% TS");
      physValue pADL=     new science.physValue("ADL",     ADL,     "% TS");

      return calcNDF(pHemCell, pCell, pADL);
    }
    /// <summary>
    /// Neutral Detergent Fiber (NDF) is the most common measure of fiber
    /// used for animal feed analysis, but it does not represent a unique
    /// class of chemical compounds. NDF measures most of the structural
    /// components in plant cells (i.e. lignin, hemicellulose and
    /// cellulose), but not pectin (see
    /// http://en.wikipedia.org/wiki/Neutral_Detergent_Fiber). 
    ///
    /// For the determination of Neutral Detergent Fibre (NDF), feed samples
    /// are boiled in a solution containing sodium lauryl sulphate. This
    /// detergent extracts lipids, sugars, organic acids and other water soluble
    /// components as well as pectin, non-protein nitrogen (NPN) compunds,
    /// soluble protein and some of the silica and tannin. NDF is the insoluble
    /// residue made up of cellulose, hemicellulose, lignin, lignin-bound
    /// nitrogen, some protein, minerals and cuticle. 
    /// 
    /// NDF = hemicellulose + lignin + cellulose
    /// ADF =                 lignin + cellulose
    /// 
    /// As a reference see:
    /// 
    /// Koch, K., Lübken, M., Gehring, T., Wichern, M., and Horn, H.: 
    /// Biogas from grass silage – Measurements and modeling with ADM1, 
    /// Bioresource Technology 101, pp. 8158-8165, 2010.
    /// 
    /// Van Soest, P.J., Robertson, J.B., and Lewis, B.A.: 
    /// Methods for dietary fiber, neutral detergent fiber, and
    /// nonstarch polysaccharides in relation to animal production, 
    /// Journal of Dairy Science 74, pp. 3583-3597, 1991
    /// 
    /// http://www.agromedia.ca/ADM_Articles/content/f1a1n1.pdf
    /// </summary>
    /// <param name="pHemCell">hemicellulose</param>
    /// <param name="pCell">cellulose</param>
    /// <param name="pADL">ADL</param>
    /// <returns>NDF</returns>
    /// <exception cref="exception">value out of bounds</exception>
    private static physValueBounded calcNDF(physValue pHemCell, 
                                            physValue pCell, physValue pADL)
    {
      physValue HemCell= pHemCell.convertUnit("% TS");
      physValue Cell=       pCell.convertUnit("% TS");
      physValue ADL=         pADL.convertUnit("% TS");

      // NDF := ADF + Hemicellulose
      physValueBounded NDF= new physValueBounded(calcADF(Cell, ADL) + HemCell);

      NDF.Symbol= "NDF";

      NDF.setLB(0);

      NDF.printIsOutOfBounds();

      return NDF;
    }

    /// <summary>
    /// Non-Fibre Carbohydrates (NFC) represent feed carbohydrates, including
    /// starch, pectin and sugars, which are more rapidly degradable in the
    /// rumen relative to the cell wall carbohydrates measured as Neutral
    /// Detergent Fibre (NDF).
    /// 
    /// http://www.agromedia.ca/ADM_Articles/content/f1a1n4.pdf
    /// 
    /// As a reference see:
    /// 
    /// A. Schuldt, R. Dinse, “Übungen zur Tierernährung im Rahmen des Moduls 
    /// ‘Tierernährung und Futtermittelkunde‘”, Hochschule Neubrandenburg, 
    /// Fachbereich Agrarwirtschaft und Lebensmittelwissenschaften, 2010.
    /// </summary>
    /// <returns>NFC</returns>
    private physValueBounded calcNFC()
    {
      return calcNFC(this);
    }
    /// <summary>
    /// calc NFC
    /// </summary>
    /// <param name="mySubstrate">a substrate</param>
    /// <returns>NFC</returns>
    /// <exception cref="exception">value out of bounds</exception>
    private static physValueBounded calcNFC(substrate mySubstrate)
    {
      physValue[] values= new physValue[4];

      try
      {
        mySubstrate.get_params_of(out values, "VS", "RP", "RL", "NDF");
      }
      catch (exception e)
      {
        Console.WriteLine(e.Message);
        return new physValueBounded("error NFC");
      }

      physValue VS=  values[0];
      physValue RP=  values[1];
      physValue RL=  values[2];
      physValue NDF= values[3];

      return calcNFC(VS, RP, RL, NDF);
    }
    /// <summary>
    /// calc NFC
    /// </summary>
    /// <param name="VS">must be measured in % TS</param>
    /// <param name="RP">must be measured in % TS</param>
    /// <param name="RL">must be measured in % TS</param>
    /// <param name="NDF">must be measured in % TS</param>
    /// <returns>NFC</returns>
    /// <exception cref="exception">value out of bounds</exception>
    private static physValueBounded calcNFC(double VS, double RP, double RL, double NDF)
    {
      physValue pVS=  new science.physValue("VS",  VS,  "% TS");
      physValue pRP=  new science.physValue("RP",  RP,  "% TS");
      physValue pRL=  new science.physValue("RL",  RL,  "% TS");
      physValue pNDF= new science.physValue("NDF", NDF, "% TS");

      return calcNFC(pVS, pRP, pRL, pNDF);
    }
    /// <summary>
    /// calc NFC
    /// </summary>
    /// <param name="pVS">VS</param>
    /// <param name="pRP">RP</param>
    /// <param name="pRL">RL</param>
    /// <param name="pNDF">NDF</param>
    /// <returns>NFC</returns>
    /// <exception cref="exception">value out of bounds</exception>
    private static physValueBounded calcNFC(physValue pVS, physValue pRP, 
                                            physValue pRL, physValue pNDF)
    {
      physValue VS=   pVS.convertUnit("% TS");
      physValue RP=   pRP.convertUnit("% TS");
      physValue RL=   pRL.convertUnit("% TS");
      physValue NDF= pNDF.convertUnit("% TS");

      // 
      physValueBounded NFC= new physValueBounded(VS - RP - RL - NDF);

      NFC.Symbol= "NFC";

      NFC.setLB(0);

      NFC.printIsOutOfBounds();

      return NFC;
    }
    /// <summary>
    /// calc NFC
    /// </summary>
    /// <param name="RF">must be measured in % TS</param>
    /// <param name="NfE">must be measured in % TS</param>
    /// <param name="NDF">must be measured in % TS</param>
    /// <returns>NFC</returns>
    /// <exception cref="exception">value out of bounds</exception>
    private static physValueBounded calcNFC(double RF, double NfE, double NDF)
    {
      physValue pRF=  new science.physValue("RF",  RF,  "% TS");
      physValue pNfE= new science.physValue("NfE", NfE, "% TS");
      physValue pNDF= new science.physValue("NDF", NDF, "% TS");

      return calcNFC(pRF, pNfE, pNDF);
    }
    /// <summary>
    /// calc NFC
    /// </summary>
    /// <param name="pRF">RF</param>
    /// <param name="pNfE">NfE</param>
    /// <param name="pNDF">NDF</param>
    /// <returns>NFC</returns>
    /// <exception cref="exception">value out of bounds</exception>
    private static physValueBounded calcNFC(physValue pRF, physValue pNfE, physValue pNDF)
    {
      physValue RF=   pRF.convertUnit("% TS");
      physValue NfE= pNfE.convertUnit("% TS");
      physValue NDF= pNDF.convertUnit("% TS");

      // 
      physValueBounded NFC= new physValueBounded(RF + NfE - NDF);

      NFC.Symbol= "NFC";

      NFC.setLB(0);

      NFC.printIsOutOfBounds();

      return NFC;
    }

    /// <summary>
    /// Bound NDF, such that NFC is always positive, wenn VS and RF changes
    /// da NfE aus VS und RF berechnet wird, ist die methode OK
    /// </summary>
    /// <returns>NDF</returns>
    private physValue boundNDF()
    {
      return boundNDF(this);
    }
    /// <summary>
    /// Bound NDF, such that NFC is always positive, wenn VS and RF changes
    /// da NfE aus VS und RF berechnet wird, ist die methode OK
    /// </summary>
    /// <param name="mySubstrate">a substrate</param>
    /// <returns>NDF</returns>
    private static physValue boundNDF(substrate mySubstrate)
    {
      physValue[] values= new physValue[2];

      try
      {
        mySubstrate.get_params_of(out values, "RF", "NDF");
      }
      catch (exception e)
      {
        Console.WriteLine(e.Message);
        return new physValue("error NDF");
      }

      physValue RF = values[0];
      physValue NDF= values[1];

      physValue NfE= mySubstrate.calcNfE();

      return boundNDF(RF, NDF, NfE);
    }
    /// <summary>
    /// Bound NDF, such that NFC is always positive, wenn VS and RF changes
    /// da NfE aus VS und RF berechnet wird, ist die methode OK
    /// </summary>
    /// <param name="pRF">RF</param>
    /// <param name="pNDF">NDF</param>
    /// <param name="pNfE">NfE</param>
    /// <returns>NDF</returns>
    private static physValue boundNDF(physValue pRF, physValue pNDF, physValue pNfE)
    {
      physValue RF = pRF.convertUnit("% TS");
      physValue NDF= pNDF.convertUnit("% TS");
      physValue NfE= pNfE.convertUnit("% TS");

      // Formel ist:
      // NDF= RF + NfE - NFC
      // kleinster zulässiger Wert für NFC sei 0.001 % TS
      NDF= physValue.min(NDF, RF + NfE - new physValue(0.001, "% TS"));
      
      return NDF;
    }


    /// <summary>
    /// Bound ADL, such that ADL &lt;= VS*(1 - D_VS), needed such that 
    /// d is &lt;= 1
    /// </summary>
    /// <returns>ADL</returns>
    private physValue boundADL()
    {
      return boundADL(this);
    }
    /// <summary>
    /// Bound ADL, such that ADL &lt;= VS*(1 - D_VS), needed such that 
    /// d is &lt;= 1
    /// </summary>
    /// <param name="mySubstrate">a substrate</param>
    /// <returns>ADL</returns>
    private static physValue boundADL(substrate mySubstrate)
    {
      physValue[] values = new physValue[3];

      try
      {
        mySubstrate.get_params_of(out values, "VS", "ADL", "D_VS");
      }
      catch (exception e)
      {
        Console.WriteLine(e.Message);
        return new physValue("error get_params boundADL");
      }

      physValue VS   = values[0];
      physValue ADL  = values[1];
      physValue D_VS = values[2];

      return boundADL(VS, ADL, D_VS);
    }
    /// <summary>
    /// Bound ADL, such that ADL &lt;= VS*(1 - D_VS), needed such that 
    /// d is &lt;= 1
    /// </summary>
    /// <param name="pVS">VS</param>
    /// <param name="pADL">ADL</param>
    /// <param name="pD_VS">D_VS</param>
    /// <returns>ADL</returns>
    private static physValue boundADL(physValue pVS, physValue pADL, physValue pD_VS)
    {
      physValue VS = pVS.convertUnit("% TS");
      physValue ADL = pADL.convertUnit("% TS");
      physValue D_VS = pD_VS.convertUnit("100 %");

      // Formel für d ist: (s. calc_d())
      // d= (NDF - VS * (1 - D_VS)) / (NDF - ADL)
      // damit d <= 1 muss gelten: VS*(1 - D_VS) >= ADL
      ADL = physValue.min(ADL, VS * (new physValue(1, "100 %") - D_VS));
      
      return ADL;
    }


    /// <summary>
    /// NfE: This fraction consists of such things as the water soluble vitamins,
    /// and also any other feed component that has not been accounted for
    /// elsewhere, but it principally comprises of starch (Stärke) and sugar (in other
    /// words, apart from the oil, the main energy sources in the feed). It often
    /// (certainly in the case of cereals) constitutes the greatest proportion of
    /// the feed.     
    ///
    /// http://www.smallstock.info/info/feed/chemical.htm#NitrogenFree
    /// </summary>
    /// <returns>NfE</returns>
    /// <exception cref="exception">value out of bounds</exception>
    private physValueBounded calcNfE()
    {
      physValue[] values= new physValue[4];

      try
      {
        this.get_params_of(out values, "RF", "RP", "RL", "VS");
      }
      catch (exception e)
      { 
        Console.WriteLine(e.Message);
        return new physValueBounded("error NfE");
      }

      physValue RF= values[0];
      physValue RP= values[1];
      physValue RL= values[2];
      physValue VS= values[3];

      return calcNfE(RF, RP, RL, VS);
    }
    /// <summary>
    /// calc NfE
    /// </summary>
    /// <param name="RF">must be measured in % TS</param>
    /// <param name="RP">must be measured in % TS</param>
    /// <param name="RL">must be measured in % TS</param>
    /// <param name="VS">must be measured in % TS</param>
    /// <returns>NfE</returns>
    /// <exception cref="exception">value out of bounds</exception>
    private static physValueBounded calcNfE(double RF, double RP, double RL, double VS)
    {
      physValue pRF= new science.physValue("RF", RF, "% TS");
      physValue pRP= new science.physValue("RP", RP, "% TS");
      physValue pRL= new science.physValue("RL", RL, "% TS");
      physValue pVS= new science.physValue("VS", VS, "% TS");

      return calcNfE(RF, RP, RL, VS);
    }
    /// <summary>
    /// calc NfE
    /// </summary>
    /// <param name="pRF">RF</param>
    /// <param name="pRP">RP</param>
    /// <param name="pRL">RL</param>
    /// <param name="pVS">VS</param>
    /// <returns>NfE</returns>
    /// <exception cref="exception">value out of bounds</exception>
    private static physValueBounded calcNfE(physValue pRF, physValue pRP, 
                                            physValue pRL, physValue pVS)
    {
      physValue RF= pRF.convertUnit("% TS");
      physValue RP= pRP.convertUnit("% TS");
      physValue RL= pRL.convertUnit("% TS");
      physValue VS= pVS.convertUnit("% TS");

      // 
      physValueBounded NfE= new physValueBounded(VS - (RF + RP + RL));

      NfE.Symbol= "NfE";

      // 0 ist zu stark, kann passieren, dass NfE minimal negativ wird, wenn Anlage
      // abstürzt, kann sogar < -5 werden, sehr seltsam!
      NfE.setLB(-5000);//0);

      //if (NfE.isOutOfBounds())
      //{
      //  throw new exception(String.Format("VS= {0}, RF= {1}, RP= {2}, RL= {3}",
      //    VS.Value, RF.Value, RP.Value, RL.Value));
      //}

      NfE.printIsOutOfBounds();

      return NfE;
    }

    /// <summary>
    /// Calculate Total Kjeldahl Nitrogen [% TS]
    /// 
    /// TKN= sum of organic nitrogen, ammonia (NH3), and ammonium (NH4+)
    /// 
    /// Since most feed proteins contain about 16% N, CP (crude proteine) % is estimated by
    /// multiplying the N concentration in the feed by 6.25 - the inverse of 16%
    /// (1 ÷ 0.16 = 6.25).
    /// 
    /// As a reference see:
    /// 
    /// http://www.agromedia.ca/ADM_Articles/content/f1a1c3.pdf
    /// 
    /// </summary>
    /// <returns>TKN in FM</returns>
    /// <exception cref="exception">value out of bounds</exception>
    private physValueBounded calcTKN()
    {
      return calcTKN(this);
    }
    /// <summary>
    /// calc TKN in FM
    /// </summary>
    /// <param name="mySubstrate">a substrate</param>
    /// <returns>TKN in FM</returns>
    /// <exception cref="exception">value out of bounds</exception>
    private static physValueBounded calcTKN(substrate mySubstrate)
    {
      physValue[] values= new physValue[2];

      try
      {
        mySubstrate.get_params_of(out values, "RP", "TS");
      }
      catch (exception e)
      {
        Console.WriteLine(e.Message);
        return new physValueBounded("error TKN");
      }

      physValue RP= values[0];
      physValue TS= values[1];
            
      return calcTKN(RP, TS);
    }
    /// <summary>
    /// calc TKN in FM
    /// </summary>
    /// <param name="RP">must be measured in % TS</param>
    /// <param name="TS">must be measured in % FM</param>
    /// <returns>TKN in FM</returns>
    /// <exception cref="exception">value out of bounds</exception>
    private static physValueBounded calcTKN(double RP, double TS)
    {
      physValue pRP=  new science.physValue("RP", RP, "% TS");
      physValue pTS=  new science.physValue("TS", TS, "% FM");
      
      return calcTKN(pRP, pTS);
    }
    /// <summary>
    /// calc TKN in FM
    /// </summary>
    /// <param name="pRP">RP</param>
    /// <param name="pTS">TS</param>
    /// <returns>TKN</returns>
    /// <exception cref="exception">value out of bounds</exception>
    private static physValueBounded calcTKN(physValue pRP, physValue pTS)
    {
      physValue RP= pRP.convertUnit("% TS");
      RP= convertFrom_TS_To_FM(RP, pTS);

      // 
      physValueBounded TKN= new physValueBounded(RP / 6.25);

      TKN.Symbol= "TKN";

      TKN.setLB(0);

      TKN.printIsOutOfBounds();

      return TKN;
    }

    /// <summary>
    /// Volatile Solids (VS) is a measure of the solids (portion of TS) which are 
    /// actually available for bioconversion
    /// 
    /// As a reference see:
    /// 
    /// http://www.bioconverter.com/technology/primer.htm#Volatile%20Solids%20%28VS%29
    /// 
    /// </summary>
    /// <param name="RF">must be measured in % TS</param>
    /// <param name="RP">must be measured in % TS</param>
    /// <param name="RL">must be measured in % TS</param>
    /// <param name="NfE">must be measured in % TS</param>
    /// <returns>VS</returns>
    /// <exception cref="exception">value out of bounds</exception>
    private static physValueBounded calcVS(double RF, double RP, double RL, double NfE)
    {
      physValue pRF=  new science.physValue("RF",  RF,  "% TS");
      physValue pRP=  new science.physValue("RP",  RP,  "% TS");
      physValue pRL=  new science.physValue("RL",  RL,  "% TS");
      physValue pNfE= new science.physValue("NfE", NfE, "% TS");

      return calcVS(RF, RP, RL, NfE);
    }
    /// <summary>
    /// calc VS
    /// </summary>
    /// <param name="pRF">RF</param>
    /// <param name="pRP">RP</param>
    /// <param name="pRL">RL</param>
    /// <param name="pNfE">NfE</param>
    /// <returns>VS</returns>
    /// <exception cref="exception">value out of bounds</exception>
    private static physValueBounded calcVS(physValue pRF, physValue pRP, 
                                           physValue pRL, physValue pNfE)
    {
      physValue RF=   pRF.convertUnit("% TS");
      physValue RP=   pRP.convertUnit("% TS");
      physValue RL=   pRL.convertUnit("% TS");
      physValue NfE= pNfE.convertUnit("% TS");

      // 
      physValueBounded VS= new physValueBounded(RF + RP + RL + NfE);

      VS.Symbol= "VS";

      VS.setLB(0);

      VS.printIsOutOfBounds();

      return VS;
    }

    /// <summary>
    /// calc VFA in gHAceq/l
    /// </summary>
    /// <returns>VFA</returns>
    /// <exception cref="exception">value out of bounds</exception>
    private physValueBounded calcVFA()
    {
      return calcVFA(this);
    }
    /// <summary>
    /// calc VFA in gHAceq/l
    /// </summary>
    /// <param name="mySubstrate">a substrate</param>
    /// <returns>VFA</returns>
    /// <exception cref="exception">value out of bounds</exception>
    private static physValueBounded calcVFA(substrate mySubstrate)
    {
      physValue[] values = new physValue[4];

      try
      {
        mySubstrate.get_params_of(out values, "Sac", "Sbu", "Spro", "Sva");
      }
      catch (exception e)
      {
        Console.WriteLine(e.Message);
        return new physValueBounded("error VFA");
      }

      physValue pSac = values[0];
      physValue pSbu = values[1];
      physValue pSpro= values[2];
      physValue pSva = values[3];

      return calcVFA(pSac, pSbu, pSpro, pSva, "gHAceq/l");
    }
    /// <summary>
    /// calc VFA in gHAceq/l
    /// </summary>
    /// <param name="pSac">Sac</param>
    /// <param name="pSbu">Sbu</param>
    /// <param name="pSpro">Spro</param>
    /// <param name="pSva">Sva</param>
    /// <returns>VFA</returns>
    /// <exception cref="exception">value out of bounds</exception>
    private static physValueBounded calcVFA(physValue pSac, physValue pSbu,
                                            physValue pSpro, physValue pSva)
    {
      return calcVFA(pSac, pSbu, pSpro, pSva, "gHAceq/l");
    }
    /// <summary>
    /// Calculates volatile fatty acid concentration of the substrate in the given unit
    /// 
    /// See Also:
    /// ADMstate: 
    /// public static physValueBounded calcVFAOfADMstate(double[] x, string unit)
    ///
    /// </summary>
    /// <param name="pSac">Sac</param>
    /// <param name="pSbu">Sbu</param>
    /// <param name="pSpro">Spro</param>
    /// <param name="pSva">Sva</param>
    /// <param name="unit">unit in which you want to have the vfa concentration returned</param>
    /// <returns>VFA</returns>
    /// <exception cref="exception">value out of bounds</exception>
    private static physValueBounded calcVFA(physValue pSac, physValue pSbu, 
                                            physValue pSpro, physValue pSva, string unit)
    {
      physValue Sac = pSac.convertUnit("mol/l");
      physValue Sbu = pSbu.convertUnit("mol/l");
      physValue Spro = pSpro.convertUnit("mol/l");
      physValue Sva = pSva.convertUnit("mol/l");

      physValueBounded Svfa = new physValueBounded(Sac + Spro + Sbu + Sva);

      Svfa = Svfa.convertUnit(unit);

      Svfa.Symbol = "VFA";

      Svfa.printIsOutOfBounds();

      return Svfa;
    }



  }
}


