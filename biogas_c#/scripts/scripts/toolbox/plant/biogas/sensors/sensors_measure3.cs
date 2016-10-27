/**
 * This file is part of the partial class sensors and defines
 * measure methods for type 3 of the class.
 * 
 * TODOs:
 * - 
 * 
 * Apart from that FINISHED!
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
    /// Do measurements which depend on substrates. 
    /// 
    /// 3rd type
    /// 
    /// example sensor: 
    /// substrate_sensor, VS_sensor
    /// </summary>
    /// <param name="time">current simulation time</param>
    /// <param name="id">id of sensor</param>
    /// <param name="x">could be state vector</param>
    /// <param name="mySubstrates"></param>
    /// <param name="Q">volumeflow of substrates</param>
    /// <param name="value">measured values as double</param>
    /// <exception cref="exception">Unknown sensor id</exception>
    public void measure(double time, string id, //double deltatime,
                        double[] x, biogas.substrates mySubstrates,
                        double[] Q, out double value)
    {
      value = measure(time, id, x, mySubstrates, Q).Value;
    }
    /// <summary>
    /// Do measurements which depend on substrates. 
    /// 
    /// 3rd type
    /// 
    /// example sensor: 
    /// substrate_sensor, VS_sensor
    /// </summary>
    /// <param name="time">current simulation time</param>
    /// <param name="id">id of sensor</param>
    /// <param name="x">could be state vector</param>
    /// <param name="mySubstrates"></param>
    /// <param name="Q">volumeflow of substrates</param>
    /// <returns>measured value</returns>
    /// <exception cref="exception">Unknown sensor id</exception>
    public physValue measure(double time, string id, //double deltatime,
                             double[] x, biogas.substrates mySubstrates,
                             double[] Q)
    {
      physValue[] values = measureVec(time, id, x, mySubstrates, Q);

      return values[0];
    }

    /// <summary>
    /// Do measurements which depend on substrates. 
    /// 
    /// 3rd type
    /// 
    /// example sensor: 
    /// substrate_sensor, VS_sensor
    /// </summary>
    /// <param name="time">current simulation time</param>
    /// <param name="id">id of sensor</param>
    /// <param name="x">could be state vector</param>
    /// <param name="mySubstrates"></param>
    /// <param name="value">first measured value as double</param>
    /// <exception cref="exception">Unknown sensor id</exception>
    public void measure(double time, string id, //double deltatime,
                        double[] x, biogas.substrates mySubstrates,
                        out double value)
    {
      value = measure(time, id, x, mySubstrates).Value;
    }
    /// <summary>
    /// Do measurements which depend on substrates. 
    /// 
    /// 3rd type
    /// 
    /// example sensor: 
    /// substrate_sensor, VS_sensor
    /// </summary>
    /// <param name="time">current simulation time</param>
    /// <param name="id">id of sensor</param>
    /// <param name="x">could be state vector</param>
    /// <param name="mySubstrates"></param>
    /// <returns>first measured value</returns>
    /// <exception cref="exception">Unknown sensor id</exception>
    public physValue measure(double time, string id, //double deltatime,
                             double[] x, biogas.substrates mySubstrates)
    {
      physValue[] values = measureVec(time, id, x, mySubstrates);

      return values[0];
    }
    /// <summary>
    /// Do measurements which depend on substrates. 
    /// 
    /// 3rd type
    /// 
    /// example sensor: 
    /// substrate_sensor, VS_sensor
    /// </summary>
    /// <param name="time">current simulation time</param>
    /// <param name="id">id of sensor</param>
    /// <param name="mySubstrates"></param>
    /// <param name="value">first measured value</param>
    /// <exception cref="exception">Unknown sensor id</exception>
    public void measure(double time, string id, //double deltatime,
                        biogas.substrates mySubstrates,
                        out double value)
    {
      value = measure(time, id, mySubstrates).Value;
    }
    /// <summary>
    /// Do measurements which depend on substrates. 
    /// 
    /// 3rd type
    /// 
    /// example sensor: 
    /// substrate_sensor, VS_sensor
    /// </summary>
    /// <param name="time">current simulation time</param>
    /// <param name="id">id of sensor</param>
    /// <param name="mySubstrates"></param>
    /// <returns>first measured value</returns>
    /// <exception cref="exception">Unknown sensor id</exception>
    public physValue measure(double time, string id, //double deltatime,
                             biogas.substrates mySubstrates)
    {
      double[] x = new double[1];

      return measure(time, id, x, mySubstrates);
    }



    /// <summary>
    /// Do measurements which depend on substrates. 
    /// 
    /// 3rd type
    /// 
    /// example sensor: 
    /// substrate_sensor, VS_sensor
    /// </summary>
    /// <param name="time">current simulation time</param>
    /// <param name="id">id of sensor</param>
    /// <param name="x">could be state vector</param>
    /// <param name="mySubstrates"></param>
    /// <returns>measured values</returns>
    /// <exception cref="exception">Unknown sensor id</exception>
    public physValue[] measureVec(double time, string id, //double deltatime,
                                  double[] x, biogas.substrates mySubstrates)
    {
      double[] Q;

      // TODO !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
      // id_in_array einführen und durch "Q" ersetzen
      // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
      // TODO - getCurrentMeasurements darf nie für substrate Q aufgerufen werden
      // da zu beginn der simulation alle Qs bereits in den sensor geschrieben werden
      // und damit current immer das letzte element im sensor ist.
      //getCurrentMeasurements("Q", "Q", mySubstrates, out Q);
      getMeasurementsAt("Q", "Q", time, mySubstrates, out Q);

      return measureVec(time, id, x, mySubstrates,
                        Q);
    }
    /// <summary>
    /// Do measurements which depend on substrates. 
    /// 
    /// 3rd type
    /// 
    /// example sensor: 
    /// substrate_sensor, VS_sensor
    /// </summary>
    /// <param name="time">current simulation time</param>
    /// <param name="id">id of sensor</param>
    /// <param name="x">could be state vector</param>
    /// <param name="mySubstrates"></param>
    /// <param name="Q">could be volumeflow of substrates</param>
    /// <returns>measured values</returns>
    /// <exception cref="exception">Unknown sensor id</exception>
    public physValue[] measureVec(double time, string id, //double deltatime,
                                  double[] x, biogas.substrates mySubstrates,
                                  double[] Q)
    {
      double[] par = new double[1];

      return measureVec(time, id, x, mySubstrates,
                        Q, par);
    }
    /// <summary>
    /// Do measurements which depend on substrates. 
    /// 
    /// 3rd type
    /// 
    /// example sensor: 
    /// substrate_sensor, VS_sensor
    /// </summary>
    /// <param name="time">current simulation time</param>
    /// <param name="id">id of sensor</param>
    /// <param name="x">could be state vector</param>
    /// <param name="mySubstrates"></param>
    /// <param name="Q">could be volumeflow of substrates</param>
    /// <param name="par">some doubles</param>
    /// <returns>measured values</returns>
    /// <exception cref="exception">Unknown sensor id</exception>
    public physValue[] measureVec(double time, string id, //double deltatime,
                                  double[] x, biogas.substrates mySubstrates,
                                  double[] Q, params double[] par)
    {
      sensor mySensor = get(id);

      return mySensor.measure(time, sampling_time, x, mySubstrates, Q, par);
    }



  }
}


