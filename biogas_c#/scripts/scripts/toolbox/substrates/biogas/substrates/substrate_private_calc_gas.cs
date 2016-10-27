/**
 * This file is part of the partial class substrate and defines
 * private methods, all are calc methods. that have to do with gas production.
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
    
    /// <summary>
    /// Calculates the theoretical biochemical methane potential of the substrate
    /// measured in l per g fresh matter
    /// </summary>
    /// <returns>BMP</returns>
    /// <exception cref="exception">Unit of parameters not as specified in method below
    /// </exception>
    private physValue calcBMP()
    {
      return calcBMP(this);
    }
    /// <summary>
    /// Calculates the theoretical biochemical methane potential of the substrate
    /// measured in l per g fresh matter
    /// </summary>
    /// <param name="mySubstrate">a substrate</param>
    /// <returns>BMP</returns>
    /// <exception cref="exception">Unit of parameters not as specified in method below
    /// </exception>
    private static physValue calcBMP(substrate mySubstrate)
    {
      physValue[] values= new physValue[7];

      try
      {
        mySubstrate.get_params_of(out values, "RF", "RP", "RL",
                                              "ADL", "VS", "TS", "NDF");
      }
      catch (exception e)
      {
        Console.WriteLine(e.Message);
        return new physValue("error BMP");
      }

      physValue RF=  values[0];
      physValue RP=  values[1];
      physValue RL=  values[2];
      physValue ADL= values[3];
      physValue VS=  values[4];
      physValue TS=  values[5];
      physValue NDF= values[6];

      double d;
  
      try
      {
        d= calc_d(mySubstrate);
      }
      catch (exception e)
      {
        Console.WriteLine(e.Message);
        return new physValue("error2");
      }

      return calcBMP(RF, RP, RL, ADL, VS, TS, d, NDF);
    }
    /// <summary>
    /// Calculates the theoretical biochemical methane potential of the substrate
    /// measured in l per g fresh matter
    /// </summary>
    /// <param name="pRF">must be measured in % TS</param>
    /// <param name="pRP">must be measured in % TS</param>
    /// <param name="pRL">must be measured in % TS</param>
    /// <param name="pADL">must be measured in % TS</param>
    /// <param name="pVS">must be measured in % TS</param>
    /// <param name="pTS">must be measured in % FM</param>
    /// <param name="d">
    /// percentage of the degradable part of cellulose and hemicellulose
    /// </param>
    /// <param name="pNDF">neutral detergent fiber</param>
    /// <returns>BMP</returns>
    /// <exception cref="exception">Unit of parameters not as specified</exception>
    private static physValue calcBMP(physValue pRF,  physValue pRP, physValue pRL,
                                     physValue pADL, physValue pVS, physValue pTS,
                                     double d, physValue pNDF)
    {
      physValue BMP, BMPch, BMPpr, BMPli, pNfE;

      try
      {
        // get the biochemical methane potential for the basic molecules
        // mol ch4 / g of molecule
        BMPch = biogas.chemistry.calcBMP("Xch");
        BMPpr = biogas.chemistry.calcBMP("Xpr");
        BMPli = biogas.chemistry.calcBMP("Xli");
        // is zero, lignin cannot be digested
        //physValue BMPl=  biogas.chemistry.calcBMP("Lignin");

        // calc nitrogen-free extract of the substrate
        pNfE = calcNfE(pRF, pRP, pRL, pVS);
      }
      catch (exception e)
      {
        Console.WriteLine(e.Message);
        return new physValue("error BMP");
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
      if (pADL.Unit != "% TS")
        throw new exception(String.Format("ADL must be measured in % TS, not in {0}!", pADL.Unit));
      if (pNDF.Unit != "% TS")
        throw new exception(String.Format("NDF must be measured in % TS, not in {0}!", pNDF.Unit));

      // TODO - könnte Fehler werfen, aber ausgeschlossen, wegen Einheitenüberprüfung oben
      physValue RF=   pRF.convertUnit("100 %");
      physValue RP=   pRP.convertUnit("100 %");
      physValue RL=   pRL.convertUnit("100 %");
      physValue NfE= pNfE.convertUnit("100 %");
      physValue ADL= pADL.convertUnit("100 %");
      physValue NDF = pNDF.convertUnit("100 %");

      // mol ch4 per g substrate FM
      // Quelle: Koch et al. 2010
      BMP= TS * (
              RP * BMPpr +  // proteins
              RL * BMPli +  // lipids
             //ADL * BMPl  +  // lignin
             ((RF + NfE - NDF) + (NDF - ADL) * d) * BMPch // carbohydrates - lignin
           );

      // TODO
      // maybe better calculate from mol to g using molar mass of ch4
      // then use specific volume of methane: 1.48 m^3/kg
      // kommt ziemlich das gleiche raus: M_CH4= 16 g/mol 
      // 16 g/mol * 1.48 l/g = ca. 24 l/mol
      //
      // maybe also multiply with D, digestibility value
      // l methane per g of substrate FM
      BMP= BMP * chemistry.Vm;

      return BMP;
    }

    /// <summary>
    /// Calculates the expected CO2 production of the substrate
    /// measured in l per g fresh matter
    /// based on buswell equation
    /// </summary>
    /// <returns>expected CO2 production</returns>
    /// <exception cref="exception">Unit of parameters not as specified in method below
    /// </exception>
    private physValue calcCO2exp()
    {
      return calcCO2exp(this);
    }
    /// <summary>
    /// Calculates the expected CO2 production of the substrate
    /// measured in l per g fresh matter
    /// based on buswell equation
    /// </summary>
    /// <param name="mySubstrate">a substrate</param>
    /// <returns>expected CO2 production</returns>
    /// <exception cref="exception">Unit of parameters not as specified in method below
    /// </exception>
    private static physValue calcCO2exp(substrate mySubstrate)
    {
      physValue[] values = new physValue[7];

      try
      {
        mySubstrate.get_params_of(out values, "RF", "RP", "RL",
                                              "ADL", "VS", "TS", "NDF");
      }
      catch (exception e)
      {
        Console.WriteLine(e.Message);
        return new physValue("error CO2");
      }

      physValue RF = values[0];
      physValue RP = values[1];
      physValue RL = values[2];
      physValue ADL = values[3];
      physValue VS = values[4];
      physValue TS = values[5];
      physValue NDF = values[6];

      double d;

      try
      {
        d = calc_d(mySubstrate);
      }
      catch (exception e)
      {
        Console.WriteLine(e.Message);
        return new physValue("error2");
      }

      return calcCO2exp(RF, RP, RL, ADL, VS, TS, d, NDF);
    }
    /// <summary>
    /// Calculates the expected CO2 production of the substrate
    /// measured in l per g fresh matter
    /// based on buswell equation
    /// </summary>
    /// <param name="pRF">must be measured in % TS</param>
    /// <param name="pRP">must be measured in % TS</param>
    /// <param name="pRL">must be measured in % TS</param>
    /// <param name="pADL">must be measured in % TS</param>
    /// <param name="pVS">must be measured in % TS</param>
    /// <param name="pTS">must be measured in % FM</param>
    /// <param name="d">
    /// percentage of the degradable part of cellulose and hemicellulose
    /// </param>
    /// <param name="pNDF">neutral detergent fiber</param>
    /// <returns>expected CO2 production</returns>
    /// <exception cref="exception">Unit of parameters not as specified</exception>
    private static physValue calcCO2exp(physValue pRF, physValue pRP, physValue pRL,
                                     physValue pADL, physValue pVS, physValue pTS,
                                     double d, physValue pNDF)
    {
      physValue CO2exp, CO2expch, CO2exppr, CO2expli, pNfE;

      try
      {
        // TODO - es gibt auch CO2vol in chemistry
        // get the expected CO2 production for the basic molecules
        // mol co2 / g of molecule
        CO2expch = biogas.chemistry.calcCO2exp("Xch");
        CO2exppr = biogas.chemistry.calcCO2exp("Xpr");
        CO2expli = biogas.chemistry.calcCO2exp("Xli");
        
        // calc nitrogen-free extract of the substrate
        pNfE = calcNfE(pRF, pRP, pRL, pVS);
      }
      catch (exception e)
      {
        Console.WriteLine(e.Message);
        return new physValue("error CO2");
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
      if (pADL.Unit != "% TS")
        throw new exception(String.Format("ADL must be measured in % TS, not in {0}!", pADL.Unit));
      if (pNDF.Unit != "% TS")
        throw new exception(String.Format("NDF must be measured in % TS, not in {0}!", pNDF.Unit));

      // TODO - könnte Fehler werfen, aber ausgeschlossen, wegen Einheitenüberprüfung oben
      physValue RF = pRF.convertUnit("100 %");
      physValue RP = pRP.convertUnit("100 %");
      physValue RL = pRL.convertUnit("100 %");
      physValue NfE = pNfE.convertUnit("100 %");
      physValue ADL = pADL.convertUnit("100 %");
      physValue NDF = pNDF.convertUnit("100 %");

      // mol co2 per g substrate FM
      // Quelle: Koch et al. 2010
      CO2exp = TS * (
              RP * CO2exppr +  // proteins
              RL * CO2expli +  // lipids
             ((RF + NfE - NDF) + (NDF - ADL) * d) * CO2expch // carbohydrates - lignin
           );

      // l co2 per g of substrate FM
      CO2exp = CO2exp * chemistry.Vm;

      return CO2exp;
    }

    /// <summary>
    /// Calculates the expected NH3 production of the substrate
    /// measured in l per g fresh matter
    /// based on buswell equation
    /// </summary>
    /// <returns>expected NH3 production</returns>
    /// <exception cref="exception">Unit of parameters not as specified in method below
    /// </exception>
    private physValue calcNH3exp()
    {
      return calcNH3exp(this);
    }
    /// <summary>
    /// Calculates the expected NH3 production of the substrate
    /// measured in l per g fresh matter
    /// based on buswell equation
    /// </summary>
    /// <param name="mySubstrate">a substrate</param>
    /// <returns>expected NH3 production</returns>
    /// <exception cref="exception">Unit of parameters not as specified in method below
    /// </exception>
    private static physValue calcNH3exp(substrate mySubstrate)
    {
      physValue[] values = new physValue[7];

      try
      {
        mySubstrate.get_params_of(out values, "RF", "RP", "RL",
                                              "ADL", "VS", "TS", "NDF");
      }
      catch (exception e)
      {
        Console.WriteLine(e.Message);
        return new physValue("error NH3");
      }

      physValue RF = values[0];
      physValue RP = values[1];
      physValue RL = values[2];
      physValue ADL = values[3];
      physValue VS = values[4];
      physValue TS = values[5];
      physValue NDF = values[6];

      double d;

      try
      {
        d = calc_d(mySubstrate);
      }
      catch (exception e)
      {
        Console.WriteLine(e.Message);
        return new physValue("error2");
      }

      return calcNH3exp(RF, RP, RL, ADL, VS, TS, d, NDF);
    }
    /// <summary>
    /// Calculates the expected NH3 production of the substrate
    /// measured in l per g fresh matter
    /// based on buswell equation
    /// </summary>
    /// <param name="pRF">must be measured in % TS</param>
    /// <param name="pRP">must be measured in % TS</param>
    /// <param name="pRL">must be measured in % TS</param>
    /// <param name="pADL">must be measured in % TS</param>
    /// <param name="pVS">must be measured in % TS</param>
    /// <param name="pTS">must be measured in % FM</param>
    /// <param name="d">
    /// percentage of the degradable part of cellulose and hemicellulose
    /// </param>
    /// <param name="pNDF">neutral detergent fiber</param>
    /// <returns>expected NH3 production</returns>
    /// <exception cref="exception">Unit of parameters not as specified</exception>
    private static physValue calcNH3exp(physValue pRF, physValue pRP, physValue pRL,
                                     physValue pADL, physValue pVS, physValue pTS,
                                     double d, physValue pNDF)
    {
      physValue NH3exp, NH3expch, NH3exppr, NH3expli, pNfE;

      try
      {
        // TODO - es gibt auch NH3vol in chemistry
        // get the expected NH3 production for the basic molecules
        // mol NH3 / g of molecule
        NH3expch = biogas.chemistry.calcNH3exp("Xch");
        NH3exppr = biogas.chemistry.calcNH3exp("Xpr");
        NH3expli = biogas.chemistry.calcNH3exp("Xli");

        // calc nitrogen-free extract of the substrate
        pNfE = calcNfE(pRF, pRP, pRL, pVS);
      }
      catch (exception e)
      {
        Console.WriteLine(e.Message);
        return new physValue("error");
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
      if (pADL.Unit != "% TS")
        throw new exception(String.Format("ADL must be measured in % TS, not in {0}!", pADL.Unit));
      if (pNDF.Unit != "% TS")
        throw new exception(String.Format("NDF must be measured in % TS, not in {0}!", pNDF.Unit));

      // TODO - könnte Fehler werfen, aber ausgeschlossen, wegen Einheitenüberprüfung oben
      physValue RF = pRF.convertUnit("100 %");
      physValue RP = pRP.convertUnit("100 %");
      physValue RL = pRL.convertUnit("100 %");
      physValue NfE = pNfE.convertUnit("100 %");
      physValue ADL = pADL.convertUnit("100 %");
      physValue NDF = pNDF.convertUnit("100 %");

      // mol NH3 per g substrate FM
      // Quelle: Koch et al. 2010
      NH3exp = TS * (
              RP * NH3exppr +  // proteins
              RL * NH3expli +  // lipids
             ((RF + NfE - NDF) + (NDF - ADL) * d) * NH3expch // carbohydrates - lignin
           );

      // l co2 per g of substrate FM
      NH3exp = NH3exp * chemistry.Vm;

      return NH3exp;
    }

    /// <summary>
    /// Calculates the expected H2S production of the substrate
    /// measured in l per g fresh matter
    /// based on buswell equation
    /// </summary>
    /// <returns>expected H2S production</returns>
    /// <exception cref="exception">Unit of parameters not as specified in method below
    /// </exception>
    private physValue calcH2Sexp()
    {
      return calcH2Sexp(this);
    }
    /// <summary>
    /// Calculates the expected H2S production of the substrate
    /// measured in l per g fresh matter
    /// based on buswell equation
    /// </summary>
    /// <param name="mySubstrate">a substrate</param>
    /// <returns>expected H2S production</returns>
    /// <exception cref="exception">Unit of parameters not as specified in method below
    /// </exception>
    private static physValue calcH2Sexp(substrate mySubstrate)
    {
      physValue[] values = new physValue[7];

      try
      {
        mySubstrate.get_params_of(out values, "RF", "RP", "RL",
                                              "ADL", "VS", "TS", "NDF");
      }
      catch (exception e)
      {
        Console.WriteLine(e.Message);
        return new physValue("error");
      }

      physValue RF = values[0];
      physValue RP = values[1];
      physValue RL = values[2];
      physValue ADL = values[3];
      physValue VS = values[4];
      physValue TS = values[5];
      physValue NDF = values[6];

      double d;

      try
      {
        d = calc_d(mySubstrate);
      }
      catch (exception e)
      {
        Console.WriteLine(e.Message);
        return new physValue("error2");
      }

      return calcH2Sexp(RF, RP, RL, ADL, VS, TS, d, NDF);
    }
    /// <summary>
    /// Calculates the expected H2S production of the substrate
    /// measured in l per g fresh matter
    /// based on buswell equation
    /// </summary>
    /// <param name="pRF">must be measured in % TS</param>
    /// <param name="pRP">must be measured in % TS</param>
    /// <param name="pRL">must be measured in % TS</param>
    /// <param name="pADL">must be measured in % TS</param>
    /// <param name="pVS">must be measured in % TS</param>
    /// <param name="pTS">must be measured in % FM</param>
    /// <param name="d">
    /// percentage of the degradable part of cellulose and hemicellulose
    /// </param>
    /// <param name="pNDF">neutral detergent fiber</param>
    /// <returns>expected H2S production</returns>
    /// <exception cref="exception">Unit of parameters not as specified</exception>
    private static physValue calcH2Sexp(physValue pRF, physValue pRP, physValue pRL,
                                     physValue pADL, physValue pVS, physValue pTS,
                                     double d, physValue pNDF)
    {
      physValue H2Sexp, H2Sexpch, H2Sexppr, H2Sexpli, pNfE;

      try
      {
        // TODO - es gibt auch H2Svol in chemistry
        // get the expected H2S production for the basic molecules
        // mol H2S / g of molecule
        H2Sexpch = biogas.chemistry.calcH2Sexp("Xch");
        H2Sexppr = biogas.chemistry.calcH2Sexp("Xpr");
        H2Sexpli = biogas.chemistry.calcH2Sexp("Xli");

        // calc nitrogen-free extract of the substrate
        pNfE = calcNfE(pRF, pRP, pRL, pVS);
      }
      catch (exception e)
      {
        Console.WriteLine(e.Message);
        return new physValue("error");
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
      if (pADL.Unit != "% TS")
        throw new exception(String.Format("ADL must be measured in % TS, not in {0}!", pADL.Unit));
      if (pNDF.Unit != "% TS")
        throw new exception(String.Format("NDF must be measured in % TS, not in {0}!", pNDF.Unit));

      // TODO - könnte Fehler werfen, aber ausgeschlossen, wegen Einheitenüberprüfung oben
      physValue RF = pRF.convertUnit("100 %");
      physValue RP = pRP.convertUnit("100 %");
      physValue RL = pRL.convertUnit("100 %");
      physValue NfE = pNfE.convertUnit("100 %");
      physValue ADL = pADL.convertUnit("100 %");
      physValue NDF = pNDF.convertUnit("100 %");

      // mol H2S per g substrate FM
      // Quelle: Koch et al. 2010
      H2Sexp = TS * (
              RP * H2Sexppr +  // proteins
              RL * H2Sexpli +  // lipids
             ((RF + NfE - NDF) + (NDF - ADL) * d) * H2Sexpch // carbohydrates - lignin
           );

      // l co2 per g of substrate FM
      H2Sexp = H2Sexp * chemistry.Vm;

      return H2Sexp;
    }

    /// <summary>
    /// Calculates gas quality of substrate.
    /// gas quality: % methane content in resulting biogas
    /// based on ratio of ch4 to ch4 + co2 + nh3 + h2s
    /// this is based on the extended buswell equation
    /// </summary>
    /// <returns>gas quality, methane in %</returns>
    /// <exception cref="exception">Unit of parameters not as specified in method below
    /// </exception>
    private physValue calcGasQuality()
    {
      return calcGasQuality(this);
    }
    /// <summary>
    /// Calculates gas quality of substrate.
    /// gas quality: % methane content in resulting biogas
    /// based on ratio of ch4 to ch4 + co2 + nh3 + h2s
    /// this is based on the extended buswell equation
    /// </summary>
    /// <param name="mySubstrate">a substrate</param>
    /// <returns>gas quality, methane in %</returns>
    /// <exception cref="exception">Unit of parameters not as specified in method below
    /// </exception>
    private static physValue calcGasQuality(substrate mySubstrate)
    {
      physValue[] values= new physValue[5];

      try
      {
      mySubstrate.get_params_of(out values, "RF", "RP", "RL",
                                            "ADL", "VS");//, "TS");
      }
      catch (exception e)
      {
        Console.WriteLine(e.Message);
        return new physValue("error");
      }

      physValue RF=  values[0];
      physValue RP=  values[1];
      physValue RL=  values[2];
      physValue ADL= values[3];
      physValue VS=  values[4];
      //physValue TS=  values[5];

      return calcGasQuality(RF, RP, RL, ADL, VS);//, TS);
    }
    /// <summary>
    /// Calculates gas quality of substrate.
    /// gas quality: % methane content in resulting biogas
    /// based on ratio of ch4 to ch4 + co2 + nh3 + h2s
    /// this is based on the extended buswell equation
    /// </summary>
    /// <param name="pRF">must be measured in % TS</param>
    /// <param name="pRP">must be measured in % TS</param>
    /// <param name="pRL">must be measured in % TS</param>
    /// <param name="pADL">must be measured in % TS</param>
    /// <param name="pVS">must be measured in % TS</param>
    /// <returns>gas quality, methane in %</returns>
    /// <exception cref="exception">Unit of parameters not as specified</exception>
    private static physValue calcGasQuality(physValue pRF, physValue pRP, physValue pRL,
                                            physValue pADL, physValue pVS)//, physValue pTS)
    {
      physValue gasQuality, gasQualitych, gasQualitypr, gasQualityli, pNfE;

      try
      {
        // get the gas quality for the basic molecules
        gasQualitych = biogas.chemistry.calcGasQuality("Xch");
        gasQualitypr = biogas.chemistry.calcGasQuality("Xpr");
        gasQualityli = biogas.chemistry.calcGasQuality("Xli");
        // is zero
        //physValue gasQualityl=  biogas.chemistry.calcGasQuality("Lignin");

        // calc nitrogen-free extract of the substrate
        pNfE = calcNfE(pRF, pRP, pRL, pVS);
      }
      catch (exception e)
      { 
        Console.WriteLine(e.Message);
        return new physValue("error");
      }

      // all numbers are given in % FM respectively % TS, 
      // divide by 100 % FM respectively % TS to get them in 100 %, thus unitless

      //if (pTS.Unit != "% FM")
      //  throw new exception(String.Format("TS must be measured in % FM, not in {0}!", pTS.Unit));

      //physValue TS=   pTS.convertUnit("100 %");

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

      // Fehler ist ausgeschlossen
      physValue RF=   pRF.convertUnit("100 %");
      physValue RP=   pRP.convertUnit("100 %");
      physValue RL=   pRL.convertUnit("100 %");
      physValue NfE= pNfE.convertUnit("100 %");
      physValue ADL= pADL.convertUnit("100 %");

      physValue sum_c= RP + RL + RF + NfE;

      if (sum_c != new physValue(0, "100 %"))
      {
        // gewichteter Mittelwert
        gasQuality = (
                RP * gasQualitypr +  // proteins
                RL * gasQualityli +  // lipids
          //ADL * BMPl  +  // lignin
               (RF + NfE) * gasQualitych // carbohydrates - lignin
                    ) / sum_c;
      }
      else
      {
        Console.WriteLine("sum_c == 0");
        return new physValue("error");
      }

      return gasQuality;
    }


    
  }
}


