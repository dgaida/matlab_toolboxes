/**
 * This file is part of the partial class substrate and defines
 * public methods used to calculate the f-Factors.
 * fCh_Xc, fPr_Xc, fLi_Xc, fSI_Xc, fXI_Xc, fXp_Xc
 * 
 * TODOs:
 * - think about calcfSI_Xc(), because it is just returning 0. is ok.
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
  public partial class substrate
  {
    // -------------------------------------------------------------------------------------
    //                        !!! PUBLIC METHODS: f-Factors !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// Calculates all f Factors
    /// It is assured that the sum of all f factors is 1.
    /// </summary>
    /// <param name="fCH_XC">fCh_Xc</param>
    /// <param name="fPR_XC">fPr_Xc</param>
    /// <param name="fLI_XC">fLi_Xc</param>
    /// <param name="fXI_XC">fXI_Xc</param>
    /// <param name="fSI_XC">fSI_Xc</param>
    /// <param name="fXP_XC">fXP_Xc</param>
    /// <exception cref="exception">value out of bounds</exception>
    public void calcfFactors(out double fCH_XC, out double fPR_XC, out double fLI_XC,
                             out double fXI_XC, out double fSI_XC, out double fXP_XC)
    { 
      fXP_XC = calcfXp_Xc(out fCH_XC, out fPR_XC, out fLI_XC, out fXI_XC, out fSI_XC);
    }
     
    /// <summary>
    /// Calculates the f-Factor: fCh_Xc, defining the fraction of carbohydrates in 
    /// composites Xc
    /// 
    /// As a reference see:
    /// 
    /// Koch, K., Lübken, M., Gehring, T., Wichern, M., and Horn, H.: 
    /// Biogas from grass silage – Measurements and modeling with ADM1, 
    /// Bioresource Technology 101, pp. 8158-8165, 2010.
    /// 
    /// </summary>
    /// <returns>fCh_Xc</returns>
    /// <exception cref="exception">value out of bounds</exception>
    public double calcfCh_Xc()
    {
      return calcfCh_Xc(this);
    }
    /// <summary>
    /// Calculates the f-Factor: fCh_Xc, defining the fraction of carbohydrates in 
    /// composites Xc
    /// </summary>
    /// <param name="mySubstrate">a substrate</param>
    /// <returns>fCh_Xc</returns>
    /// <exception cref="exception">value out of bounds</exception>
    public static double calcfCh_Xc(substrate mySubstrate)
    {
      physValue[] values= new physValue[6];

      try
      {
        mySubstrate.get_params_of(out values, "RF", "NfE", "ADL", "NDF", "VS", "D_VS");
      }
      catch (exception e)
      {
        Console.WriteLine(e.Message);
        return -1;
      }

      physValue RF=   values[0];
      physValue NfE=  values[1];
      physValue ADL=  values[2];
      physValue NDF=  values[3];
      physValue VS=   values[4];
      physValue D_VS= values[5];

      return calcfCh_Xc(RF, NfE, ADL, NDF, VS, D_VS);
    }
    /// <summary>
    /// Calculates the f-Factor: fCh_Xc, defining the fraction of carbohydrates in 
    /// composites Xc
    /// </summary>
    /// <param name="RF">must be measured in % TS</param>
    /// <param name="NfE">must be measured in % TS</param>
    /// <param name="ADL">must be measured in % TS</param>
    /// <param name="NDF">must be measured in % TS</param>
    /// <param name="VS">must be measured in % TS</param>
    /// <param name="D_VS">must be measured in 100 %</param>
    /// <returns>fCh_Xc</returns>
    /// <exception cref="exception">value out of bounds</exception>
    public static double calcfCh_Xc(double RF,  double NfE, double ADL, 
                                    double NDF, double VS,  double D_VS)
    {
      physValue pRF=   new science.physValue("RF",   RF,   "% TS");
      physValue pNfE=  new science.physValue("NfE",  NfE,  "% TS");
      physValue pADL=  new science.physValue("ADL",  ADL,  "% TS");
      physValue pNDF=  new science.physValue("NDF",  NDF,  "% TS");
      physValue pVS=   new science.physValue("VS",   VS,   "% TS");
      physValue pD_VS= new science.physValue("D_VS", D_VS, "100 %");

      return calcfCh_Xc(pRF, pNfE, pADL, pNDF, pVS, pD_VS);
    }
    /// <summary>
    /// Calculates the f-Factor: fCh_Xc, defining the fraction of carbohydrates in 
    /// composites Xc
    /// The values given are converted to the correct unit, thus the units
    /// of the given values are not important. 
    /// </summary>
    /// <param name="pRF">raw fiber</param>
    /// <param name="pNfE">nitrogen free extracts</param>
    /// <param name="pADL">acid detergent lignin</param>
    /// <param name="pNDF">neutral detergent fiber</param>
    /// <param name="pVS">volatile solids</param>
    /// <param name="pD_VS">degradation level</param>
    /// <returns>fCh_Xc</returns>
    /// <exception cref="exception">value out of bounds</exception>
    public static double calcfCh_Xc(physValue pRF,  physValue pNfE, physValue pADL, 
                                    physValue pNDF, physValue pVS,  physValue pD_VS)
    {
      physValue RF=     pRF.convertUnit("% TS");
      physValue NfE=   pNfE.convertUnit("% TS");
      physValue ADL=   pADL.convertUnit("% TS");
      physValue NDF=   pNDF.convertUnit("% TS");
      physValue VS=     pVS.convertUnit("% TS");
      physValue D_VS= pD_VS.convertUnit("100 %");

      double d= calc_d(ADL, NDF, D_VS, VS);

      physValue pfCh_Xc;

      if (VS.Value > 0)
        pfCh_Xc= (calcNFC(RF, NfE, NDF) + d * (NDF - ADL)) / VS;
      else
        pfCh_Xc= new physValue(0, "-");

      double fCh_Xc= pfCh_Xc.Value;

      if (fCh_Xc < 0 || fCh_Xc > 1)
        throw new exception(String.Format("fCh_Xc is out of bounds [0,1]: {0}!",
                                           fCh_Xc));

      return fCh_Xc;
    }

    /// <summary>
    /// Calculates the f-Factor: fLi_Xc, defining the fraction of lipids in 
    /// composites Xc
    /// 
    /// As a reference see:
    /// 
    /// Koch, K., Lübken, M., Gehring, T., Wichern, M., and Horn, H.: 
    /// Biogas from grass silage – Measurements and modeling with ADM1, 
    /// Bioresource Technology 101, pp. 8158-8165, 2010.
    /// 
    /// </summary>
    /// <returns>fLi_Xc</returns>
    /// <exception cref="exception">value out of bounds</exception>
    public double calcfLi_Xc()
    {
      return calcfLi_Xc(this);
    }
    /// <summary>
    /// Calculates the f-Factor: fLi_Xc, defining the fraction of lipids in 
    /// composites Xc
    /// </summary>
    /// <param name="mySubstrate">a substrate</param>
    /// <returns>fLi_Xc</returns>
    /// <exception cref="exception">value out of bounds</exception>
    public static double calcfLi_Xc(substrate mySubstrate)
    {
      physValue[] values= new physValue[2];

      try
      {
        mySubstrate.get_params_of(out values, "RL", "VS");
      }
      catch (exception e)
      {
        Console.WriteLine(e.Message);
        return -1;
      }

      physValue RL= values[0];
      physValue VS= values[1];
      
      return calcfLi_Xc(RL, VS);
    }
    /// <summary>
    /// Calculates the f-Factor: fLi_Xc, defining the fraction of lipids in 
    /// composites Xc
    /// </summary>
    /// <param name="RL">must be measured in % TS</param>
    /// <param name="VS">must be measured in % TS</param>
    /// <returns>fLi_Xc</returns>
    /// <exception cref="exception">value out of bounds</exception>
    public static double calcfLi_Xc(double RL, double VS)
    {
      physValue pRL= new science.physValue("RL", RL, "% TS");
      physValue pVS= new science.physValue("VS", VS, "% TS");
      
      return calcfLi_Xc(pRL, pVS);
    }
    /// <summary>
    /// Calculates the f-Factor: fLi_Xc, defining the fraction of lipids in 
    /// composites Xc
    /// </summary>
    /// <param name="pRL">RL</param>
    /// <param name="pVS">VS</param>
    /// <returns>fLi_Xc</returns>
    /// <exception cref="exception">value out of bounds</exception>
    public static double calcfLi_Xc(physValue pRL, physValue pVS)
    {
      physValue RL= pRL.convertUnit("% TS");
      physValue VS= pVS.convertUnit("% TS");

      physValue pfLi_Xc;
      
      if (VS.Value > 0)
        pfLi_Xc= RL / VS;
      else
        pfLi_Xc= new physValue(0, "-");

      double fLi_Xc= pfLi_Xc.Value;

      if (fLi_Xc < 0 || fLi_Xc > 1)
        throw new exception(String.Format("fLi_Xc is out of bounds [0,1]: {0}!",
                                          fLi_Xc));

      return fLi_Xc;
    }

    /// <summary>
    /// Calculates the f-Factor: fPr_Xc, defining the fraction of proteins in 
    /// composites Xc
    /// 
    /// As a reference see:
    /// 
    /// Koch, K., Lübken, M., Gehring, T., Wichern, M., and Horn, H.: 
    /// Biogas from grass silage – Measurements and modeling with ADM1, 
    /// Bioresource Technology 101, pp. 8158-8165, 2010.
    /// 
    /// </summary>
    /// <returns>fPr_Xc</returns>
    /// <exception cref="exception">value out of bounds</exception>
    public double calcfPr_Xc()
    {
      return calcfPr_Xc(this);
    }
    /// <summary>
    /// Calculates the f-Factor: fPr_Xc, defining the fraction of proteins in 
    /// composites Xc
    /// </summary>
    /// <param name="mySubstrate">a substrate</param>
    /// <returns>fPr_Xc</returns>
    /// <exception cref="exception">value out of bounds</exception>
    public static double calcfPr_Xc(substrate mySubstrate)
    {
      physValue[] values= new physValue[2];

      try
      {
        mySubstrate.get_params_of(out values, "RP", "VS");
      }
      catch (exception e)
      {
        Console.WriteLine(e.Message);
        return -1;
      }

      physValue RP= values[0];
      physValue VS= values[1];

      return calcfPr_Xc(RP, VS);
    }
    /// <summary>
    /// Calculates the f-Factor: fPr_Xc, defining the fraction of proteins in 
    /// composites Xc
    /// </summary>
    /// <param name="RP">must be measured in % TS</param>
    /// <param name="VS">must be measured in % TS</param>
    /// <returns>fPr_Xc</returns>
    /// <exception cref="exception">value out of bounds</exception>
    public static double calcfPr_Xc(double RP, double VS)
    {
      physValue pRP= new science.physValue("RP", RP, "% TS");
      physValue pVS= new science.physValue("VS", VS, "% TS");

      return calcfPr_Xc(pRP, pVS);
    }
    /// <summary>
    /// Calculates the f-Factor: fPr_Xc, defining the fraction of proteins in 
    /// composites Xc
    /// </summary>
    /// <param name="pRP">RP</param>
    /// <param name="pVS">VS</param>
    /// <returns>fPr_Xc</returns>
    /// <exception cref="exception">value out of bounds</exception>
    public static double calcfPr_Xc(physValue pRP, physValue pVS)
    {
      physValue RP= pRP.convertUnit("% TS");
      physValue VS= pVS.convertUnit("% TS");

      physValue pfPr_Xc;

      if (VS.Value > 0)
        pfPr_Xc= RP / VS;
      else
        pfPr_Xc= new physValue(0, "-");

      double fPr_Xc= pfPr_Xc.Value;

      if (fPr_Xc < 0 || fPr_Xc > 1)
        throw new exception(String.Format("fPr_Xc is out of bounds [0,1]: {0}!",
                                          fPr_Xc));

      return fPr_Xc;
    }

    /// <summary>
    /// Calculates the f-Factor: fXI_Xc, defining the fraction of particulate inerts in 
    /// composites Xc
    /// 
    /// As a reference see:
    /// 
    /// Koch, K., Lübken, M., Gehring, T., Wichern, M., and Horn, H.: 
    /// Biogas from grass silage – Measurements and modeling with ADM1, 
    /// Bioresource Technology 101, pp. 8158-8165, 2010.
    /// 
    /// </summary>
    /// <returns>fXI_Xc</returns>
    public double calcfXI_Xc()
    {
      return calcfXI_Xc(this);
    }
    /// <summary>
    /// Calculates the f-Factor: fXI_Xc, defining the fraction of particulate inerts in 
    /// composites Xc
    /// </summary>
    /// <param name="mySubstrate">a substrate</param>
    /// <returns>fXI_Xc</returns>
    public static double calcfXI_Xc(substrate mySubstrate)
    {
      physValue[] values= new physValue[4];

      try
      {
        mySubstrate.get_params_of(out values, "ADL", "NDF", "VS", "D_VS");
      }
      catch (exception e)
      {
        Console.WriteLine(e.Message);
        return -1;
      }

      physValue ADL=  values[0];
      physValue NDF=  values[1];
      physValue VS=   values[2];
      physValue D_VS= values[3];

      return calcfXI_Xc(ADL, NDF, VS, D_VS);
    }
    /// <summary>
    /// Calculates the f-Factor: fXI_Xc, defining the fraction of particulate inerts in 
    /// composites Xc
    /// </summary>
    /// <param name="ADL">must be measured in % TS</param>
    /// <param name="NDF">must be measured in % TS</param>
    /// <param name="VS">must be measured in % TS</param>
    /// <param name="D_VS">must be measured in 100 %</param>
    /// <returns>fXI_Xc</returns>
    public static double calcfXI_Xc(double ADL, double NDF, double VS, double D_VS)
    {
      physValue pADL=  new science.physValue("ADL",  ADL,  "% TS");
      physValue pNDF=  new science.physValue("NDF",  NDF,  "% TS");
      physValue pVS=   new science.physValue("VS",   VS,   "% TS");
      physValue pD_VS= new science.physValue("D_VS", D_VS, "100 %");

      return calcfXI_Xc(pADL, pNDF, pVS, pD_VS);
    }
    /// <summary>
    /// Calculates the f-Factor: fXI_Xc, defining the fraction of particulate inerts in 
    /// composites Xc
    /// </summary>
    /// <param name="pADL">ADL</param>
    /// <param name="pNDF">NDF</param>
    /// <param name="pVS">VS</param>
    /// <param name="pD_VS">degradation level</param>
    /// <returns>fXI_Xc</returns>
    /// <exception cref="exception">value out of bounds</exception>
    public static double calcfXI_Xc(physValue pADL, physValue pNDF, 
                                    physValue pVS, physValue pD_VS)
    {
      physValue ADL=   pADL.convertUnit("% TS");
      physValue NDF=   pNDF.convertUnit("% TS");
      physValue VS=     pVS.convertUnit("% TS");
      physValue D_VS= pD_VS.convertUnit("100 %");

      double d= calc_d(ADL, NDF, D_VS, VS);

      physValue pfXI_Xc;
      
      if (VS.Value > 0)
        pfXI_Xc= ( ADL + ( 1 - d) * ( NDF - ADL ) ) / VS;
      else
        pfXI_Xc= new physValue(0, "-");

      // 0.8 ist Test, noch nicht in thesis, s.u. fSI_XC, da steht 0.2f
      double fXI_Xc = pfXI_Xc.Value;// *0.6f;   

      if (fXI_Xc < 0 || fXI_Xc > 1)
        throw new exception(String.Format("fXI_Xc is out of bounds [0,1]: {0}!",
                                          fXI_Xc));

      return fXI_Xc;
    }

    /// <summary>
    /// Calculates the f-Factor: fSI_Xc, defining the fraction of soluble inerts in 
    /// composites Xc
    /// TODO: returns 0, think about, if this can and should be changed
    /// is ok, see my thesis
    /// </summary>
    /// <returns>fSI_Xc</returns>
    public double calcfSI_Xc()
    {
      return 0;
    }

    ///// <summary>
    ///// Calculates the f-Factor: fSI_Xc, defining the fraction of soluble inerts in 
    ///// composites Xc
    ///// 
    ///// As a reference see:
    ///// 
    ///// Koch, K., Lübken, M., Gehring, T., Wichern, M., and Horn, H.: 
    ///// Biogas from grass silage – Measurements and modeling with ADM1, 
    ///// Bioresource Technology 101, pp. 8158-8165, 2010.
    ///// 
    ///// </summary>
    ///// <returns>fSI_Xc</returns>
    //public double calcfSI_Xc()
    //{
    //  return calcfSI_Xc(this);
    //}
    ///// <summary>
    ///// Calculates the f-Factor: fSI_Xc, defining the fraction of soluble inerts in 
    ///// composites Xc
    ///// </summary>
    ///// <param name="mySubstrate">a substrate</param>
    ///// <returns>fSI_Xc</returns>
    //public static double calcfSI_Xc(substrate mySubstrate)
    //{
    //  physValue[] values = new physValue[4];

    //  try
    //  {
    //    mySubstrate.get_params_of(out values, "ADL", "NDF", "VS", "D_VS");
    //  }
    //  catch (exception e)
    //  {
    //    Console.WriteLine(e.Message);
    //    return -1;
    //  }

    //  physValue ADL = values[0];
    //  physValue NDF = values[1];
    //  physValue VS = values[2];
    //  physValue D_VS = values[3];

    //  return calcfSI_Xc(ADL, NDF, VS, D_VS);
    //}
    ///// <summary>
    ///// Calculates the f-Factor: fSI_Xc, defining the fraction of soluble inerts in 
    ///// composites Xc
    ///// </summary>
    ///// <param name="ADL">must be measured in % TS</param>
    ///// <param name="NDF">must be measured in % TS</param>
    ///// <param name="VS">must be measured in % TS</param>
    ///// <param name="D_VS">must be measured in 100 %</param>
    ///// <returns>fSI_Xc</returns>
    //public static double calcfSI_Xc(double ADL, double NDF, double VS, double D_VS)
    //{
    //  physValue pADL = new science.physValue("ADL", ADL, "% TS");
    //  physValue pNDF = new science.physValue("NDF", NDF, "% TS");
    //  physValue pVS = new science.physValue("VS", VS, "% TS");
    //  physValue pD_VS = new science.physValue("D_VS", D_VS, "100 %");

    //  return calcfSI_Xc(pADL, pNDF, pVS, pD_VS);
    //}
    ///// <summary>
    ///// Calculates the f-Factor: fSI_Xc, defining the fraction of soluble inerts in 
    ///// composites Xc
    ///// </summary>
    ///// <param name="pADL">ADL</param>
    ///// <param name="pNDF">NDF</param>
    ///// <param name="pVS">VS</param>
    ///// <param name="pD_VS">degradation level</param>
    ///// <returns>fSI_Xc</returns>
    ///// <exception cref="exception">value out of bounds</exception>
    //public static double calcfSI_Xc(physValue pADL, physValue pNDF,
    //                                physValue pVS, physValue pD_VS)
    //{
    //  physValue ADL = pADL.convertUnit("% TS");
    //  physValue NDF = pNDF.convertUnit("% TS");
    //  physValue VS = pVS.convertUnit("% TS");
    //  physValue D_VS = pD_VS.convertUnit("100 %");

    //  double d = calc_d(ADL, NDF, D_VS, VS);

    //  physValue pfSI_Xc;

    //  if (VS.Value > 0)
    //    pfSI_Xc = (ADL + (1 - d) * (NDF - ADL)) / VS;
    //  else
    //    pfSI_Xc = new physValue(0, "-");

    //  // 0.2 ist Test, noch nicht in thesis, s.o. fXI_XC, da steht 0.8f
    //  // wird gemacht um TS Gehalt zu senken, Test
    //  double fSI_Xc = pfSI_Xc.Value * 0.4f;

    //  if (fSI_Xc < 0 || fSI_Xc > 1)
    //    throw new exception(String.Format("fSI_Xc is out of bounds [0,1]: {0}!",
    //                                      fSI_Xc));

    //  return fSI_Xc;
    //}

    /// <summary>
    /// Calculates the f-Factor: fXp_Xc, defining the fraction of Xp in 
    /// composites Xc
    /// </summary>
    /// <returns>fXp_Xc</returns>
    /// <exception cref="exception">value out of bounds</exception>
    public double calcfXp_Xc()
    {
      return 1 - calcfCh_Xc() - calcfPr_Xc() - calcfLi_Xc() - calcfXI_Xc() - calcfSI_Xc();
    }

    /// <summary>
    /// this is the more economic version if you need all f factors anyway.
    /// returns fXp_XC
    /// </summary>
    /// <param name="fCH_XC">fCh_Xc</param>
    /// <param name="fPR_XC">fPr_Xc</param>
    /// <param name="fLI_XC">fLi_Xc</param>
    /// <param name="fXI_XC">fXI_Xc</param>
    /// <param name="fSI_XC">fSI_Xc</param>
    /// <returns>fXP_Xc</returns>
    /// <exception cref="exception">value out of bounds</exception>
    public double calcfXp_Xc(out double fCH_XC, out double fPR_XC, out double fLI_XC,
                             out double fXI_XC, out double fSI_XC)
    {
      fCH_XC = calcfCh_Xc();
      fPR_XC = calcfPr_Xc();
      fLI_XC = calcfLi_Xc();
      fXI_XC = calcfXI_Xc();
      fSI_XC = calcfSI_Xc();

      return 1 - fCH_XC - fPR_XC - fLI_XC - fXI_XC - fSI_XC;
    }



    /// <summary>
    /// calc fSIN_Xc, which is ratio of (NH4 + NH3) / XcIN
    /// NH3+NH4 fraction from XC
    /// </summary>
    /// <returns>fSIN_Xc</returns>
    /// <exception cref="exception">value out of bounds</exception>
    public double calcfSIN_Xc()
    {
      return 0;
      //return calcfSIN_Xc(this);
    }

    // fSIN_Xc ist gefährlich
    // da fSIN_xc= (NH4 + NH3)/XcIN, ist der Parameter nicht mehr "linear"
    // das problem liegt in der mittelwertbildung.
    // der mittelwert dieses Parameters multipliziert mit dem mittelwert von XcIN
    // ist nicht der Mittelwert von NH4+NH3 !!!
    // deshalb nutze ich den Parameter nicht mehr
    // mit n := NH4+NH3 und x := XcIN und dem gewichtugnsfaktor a in [0, 1]
    // 
    // ( a*n1/x1 + (1-a)*n2/x2 ) * ( a*x1 + (1-a)*x2 ) !=
    // das was man erwarten würde
    // ( a*n1 + (1-a)*n2 )

    ///// <summary>
    ///// calc fSIN_Xc, which is ratio of (NH4 + NH3) / XcIN
    ///// NH3+NH4 fraction from XC
    ///// </summary>
    ///// <param name="mySubstrate"></param>
    ///// <returns>fSIN_Xc</returns>
    ///// <exception cref="exception">value out of bounds</exception>
    //public static double calcfSIN_Xc(substrate mySubstrate)
    //{
    //  physValue[] values = new physValue[3];

    //  try
    //  {
    //    mySubstrate.get_params_of(out values, "Snh4", "Snh3", "XcIN"/*, 
    //      "COD_SX", "Xbacteria", "Xmethan"*/);
    //  }
    //  catch (exception e)
    //  {
    //    Console.WriteLine(e.Message);
    //    return -1;
    //  }

    //  physValue Snh4 = values[0];
    //  physValue Snh3 = values[1];
    //  physValue XcIN = values[2];
    //  //physValue COD_SX = values[3];
    //  //physValue Xbac = values[4];
    //  //physValue Xmeth = values[5];
      
    //  return calcfSIN_Xc(Snh4, Snh3, XcIN/*, COD_SX, Xbac, Xmeth*/);
    //}
    ///// <summary>
    ///// calc fSIN_Xc, which is ratio of (NH4 + NH3) / XcIN
    ///// NH3+NH4 fraction from XC
    ///// </summary>
    ///// <param name="pNH4">NH4</param>
    ///// <param name="pNH3">NH3</param>
    ///// <param name="pXcIN">particulate COD of input</param>
    ///// <returns>fSIN_Xc</returns>
    ///// <exception cref="exception">value out of bounds</exception>
    //public static double calcfSIN_Xc(physValue pNH4, physValue pNH3,
    //                                 physValue pXcIN/*, physValue pCOD_SX, 
    //                                 physValue pXbac, physValue pXmeth*/)
    //{
    //  physValue NH4 = pNH4.convertUnit("kmol/m^3");
    //  physValue NH3 = pNH3.convertUnit("kmol/m^3");
    //  physValue XcIN = pXcIN.convertUnit("kgCOD/m^3");
    //  //physValue COD_SX = pCOD_SX.convertUnit("kgCOD/m^3");
    //  //physValue Xbac = pXbac.convertUnit("kgCOD/m^3");
    //  //physValue Xmeth = pXmeth.convertUnit("kgCOD/m^3");
      
    //  physValue pfSIN_Xc;

    //  if (XcIN /*- COD_SX - Xbac - Xmeth*/ > new physValue(0, "kgCOD/m^3"))
    //    pfSIN_Xc = ( NH4 + NH3 ) / (XcIN /*- COD_SX - Xbac - Xmeth*/);
    //  else
    //    pfSIN_Xc = new physValue(0, "-");

    //  // kmol N / kgCOD
    //  double fSIN_Xc = pfSIN_Xc.Value;

    //  if (fSIN_Xc < 0 || fSIN_Xc > 1)
    //    throw new exception(String.Format("fSIN_Xc is out of bounds [0,1]: {0}!",
    //                                      fSIN_Xc));

    //  return fSIN_Xc;
    //}



  }
}


