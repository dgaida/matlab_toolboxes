/**
 * This file is part of the partial class sensors and defines
 * measure methods for type 7 of the class.
 * 
 * TODOs:
 * - to pass the object mySensors as parameter to these function does not make any sense
 *   at all, because this is the mySensors class!
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
    /// Do measurements which depend on plant and substrates and other measurements. 
    /// 
    /// 7th type
    /// 
    /// example sensors:
    /// called by TS sensor
    /// OLR_sensor
    /// density_sensor
    /// </summary>
    /// <param name="time">current simulation time</param>
    /// <param name="id">id of sensor</param>
    /// <param name="x">could be statevector</param>
    /// <param name="myPlant"></param>
    /// <param name="mySubstrates"></param>
    /// <param name="mySensors"></param>
    /// <param name="Q">could be substrate feed</param>
    /// <param name="value">first measured value</param>
    /// <exception cref="exception">Unknown sensor id</exception>
    public void measure(double time, string id, //double deltatime,
                        double[] x, biogas.plant myPlant, biogas.substrates mySubstrates,
                        biogas.sensors mySensors, 
                        double[] Q, out double value)
    {
      physValue[] vals= measureVec(time, id, x, myPlant, mySubstrates, mySensors, Q);

      value= vals[0].Value;
    }
    /// <summary>
    /// Do measurements which depend on plant and substrates and other measurements. 
    /// 
    /// 7th type
    /// 
    /// example sensors:
    /// called by TS sensor
    /// OLR_sensor
    /// density_sensor
    /// </summary>
    /// <param name="time">current simulation time</param>
    /// <param name="id">id of sensor</param>
    /// <param name="x">could be statevector</param>
    /// <param name="myPlant"></param>
    /// <param name="mySubstrates"></param>
    /// <param name="mySensors"></param>
    /// <param name="substrate_network"></param>
    /// <param name="plant_network"></param>
    /// <param name="digester_id">digester ID</param>
    /// <param name="value">first measured value</param>
    /// <exception cref="exception">Unknown sensor id</exception>
    public void measure(double time, string id, //double deltatime,
                        double[] x, biogas.plant myPlant, biogas.substrates mySubstrates,
                        biogas.sensors mySensors,
                        double[,] substrate_network, double[,] plant_network, 
                        string digester_id, out double value)
    {
      physValue[] vals= measureVec(time, id, x, myPlant,
                                   mySubstrates, mySensors, 
                                   substrate_network, plant_network, digester_id);

      value= vals[0].Value;
    }
    /// <summary>
    /// Do measurements which depend on plant and substrates and other measurements. 
    /// 
    /// 7th type
    /// 
    /// example sensors:
    /// called by TS sensor
    /// OLR_sensor
    /// density_sensor
    /// </summary>
    /// <param name="time">current simulation time</param>
    /// <param name="id">id of sensor</param>
    /// <param name="x">could be statevector</param>
    /// <param name="myPlant"></param>
    /// <param name="mySubstrates"></param>
    /// <param name="mySensors"></param>
    /// <param name="substrate_network"></param>
    /// <param name="plant_network"></param>
    /// <param name="digester_id">ID of digester</param>
    /// <returns>measured values</returns>
    /// <exception cref="exception">Unknown sensor id</exception>
    public physValue[] measureVec(double time, string id, //double deltatime,
                                  double[] x, biogas.plant myPlant, biogas.substrates mySubstrates,
                                  biogas.sensors mySensors,
                                  double[,] substrate_network, double[,] plant_network, 
                                  string digester_id)
    {
      physValue[] pQ= getInputVolumeflowForFermenter(time, mySubstrates, myPlant, mySensors,
                                  substrate_network, plant_network, digester_id);

      // first values are Q for substrates, then pumped sludge going into digester
      double[] Q= physValue.getValues(pQ);

      return measureVec(time, id, x, myPlant, mySubstrates, mySensors, Q);
    }
    /// <summary>
    /// Do measurements which depend on plant and substrates and other measurements. 
    /// 
    /// 7th type
    /// 
    /// example sensors:
    /// called by TS sensor
    /// OLR_sensor
    /// density_sensor
    /// </summary>
    /// <param name="time">current simulation time</param>
    /// <param name="id">id of sensor</param>
    /// <param name="x">could be statevector</param>
    /// <param name="myPlant"></param>
    /// <param name="mySubstrates"></param>
    /// <param name="mySensors"></param>
    /// <param name="Q">
    /// first values are Q for substrates, then pumped sludge going into digester
    /// dimension: always number of substrates + number of digesters
    /// </param>
    /// <returns>measured values</returns>
    /// <exception cref="exception">Unknown sensor id</exception>
    public physValue[] measureVec(double time, string id, //double deltatime,
                                  double[] x, biogas.plant myPlant, biogas.substrates mySubstrates,
                                  biogas.sensors mySensors, 
                                  double[] Q)
    {
      double[] par = new double[1];

      return measureVec(time, id, x, myPlant, mySubstrates, mySensors, 
                        Q, par);
    }
    /// <summary>
    /// Do measurements which depend on plant and substrates and other measurements. 
    /// 
    /// 7th type
    /// 
    /// example sensors:
    /// called by TS sensor
    /// OLR_sensor
    /// density_sensor
    /// </summary>
    /// <param name="time">current simulation time</param>
    /// <param name="id">id of sensor</param>
    /// <param name="x">could be statevector</param>
    /// <param name="myPlant"></param>
    /// <param name="mySubstrates"></param>
    /// <param name="mySensors"></param>
    /// <param name="Q">
    /// first values are Q for substrates, then pumped sludge going into digester
    /// </param>
    /// <param name="par">some doubles</param>
    /// <returns>measured values</returns>
    /// <exception cref="exception">Unknown sensor id</exception>
    public physValue[] measureVec(double time, string id, //double deltatime,
                                  double[] x, biogas.plant myPlant, biogas.substrates mySubstrates,
                                  biogas.sensors mySensors, 
                                  double[] Q, params double[] par)
    {
      sensor mySensor = get(id);

      return mySensor.measure(time, sampling_time, x, myPlant, mySubstrates, mySensors, Q, par);
    }



  }
}


