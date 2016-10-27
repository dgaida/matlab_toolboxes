/**
 * This file is part of the partial class chp and defines
 * all private methods.
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
  /// Definition of a combined heat and power plant (cogeneration unit)
  /// </summary>
  public partial class chp
  {

    // -------------------------------------------------------------------------------------
    //                              !!! PRIVATE METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// This method defines what the units are, in which the values of the params
    /// are saved in the chp object.
    /// </summary>
    /// <param name="values">default values</param>
    /// <exception cref="exception">values.Length != 4</exception>
    private void set_params_of(params double[] values)
    {
      if (values.Length != 4)
        throw new exception(String.Format(
              "You may only call this method with 4 parameters and not with {0} parameters!",
              values.Length));

      this._Pel=      new physValue("Pel",    values[0], "kW");
      this._Ptherm=   new physValue("Ptherm", values[1], "kW");
      this._eta_el=                           values[2];   // 100 %
      this.eta_therm=                         values[3];   // 100 %
    }



  }
}


