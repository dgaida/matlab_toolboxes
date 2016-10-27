/**
 * This file is part of the partial class substrates and defines
 * calc and get_weighted_... methods.
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
using System.Xml;
using System.IO;
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
  /// List of substrates
  /// </summary>
  public partial class substrates : List<substrate>
  {

    // -------------------------------------------------------------------------------------
    //                              !!! PUBLIC METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// Calculates mean energy needed to heat all substrates from their actual 
    /// temperature up to the given temperature Tend, Q measured in m^3/d
    /// </summary>
    /// <param name="Q">volume flow rate of all substrates, must be measured in m^3/d
    /// </param>
    /// <param name="Tend">digester temperature</param>
    /// <returns>sum of heat energy needed to heat all substrates in kWh/d</returns>
    /// <exception cref="exception">Q.Length &lt; this.Count</exception>
    public physValue calcSumQuantityOfHeatPerDay(double[] Q, physValue Tend)
    {
      physValue sumheatsubs = physValue.sum(calcQuantityOfHeatPerDay(Q, Tend));

      sumheatsubs.Symbol = "Qheat_substrates";

      return sumheatsubs;
    }
    /// <summary>
    /// Calculates energy needed to heat each substrate seperately from its actual 
    /// temperature up to the given temperature Tend, Q measured in m^3/d
    /// </summary>
    /// <param name="Q">volume flow rate of all substrates, must be measured in m^3/d
    /// </param>
    /// <param name="Tend">digester temperature</param>
    /// <returns>heat energy for each substrate in kWh/d</returns>
    /// <exception cref="exception">Q.Length &lt; this.Count</exception>
    public physValue[] calcQuantityOfHeatPerDay(double[] Q, physValue Tend)
    {
      physValue[] pQ= new physValue[Q.Length];

      for (int iel= 0; iel < Q.Length; iel++)
        pQ[iel]= new physValue("Q", Q[iel], "m^3/d");

      return calcQuantityOfHeatPerDay(pQ, Tend);
    }
    /// <summary>
    /// Calculates total energy needed to heat all substrates from their actual 
    /// temperature up to the given temperature Tend
    /// </summary>
    /// <param name="Q">volume flow rate of substrates</param>
    /// <param name="Tend">digester temperature</param>
    /// <returns>sum of heat energy needed to heat all substrates in kWh/d</returns>
    /// <exception cref="exception">Q.Length &lt; this.Count</exception>
    /// <exception cref="exception">unit mismatch</exception>
    public physValue calcSumQuantityOfHeatPerDay(physValue[] Q, physValue Tend)
    {
      return physValue.sum(calcQuantityOfHeatPerDay(Q, Tend));
    }
    /// <summary>
    /// Calculates energy needed to heat each substrate separately from its actual 
    /// temperature up to the given temperature Tend
    /// </summary>
    /// <param name="Q">volume flow rate of substrates</param>
    /// <param name="Tend">digester temperature</param>
    /// <returns>heat energy for each substrate in kWh/d</returns>
    /// <exception cref="exception">Q.Length &lt; this.Count</exception>
    public physValue[] calcQuantityOfHeatPerDay(physValue[] Q, physValue Tend)
    {
      // ignoriere sludge
      if (Q.Length < this.Count)
        throw new exception(String.Format("Q.Length < this.Count: {0} < {1}!",
                                           Q.Length,   this.Count));

      physValue[] Qtherm= new physValue[this.Count];

      for (int isubstrate= 0; isubstrate < this.Count; isubstrate++)
      {
        Qtherm[isubstrate]= biogas.substrate.calcQuantityOfHeatPerDay(
                             this[isubstrate], Q[isubstrate], Tend);
      }

      return Qtherm;
    }

    /// <summary>
    /// Returns the weighted sum of the parameter param (must be physValue), weighted by Q.
    /// Q is supposed to be measured in m^3/d
    /// 
    /// param must be defined in substrate
    /// </summary>
    /// <param name="Q">
    /// double vector with at least as many elements as there are substrates
    /// </param>
    /// <param name="param">physValue parameter to get weighted sum of</param>
    /// <param name="w_sum">the weighted sum value</param>
    /// <exception cref="exception">Q.Length &lt; this.Count</exception>
    /// <exception cref="exception">Unknown parameter</exception>
    /// <exception cref="exception">Conversion to physValue not possible</exception>
    public void get_weighted_sum_of(double[] Q, string param, out physValue w_sum)
    {
      int isubstrate= 0;
      physValue param_value;
      w_sum= new physValue(0, "1");

      double Qsum = math.sum(Q);
      
      foreach (substrate mySubstrate in this)
      {
        param_value= mySubstrate.get_params_of(param);

        if (isubstrate == 0)
          w_sum= new physValue(param_value.Symbol, 0, param_value.Unit);

        if (!(isubstrate >= Q.Length))
        {
          if (Qsum != 0)
            w_sum += Q[isubstrate] * param_value;
          else
            w_sum += param_value;
        }
        else
          throw new IndexOutOfRangeException(String.Format("isubstrate >= Q.Length: {0} >= {1}!",
                                             isubstrate, Q.Length));

        isubstrate++;
      }

      w_sum= w_sum * new physValue("Q", 1, "m^3/d");
    }
    /// <summary>
    /// Returns the weighted sum of the parameter param, weighted by Q.
    /// Here param is supposed to be a double param.
    /// </summary>
    /// <param name="Q">
    /// volume flow rate of substrates, at least as many elements as there are substrates
    /// </param>
    /// <param name="param">a double parameter</param>
    /// <returns>weighted sum of a double parameter</returns>
    /// <exception cref="exception">Q.Length &lt; this.Count</exception>
    /// <exception cref="exception">Unknown parameter</exception>
    /// <exception cref="exception">Conversion to double not possible</exception>
    public double get_weighted_sum_of(double[] Q, string param)
    {
      int isubstrate= 0;
      double param_value;
      double w_sum= 0;

      double Qsum = math.sum(Q);
      
      foreach (substrate mySubstrate in this)
      {
        param_value= mySubstrate.get_param_of_d(param);

        if (!(isubstrate >= Q.Length))
        {
          if (Qsum != 0)
            w_sum += Q[isubstrate] * param_value;
          else
            w_sum += param_value;
        }
        else
          throw new IndexOutOfRangeException(String.Format("isubstrate >= Q.Length: {0} >= {1}!",
                                             isubstrate, Q.Length));

        isubstrate++;
      }

      return w_sum;
    }

    /// <summary>
    /// Returns the weighted mean of the parameter param, weighted by Q.
    /// Q is supposed to be measured in m^3/d.
    /// </summary>
    /// <param name="Q">
    /// volume flow rate of substrates, at least as many elements as there are substrates
    /// </param>
    /// <param name="param">physValue parameter</param>
    /// <param name="mean_param">mean value of param</param>
    /// <exception cref="exception">Q.Length &lt; this.Count</exception>
    /// <exception cref="exception">Unknown parameter</exception>
    /// <exception cref="exception">Conversion to physValue not possible</exception>
    public void get_weighted_mean_of(double[] Q, string param, out physValue mean_param)
    {
      double Qtot= math.sum(Q);

      physValue sum_param;

      get_weighted_sum_of(Q, param, out sum_param);

      if (Qtot != 0)
        mean_param= sum_param / new physValue(Qtot, "m^3/d");
      else
        // teile durch Länge von Q, da ich in weighted_sum in dem Fall
        // einfach die Parameter addiert habe, also ist Mittelwert hier
        // der arithmethische Mittelwert
        mean_param = sum_param / new physValue((double)Q.Length, "m^3/d"); 
      //new physValue(sum_param.Symbol, 0, sum_param.Unit) / 
      //              new physValue(1, "m^3/d");
    }
    /// <summary>
    /// Returns the weighted mean of the parameter param, weighted by Q.
    /// Here param is supposed to be a double param.
    /// Q is supposed to be measured in m^3/d.
    /// </summary>
    /// <param name="Q">
    /// volume flow rate of substrates, at least as many elements as there are substrates
    /// </param>
    /// <param name="param">double parameter</param>
    /// <returns></returns>
    /// <exception cref="exception">Q.Length &lt; this.Count</exception>
    /// <exception cref="exception">Unknown parameter</exception>
    /// <exception cref="exception">Conversion to double not possible</exception>
    public double get_weighted_mean_of(double[] Q, string param)
    {
      double Qtot= math.sum(Q);

      double sum_param;

      sum_param= get_weighted_sum_of(Q, param);

      double mean_param;

      if (Qtot != 0)
        mean_param = sum_param / Qtot;
      else
        // teile durch Länge von Q, da ich in weighted_sum in dem Fall
        // einfach die Parameter addiert habe, also ist Mittelwert hier
        // der arithmethische Mittelwert
        mean_param = sum_param / (double)Q.Length; //0;

      return mean_param;
    }

    /// <summary>
    /// Calculates mean f-Factors, weighted by Q, which is assumed to be measured in m^3/d
    /// </summary>
    /// <param name="Q">
    /// volume flow rate of substrates, at least as many elements as there are substrates
    /// </param>
    /// <param name="fCH_XC">mean fCh_Xc</param>
    /// <param name="fPR_XC">mean fPr_Xc</param>
    /// <param name="fLI_XC">mean fLi_Xc</param>
    /// <param name="fXI_XC">mean fXI_Xc</param>
    /// <param name="fSI_XC">mean fSI_Xc</param>
    /// <param name="fXP_XC">mean fXp_Xc</param>
    public void calcfFactors(double[] Q, out double fCH_XC, out double fPR_XC, out double fLI_XC,
                                         out double fXI_XC, out double fSI_XC, out double fXP_XC)
    {
      try
      {
        fCH_XC = get_weighted_mean_of(Q, "fCh_Xc");
        fPR_XC = get_weighted_mean_of(Q, "fPr_Xc");
        fLI_XC = get_weighted_mean_of(Q, "fLi_Xc");
        fXI_XC = get_weighted_mean_of(Q, "fXI_Xc");
        fSI_XC = get_weighted_mean_of(Q, "fSI_Xc");
        fXP_XC = get_weighted_mean_of(Q, "fXp_Xc");
      }
      catch (exception e)
      {
        fCH_XC = fPR_XC = fLI_XC = fXI_XC = fSI_XC = fXP_XC = 0;

        Console.WriteLine(e.Message);
      }
    }

    /// <summary>
    /// calc fSIN_Xc, which is ratio of (NH4 + NH3) / Xc
    /// NH3+NH4 fraction from XC
    /// </summary>
    /// <param name="Q">
    /// volume flow rate of substrates, at least as many elements as there are substrates
    /// </param>
    /// <returns>mean fSIN_Xc</returns>
    public double calcfSIN_Xc(double[] Q)
    { 
      try
      {
        return get_weighted_mean_of(Q, "fSIN_Xc");
      }
      catch (exception e)
      {
        Console.WriteLine(e.Message);

        return 0;
      }
    }

    /// <summary>
    /// Calculate hydrolysis params of the substrate feed
    /// </summary>
    /// <param name="Q">feed of the substrates in m³/d</param>
    /// <param name="khyd_ch">hydrolysis parameter for carbohydrates</param>
    /// <param name="khyd_pr">hydrolysis parameter for proteins</param>
    /// <param name="khyd_li">hydrolysis parameter for lipids</param>
    public void calcHydrolysisParams(double[] Q, out double khyd_ch, out double khyd_pr, 
                                                 out double khyd_li)
    {
      physValue pkhyd_ch, pkhyd_pr, pkhyd_li;

      try
      {
        get_weighted_mean_of(Q, "khyd_ch", out pkhyd_ch);
        khyd_ch = pkhyd_ch.Value;

        get_weighted_mean_of(Q, "khyd_pr", out pkhyd_pr);
        khyd_pr = pkhyd_pr.Value;

        get_weighted_mean_of(Q, "khyd_li", out pkhyd_li);
        khyd_li = pkhyd_li.Value;
      }
      catch (exception e)
      {
        khyd_ch = khyd_pr = khyd_li = 0;

        Console.WriteLine(e.Message);
      }
    }

    /// <summary>
    /// Calculate disintegration constant kdis
    /// </summary>
    /// <param name="Q">feed of the substrates in m³/d</param>
    /// <returns>kdis in [1/d]</returns>
    public double calcDisintegrationParam(double[] Q)
    {
      physValue kdis;

      try
      {
        get_weighted_mean_of(Q, "kdis", out kdis);

        return kdis.Value;
      }
      catch (exception e)
      {
        Console.WriteLine(e.Message);

        return 0;
      }
    }

    /// <summary>
    /// Calculate max. uptake rate params of the substrate feed
    /// </summary>
    /// <param name="Q">feed of the substrates in m³/d</param>
    /// <param name="km_c4">max. uptake rate of valerate and butyrate</param>
    /// <param name="km_pro">max. uptake rate of propionate</param>
    /// <param name="km_ac">max. uptake rate of acetate</param>
    /// <param name="km_h2">max. uptake rate of hydrogen</param>
    public void calcMaxUptakeRateParams(double[] Q, out double km_c4, out double km_pro,
                                                    out double km_ac, out double km_h2)
    {
      physValue pkm_c4, pkm_pro, pkm_ac, pkm_h2;

      try
      {
        get_weighted_mean_of(Q, "km_c4", out pkm_c4);
        km_c4 = pkm_c4.Value;

        get_weighted_mean_of(Q, "km_pro", out pkm_pro);
        km_pro = pkm_pro.Value;

        get_weighted_mean_of(Q, "km_ac", out pkm_ac);
        km_ac = pkm_ac.Value;

        get_weighted_mean_of(Q, "km_h2", out pkm_h2);
        km_h2 = pkm_h2.Value;
      }
      catch (exception e)
      {
        km_c4 = km_pro = km_ac = km_h2 = 0;

        Console.WriteLine(e.Message);
      }
    }



  }
}


