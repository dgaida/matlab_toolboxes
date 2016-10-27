/**
 * This file is part of the partial class stirrer and defines
 * public set_params_of methods of the stirrer.
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
  /// Defines a stirrer used to stir the content in a digester
  /// </summary>
  public partial class stirrer : set_get_interface
  {
    
    // -------------------------------------------------------------------------------------
    //                              !!! PUBLIC METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// Sets parameters of this class.
    /// </summary>
    /// <param name="symbols">"eta_mixer", 0.4</param>
    /// <exception cref="exception">Unknown parameter</exception>
    public override void set_params_of(params object[] symbols)
    {
      for (int iarg= 0; iarg < symbols.Length; iarg= iarg + 2)
      {
        switch ((string)symbols[iarg])
        {
          case "id":
            this._id = (string)symbols[iarg + 1];
            break;
          case "eta_mixer":                // electrical degree of efficiency
            this._eta_mixer=     (double)symbols[iarg + 1];
            break;
          case "diameter":                // diameter of the stirrer in meter
            this._diameter = (double)symbols[iarg + 1];
            break;
          case "rotspeed":                // rotation speed of the stirrer in 1/second
            this._rotspeed = (double)symbols[iarg + 1];
            break;
          case "runtime":                // Laufzeit (run time) des Rührwerks
            this._runtime = (double)symbols[iarg + 1];
            break;
          case "type":                // type of stirrer: 0: central, 1: submersible
            this._type = (int)symbols[iarg + 1];
            break;
          case "stirred":             // on or off
            this._stirred=  Convert.ToBoolean(symbols[iarg + 1]);
            break;

          default:
            throw new exception(String.Format("Unknown parameter: {0}!",
                                              (string)symbols[iarg]));
        }
      }
    }



  }
}


