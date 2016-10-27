/**
 * This file is part of the partial class sensor and defines
 * methods to set the params of the sensor.
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
  /// abstract class defining a sensor
  /// 
  /// A sensor can measure one or more physValues over time. To identify a 
  /// sensor it has an id and a id_suffix which indicates the location of the
  /// sensor. To measure a value use one of the measure methods. To get 
  /// a measured value at a given time use one of the getMeasurement methods. 
  /// </summary>
  public abstract partial class sensor : set_get_interface
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
          case "name":
            this._name=   (string)symbols[iarg + 1];
            break;
          
          default:
            throw new exception(String.Format("Unknown parameter: {0}!",
                                              (string)symbols[iarg]));
        }
      }
    }



  }
}


