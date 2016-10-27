/**
 * This file is part of the partial class pump and defines
 * all properties of the class.
 * 
 * TODOs:
 * - evtl. eine funktion hinzufügen, welche id in id_start und id_end zerbricht,
 *   setzt allerdings voraus, dass ids keine unterstriche beinhalten dürfen.
 *   glaube, dass ich das so festgelegt habe, mehtode wird aber nur 
 *   implementiert wenn diese benötigt wird, da sie ein bisschen fehleranfällig sein
 *   könnte. Wird aktuell nicht benötigt.
 * 
 * Except for that FINISHED!
 * 
 */

using System;
using System.Collections.Generic;
using System.Text;
using science;

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
  /// Pumpen können zwischen
  /// 
  /// - Substratzufuhr und Fermenter (substratemix -> digester_id)
  /// - verschiedenen Fermentern
  /// - Fermenter und Endlager (digester_id -> storagetank)
  /// 
  /// angebracht werden.
  /// 
  /// Pumps basically just calculate the energy needed to pump the stuff.
  /// 
  /// energy is needed for two reasons:
  /// - to pump over a distance -> friction
  /// - to liften stuff -> potential energy
  /// 
  /// </summary>
  public partial class pump
  {

    // -------------------------------------------------------------------------------------
    //                            !!! PRIVATE FIELDS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// unit to pump stuff from, unit can be "substratemix", a digester or "storagetank"
    /// </summary>
    private string _unit_start = "";

    /// <summary>
    /// unit to pump stuff to, unit can be a digester or "storagetank"
    /// </summary>
    private string _unit_destiny = "";

    /// <summary>
    /// lifting height of the pump, vertically measured from the bottom to the top of
    /// the pump (measured in m)
    /// </summary>
    private physValue _h_lift = new physValue("h", 1, "m", "lifting height");

    /// <summary>
    /// distance, only measured horizontaly. from the left to the right corner,
    /// measured in m
    /// </summary>
    private physValue _d_horizontal = new physValue("d", 1, "m", "distance horizontal");

    /// <summary>
    /// electrical degree of efficiency of the pump, no unit, respectively: 100 %
    /// </summary>
    private double _eta = 0.8f;

    ///// <summary>
    ///// Reibungskoeffizient, coefficient of friction, no unit
    ///// </summary>
    //private double _mu = 0.2;

    /// <summary>
    /// diameter of pipe [m]
    /// </summary>
    private double _d_pipe = 0.1;

    /// <summary>
    /// roughness of pipe [mm]
    /// </summary>
    private double _k_pipe = 0.1;     



    // -------------------------------------------------------------------------------------
    //                              !!! PROPERTIES !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// creates pump id out of given start and destiny unit
    /// </summary>
    /// <param name="unit_start">start unit</param>
    /// <param name="unit_destiny">destiny unit</param>
    /// <returns>unit_start + "_" + unit_destiny</returns>
    public static string getid(string unit_start, string unit_destiny)
    {
      return unit_start + "_" + unit_destiny;
    }

    /// <summary>
    /// id of the pump, which is always: _unit_start + "_" + _unit_destiny
    /// </summary>
    public string id
    {
      get { return getid(_unit_start, _unit_destiny); }
    }

    /// <summary>
    /// unit to pump stuff from, unit can be "substratemix", a digester or "storagetank"
    /// </summary>
    public string unit_start
    {
      get { return _unit_start; }
    }

    /// <summary>
    /// unit to pump stuff to, unit can be a digester or "storagetank"
    /// </summary>
    public string unit_destiny
    {
      get { return _unit_destiny; }
    }

    /// <summary>
    /// lifting height of the pump, vertically measured from the bottom to the top of
    /// the pump (measured in m)
    /// </summary>
    public physValue h_lift
    {
      get { return _h_lift; }
    }

    /// <summary>
    /// distance, only measured horizontaly. from the left to the right corner,
    /// measured in m
    /// </summary>
    public physValue d_horizontal
    {
      get { return _d_horizontal; }
    }

    /// <summary>
    /// electrical degree of efficiency of the pump, no unit, respectively: 100 %
    /// </summary>
    public double eta
    {
      get { return _eta; }
    }

    ///// <summary>
    ///// Reibungskoeffizient, coefficient of friction, no unit
    ///// </summary>
    //public double mu
    //{
    //  get { return _mu; }
    //}



  }



}


