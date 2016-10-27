/**
 * This file defines the properties of finances of the biogas plant. 
 * 
 * TODOs:
 * - 
 * 
 * Looks pretty good!
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
  /// finances of a biogas plant
  ///
  /// includes EEG 2009 and EEG 2012
  /// </summary>
  public partial class finances
  {

    // -------------------------------------------------------------------------------------
    //                            !!! PRIVATE FIELDS !!!
    // -------------------------------------------------------------------------------------

    //private physValue _revenueEl;           // revenue from selling produced electrical energy

    /// <summary>
    /// revenue from selling produced thermal energy
    /// </summary>
    private physValue _revenueTherm;
        
    /// <summary>
    /// revenue from selling produced biogas
    /// </summary>
    private physValue _revenueGas;

    //private physValue _revenueManureBonus;  // revenue of manure bonus (EEG 2009)

    // TODO: besser in cost, anstatt price umbenennen
    /// <summary>
    /// price for buying electrical energy
    /// </summary>
    private physValue _priceElEnergy;

    /// <summary>
    /// funding by the erneuerbare Energien Gesetz
    /// </summary>
    private funding myEEG;



    // -------------------------------------------------------------------------------------
    //                              !!! PROPERTIES !!!
    // -------------------------------------------------------------------------------------

    //public physValue revenueEl
    //{
    //  get { return _revenueEl; }
    //}

    /// <summary>
    /// revenue from selling produced thermal energy
    /// </summary>
    public physValue revenueTherm
    {
      get { return _revenueTherm; }
    }

    /// <summary>
    /// revenue from selling produced biogas
    /// </summary>
    public physValue revenueGas
    {
      get { return _revenueGas; }
    }

    //public physValue revenueManureBonus
    //{
    //  get { return _revenueManureBonus; }
    //}

    /// <summary>
    /// price for buying electrical energy
    /// </summary>
    public physValue priceElEnergy
    {
      get { return _priceElEnergy; }
    }



  }
}


