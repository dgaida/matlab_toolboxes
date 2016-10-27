/**
 * This file is part of the partial class biogas and defines
 * the class.
 * 
 * TODOs:
 * - es ist nicht schön, dass so viele parameter public sind
 * - energie produktion bei methan anteil unter 40 % nicht mehr möglich, warum 40 %, referenz?
 * 
 * 
 * Because of that not yet FINISHED! 
 * 
 */

using System;
using System.Collections.Generic;
using System.Text;
using science;
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
  /// Defines biogas: a mix of CH4, CO2, H2 and H2S, ...
  /// 
  /// Definitions:
  /// 
  /// biogas is at least a three dimensional vector with the
  /// following components:
  /// 
  /// h2 at first position
  /// ch4 at 2nd position
  /// h2s at 3rd position
  /// 
  /// biogas could also be a higher dimensional vector
  /// then fourth position could e.g. be
  /// h2s, ...
  /// 
  /// </summary>
  public partial class BioGas
  {
        
    // -------------------------------------------------------------------------------------
    //                              !!! PUBLIC METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// burn biogas stream and return energy per day measured in kWh/d
    /// </summary>
    /// <param name="u">
    /// vector with as many elements as there are number of gases (BioGas.n_gases)
    /// the positions of the gases inside the vector are: 
    /// - biogas.BioGas.pos_ch4
    /// - biogas.BioGas.pos_co2
    /// - biogas.BioGas.pos_h2
    /// - biogas.BioGas.pos_h2s (optional)
    /// values measured in m^3/d
    /// </param>
    /// <returns>energy in kWh/d</returns>
    /// <exception cref="exception">u.Length &lt; _n_gases</exception>
    public static physValue burn(double[] u)
    {
      // calorific value (Brennwert) of methane
      physValue Hch4 = biogas.chemistry.Hch4;
      // calorific value of molecular hydrogen
      physValue Hh2 = biogas.chemistry.Hh2;

      if (u.Length < _n_gases)
      {
        throw new exception(String.Format(
          "The gas stream u has not the right dimension ({0}). Must be >= {1}!",
          u.Length, _n_gases));
      }

      // total biogas production in m³/d
      double total_biogas = math.sum(u);

      // P(t) [kWh/d]= Q_{ch4}(t) * H_{ch4}
      //
      // [ kWh/d ]= [ m^3/d * kWh / ( Nm^3 ) ]
      //
      // Zündtemperatur von Wasserstoff und Methan liegen beide beide ca. 600 °C, dürften
      // also beide verbrennen:
      //
      // http://de.wikipedia.org/wiki/Wasserstoffverbrennungsmotor
      // http://de.wikipedia.org/wiki/Methan
      //
      physValue energy = new physValue(u[pos_ch4 - 1], "m^3/d") * Hch4 +
                         new physValue(u[pos_h2 - 1] , "m^3/d") * Hh2;

      // TODO - why 40 ?
      // if methane content is < 40 %, then no energy production in chp is possible
      // why 40 %, is there a reference? there are already problems at 50 %, but used
      // 40 % as a lower boundary. only such that a crashed biogas plant, with almost only
      // H2 production does not produce energy
      if (u[pos_ch4 - 1] < 0.4 * total_biogas)
        energy = new physValue("Pel", 0, "kWh/d");

      return energy;
    }

    /// <summary>
    /// merge biogas stream from different digesters
    /// </summary>
    /// <param name="u">
    /// u is a n_digester * BioGas.n_gases (or higher) dimensional vector
    /// measured in m^3/d. [u_digester1, u_digester2, ...]
    /// </param>
    /// <param name="n_digester">number of digester on the plant</param>
    /// <returns>a _n_gases (or higher) dimensional vector measure biogas in m^3/d</returns>
    /// <exception cref="exception">n_digester &lt; 1</exception>
    /// <exception cref="exception">num_gases &lt; _n_gases</exception>
    public static double[] merge_streams(double[] u, int n_digester)
    {
      // u contains (h2, ch4, co2)_digester_1, (h2, ch4, co2)_digester_2, ...

      if (n_digester <= 0)
      {
        throw new exception(String.Format(
          "n_digester: {0}. Must be >= 1!", n_digester));
      }

      int num_gases = (int)(u.Length / n_digester);

      // u is a n_digester * BioGas.n_gases dimensional vector
      if (num_gases < _n_gases)
        throw new exception(String.Format(
                            "u has not the correct dimension! is: {0}, must be at least {1}!",
                             u.Length, n_digester * _n_gases));
            
      // total biogas in m^3/d (h2, ch4, co2)
      double[] biogas_total = new double[num_gases];

      for (int igas = 0; igas < u.Length; igas++)
      {
        biogas_total[igas % num_gases] = biogas_total[igas % num_gases] + u[igas];
      }

      return biogas_total;
    }

    /// <summary>
    /// Calculates the rel. content of the different components in the biogas stream
    /// u
    /// </summary>
    /// <param name="u">biogas stream measured in m^3/d, dim: _n_gases</param>
    /// <param name="total_biogas_total">sum of u in m^3/d</param>
    /// <returns>h2 in ppm, ch4 and co2 in %</returns>
    /// <exception cref="exception">u.Length &lt; _n_gases</exception>
    public static double[] calcRelContent(double[] u, out double total_biogas_total)
    {
      if (u.Length < _n_gases)
      {
        throw new exception(String.Format(
          "The gas stream u has not the right dimension ({0}). Must be >= {1}!",
          u.Length, _n_gases));
      }

      // percentual biogas prdocution on the plant (h2 ppm, ch4 %, co2 %)
      double[] biogas_total_perc = math.zeros(u.Length);

      // total biogas production in m³/d
      total_biogas_total = math.sum(u);

      if (total_biogas_total != 0)
      {
        for (int igas = 0; igas < u.Length; igas++)
          biogas_total_perc[igas] = u[igas] / total_biogas_total * 100;
      }

      // h2 in ppm
      biogas_total_perc[pos_h2 - 1] = biogas_total_perc[pos_h2 - 1] * 10000;

      return biogas_total_perc;
    }

    /// <summary>
    /// converts double biogas stream u, given in ppm, % and % to
    /// corresponding physValues
    /// </summary>
    /// <param name="u_rel">n_gases dim vector of h2 in ppm, 
    /// ch4 in % and co2 in %</param>
    /// <returns>u as physValue vector measured in % and ppm resp.</returns>
    /// <exception cref="exception">u_rel.Length &lt; _n_gases</exception>
    public static physValue[] convert(double[] u_rel)
    {
      if (u_rel.Length < _n_gases)
      {
        throw new exception(String.Format(
          "The gas stream u has not the right dimension ({0}). Must be >= {1}!",
          u_rel.Length, _n_gases));
      }

      physValue[] values = new physValue[u_rel.Length];

      //

      for (int igas = 0; igas < u_rel.Length; igas++)
      {
        if (igas == pos_h2 - 1)
          values[igas] = new physValue(symGases[igas] + "_t", u_rel[igas], "ppm", labelGases[igas]);
        else
          values[igas] = new physValue(symGases[igas] + "_t", u_rel[igas], "%", labelGases[igas]);
      }

      return values;
    }



    /// <summary>
    /// Calculates percentual biogas composition out of biogas stream. 
    /// Qgas must be array with BioGas.n_gases elements, all measured
    /// in m³/d
    /// 
    /// TODO: very similar to above one
    /// </summary>
    /// <param name="Qgas">biogas stream measured in m³/d</param>
    /// <param name="QgasP">biogas composition measured in %</param>
    /// <exception cref="exception">Qgas.Length &lt; _n_gases</exception>
    /// <exception cref="exception">Qgas is empty</exception>
    public static void calcPercentualBiogasComposition(double[] Qgas,
                                                       out physValue[] QgasP)
    {
      int no_gases = Qgas.Length;

      if (no_gases < _n_gases)
      {
        throw new exception(String.Format("Number of gases in Qgas is false: {0} < {1}!",
                                          no_gases, _n_gases));
      }

      physValue[] pQgas = new physValue[no_gases];

      for (int igas = 0; igas < no_gases; igas++)
      {
        pQgas[igas] = new physValue(symGases[igas], Qgas[igas], "m^3/d", labelGases[igas]);
      }

      calcPercentualBiogasComposition(pQgas, out QgasP);

    }
    /// <summary>
    /// Calculates percentual biogas composition out of biogas stream. 
    /// Qgas must be array with BioGas.n_gases elements, all measured
    /// in m³/d
    /// 
    /// TODO: very similar to above one
    /// </summary>
    /// <param name="Qgas">biogas stream measured in m³/d</param>
    /// <param name="QgasP">biogas composition measured in %</param>
    /// <exception cref="exception">Qgas.Length &lt; _n_gases</exception>
    /// <exception cref="exception">Qgas is empty</exception>
    /// <exception cref="exception">Qgas not measured in m^3/d</exception>
    public static void calcPercentualBiogasComposition(physValue[] Qgas,
                                                       out physValue[] QgasP)
    {
      int no_gases = Qgas.Length;

      if (no_gases < _n_gases)
      {
        throw new exception(String.Format("Number of gases in Qgas is false: {0} < {1}!",
                                          no_gases, _n_gases));
      }

      physValue sumQgas = physValue.sum(Qgas);

      if (sumQgas.Unit != "m^3/d")
        throw new exception(String.Format("Units of Qgas must be m^3/d. Is: {0}!", sumQgas.Unit));

      QgasP = new physValue[no_gases];

      for (int igas = 0; igas < no_gases; igas++)
      {
        if (sumQgas != new physValue("Qgas_min", 0, "m^3/d"))
        {
          QgasP[igas] = Qgas[igas] / sumQgas;
          QgasP[igas].Symbol = symGases[igas];
          QgasP[igas].Label = labelGases[igas];
        }
        else
          QgasP[igas] = new physValue(Qgas[igas].Symbol, 0, "100 %");

        QgasP[igas] = QgasP[igas].convertUnit("%");
      }

    }
  


  }
}


