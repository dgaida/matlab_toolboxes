/**
 * This file is part of the partial class sensors and defines
 * measure methods for type 9 of the class.
 * 
 * TODOs:
 * - NOT FINISHED
 * 
 * Apart from that FINISHED!
 * 
 */

using System;
using System.Collections.Generic;
using System.Text;
using science;
using toolbox;
using biooptim;



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
  /// List of sensors
  /// 
  /// is a list of sensors. The ids of the sensors inside this list
  /// are also saved inside the list ids. Next to sensors
  /// it also can contain sensor_arrays, which are an array of sensors.
  /// Sensors are grouped in different groups, dependent on the measure call syntax
  /// they have (those are the types: 0, 1, 2, ...).
  /// </summary>
  public partial class sensors : List<sensor>
  {

    // -------------------------------------------------------------------------------------
    //                              !!! PUBLIC METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// Do measurements which depend on sensors and substrates. 
    /// 
    /// 9th type
    /// 
    /// example sensor:
    /// manure bonus sensor
    /// </summary>
    /// <param name="time">current simulation time</param>
    /// <param name="id">id of sensor</param>
    /// <param name="mySubstrates"></param>
    /// <param name="par">some double</param>
    /// <param name="value">first measured value</param>
    /// <exception cref="exception">Unknown sensor id</exception>
    public void measure(double time, string id, biogas.substrates mySubstrates, 
                        double par, out double value)
    {
      double[] parvec = { par };
      measure(time, id, mySubstrates, parvec, out value);
    }
    /// <summary>
    /// Do measurements which depend on sensors and substrates.
    /// 
    /// 9th type
    /// 
    /// example sensor:
    /// used by manure bonus sensor
    /// </summary>
    /// <param name="time">current simulation time</param>
    /// <param name="id">id of sensor</param>
    /// <param name="mySubstrates"></param>
    /// <param name="par">some doubles</param>
    /// <param name="value">first measured value</param>
    /// <exception cref="exception">Unknown sensor id</exception>
    public void measure(double time, string id, biogas.substrates mySubstrates, 
                        double[] par, out double value)
    {
      physValue[] vals = measureVec(time, id, mySubstrates, par);

      value = vals[0].Value;
    }
    /// <summary>
    /// Do measurements which depend on sensors and substrates. 
    /// 
    /// 9th type
    /// 
    /// example sensor:
    /// used by manure bonus sensor
    /// </summary>
    /// <param name="time">current simulation time</param>
    /// <param name="id">id of sensor</param>
    /// <param name="mySubstrates"></param>
    /// <param name="par">some doubles</param>
    /// <returns>measured values</returns>
    /// <exception cref="exception">Unknown sensor id</exception>
    public physValue[] measureVec(double time, string id, biogas.substrates mySubstrates, 
                                  params double[] par)
    {
      sensor mySensor = get(id);

      return mySensor.measure(time, sampling_time, mySubstrates, this, par);
    }



  }
}


