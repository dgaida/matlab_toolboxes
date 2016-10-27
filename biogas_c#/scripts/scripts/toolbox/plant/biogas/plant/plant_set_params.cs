/**
 * This file is part of the partial class plant and defines
 * public set_params_of methods.
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
using System.Xml;
using System.IO;
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
  /// Defines the biogas plant.
  /// It is defined by its id and has a name.
  /// A biogas plant contains digesters, chps and pumps.
  /// 
  /// </summary>
  public partial class plant : set_get_interface
  {

    // -------------------------------------------------------------------------------------
    //                              !!! PUBLIC METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// Sets parameters to object values.
    /// </summary>
    /// <param name="symbols"></param>
    /// <exception cref="exception">Unknown parameter</exception>
    public override void set_params_of(params object[] symbols)
    {
      for (int iarg= 0; iarg < symbols.Length; iarg= iarg + 2)
      {
        switch ((string)symbols[iarg])
        {
          case "id":
            this._id=          (string)symbols[iarg + 1];
            break;
          case "name":
            this._name=        (string)symbols[iarg + 1];
            break;

          case "Tout":                // ambient temperature [°C]
            this._Tout.Value=  (double)symbols[iarg + 1];
            break;
          case "g":                   // 
            this._g.Value=     (double)symbols[iarg + 1];
            break;
          case "construct_year":                   // 
            this._construct_year = (Int32)symbols[iarg + 1];
            break;
          
          // 
          default:
            throw new exception(String.Format("Unknown parameter: {0}!",
                                              (string)symbols[iarg]));
        }
      }
    }



    /// <summary>
    /// Get params as an array of objects.
    /// </summary>
    /// <param name="variables">values</param>
    /// <param name="symbols">"id", ...</param>
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
            case "id":
              variables[iarg] = this.id;
              break;
            case "name":                        // name of plant
              variables[iarg] = this.name;
              break;
            case "Tout":                         // 
              variables[iarg] = this.Tout;
              break;
            case "g":                      // 
              variables[iarg] = this.g;
              break;
            case "construct_year":                      // 
              variables[iarg] = this.construct_year;
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


