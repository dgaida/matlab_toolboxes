/**
 * This file is part of the partial class digester and defines
 * private methods.
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
  /// Defines a digester on a biogas plant. To each digester a heating belongs, which is
  /// either switched on or off.
  /// 
  /// Furthermore each digester is modelled by an anaerobic digestion model (ADM).
  /// This ADM object is accessible through this class.
  /// 
  /// </summary>
  public partial class digester
  {

    // -------------------------------------------------------------------------------------
    //                              !!! PRIVATE METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// This method defines what the units are in which the values of the params
    /// are saved in the digester object.
    /// 
    /// </summary>
    /// <param name="values">default values</param>
    /// <exception cref="exception">values.Length != 11</exception>
    private void set_params_of(params double[] values)
    {
      if (values.Length != 11)
        throw new exception(String.Format(
              "You may only call this method with 11 parameters and not with {0} parameters!",
              values.Length));

      this.Vtot=      new physValue("Vtot",    values[0], "m^3");
      this._Vliq=     new physValue("Vliq",    values[1], "m^3");
      this.Vliqmax=   new physValue("Vliqmax", values[2], "m^3", "max. liquid volume");
      this._Vgas=     new physValue("Vgas",    values[3], "m^3");
      this.Vgasmax=   new physValue("Vgasmax", values[4], "m^3", "max. volume of gas phase");
      this._T=        new physValue("T",       values[5], "°C", "digester temperature");
      this._diam=     new physValue("diam",    values[6], "m");
      this._k_wall=   new physValue("k_wall",  values[7], "W/(m^2 * K)");
      this._k_roof=   new physValue("k_roof",  values[8], "W/(m^2 * K)");
      this._k_ground= new physValue("k_ground",values[9], "W/(m^2 * K)");
      this._heating=  new heating(             values[10]);   // double eta

      //this._mixer = new stirrer();
    }



  }
}


