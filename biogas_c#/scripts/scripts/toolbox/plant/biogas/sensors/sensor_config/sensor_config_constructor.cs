/**
 * This file is part of the partial class sensor_config and defines
 * the constructors of the class.
 * 
 * TODOs:
 * 
 * FINISHED!
 * 
 */

using System;
using toolbox;
using System.Text;
using System.Collections;

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
  /// <remarks>
  /// special class for real measurements. defines how a physValue by a sensor is measured with noise
  /// drift, calibration, etc.
  /// </remarks>
  public partial class sensor_config
  {

    // -------------------------------------------------------------------------------------
    //                              !!! CONSTRUCTOR METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// standard constructor, everything default
    /// </summary>
    public sensor_config(int index)
    {
      this.index = index;
    }

    /// <summary>
    /// copy constructor
    /// </summary>
    /// <param name="template">template</param>
    /// <param name="index">index of sensor</param>
    public sensor_config(sensor_config template, int index)
    {
      this.index = index;
      this._apply_real_sensor = template.apply_real_sensor;
      this.T_fil = template.T_fil;
      this.noise_level = template.noise_level;
      this.y_min = template.y_min;
      this.y_max = template.y_max;
      this.drift = template.drift;
      this.dT_calib = template.dT_calib;
      this.t_calib = template.t_calib;
    }
    
    

  }
}


