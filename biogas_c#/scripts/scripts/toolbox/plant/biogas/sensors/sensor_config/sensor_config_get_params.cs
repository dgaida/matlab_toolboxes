/**
 * This file is part of the partial class sensor_config and defines
 * methods to get the params of the sensor_config.
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
  /// special class for real measurements. defines how a physValue by a sensor is measured with noise
  /// drift, calibration, etc.
  /// </summary>
  public partial class sensor_config : set_get_interface
  {

    // -------------------------------------------------------------------------------------
    //                              !!! PUBLIC METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// Get params as an array of objects.
    /// </summary>
    /// <param name="variables"></param>
    /// <param name="symbols"></param>
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
            case "index":                      // 
              variables[iarg] = this.index;
              break;

            case "apply_real_sensor":                      // 
              variables[iarg] = this.apply_real_sensor;
              break;

            case "noise_level":                          // 
              variables[iarg] = this.noise_level;
              break;
            case "y_min":                    // 
              variables[iarg] = this.y_min;
              break;
            case "y_max":                             // 
              variables[iarg] = this.y_max;
              break;
            case "drift":                          // drift
              variables[iarg] = this.drift;
              break;
            case "dT_calib":                          // 
              variables[iarg] = this.dT_calib;
              break;
            case "t_calib":                          // 
              variables[iarg] = this.t_calib;
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


