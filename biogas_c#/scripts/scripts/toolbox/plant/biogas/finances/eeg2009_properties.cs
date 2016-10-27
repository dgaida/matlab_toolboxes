/**
 * This file defines funding via the EEG 2009 (only the properties and fields).
 * 
 * TODOs:
 * - 
 * 
 * Should be FINISHED!
 * 
 */

using System;
using System.Collections.Generic;
using System.Text;
using System.Xml;
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
  /// funding structure of EEG 2009
  /// </summary>
  public partial class eeg2009 : funding
  {

    // -------------------------------------------------------------------------------------
    //                            !!! PRIVATE FIELDS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// Leistungsschwellwerte nach EEG 2009 gemessen in kW
    /// el. Leistung: bis 150 kW, bis 500 kW, bis 5 MW, bis 20 MW
    /// </summary>
    private static double[] schwellwerte = { 150, 500, 5000, 20000 };

    /// <summary>
    /// Grundvergütung in ct./kWh für eine Anlage Baujahr 2009
    /// el. Leistung: bis 150 kW, bis 500 kW, bis 5 MW, bis 20 MW
    /// </summary>
    private static double[] grundverguetung = { 11.67, 9.18, 8.25, 7.79 };

    /// <summary>
    /// NaWaRo-Bonus in ct./kWh für eine Anlage Baujahr 2009
    /// el. Leistung: bis 150 kW, bis 500 kW, bis 5 MW, bis 20 MW
    /// </summary>
    private static double[] nawaro = { 7.00, 7.00, 4.00, 0.00 };

    /// <summary>
    /// if true, then get NaWaRo-Bonus, if false not
    /// </summary>
    private bool nawaro_b;

    /// <summary>
    /// KWK-Bonus in ct./kWh für eine Anlage Baujahr 2009
    /// el. Leistung: bis 150 kW, bis 500 kW, bis 5 MW, bis 20 MW
    /// </summary>
    private static double[] kwk = { 3.00, 3.00, 3.00, 3.00 };

    /// <summary>
    /// if true, then get KWK-Bonus, if false not
    /// </summary>
    private bool kwk_b;

    /// <summary>
    /// Innovations-/Technologie-Bonus in ct./kWh für eine Anlage Baujahr 2009
    /// el. Leistung: bis 150 kW, bis 500 kW, bis 5 MW, bis 20 MW
    /// TODO - hängt von aufbereiteter Menge biomethan ab
    /// 2 ct./kWh gibt es bis zu 350 Nm^3/h und nur 1.0 ct/kWh bei bis zu 700 Nm^3/h
    /// s. biogashandbuch: S. 158
    /// </summary>
    private static double[] innovation = { 2.00, 2.00, 2.00, 0.00 };

    /// <summary>
    /// if true, then get Innovations-/Technologie-Bonus, if false not
    /// </summary>
    private bool innovation_b;

    /// <summary>
    /// Ludtreinhaltungs-/Immissions-Bonus in ct./kWh für eine Anlage Baujahr 2009
    /// el. Leistung: bis 150 kW, bis 500 kW, bis 5 MW, bis 20 MW
    /// </summary>
    private static double[] immission = { 1.00, 1.00, 0.00, 0.00 };

    /// <summary>
    /// if true, then get Ludtreinhaltungs-/Immissions-Bonus, if false not
    /// </summary>
    private bool immission_b;

    /// <summary>
    /// Gülle-Bonus in ct. für eine Anlage Baujahr 2009
    /// el. Leistung: bis 150 kW, bis 500 kW, bis 5 MW, bis 20 MW
    /// an NaWaRo gekoppelt
    /// </summary>
    private static double[] manure = { 4.00, 1.00, 0.00, 0.00 };

    /// <summary>
    /// if true, then get Gülle-Bonus, if false not
    /// </summary>
    private bool manure_b;

    /// <summary>
    /// Landschaftspflege-Bonus in ct./kWh für eine Anlage Baujahr 2009
    /// el. Leistung: bis 150 kW, bis 500 kW, bis 5 MW, bis 20 MW
    /// an NaWaRo gekoppelt
    /// </summary>
    private static double[] landschaft = { 2.00, 2.00, 0.00, 0.00 };

    /// <summary>
    /// if true, then get Landschaftspflege-Bonus, if false not
    /// </summary>
    private bool landschaft_b;



    // -------------------------------------------------------------------------------------
    //                              !!! PROPERTIES !!!
    // -------------------------------------------------------------------------------------



  }
}


