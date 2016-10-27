/**
 * This file is part of the partial class substrate and defines
 * private methods, all are get_..._of (... are C, H, O, N, S) methods.
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
  /// <summary>
  /// Defines the physicochemical characteristics of a substrate used on biogas plants.
  /// </summary>
  public partial class substrate
  {
    
    // -------------------------------------------------------------------------------------
    //                              !!! PRIVATE METHODS !!!
    // -------------------------------------------------------------------------------------
    
    /// <summary>
    /// Calculate mol C / mol substrate fresh matter
    /// </summary>
    /// <returns>mol C / mol substrate FM</returns>
    private physValue get_C_of()
    {
      return get_C_of(this);
    }
    /// <summary>
    /// Calculate mol C / mol substrate fresh matter
    /// </summary>
    /// <param name="mySubstrate">a substrate</param>
    /// <returns>mol C / mol substrate FM</returns>
    private static physValue get_C_of(substrate mySubstrate)
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

      return get_C_of(RF, RP, RL, NfE, ADL, TS);
    }
    /// <summary>
    /// Calculate mol C / mol substrate fresh matter
    /// </summary>
    /// <param name="RF">must be measured in % TS</param>
    /// <param name="RP">must be measured in % TS</param>
    /// <param name="RL">must be measured in % TS</param>
    /// <param name="NfE">must be measured in % TS</param>
    /// <param name="ADL">must be measured in % TS</param>
    /// <param name="TS">must be measured in % FM</param>
    /// <returns>mol C / mol substrate FM</returns>
    private static physValue get_C_of(double RF, double RP, double RL,
                                      double NfE, double ADL, double TS)
    {
      physValue pRF = new science.physValue("RF", RF, "% TS");
      physValue pRP = new science.physValue("RP", RP, "% TS");
      physValue pRL = new science.physValue("RL", RL, "% TS");
      physValue pNfE = new science.physValue("NfE", NfE, "% TS");
      physValue pADL = new science.physValue("ADL", ADL, "% TS");
      physValue pTS = new science.physValue("TS", TS, "% FM");

      return get_C_of(pRF, pRP, pRL, pNfE, pADL, pTS);
    }
    /// <summary>
    /// Calculate mol C / mol substrate fresh matter
    /// </summary>
    /// <param name="pRF">raw fiber</param>
    /// <param name="pRP">raw protein</param>
    /// <param name="pRL">raw lipids</param>
    /// <param name="pNfE">nitrogen free extracts</param>
    /// <param name="pADL">acid detergent lignin</param>
    /// <param name="pTS">total solids</param>
    /// <returns>mol C / mol substrate FM</returns>
    private static physValue get_C_of(physValue pRF, physValue pRP, physValue pRL,
                                      physValue pNfE, physValue pADL, physValue pTS)
    {
      physValue C_ch, C_pr, C_li, C_Lignin;

      try
      {
        // mol C / mol carbohydrates
        C_ch = biogas.chemistry.get_C_of("Xch");
        // mol C / mol proteins
        C_pr = biogas.chemistry.get_C_of("Xpr");
        // mol C / mol lipids
        C_li = biogas.chemistry.get_C_of("Xli");
        // mol C / mol lignin
        C_Lignin = biogas.chemistry.get_C_of("Lignin");
      }
      catch (exception e)
      {
        Console.WriteLine(e.Message);

        return new physValue("error");
      }

      physValue RF, RP, RL, NfE, ADL, TS;

      try
      {
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

        return new physValue("error2");
      }

      // TODO - unit mismatch wäre hier noch möglich
      // mol C / mol substrate fresh matter 
      physValue C_total = TS * (RP * C_pr +        // proteins
                                RL * C_li +        // lipids
                               ADL * C_Lignin +   // lignin
                  (RF + NfE - ADL) * C_ch);

      C_total.Symbol = "C";

      return C_total;
    }

    /// <summary>
    /// Calculate mol H / mol substrate fresh matter
    /// </summary>
    /// <returns>mol H / mol substrate FM</returns>
    private physValue get_H_of()
    {
      return get_H_of(this);
    }
    /// <summary>
    /// Calculate mol H / mol substrate fresh matter
    /// </summary>
    /// <param name="mySubstrate">a substrate</param>
    /// <returns>mol H / mol substrate FM</returns>
    private static physValue get_H_of(substrate mySubstrate)
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

      return get_H_of(RF, RP, RL, NfE, ADL, TS);
    }
    /// <summary>
    /// Calculate mol H / mol substrate fresh matter
    /// </summary>
    /// <param name="RF">must be measured in % TS</param>
    /// <param name="RP">must be measured in % TS</param>
    /// <param name="RL">must be measured in % TS</param>
    /// <param name="NfE">must be measured in % TS</param>
    /// <param name="ADL">must be measured in % TS</param>
    /// <param name="TS">must be measured in % FM</param>
    /// <returns>mol H / mol substrate FM</returns>
    private static physValue get_H_of(double RF, double RP, double RL,
                                      double NfE, double ADL, double TS)
    {
      physValue pRF = new science.physValue("RF", RF, "% TS");
      physValue pRP = new science.physValue("RP", RP, "% TS");
      physValue pRL = new science.physValue("RL", RL, "% TS");
      physValue pNfE = new science.physValue("NfE", NfE, "% TS");
      physValue pADL = new science.physValue("ADL", ADL, "% TS");
      physValue pTS = new science.physValue("TS", TS, "% FM");

      return get_H_of(pRF, pRP, pRL, pNfE, pADL, pTS);
    }
    /// <summary>
    /// Calculate mol H / mol substrate fresh matter
    /// </summary>
    /// <param name="pRF">raw fiber</param>
    /// <param name="pRP">raw protein</param>
    /// <param name="pRL">raw lipids</param>
    /// <param name="pNfE">nitrogen free extracts</param>
    /// <param name="pADL">acid detergent lignin</param>
    /// <param name="pTS">total solids</param>
    /// <returns>mol H / mol substrate FM</returns>
    private static physValue get_H_of(physValue pRF, physValue pRP, physValue pRL,
                                      physValue pNfE, physValue pADL, physValue pTS)
    {
      physValue H_ch, H_pr, H_li, H_Lignin;
      physValue RF, RP, RL, NfE, ADL, TS;

      try
      {
        // mol H / mol carbohydrates
        H_ch = biogas.chemistry.get_H_of("Xch");
        // mol H / mol proteins
        H_pr = biogas.chemistry.get_H_of("Xpr");
        // mol H / mol lipids
        H_li = biogas.chemistry.get_H_of("Xli");
        // mol H / mol lignin
        H_Lignin = biogas.chemistry.get_H_of("Lignin");

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

      // mol H / mol substrate fresh matter 
      physValue H_total = TS * (RP * H_pr +        // proteins
                                RL * H_li +        // lipids
                               ADL * H_Lignin +   // lignin
                  (RF + NfE - ADL) * H_ch);

      H_total.Symbol = "H";

      return H_total;
    }

    /// <summary>
    /// Calculate mol O / mol substrate fresh matter
    /// </summary>
    /// <returns>mol O / mol substrate FM</returns>
    private physValue get_O_of()
    {
      return get_O_of(this);
    }
    /// <summary>
    /// Calculate mol O / mol substrate fresh matter
    /// </summary>
    /// <param name="mySubstrate">a substrate</param>
    /// <returns>mol O / mol substrate FM</returns>
    private static physValue get_O_of(substrate mySubstrate)
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

      return get_O_of(RF, RP, RL, NfE, ADL, TS);
    }
    /// <summary>
    /// Calculate mol O / mol substrate fresh matter
    /// </summary>
    /// <param name="RF">must be measured in % TS</param>
    /// <param name="RP">must be measured in % TS</param>
    /// <param name="RL">must be measured in % TS</param>
    /// <param name="NfE">must be measured in % TS</param>
    /// <param name="ADL">must be measured in % TS</param>
    /// <param name="TS">must be measured in % FM</param>
    /// <returns>mol O / mol substrate FM</returns>
    private static physValue get_O_of(double RF, double RP, double RL,
                                      double NfE, double ADL, double TS)
    {
      physValue pRF = new science.physValue("RF", RF, "% TS");
      physValue pRP = new science.physValue("RP", RP, "% TS");
      physValue pRL = new science.physValue("RL", RL, "% TS");
      physValue pNfE = new science.physValue("NfE", NfE, "% TS");
      physValue pADL = new science.physValue("ADL", ADL, "% TS");
      physValue pTS = new science.physValue("TS", TS, "% FM");

      return get_O_of(pRF, pRP, pRL, pNfE, pADL, pTS);
    }
    /// <summary>
    /// Calculate mol O / mol substrate fresh matter
    /// </summary>
    /// <param name="pRF">raw fiber</param>
    /// <param name="pRP">raw protein</param>
    /// <param name="pRL">raw lipids</param>
    /// <param name="pNfE">nitrogen free extracts</param>
    /// <param name="pADL">acid detergent lignin</param>
    /// <param name="pTS">total solids</param>
    /// <returns>mol O / mol substrate FM</returns>
    private static physValue get_O_of(physValue pRF, physValue pRP, physValue pRL,
                                      physValue pNfE, physValue pADL, physValue pTS)
    {
      physValue O_ch, O_pr, O_li, O_Lignin;
      physValue RF, RP, RL, NfE, ADL, TS;

      try
      {
        // mol O / mol carbohydrates
        O_ch = biogas.chemistry.get_O_of("Xch");
        // mol O / mol proteins
        O_pr = biogas.chemistry.get_O_of("Xpr");
        // mol O / mol lipids
        O_li = biogas.chemistry.get_O_of("Xli");
        // mol O / mol lignin
        O_Lignin = biogas.chemistry.get_O_of("Lignin");

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

      // mol O / mol substrate fresh matter 
      physValue O_total = TS * (RP * O_pr +        // proteins
                                RL * O_li +        // lipids
                               ADL * O_Lignin +   // lignin
                  (RF + NfE - ADL) * O_ch);

      O_total.Symbol = "O";

      return O_total;
    }

    /// <summary>
    /// Calculate mol N / mol substrate fresh matter
    /// </summary>
    /// <returns>mol N / mol substrate FM</returns>
    private physValue get_N_of()
    {
      return get_N_of(this);
    }
    /// <summary>
    /// Calculate mol N / mol substrate fresh matter
    /// </summary>
    /// <param name="mySubstrate">a substrate</param>
    /// <returns>mol N / mol substrate FM</returns>
    private static physValue get_N_of(substrate mySubstrate)
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

      return get_N_of(RF, RP, RL, NfE, ADL, TS);
    }
    /// <summary>
    /// Calculate mol N / mol substrate fresh matter
    /// </summary>
    /// <param name="RF">must be measured in % TS</param>
    /// <param name="RP">must be measured in % TS</param>
    /// <param name="RL">must be measured in % TS</param>
    /// <param name="NfE">must be measured in % TS</param>
    /// <param name="ADL">must be measured in % TS</param>
    /// <param name="TS">must be measured in % FM</param>
    /// <returns>mol N / mol substrate FM</returns>
    private static physValue get_N_of(double RF, double RP, double RL,
                                      double NfE, double ADL, double TS)
    {
      physValue pRF = new science.physValue("RF", RF, "% TS");
      physValue pRP = new science.physValue("RP", RP, "% TS");
      physValue pRL = new science.physValue("RL", RL, "% TS");
      physValue pNfE = new science.physValue("NfE", NfE, "% TS");
      physValue pADL = new science.physValue("ADL", ADL, "% TS");
      physValue pTS = new science.physValue("TS", TS, "% FM");

      return get_N_of(pRF, pRP, pRL, pNfE, pADL, pTS);
    }
    /// <summary>
    /// Calculate mol N / mol substrate fresh matter
    /// </summary>
    /// <param name="pRF">raw fiber</param>
    /// <param name="pRP">raw protein</param>
    /// <param name="pRL">raw lipids</param>
    /// <param name="pNfE">nitrogen free extracts</param>
    /// <param name="pADL">acid detergent lignin</param>
    /// <param name="pTS">total solids</param>
    /// <returns>mol N / mol substrate FM</returns>
    private static physValue get_N_of(physValue pRF, physValue pRP, physValue pRL,
                                      physValue pNfE, physValue pADL, physValue pTS)
    {
      physValue N_ch, N_pr, N_li, N_Lignin;
      physValue RF, RP, RL, NfE, ADL, TS;

      try
      {
        // mol N / mol carbohydrates
        N_ch = biogas.chemistry.get_N_of("Xch");
        // mol N / mol proteins
        N_pr = biogas.chemistry.get_N_of("Xpr");
        // mol N / mol lipids
        N_li = biogas.chemistry.get_N_of("Xli");
        // mol N / mol lignin
        N_Lignin = biogas.chemistry.get_N_of("Lignin");

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

      // mol N / mol substrate fresh matter 
      physValue N_total = TS * (RP * N_pr +        // proteins
                                RL * N_li +        // lipids
                               ADL * N_Lignin +   // lignin
                  (RF + NfE - ADL) * N_ch);

      N_total.Symbol = "N";

      return N_total;
    }

    /// <summary>
    /// Calculate mol S / mol substrate fresh matter
    /// </summary>
    /// <returns>mol S / mol substrate FM</returns>
    private physValue get_S_of()
    {
      return get_S_of(this);
    }
    /// <summary>
    /// Calculate mol S / mol substrate fresh matter
    /// </summary>
    /// <param name="mySubstrate">a substrate</param>
    /// <returns>mol S / mol substrate FM</returns>
    private static physValue get_S_of(substrate mySubstrate)
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

      return get_S_of(RF, RP, RL, NfE, ADL, TS);
    }
    /// <summary>
    /// Calculate mol S / mol substrate fresh matter
    /// </summary>
    /// <param name="RF">must be measured in % TS</param>
    /// <param name="RP">must be measured in % TS</param>
    /// <param name="RL">must be measured in % TS</param>
    /// <param name="NfE">must be measured in % TS</param>
    /// <param name="ADL">must be measured in % TS</param>
    /// <param name="TS">must be measured in % FM</param>
    /// <returns>mol S / mol substrate FM</returns>
    private static physValue get_S_of(double RF, double RP, double RL,
                                      double NfE, double ADL, double TS)
    {
      physValue pRF = new science.physValue("RF", RF, "% TS");
      physValue pRP = new science.physValue("RP", RP, "% TS");
      physValue pRL = new science.physValue("RL", RL, "% TS");
      physValue pNfE = new science.physValue("NfE", NfE, "% TS");
      physValue pADL = new science.physValue("ADL", ADL, "% TS");
      physValue pTS = new science.physValue("TS", TS, "% FM");

      return get_S_of(pRF, pRP, pRL, pNfE, pADL, pTS);
    }
    /// <summary>
    /// Calculate mol S / mol substrate fresh matter
    /// </summary>
    /// <param name="pRF">raw fiber</param>
    /// <param name="pRP">raw protein</param>
    /// <param name="pRL">raw lipids</param>
    /// <param name="pNfE">nitrogen free extracts</param>
    /// <param name="pADL">acid detergent lignin</param>
    /// <param name="pTS">total solids</param>
    /// <returns>mol S / mol substrate FM</returns>
    private static physValue get_S_of(physValue pRF, physValue pRP, physValue pRL,
                                      physValue pNfE, physValue pADL, physValue pTS)
    {
      physValue S_ch, S_pr, S_li, S_Lignin;
      physValue RF, RP, RL, NfE, ADL, TS;

      try
      {
        // mol S / mol carbohydrates
        S_ch = biogas.chemistry.get_S_of("Xch");
        // mol S / mol proteins
        S_pr = biogas.chemistry.get_S_of("Xpr");
        // mol S / mol lipids
        S_li = biogas.chemistry.get_S_of("Xli");
        // mol S / mol lignin
        S_Lignin = biogas.chemistry.get_S_of("Lignin");

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

      // mol S / mol substrate fresh matter 
      physValue S_total = TS * (RP * S_pr +        // proteins
                                RL * S_li +        // lipids
                               ADL * S_Lignin +   // lignin
                  (RF + NfE - ADL) * S_ch);

      S_total.Symbol = "S";

      return S_total;
    }



  }
}


