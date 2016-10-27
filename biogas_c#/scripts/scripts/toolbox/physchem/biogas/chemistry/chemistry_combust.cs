/**
 * This file is part of the partial class chemistry and contains
 * the combustion equation methods.
 * 
 * TODOs:
 * - if needed, the combust equation can be extended with N, yields NH3, see my phd, erledigt
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
    /// Combusts the chemical formula C_cH_hO_oN_n.
    /// Calculates O2 in mol/mol
    /// </summary>
    /// <param name="c">mol C in molecule</param>
    /// <param name="h">mol H in molecule</param>
    /// <param name="o">mol O in molecule</param>
    /// <param name="n">mol N in molecule</param>
    /// <param name="o2">mol O2 oxydized in the reaction</param>
    public static void combust(physValue c, physValue h, physValue o, physValue n, 
                               out physValue o2)
    {
      physValue co2;

      combust(c, h, o, n, out o2, out co2);
    }
    /// <summary>
    /// Combusts the chemical formula C_cH_hO_oN_n.
    /// Calculates O2 and CO2 in mol/mol
    /// </summary>
    /// <param name="c">mol C in molecule</param>
    /// <param name="h">mol H in molecule</param>
    /// <param name="o">mol O in molecule</param>
    /// <param name="n">mol N in molecule</param>
    /// <param name="o2">mol O2 oxydized in the reaction</param>
    /// <param name="co2">mol CO2 created during combustion</param>
    public static void combust(physValue c, physValue h, physValue o, physValue n,
                               out physValue o2, out physValue co2)
    {
      physValue h2o;

      combust(c, h, o, n, out o2, out co2, out h2o);
    }
    /// <summary>
    /// Combusts the chemical formula C_cH_hO_oN_n.
    /// Calculates O2 and CO2 in mol/mol
    /// </summary>
    /// <param name="c">mol C in molecule</param>
    /// <param name="h">mol H in molecule</param>
    /// <param name="o">mol O in molecule</param>
    /// <param name="n">mol N in molecule</param>
    /// <param name="o2">mol O2 oxydized in the reaction</param>
    /// <param name="co2">mol CO2 created during combustion</param>
    /// <param name="h2o">mol H2O created during combustion</param>
    public static void combust(physValue c, physValue h, physValue o, physValue n,
                               out physValue o2, out physValue co2, out physValue h2o)
    {
      physValue nh3;

      combust(c, h, o, n, out o2, out co2, out h2o, out nh3);
    }
    /// <summary>
    /// Combusts the chemical formula C_cH_hO_oN_n.
    /// Calculates O2, CO2, H2O and NH3 in mol/mol
    /// </summary>
    /// <param name="c">mol C in molecule</param>
    /// <param name="h">mol H in molecule</param>
    /// <param name="o">mol O in molecule</param>
    /// <param name="n">mol N in molecule</param>
    /// <param name="o2">mol O2 oxydized in the reaction</param>
    /// <param name="co2">mol CO2 created during combustion</param>
    /// <param name="h2o">mol H2O created during combustion</param>
    /// <param name="nh3">mol NH3 created during combustion</param>
    public static void combust(physValue c, physValue h, physValue o, physValue n,
                               out physValue o2, out physValue co2, out physValue h2o, 
                               out physValue nh3)
    { 
      // in meinem PDF steht hier fehlerhaft + o/2, muss - o/2 sein, sonst geht O Bilanz nicht auf
      o2= c + h / 4f - o / 2f - 3f*n/4f;

      co2= c;

      h2o= h / 2f - 3f*n/2f;

      nh3 = n;

      o2.Symbol= "o2";
      o2.Label = String.Format("mol molecular oxygen / mol C{0}H{1}O{2}N{3} (combustion)",
                              c.Value, h.Value, o.Value, n.Value);

      co2.Symbol= "co2";
      co2.Label = String.Format("mol carbon dioxide / mol C{0}H{1}O{2}N{3} (combustion)",
                               c.Value, h.Value, o.Value, n.Value);

      h2o.Symbol= "o2";
      h2o.Label = String.Format("mol water / mol C{0}H{1}O{2}N{3} (combustion)",
                               c.Value, h.Value, o.Value, n.Value);

      nh3.Symbol= "nh3";
      nh3.Label = String.Format("mol ammonia / mol C{0}H{1}O{2}N{3} (combustion)",
                               c.Value, h.Value, o.Value, n.Value);
    }

    /// <summary>
    /// Combusts the molecule
    /// </summary>
    /// <param name="molecule">molecule</param>
    /// <param name="o2">oxidized oxygen</param>
    /// <exception cref="exception">Unknown molecule</exception>
    public static void combust(string molecule, out physValue o2)
    {
      physValue c;
      physValue h;
      physValue o;
      physValue n;
      
      get_CHON_of(molecule, out c, out h, out o, out n);

      // 
      combust(c, h, o, n, out o2);
    }

    /// <summary>
    /// Combusts the molecule
    /// </summary>
    /// <param name="molecule">molecule</param>
    /// <param name="o2">oxidized oxygen</param>
    /// <param name="co2">created CO2</param>
    /// <exception cref="exception">Unknown molecule</exception>
    public static void combust(string molecule, out physValue o2, out physValue co2)
    {
      physValue c;
      physValue h;
      physValue o;
      physValue n;

      get_CHON_of(molecule, out c, out h, out o, out n);

      // 
      combust(c, h, o, n, out o2, out co2);
    }

    /// <summary>
    /// Combusts the molecule
    /// </summary>
    /// <param name="molecule">molecule</param>
    /// <param name="o2">oxidized oxygen</param>
    /// <param name="co2">created CO2</param>
    /// <param name="h2o">created H2O</param>
    /// <exception cref="exception">Unknown molecule</exception>
    public static void combust(string molecule, out physValue o2, out physValue co2, 
                                                out physValue h2o)
    {
      physValue c;
      physValue h;
      physValue o;
      physValue n;

      get_CHON_of(molecule, out c, out h, out o, out n);

      // 
      combust(c, h, o, n, out o2, out co2, out h2o);
    }
    
    /// <summary>
    /// Combusts the molecule
    /// </summary>
    /// <param name="molecule">molecule</param>
    /// <param name="o2">oxidized oxygen</param>
    /// <param name="co2">created CO2</param>
    /// <param name="h2o">created H2O</param>
    /// <param name="nh3">created NH3</param>
    /// <exception cref="exception">Unknown molecule</exception>
    public static void combust(string molecule, out physValue o2, out physValue co2,
                                                out physValue h2o, out physValue nh3)
    {
      physValue c;
      physValue h;
      physValue o;
      physValue n;

      get_CHON_of(molecule, out c, out h, out o, out n);

      // 
      combust(c, h, o, n, out o2, out co2, out h2o, out nh3);
    }



  }
}


