/**
 * This file is part of the partial class substrate and defines
 * private methods, all are calc... (... are C, H, O, N, S) methods.
 * 
 * TODOs:
 * - 
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
    /// Calculate g C / kg substrate fresh matter
    /// </summary>
    /// <returns>g C / kg fresh matter</returns>
    private physValue calcC()
    {
      return calcC(this);
    }
    /// <summary>
    /// Calculate g C / kg substrate fresh matter
    /// </summary>
    /// <param name="mySubstrate">a substrate</param>
    /// <returns>g C / kg fresh matter</returns>
    private static physValue calcC(substrate mySubstrate)
    {
      physValue[] values= new physValue[6];

      try
      {
        mySubstrate.get_params_of(out values, "RF", "RP", "RL",
                                              "NfE", "ADL", "TS");
      }
      catch (exception e)
      {
        Console.WriteLine(e.Message);

        return new physValue("error");
      }

      physValue RF=  values[0];
      physValue RP=  values[1];
      physValue RL=  values[2];
      physValue NfE= values[3];
      physValue ADL= values[4];
      physValue TS=  values[5];

      return calcC(RF, RP, RL, NfE, ADL, TS);
    }
    /// <summary>
    /// Calculate g C / kg substrate fresh matter
    /// </summary>
    /// <param name="RF">must be measured in % TS</param>
    /// <param name="RP">must be measured in % TS</param>
    /// <param name="RL">must be measured in % TS</param>
    /// <param name="NfE">must be measured in % TS</param>
    /// <param name="ADL">must be measured in % TS</param>
    /// <param name="TS">must be measured in % FM</param>
    /// <returns>g C / kg fresh matter</returns>
    private static physValue calcC(double RF,  double RP,  double RL, 
                                   double NfE, double ADL, double TS)
    {
      physValue pRF=  new science.physValue("RF",  RF,  "% TS");
      physValue pRP=  new science.physValue("RP",  RP,  "% TS");
      physValue pRL=  new science.physValue("RL",  RL,  "% TS");
      physValue pNfE= new science.physValue("NfE", NfE, "% TS");
      physValue pADL= new science.physValue("ADL", ADL, "% TS");
      physValue pTS=  new science.physValue("TS",  TS,  "% FM");

      return calcC(pRF, pRP, pRL, pNfE, pADL, pTS);
    }
    /// <summary>
    /// Calculate g C / kg substrate fresh matter
    /// </summary>
    /// <param name="pRF">raw fiber</param>
    /// <param name="pRP">raw protein</param>
    /// <param name="pRL">raw lipids</param>
    /// <param name="pNfE">nitrogen free extracts</param>
    /// <param name="pADL">acid detergent lignin</param>
    /// <param name="pTS">total solids</param>
    /// <returns>g C / kg fresh matter</returns>
    private static physValue calcC(physValue pRF,  physValue pRP,  physValue pRL,
                                   physValue pNfE, physValue pADL, physValue pTS)
    {
      physValue C_ch, C_pr, C_li, C_Lignin;
      physValue RF, RP, RL, NfE, ADL, TS;

      try
      {
        // g C / mol carbohydrates / ( g / mol carbohydrates) = g C / g carbohydrates
        C_ch=     biogas.chemistry.get_C_rel_mass_of("Xch");
        // g C / mol proteins / ( g / mol proteins) = g C / g proteins
        C_pr=     biogas.chemistry.get_C_rel_mass_of("Xpr");
        // g C / mol lipids / ( g / mol lipids) = g C / g lipids
        C_li=     biogas.chemistry.get_C_rel_mass_of("Xli");
        // g C / mol lignin / ( g / mol lignin) = g C / g lignin
        C_Lignin= biogas.chemistry.get_C_rel_mass_of("Lignin");

        RF=   pRF.convertUnit("100 %");
        RP=   pRP.convertUnit("100 %");
        RL=   pRL.convertUnit("100 %");
        NfE= pNfE.convertUnit("100 %");
        ADL= pADL.convertUnit("100 %");
        TS=   pTS.convertUnit("% FM");

        TS= TS.convertUnit("100 %");
      }
      catch (exception e)
      {
        Console.WriteLine(e.Message);

        return new physValue("error");
      }

      // g C / g substrate * 1000 g / kg = 1000 g C / kg 
      physValue C_total= TS * ( RP * C_pr +        // proteins
                                RL * C_li +        // lipids
                               ADL * C_Lignin  +   // lignin
                  (RF + NfE - ADL) * C_ch) * new physValue(1000, "g/kg");

      C_total.Symbol= "C";

      return C_total;
    }

    /// <summary>
    /// Calculate g H / kg substrate fresh matter
    /// </summary>
    /// <returns>g H / kg substrate FM</returns>
    private physValue calcH()
    {
      return calcH(this);
    }
    /// <summary>
    /// Calculate g H / kg substrate fresh matter
    /// </summary>
    /// <param name="mySubstrate">a substrate</param>
    /// <returns>g H / kg substrate FM</returns>
    private static physValue calcH(substrate mySubstrate)
    {
      physValue[] values = new physValue[6];

      try
      {
        mySubstrate.get_params_of(out values, "RF", "RP", "RL",
                                              "NfE", "ADL", "TS");
      }
      catch (exception e)
      {
        Console.WriteLine(e.Message);

        return new physValue("error");
      }

      physValue RF = values[0];
      physValue RP = values[1];
      physValue RL = values[2];
      physValue NfE = values[3];
      physValue ADL = values[4];
      physValue TS = values[5];

      return calcH(RF, RP, RL, NfE, ADL, TS);
    }
    /// <summary>
    /// Calculate g H / kg substrate fresh matter
    /// </summary>
    /// <param name="RF">must be measured in % TS</param>
    /// <param name="RP">must be measured in % TS</param>
    /// <param name="RL">must be measured in % TS</param>
    /// <param name="NfE">must be measured in % TS</param>
    /// <param name="ADL">must be measured in % TS</param>
    /// <param name="TS">must be measured in % FM</param>
    /// <returns>g H / kg substrate FM</returns>
    private static physValue calcH(double RF, double RP, double RL,
                                   double NfE, double ADL, double TS)
    {
      physValue pRF = new science.physValue("RF", RF, "% TS");
      physValue pRP = new science.physValue("RP", RP, "% TS");
      physValue pRL = new science.physValue("RL", RL, "% TS");
      physValue pNfE = new science.physValue("NfE", NfE, "% TS");
      physValue pADL = new science.physValue("ADL", ADL, "% TS");
      physValue pTS = new science.physValue("TS", TS, "% FM");

      return calcH(pRF, pRP, pRL, pNfE, pADL, pTS);
    }
    /// <summary>
    /// Calculate g H / kg substrate fresh matter
    /// </summary>
    /// <param name="pRF">raw fiber</param>
    /// <param name="pRP">raw protein</param>
    /// <param name="pRL">raw lipids</param>
    /// <param name="pNfE">nitrogen free extracts</param>
    /// <param name="pADL">acid detergent lignin</param>
    /// <param name="pTS">total solids</param>
    /// <returns>g H / kg substrate FM</returns>
    private static physValue calcH(physValue pRF, physValue pRP, physValue pRL,
                                   physValue pNfE, physValue pADL, physValue pTS)
    {
      physValue H_ch, H_pr, H_li, H_Lignin;
      physValue RF, RP, RL, NfE, ADL, TS;

      try
      {
        // g H / mol carbohydrates / ( g / mol carbohydrates) = g H / g carbohydrates
        H_ch = biogas.chemistry.get_H_rel_mass_of("Xch");
        // g H / mol proteins / ( g / mol proteins) = g H / g proteins
        H_pr = biogas.chemistry.get_H_rel_mass_of("Xpr");
        // g H / mol lipids / ( g / mol lipids) = g H / g lipids
        H_li = biogas.chemistry.get_H_rel_mass_of("Xli");
        // g H / mol lignin / ( g / mol lignin) = g H / g lignin
        H_Lignin = biogas.chemistry.get_H_rel_mass_of("Lignin");

        RF = pRF.convertUnit("100 %");
        RP = pRP.convertUnit("100 %");
        RL = pRL.convertUnit("100 %");
        NfE = pNfE.convertUnit("100 %");
        ADL = pADL.convertUnit("100 %");
        TS = pTS.convertUnit("% FM");

        TS = TS.convertUnit("100 %");
      }
      catch (exception e)
      {
        Console.WriteLine(e.Message);

        return new physValue("error");
      }

      // g H / g substrate * 1000 g / kg = 1000 g H / kg 
      physValue H_total = TS * (RP * H_pr +        // proteins
                                RL * H_li +        // lipids
                               ADL * H_Lignin +   // lignin
                  (RF + NfE - ADL) * H_ch) * new physValue(1000, "g/kg");

      H_total.Symbol = "H";

      return H_total;
    }

    /// <summary>
    /// Calculate g O / kg substrate fresh matter
    /// </summary>
    /// <returns>g O / kg substrate FM</returns>
    private physValue calcO()
    {
      return calcO(this);
    }
    /// <summary>
    /// Calculate g O / kg substrate fresh matter
    /// </summary>
    /// <param name="mySubstrate">a substrate</param>
    /// <returns>g O / kg substrate FM</returns>
    private static physValue calcO(substrate mySubstrate)
    {
      physValue[] values = new physValue[6];

      try
      {
        mySubstrate.get_params_of(out values, "RF", "RP", "RL",
                                              "NfE", "ADL", "TS");
      }
      catch (exception e)
      {
        Console.WriteLine(e.Message);

        return new physValue("error");
      }

      physValue RF = values[0];
      physValue RP = values[1];
      physValue RL = values[2];
      physValue NfE = values[3];
      physValue ADL = values[4];
      physValue TS = values[5];

      return calcO(RF, RP, RL, NfE, ADL, TS);
    }
    /// <summary>
    /// Calculate g O / kg substrate fresh matter
    /// </summary>
    /// <param name="RF">must be measured in % TS</param>
    /// <param name="RP">must be measured in % TS</param>
    /// <param name="RL">must be measured in % TS</param>
    /// <param name="NfE">must be measured in % TS</param>
    /// <param name="ADL">must be measured in % TS</param>
    /// <param name="TS">must be measured in % FM</param>
    /// <returns>g O / kg substrate FM</returns>
    private static physValue calcO(double RF, double RP, double RL,
                                   double NfE, double ADL, double TS)
    {
      physValue pRF = new science.physValue("RF", RF, "% TS");
      physValue pRP = new science.physValue("RP", RP, "% TS");
      physValue pRL = new science.physValue("RL", RL, "% TS");
      physValue pNfE = new science.physValue("NfE", NfE, "% TS");
      physValue pADL = new science.physValue("ADL", ADL, "% TS");
      physValue pTS = new science.physValue("TS", TS, "% FM");

      return calcO(pRF, pRP, pRL, pNfE, pADL, pTS);
    }
    /// <summary>
    /// Calculate g O / kg substrate fresh matter
    /// </summary>
    /// <param name="pRF">raw fiber</param>
    /// <param name="pRP">raw protein</param>
    /// <param name="pRL">raw lipids</param>
    /// <param name="pNfE">nitrogen free extracts</param>
    /// <param name="pADL">acid detergent lignin</param>
    /// <param name="pTS">total solids</param>
    /// <returns>g O / kg substrate FM</returns>
    private static physValue calcO(physValue pRF, physValue pRP, physValue pRL,
                                   physValue pNfE, physValue pADL, physValue pTS)
    {
      physValue O_ch, O_pr, O_li, O_Lignin;
      physValue RF, RP, RL, NfE, ADL, TS;

      try
      {
        // g O / mol carbohydrates / ( g / mol carbohydrates) = g O / g carbohydrates
        O_ch = biogas.chemistry.get_O_rel_mass_of("Xch");
        // g O / mol proteins / ( g / mol proteins) = g O / g proteins
        O_pr = biogas.chemistry.get_O_rel_mass_of("Xpr");
        // g O / mol lipids / ( g / mol lipids) = g O / g lipids
        O_li = biogas.chemistry.get_O_rel_mass_of("Xli");
        // g O / mol lignin / ( g / mol lignin) = g O / g lignin
        O_Lignin = biogas.chemistry.get_O_rel_mass_of("Lignin");

        RF = pRF.convertUnit("100 %");
        RP = pRP.convertUnit("100 %");
        RL = pRL.convertUnit("100 %");
        NfE = pNfE.convertUnit("100 %");
        ADL = pADL.convertUnit("100 %");
        TS = pTS.convertUnit("% FM");

        TS = TS.convertUnit("100 %");
      }
      catch (exception e)
      {
        Console.WriteLine(e.Message);

        return new physValue("error");
      }

      // g O / g substrate * 1000 g / kg = 1000 g O / kg 
      physValue O_total = TS * (RP * O_pr +        // proteins
                                RL * O_li +        // lipids
                               ADL * O_Lignin +   // lignin
                  (RF + NfE - ADL) * O_ch) * new physValue(1000, "g/kg");

      O_total.Symbol = "O";

      return O_total;
    }

    /// <summary>
    /// Calculate g N / kg substrate fresh matter
    /// </summary>
    /// <returns>g N / kg substrate FM</returns>
    private physValue calcN()
    {
      return calcN(this);
    }
    /// <summary>
    /// Calculate g N / kg substrate fresh matter
    /// </summary>
    /// <param name="mySubstrate">a substrate</param>
    /// <returns>g N / kg substrate FM</returns>
    private static physValue calcN(substrate mySubstrate)
    {
      physValue[] values= new physValue[6];

      mySubstrate.get_params_of(out values, "RF",  "RP",  "RL",
                                            "NfE", "ADL", "TS");

      physValue RF=  values[0];
      physValue RP=  values[1];
      physValue RL=  values[2];
      physValue NfE= values[3];
      physValue ADL= values[4];
      physValue TS=  values[5];

      return calcN(RF, RP, RL, NfE, ADL, TS);
    }
    /// <summary>
    /// Calculate g N / kg substrate fresh matter
    /// </summary>
    /// <param name="RF">must be measured in % TS</param>
    /// <param name="RP">must be measured in % TS</param>
    /// <param name="RL">must be measured in % TS</param>
    /// <param name="NfE">must be measured in % TS</param>
    /// <param name="ADL">must be measured in % TS</param>
    /// <param name="TS">must be measured in % FM</param>
    /// <returns>g N / kg substrate FM</returns>
    private static physValue calcN(double RF,  double RP,  double RL, 
                                   double NfE, double ADL, double TS)
    {
      physValue pRF=  new science.physValue("RF",  RF,  "% TS");
      physValue pRP=  new science.physValue("RP",  RP,  "% TS");
      physValue pRL=  new science.physValue("RL",  RL,  "% TS");
      physValue pNfE= new science.physValue("NfE", NfE, "% TS");
      physValue pADL= new science.physValue("ADL", ADL, "% TS");
      physValue pTS=  new science.physValue("TS",  TS,  "% FM");

      return calcN(pRF, pRP, pRL, pNfE, pADL, pTS);
    }
    /// <summary>
    /// Calculate g N / kg substrate fresh matter
    /// </summary>
    /// <param name="pRF">raw fiber</param>
    /// <param name="pRP">raw protein</param>
    /// <param name="pRL">raw lipids</param>
    /// <param name="pNfE">nitrogen free extracts</param>
    /// <param name="pADL">acid detergent lignin</param>
    /// <param name="pTS">total solids</param>
    /// <returns>g N / kg substrate FM</returns>
    private static physValue calcN(physValue pRF,  physValue pRP,  physValue pRL,
                                   physValue pNfE, physValue pADL, physValue pTS)
    {
      physValue N_ch, N_pr, N_li, N_Lignin;
      physValue RF, RP, RL, NfE, ADL, TS;

      try
      {
        // g N / mol carbohydrates / ( g / mol carbohydrates) = g N / g carbohydrates
        N_ch=     biogas.chemistry.get_N_rel_mass_of("Xch");
        // g N / mol proteins / ( g / mol proteins) = g N / g proteins
        N_pr=     biogas.chemistry.get_N_rel_mass_of("Xpr");
        // g N / mol lipids / ( g / mol lipids) = g N / g lipids
        N_li=     biogas.chemistry.get_N_rel_mass_of("Xli");
        // g N / mol lignin / ( g / mol lignin) = g N / g lignin
        N_Lignin= biogas.chemistry.get_N_rel_mass_of("Lignin");

        RF=   pRF.convertUnit("100 %");
        RP=   pRP.convertUnit("100 %");
        RL=   pRL.convertUnit("100 %");
        NfE= pNfE.convertUnit("100 %");
        ADL= pADL.convertUnit("100 %");
        TS=   pTS.convertUnit("% FM");

        TS= TS.convertUnit("100 %");
      }
      catch (exception e)
      {
        Console.WriteLine(e.Message);

        return new physValue("error");
      }

      // g N / g substrate * 1000 g / kg = 1000 g N / kg 
      physValue N_total= TS * ( RP * N_pr +        // proteins
                                RL * N_li +        // lipids
                               ADL * N_Lignin  +   // lignin
                  (RF + NfE - ADL) * N_ch ) * new physValue(1000, "g/kg");

      N_total.Symbol= "N";

      return N_total;
    }

    /// <summary>
    /// Calculate g S / kg substrate fresh matter
    /// </summary>
    /// <returns>g S / kg substrate FM</returns>
    private physValue calcS()
    {
      return calcS(this);
    }
    /// <summary>
    /// Calculate g S / kg substrate fresh matter
    /// </summary>
    /// <param name="mySubstrate">a substrate</param>
    /// <returns>g S / kg substrate FM</returns>
    private static physValue calcS(substrate mySubstrate)
    {
      physValue[] values = new physValue[6];

      mySubstrate.get_params_of(out values, "RF", "RP", "RL",
                                            "NfE", "ADL", "TS");

      physValue RF = values[0];
      physValue RP = values[1];
      physValue RL = values[2];
      physValue NfE = values[3];
      physValue ADL = values[4];
      physValue TS = values[5];

      return calcS(RF, RP, RL, NfE, ADL, TS);
    }
    /// <summary>
    /// Calculate g S / kg substrate fresh matter
    /// </summary>
    /// <param name="RF">must be measured in % TS</param>
    /// <param name="RP">must be measured in % TS</param>
    /// <param name="RL">must be measured in % TS</param>
    /// <param name="NfE">must be measured in % TS</param>
    /// <param name="ADL">must be measured in % TS</param>
    /// <param name="TS">must be measured in % FM</param>
    /// <returns>g S / kg substrate FM</returns>
    private static physValue calcS(double RF, double RP, double RL,
                                   double NfE, double ADL, double TS)
    {
      physValue pRF = new science.physValue("RF", RF, "% TS");
      physValue pRP = new science.physValue("RP", RP, "% TS");
      physValue pRL = new science.physValue("RL", RL, "% TS");
      physValue pNfE = new science.physValue("NfE", NfE, "% TS");
      physValue pADL = new science.physValue("ADL", ADL, "% TS");
      physValue pTS = new science.physValue("TS", TS, "% FM");

      return calcS(pRF, pRP, pRL, pNfE, pADL, pTS);
    }
    /// <summary>
    /// Calculate g S / kg substrate fresh matter
    /// </summary>
    /// <param name="pRF">raw fiber</param>
    /// <param name="pRP">raw protein</param>
    /// <param name="pRL">raw lipids</param>
    /// <param name="pNfE">nitrogen free extracts</param>
    /// <param name="pADL">acid detergent lignin</param>
    /// <param name="pTS">total solids</param>
    /// <returns>g S / kg substrate FM</returns>
    private static physValue calcS(physValue pRF, physValue pRP, physValue pRL,
                                   physValue pNfE, physValue pADL, physValue pTS)
    {
      physValue S_ch, S_pr, S_li, S_Lignin;
      physValue RF, RP, RL, NfE, ADL, TS;

      try
      {
        // g S / mol carbohydrates / ( g / mol carbohydrates) = g S / g carbohydrates
        S_ch = biogas.chemistry.get_S_rel_mass_of("Xch");
        // g S / mol proteins / ( g / mol proteins) = g S / g proteins
        S_pr = biogas.chemistry.get_S_rel_mass_of("Xpr");
        // g S / mol lipids / ( g / mol lipids) = g S / g lipids
        S_li = biogas.chemistry.get_S_rel_mass_of("Xli");
        // g S / mol lignin / ( g / mol lignin) = g S / g lignin
        S_Lignin = biogas.chemistry.get_S_rel_mass_of("Lignin");

        RF = pRF.convertUnit("100 %");
        RP = pRP.convertUnit("100 %");
        RL = pRL.convertUnit("100 %");
        NfE = pNfE.convertUnit("100 %");
        ADL = pADL.convertUnit("100 %");
        TS = pTS.convertUnit("% FM");

        TS = TS.convertUnit("100 %");
      }
      catch (exception e)
      {
        Console.WriteLine(e.Message);

        return new physValue("error");
      }

      // g S / g substrate * 1000 g / kg = 1000 g S / kg 
      physValue S_total = TS * (RP * S_pr +        // proteins
                                RL * S_li +        // lipids
                               ADL * S_Lignin +   // lignin
                  (RF + NfE - ADL) * S_ch) * new physValue(1000, "g/kg");

      S_total.Symbol = "S";

      return S_total;
    }
        


  }
}


