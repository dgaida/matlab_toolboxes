/**
 * This file is part of the partial class pump and defines
 * methods to set the params of the pump.
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
    /// Set params of pump. Syntax: set_params_of( "h_lift", 2, "eta", 0.4, ... ).
    /// Used to set the value of physValues as well, so make sure that
    /// the value you want to set is measured in the unit in which the
    /// physValue is saved in the object. 
    /// Therefore see: set_params_of(params double[] values)
    /// </summary>
    /// <param name="symbols"></param>
    /// <exception cref="exception">Unknown parameter</exception>
    public override void set_params_of(params object[] symbols)
    {
      for (int iarg= 0; iarg < symbols.Length; iarg= iarg + 2)
      {
        switch ((string)symbols[iarg])
        {
          case "unit_start":
            this._unit_start=   (string)symbols[iarg + 1];
            break;
          case "unit_destiny":
            this._unit_destiny= (string)symbols[iarg + 1];
            break;

          case "h_lift":              // lifting height
            this.h_lift.Value=        (double)symbols[iarg + 1];
            break;
          case "d_horizontal":        // distance, only measured horizontally
            this.d_horizontal.Value=  (double)symbols[iarg + 1];
            break;
          case "eta":                 // electrical degree of efficiency
            this._eta=                (double)symbols[iarg + 1];
            break;
          //case "mu":                  // coefficient of friction
          //  this._mu=                 (double)symbols[iarg + 1];
          //  break;
          case "d_pipe":                  // diameter of pipe [m]
            this._d_pipe = (double)symbols[iarg + 1];
            break;
          case "k_pipe":                  // roughness of pipe [mm]
            this._k_pipe = (double)symbols[iarg + 1];
            break;
          
          default:
            throw new exception(String.Format("Unknown parameter: {0}!",
                                              (string)symbols[iarg]));
        }
      }
    }



  }
}


