/**
 * This file is part of the partial class chemistry and contains
 * the buswell equation methods.
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
   * Defines a few methods in the field of chemistry used in the biogas area
   * 
   * References:
   * 
   * 1) Koch, K., Lübken, M., Gehring, T., Wichern, M., and Horn, H.: 
   *    Biogas from grass silage – Measurements and modeling with ADM1, 
   *    Bioresource Technology 101, pp. 8158-8165, 2010.
   *    
   * 2) Gaida, D.: 
   *    Die anaerobe Fermentation - Theoretische Grundlagen, Simulation und Regelung -, 
   *    2009
   * 
   */
  public partial class chemistry
  {

    // -------------------------------------------------------------------------------------
    //                              !!! PUBLIC METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// Calculates the extended buswell equation for the given molecule.
    /// Calculates CH4 in "mol gas / mol molecule"
    /// </summary>
    /// <param name="molecule">molecule</param>
    /// <returns>CH4 in "mol gas / mol molecule"</returns>
    /// <exception cref="exception">Unknown molecule</exception>
    public static physValue buswell_extended(string molecule)
    { 
      physValue ch4;

      buswell_extended(molecule, out ch4);

      return ch4;
    }
    /// <summary>
    /// Calculates the extended buswell equation for the given molecule.
    /// Calculates CH4 in "mol gas / mol molecule"
    /// </summary>
    /// <param name="molecule">molecule</param>
    /// <param name="ch4">CH4 in "mol gas / mol molecule"</param>
    /// <exception cref="exception">Unknown molecule</exception>
    public static void buswell_extended(string molecule,
                                        out physValue ch4)
    {
      physValue c;
      physValue h;
      physValue o;
      physValue n;
      physValue s;

      get_CHONS_of(molecule, out c, out h, out o, out n, out s);
         
      // mol ch4 per molecule
      buswell_extended(c, h, o, n, s, out ch4);
    }
    /// <summary>
    /// Calculates the extended buswell equation for the given molecule.
    /// Calculates CH4 in "mol gas / mol molecule"
    /// </summary>
    /// <param name="molecule">molecule</param>
    /// <param name="ch4">CH4 in "mol gas / mol molecule"</param>
    /// <param name="co2">CO2 in "mol gas / mol molecule"</param>
    /// <exception cref="exception">Unknown molecule</exception>
    public static void buswell_extended(string molecule,
                                        out physValue ch4, out physValue co2)
    {
      physValue c;
      physValue h;
      physValue o;
      physValue n;
      physValue s;

      get_CHONS_of(molecule, out c, out h, out o, out n, out s);

      // mol ch4 per molecule
      buswell_extended(c, h, o, n, s, out ch4, out co2);
    }
    /// <summary>
    /// Calculates the extended buswell equation for the given molecule.
    /// Calculates CH4 in "mol gas / mol molecule"
    /// </summary>
    /// <param name="molecule">molecule</param>
    /// <param name="ch4">H4 in "mol gas / mol molecule"</param>
    /// <param name="co2">CO2 in "mol gas / mol molecule"</param>
    /// <param name="nh3">NH3 in "mol gas / mol molecule"</param>
    /// <exception cref="exception">Unknown molecule</exception>
    public static void buswell_extended(string molecule,
                                        out physValue ch4, out physValue co2, 
                                        out physValue nh3)
    {
      physValue c;
      physValue h;
      physValue o;
      physValue n;
      physValue s;

      get_CHONS_of(molecule, out c, out h, out o, out n, out s);

      // mol ch4 per molecule
      buswell_extended(c, h, o, n, s, out ch4, out co2, out nh3);
    }
    /// <summary>
    /// Calculates the extended buswell equation for the given molecule.
    /// Calculates CH4 in "mol gas / mol molecule"
    /// </summary>
    /// <param name="molecule">molecule</param>
    /// <param name="ch4">CH4 in "mol gas / mol molecule"</param>
    /// <param name="co2">CO2 in "mol gas / mol molecule"</param>
    /// <param name="nh3">NH3 in "mol gas / mol molecule"</param>
    /// <param name="h2s">H2S in "mol gas / mol molecule"</param>
    /// <exception cref="exception">Unknown molecule</exception>
    public static void buswell_extended(string molecule,
                                        out physValue ch4, out physValue co2, 
                                        out physValue nh3, out physValue h2s)
    {
      physValue c;
      physValue h;
      physValue o;
      physValue n;
      physValue s;

      get_CHONS_of(molecule, out c, out h, out o, out n, out s);

      // mol ch4 per molecule
      buswell_extended(c, h, o, n, s, out ch4, out co2, out nh3, out h2s);
    }
    /// <summary>
    /// Calculates the extended buswell equation for the given molecule.
    /// Calculates CH4 in "mol gas / mol molecule"
    /// </summary>
    /// <param name="c">mol C / mol molecule</param>
    /// <param name="h">mol H / mol molecule</param>
    /// <param name="o">mol O / mol molecule</param>
    /// <param name="n">mol N / mol molecule</param>
    /// <param name="s">mol S / mol molecule</param>
    /// <param name="ch4">CH4 in "mol gas / mol molecule"</param>
    public static void buswell_extended(physValue c, physValue h, physValue o,
                                        physValue n, physValue s,
                                        out physValue ch4)
    {
      physValue co2;

      buswell_extended(c, h, o, n, s, out ch4, out co2);
    }
    /// <summary>
    /// Calculates the extended buswell equation for the given molecule.
    /// Calculates CH4 and CO2 in "mol gas / mol molecule"
    /// </summary>
    /// <param name="c">mol C / mol molecule</param>
    /// <param name="h">mol H / mol molecule</param>
    /// <param name="o">mol O / mol molecule</param>
    /// <param name="n">mol N / mol molecule</param>
    /// <param name="s">mol S / mol molecule</param>
    /// <param name="ch4">CH4 in "mol gas / mol molecule"</param>
    /// <param name="co2">CO2 in "mol gas / mol molecule"</param>
    public static void buswell_extended(physValue c, physValue h, physValue o,
                                        physValue n, physValue s,
                                        out physValue ch4, out physValue co2)
    {
      physValue nh3;

      buswell_extended(c, h, o, n, s, out ch4, out co2, out nh3);
    }
    /// <summary>
    /// Calculates the extended buswell equation for the given molecule.
    /// Calculates CH4, CO2 and NH3 in "mol gas / mol molecule"
    /// </summary>
    /// <param name="c">mol C / mol molecule</param>
    /// <param name="h">mol H / mol molecule</param>
    /// <param name="o">mol O / mol molecule</param>
    /// <param name="n">mol N / mol molecule</param>
    /// <param name="s">mol S / mol molecule</param>
    /// <param name="ch4">CH4 in "mol gas / mol molecule"</param>
    /// <param name="co2">CO2 in "mol gas / mol molecule"</param>
    /// <param name="nh3">NH3 in "mol gas / mol molecule"</param>
    public static void buswell_extended(physValue c, physValue h, physValue o,
                                        physValue n, physValue s,
                                        out physValue ch4, out physValue co2,
                                        out physValue nh3)
    {
      physValue h2s;

      buswell_extended(c, h, o, n, s, out ch4, out co2, out nh3, out h2s);
    }
    /// <summary>
    /// Calculates the extended buswell equation for the given molecule.
    /// Calculates CH4, CO2, NH3 and H2S in "mol gas / mol molecule"
    /// </summary>
    /// <param name="c">mol C / mol molecule</param>
    /// <param name="h">mol H / mol molecule</param>
    /// <param name="o">mol O / mol molecule</param>
    /// <param name="n">mol N / mol molecule</param>
    /// <param name="s">mol S / mol molecule</param>
    /// <param name="ch4">CH4 in "mol gas / mol molecule"</param>
    /// <param name="co2">CO2 in "mol gas / mol molecule"</param>
    /// <param name="nh3">NH3 in "mol gas / mol molecule"</param>
    /// <param name="h2s">H2S in "mol gas / mol molecule"</param>
    public static void buswell_extended(physValue c, physValue h, physValue o,
                                        physValue n, physValue s,
                                        out physValue ch4, out physValue co2,
                                        out physValue nh3, out physValue h2s)
    { 
      ch4= c / 2 + h / 8 - o / 4 - 3 * n / 8 - s / 4;

      ch4.Symbol= "ch4";
      ch4.Label= String.Format("mol CH4 / mol C{0}H{1}O{2}N{3}S{4} (fermentation)",
                               c.Value, h.Value, o.Value, n.Value, s.Value);

      co2= c / 2 - h / 8 + o / 4 + 3 * n / 8 + s / 4;

      co2.Symbol= "co2";
      co2.Label= String.Format("mol CO2 / mol C{0}H{1}O{2}N{3}S{4} (fermentation)",
                               c.Value, h.Value, o.Value, n.Value, s.Value);

      nh3= n;

      nh3.Symbol= "nh3";
      nh3.Label= String.Format("mol NH3 / mol C{0}H{1}O{2}N{3}S{4} (fermentation)",
                               c.Value, h.Value, o.Value, n.Value, s.Value);

      h2s= s;

      h2s.Symbol= "h2s";
      h2s.Label= String.Format("mol H2S / mol C{0}H{1}O{2}N{3}S{4} (fermentation)",
                               c.Value, h.Value, o.Value, n.Value, s.Value);
    }

    

  }
}


