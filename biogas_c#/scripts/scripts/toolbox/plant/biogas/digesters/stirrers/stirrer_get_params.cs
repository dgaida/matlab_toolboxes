/**
 * This file is part of the partial class stirrer and defines
 * public get_params_of methods of the stirrer.
 * 
 * TODOs:
 * - 
 * 
 * Should be FINISHED!
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
    /// Get parameter from the stirrer as objects.
    /// </summary>
    /// <param name="variables">"mystirrer"</param>
    /// <param name="symbols">"id"</param>
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
              variables[iarg] = this.id;
              break;
            case "eta_mixer":
              variables[iarg]= this.eta_mixer;
              break;
            case "diameter":
              variables[iarg] = this.diameter;
              break;
            case "rotspeed":
              variables[iarg] = this.rotspeed;
              break;
            case "runtime":                   // run time in hours/day
              variables[iarg] = this.runtime;
              break;
            case "type":
              variables[iarg] = this.type;
              break;
            case "stirred":                    // status of stirrer
              variables[iarg]= this.stirred;
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


