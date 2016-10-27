/**
 * This file is part of the partial class pump and defines
 * methods to get the params of the pump.
 * 
 * TODOs:
 * - 
 * 
 * Except for that FINISHED!
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
  /// Pumpen können zwischen
  /// 
  /// - (Substratzufuhr und Fermenter (substratemix -> digester_id) nicht mehr, s. substrate_transport)
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
  /// A pump is only used to pump sludge, not to pump substrate (substrate_transport).
  /// Even if manure is fed the needed energy is calculated using (substrate_transport).
  /// </summary>
  public partial class pump : set_get_interface
  {

    // -------------------------------------------------------------------------------------
    //                              !!! PUBLIC METHODS !!!
    // -------------------------------------------------------------------------------------
        
    /// <summary>
    /// Get params as an array of objects.
    /// </summary>
    /// <param name="variables">returned params</param>
    /// <param name="symbols">names or ids of the needed params</param>
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
            case "unit_start":                      // 
              variables[iarg]= this.unit_start;
              break;
            case "unit_destiny":                    // 
              variables[iarg]= this.unit_destiny;
              break;
            case "h_lift":                          // 
              variables[iarg]= this.h_lift;
              break;
            case "d_horizontal":                    // 
              variables[iarg]= this.d_horizontal;
              break;
            case "eta":                             // 
              variables[iarg]= this.eta;
              break;
            //case "mu":                              // 
            //  variables[iarg]= this.mu;
            //  break;
            case "d_pipe":                          // diameter of pipe [m]
              variables[iarg] = this._d_pipe;
              break;
            case "k_pipe":                          // roughness of pipe [mm]
              variables[iarg] = this._k_pipe;
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


