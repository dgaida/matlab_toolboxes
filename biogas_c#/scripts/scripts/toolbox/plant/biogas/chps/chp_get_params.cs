/**
 * This file is part of the partial class chp and defines
 * methods to get the params of the chp.
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
    /// Get params as an array of objects.
    /// </summary>
    /// <param name="variables">values</param>
    /// <param name="symbols">"id", ...</param>
    /// <exception cref="exception">Unknown parameter</exception>
    /// <exception cref="exception">No input argument</exception>
    public override void get_params_of(out object[] variables, params string[] symbols)
    {
      int nargin= symbols.Length;

      if (nargin > 0)
      {
        variables= new object[nargin];

        for (int iarg= 0; iarg < nargin; iarg++)
        {
          switch (symbols[iarg])
          {
            case "id":
              variables[iarg]= this.id;
              break;
            case "name":                        // name of chp
              variables[iarg]= this.name;
              break;
            case "Pel":                         // 
              variables[iarg]= this.Pel;
              break;
            case "Ptherm":                      // 
              variables[iarg]= this.Ptherm;
              break;
            case "eta_el":                      // 
              variables[iarg]= this.eta_el;
              break;
            case "eta_therm":                   // 
              variables[iarg]= this.eta_therm;
              break;
            
            default:
              throw new exception(String.Format("Unknown parameter: {0}!", symbols[iarg]));
          }
        }
      }
      else
        throw new exception("You did not give an argument!");
    }



  }
}


