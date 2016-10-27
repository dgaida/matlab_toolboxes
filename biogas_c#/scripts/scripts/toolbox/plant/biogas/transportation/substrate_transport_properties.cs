/**
 * This file is part of the partial class substrate_transport and defines
 * all private fields and public properties.
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
  /// This class is used to transport the substrate feed.
  /// 
  /// a substrate_transport contains a pump and a transport for solid substrates
  /// </summary>
  public partial class substrate_transport : pump
  {

    // -------------------------------------------------------------------------------------
    //                            !!! PRIVATE FIELDS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// name of transportation system for solid substrates (TS >= 11 % FM)
    /// 
    /// examples:
    /// - Allgemeines Einbringsystem: 0.74 - 3.3 kWh/t
    /// - Schubboden mit Eindrückschnecke: 0.92 kWh/t
    /// - Schubboden: 0.38 kWh/t
    /// - Vertikalmischer (Futtermischwagen): 1.1 kWh/t
    /// - Trichterzulauf mit Dosierschnecke: 0.74 kWh/t
    /// - Einpresssysteme: 1.07 - 3.3 kWh/t
    /// </summary>
    private string _name_solids = "Schubboden mit Eindrückschnecke";

    /// <summary>
    /// energy needed per ton of solid substrates in kWh/t
    /// 
    /// here: 0.92 kWh/t
    /// 
    /// examples:
    /// - Allgemeines Einbringsystem: 0.74 - 3.3 kWh/t
    /// - Schubboden mit Eindrückschnecke: 0.92 kWh/t
    /// - Schubboden: 0.38 kWh/t
    /// - Vertikalmischer (Futtermischwagen): 1.1 kWh/t
    /// - Trichterzulauf mit Dosierschnecke: 0.74 kWh/t
    /// - Einpresssysteme: 1.07 - 3.3 kWh/t
    /// </summary>
    private double _energy_per_ton = 0.92;



    // -------------------------------------------------------------------------------------
    //                              !!! PROPERTIES !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// name of transportation system for solid substrates (TS >= 11 % FM)
    /// 
    /// examples:
    /// - Allgemeines Einbringsystem: 0.74 - 3.3 kWh/t
    /// - Schubboden mit Eindrückschnecke: 0.92 kWh/t
    /// - Schubboden: 0.38 kWh/t
    /// - Vertikalmischer (Futtermischwagen): 1.1 kWh/t
    /// - Trichterzulauf mit Dosierschnecke: 0.74 kWh/t
    /// - Einpresssysteme: 1.07 - 3.3 kWh/t
    /// </summary>
    public string name_solids
    {
      get { return _name_solids; }
    }

    /// <summary>
    /// energy needed per ton of solid substrates in kWh/t
    /// 
    /// here: 0.92 kWh/t
    /// 
    /// examples:
    /// - Allgemeines Einbringsystem: 0.74 - 3.3 kWh/t
    /// - Schubboden mit Eindrückschnecke: 0.92 kWh/t
    /// - Schubboden: 0.38 kWh/t
    /// - Vertikalmischer (Futtermischwagen): 1.1 kWh/t
    /// - Trichterzulauf mit Dosierschnecke: 0.74 kWh/t
    /// - Einpresssysteme: 1.07 - 3.3 kWh/t
    /// </summary>
    public double energy_per_ton
    {
      get { return _energy_per_ton; }
    }



  }
}


