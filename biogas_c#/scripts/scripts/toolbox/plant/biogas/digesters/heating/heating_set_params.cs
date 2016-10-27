/**
 * This file is part of the partial class heating and defines
 * public set_params_of methods of the heating.
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
  /// Defines a heating used to heat a digester
  /// </summary>
  public partial class heating : set_get_interface
  {
    
    // -------------------------------------------------------------------------------------
    //                              !!! PUBLIC METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// Sets parameters of this class.
    /// </summary>
    /// <param name="symbols"></param>
    /// <exception cref="exception">Unknown parameter</exception>
    public override void set_params_of(params object[] symbols)
    {
      for (int iarg= 0; iarg < symbols.Length; iarg= iarg + 2)
      {
        switch ((string)symbols[iarg])
        {
          case "eta":                // electrical degree of efficiency
            this._eta=     (double)symbols[iarg + 1];
            break;
          case "status":             // on or off
            this._status=  Convert.ToBoolean(symbols[iarg + 1]);
            break;
          case "type":             // 0, 1, 2, ...
            this._type = Convert.ToInt32(symbols[iarg + 1]);
            break;

          default:
            throw new exception(String.Format("Unknown parameter: {0}!",
                                              (string)symbols[iarg]));
        }
      }
    }



  }
}


