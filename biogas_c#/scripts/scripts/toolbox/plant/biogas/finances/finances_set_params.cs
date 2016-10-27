/**
 * This file defines the public set_params methods of finances of the biogas plant. 
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
  public partial class finances : set_get_interface
  {
   
    // -------------------------------------------------------------------------------------
    //                              !!! PUBLIC METHODS !!!
    // -------------------------------------------------------------------------------------
      
    /// <summary>
    /// set params 
    /// </summary>
    /// <param name="symbols"></param>
    /// <exception cref="exception">Unknown parameter</exception>
    public override void set_params_of(params object[] symbols)
    {
      for (int iarg= 0; iarg < symbols.Length; iarg= iarg + 2)
      {
        switch ((string)symbols[iarg])
        {
          //case "revEl":                // revenue from selling produced electrical energy
          //  this._revenueEl.Value=     (double)symbols[iarg + 1];
          //  break;
          case "revTherm":             //
            this._revenueTherm.Value=  (double)symbols[iarg + 1];
            break;
          case "revGas":               //
            this._revenueGas.Value=    (double)symbols[iarg + 1];
            break;
          //case "revManureBonus":       //
          //  this._revenueManureBonus.Value= (double)symbols[iarg + 1];
          //  break;
          case "priceEl":              // price for buying electrical energy
            this._priceElEnergy.Value= (double)symbols[iarg + 1];
            break;

          // EEG
          default:
            myEEG.set_params_of((string)symbols[iarg], symbols[iarg + 1]);
            break;
          //default:
          //  throw new exception(String.Format("Unknown parameter: {0}!",
          //                                    (string)symbols[iarg]));
        }
      }
    }

    /// <summary>
    /// Get params as an array of objects.
    /// </summary>
    /// <param name="variables">values</param>
    /// <param name="symbols"></param>
    /// <exception cref="exception">Unknown parameter</exception>
    /// <exception cref="exception">No input argument</exception>
    public override void get_params_of(out object[] variables, params string[] symbols)
    {
      int nargin = symbols.Length;

      if (nargin > 0)
      {
        variables = new object[nargin];

        for (int iarg = 0; iarg < nargin; iarg++)
        {
          switch (symbols[iarg])
          {
            case "revTherm":
              variables[iarg] = this.revenueTherm;
              break;
            case "revGas":                        // 
              variables[iarg] = this.revenueGas;
              break;
            case "priceEl":                         // 
              variables[iarg] = this.priceElEnergy;
              break;
            
            default:
              myEEG.get_params_of(out variables, symbols);
              break;
          }
        }
      }
      else
        throw new exception("You did not give an argument!");
    }



  }
}


