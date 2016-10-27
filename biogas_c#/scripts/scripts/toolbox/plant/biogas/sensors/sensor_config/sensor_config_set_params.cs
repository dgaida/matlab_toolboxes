/**
 * This file is part of the partial class sensor_config and defines
 * methods to set the params of the sensor_config.
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
  /// special class for real measurements. defines how a physValue by a sensor is measured with noise
  /// drift, calibration, etc.
  /// </summary>
  public partial class sensor_config : set_get_interface
  {

    // -------------------------------------------------------------------------------------
    //                              !!! PUBLIC METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// Set params of sensor. Syntax: set_params_of( "y_min", 0, "y_max", 46, ... ).
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
          case "index":
            this.index = (int)symbols[iarg + 1];
            break;

          case "apply_real_sensor":
            this._apply_real_sensor = (bool)symbols[iarg + 1];
            break;

          case "noise_level":           // noise level
            this.noise_level = (double)symbols[iarg + 1];
            break;
          case "y_min":                 // minimum value
            this.y_min = (double)symbols[iarg + 1];
            break;
          case "y_max":                 // maximum value
            this.y_max = (double)symbols[iarg + 1];
            break;
          case "drift":                 // drift
            this.drift = (double)symbols[iarg + 1];
            break;
          case "dT_calib":              // interval of calibration [d]
            this.dT_calib = (double)symbols[iarg + 1];
            break;
          case "t_calib":               // time for calibration [min]
            this.t_calib = (double)symbols[iarg + 1];
            break;
          
          default:
            throw new exception(String.Format("Unknown parameter: {0}!",
                                              (string)symbols[iarg]));
        }
      }
    }



  }
}


