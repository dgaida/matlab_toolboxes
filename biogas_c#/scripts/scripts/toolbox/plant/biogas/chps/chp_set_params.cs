/**
 * This file is part of the partial class chp and defines
 * methods to set the params of the chp.
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
  public partial class chp : set_get_interface
  {

    // -------------------------------------------------------------------------------------
    //                              !!! PUBLIC METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// Set params of chp. Syntax: set_params_of( "Pel", 250, "eta_el", 0.4, ... ).
    /// Used to set the value of physValues as well, so make sure that
    /// the value you want to set is measured in the unit in which the
    /// physValue is saved in the object. 
    /// Therefore see: set_params_of(params double[] values)
    /// </summary>
    /// <param name="symbols">"Pel", 250</param>
    /// <exception cref="exception">Unknown parameter</exception>
    public override void set_params_of(params object[] symbols)
    {
      for (int iarg= 0; iarg < symbols.Length; iarg= iarg + 2)
      {
        switch ((string)symbols[iarg])
        {
          case "id":
            this._id=   (string)symbols[iarg + 1];
            break;
          case "name":
            this._name= (string)symbols[iarg + 1];
            break;

          case "Pel":                   // electrical power
            this.Pel.Value=    (double)symbols[iarg + 1];
            break;
          case "Ptherm":                // thermal power
            this.Ptherm.Value= (double)symbols[iarg + 1];
            break;
          case "eta_el":                // electrical degree of efficiency
            this._eta_el=      (double)symbols[iarg + 1];
            break;
          case "eta_therm":             // thermal degree of efficiency
            this.eta_therm=    (double)symbols[iarg + 1];
            break;
          
          default:
            throw new exception(String.Format("Unknown parameter: {0}!",
                                              (string)symbols[iarg]));
        }
      }
    }



  }
}


