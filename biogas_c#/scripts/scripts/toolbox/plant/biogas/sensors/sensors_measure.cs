/**
 * This file is part of the partial class sensors and defines
 * measure methods of the class.
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
    /// called by biogas sensor (is not a type 0 sensor, because x is here biogas stream), 
    /// called in getADM1output
    /// 
    /// Make a measurement/measurements with the given sensor and add the 
    /// new measurement/s to the measurement stream.
    /// Only make these measurements when between time and the last taken measurement
    /// at least a delta of deltatime exists.
    /// 
    /// used by stream_sensor
    /// 
    /// type 0 and type 1
    /// 
    /// example sensors: 
    /// type 0: NH3_sensor, NH4_sensor, Sac_sensor, AcVsPro_sensor
    /// type 1: HRT_sensor
    /// </summary>
    /// <param name="time">current simulation time</param>
    /// <param name="id">id of sensor</param>
    /// <param name="x">could be state vector</param>
    /// <param name="value">first measured value</param>
    /// <exception cref="exception">Unknown sensor id</exception>
    public void measure(double time, string id, //double deltatime,
                        double[] x, out double value)
    { 
      value= measure(time, id, x).Value;
    }
    /// <summary>
    /// called by biogas sensor (is not a type 0 sensor, because x is here biogas stream), 
    /// called in getADM1output
    /// 
    /// Make a measurement/measurements with the given sensor and add the 
    /// new measurement/s to the measurement stream.
    /// Only make these measurements when between time and the last taken measurement
    /// at least a delta of deltatime exists.
    /// 
    /// used by stream_sensor
    /// 
    /// type 0 and type 1
    /// 
    /// example sensors: 
    /// type 0: NH3_sensor, NH4_sensor, Sac_sensor, AcVsPro_sensor
    /// type 1: HRT_sensor
    /// </summary>
    /// <param name="time">current simulation time</param>
    /// <param name="id">id of sensor</param>
    /// <param name="x">could be state vector</param>
    /// <returns>first measured value</returns>
    /// <exception cref="exception">Unknown sensor id</exception>
    public physValue measure(double time, string id, //double deltatime, 
                             double[] x)
    {
      physValue[] values= measureVec(time, id, x);

      return values[0];
    }
    /// <summary>
    /// Make a measurement/measurements with the given sensor and add the 
    /// new measurement/s to the measurement stream.
    /// Only make these measurements when between time and the last taken measurement
    /// at least a delta of deltatime exists.
    /// 
    /// used by stream_sensor
    /// 
    /// type 0 and type 1
    /// 
    /// example sensors: 
    /// type 0: NH3_sensor, NH4_sensor, Sac_sensor, AcVsPro_sensor
    /// type 1: HRT_sensor
    /// </summary>
    /// <param name="time">current simulation time</param>
    /// <param name="id">id of sensor</param>
    /// <param name="x">could be state vector</param>
    /// <param name="par">some doubles</param>
    /// <returns>first measured value</returns>
    /// <exception cref="exception">Unknown sensor id</exception>
    public physValue measure(double time, string id, //double deltatime,
                             double[] x, params double[] par)
    {
      physValue[] values = measureVec(time, id, x, par);

      return values[0];
    }
    /// <summary>
    /// Make a measurement/measurements with the given sensor and add the 
    /// new measurement/s to the measurement stream.
    /// Only make these measurements when between time and the last taken measurement
    /// at least a delta of deltatime exists.
    /// 
    /// used by stream_sensor
    /// 
    /// type 0 and type 1
    /// 
    /// example sensors: 
    /// type 0: NH3_sensor, NH4_sensor, Sac_sensor, AcVsPro_sensor
    /// type 1: HRT_sensor
    /// </summary>
    /// <param name="time">current simulation time</param>
    /// <param name="id">id of sensor</param>
    /// <param name="x">could be state vector</param>
    /// <param name="value">first measured value</param>
    /// <param name="par">some doubles</param>
    /// <exception cref="exception">Unknown sensor id</exception>
    public void measure(double time, string id, //double deltatime,
                        double[] x, out double value, params double[] par)
    {
      value = measure(time, id, x, par).Value;
    }


    
    /// <summary>
    /// called by biogas sensor (is not a type 0 sensor, because x is here biogas stream), 
    /// called in getADM1output
    /// 
    /// Make a measurement/measurements with the given sensor and add the 
    /// new measurement/s to the measurement stream.
    /// Only make these measurements when between time and the last taken measurement
    /// at least a delta of deltatime exists.
    /// 
    /// used by stream_sensor
    /// 
    /// type 0 and type 1
    /// 
    /// example sensors: 
    /// type 0: NH3_sensor, NH4_sensor, Sac_sensor, AcVsPro_sensor
    /// type 1: HRT_sensor
    /// </summary>
    /// <param name="time">current simulation time</param>
    /// <param name="id">id of sensor</param>
    /// <param name="x">could be state vector</param>
    /// <param name="values">measured values</param>
    /// <exception cref="exception">Unknown sensor id</exception>
    public void measureVec(double time, string id, //double deltatime,
                           double[] x, out double[] values)
    {
      physValue[] vals= measureVec(time, id, x);

      values= physValue.getValues(vals);
    }
    /// <summary>
    /// called by biogas sensor (is not a type 0 sensor, because x is here biogas stream), 
    /// called in getADM1output
    /// 
    /// Make a measurement/measurements with the given sensor and add the 
    /// new measurement/s to the measurement stream.
    /// Only make these measurements when between time and the last taken measurement
    /// at least a delta of deltatime exists.
    /// 
    /// used by stream_sensor
    /// 
    /// type 0 and type 1
    /// 
    /// example sensors: 
    /// type 0: NH3_sensor, NH4_sensor, Sac_sensor, AcVsPro_sensor
    /// type 1: HRT_sensor
    /// </summary>
    /// <param name="time">current simulation time</param>
    /// <param name="id">id of sensor</param>
    /// <param name="x">could be state vector</param>
    /// <returns>measured values</returns>
    /// <exception cref="exception">Unknown sensor id</exception>
    public physValue[] measureVec(double time, string id, //double deltatime,
                                  double[] x)
    {
      double[] par= new double[1];

      return measureVec(time, id, x, par);
    }
    /// <summary>
    /// Make a measurement/measurements with the given sensor and add the 
    /// new measurement/s to the measurement stream.
    /// Only make these measurements when between time and the last taken measurement
    /// at least a delta of deltatime exists.
    /// 
    /// used by stream_sensor
    /// 
    /// type 0 and type 1
    /// 
    /// example sensors: 
    /// type 0: NH3_sensor, NH4_sensor, Sac_sensor, AcVsPro_sensor
    /// type 1: HRT_sensor
    /// </summary>
    /// <param name="time">current simulation time</param>
    /// <param name="id">id of sensor</param>
    /// <param name="x">could be state vector</param>
    /// <param name="par">some doubles</param>
    /// <returns>measured values</returns>
    /// <exception cref="exception">Unknown sensor id</exception>
    public physValue[] measureVec(double time, string id, //double deltatime,
                                  double[] x, params double[] par)
    {
      return measureVec(time, id, x, "", par);
    }
    /// <summary>
    /// Make a measurement/measurements with the given sensor and add the 
    /// new measurement/s to the measurement stream.
    /// Only make these measurements when between time and the last taken measurement
    /// at least a delta of deltatime exists.
    /// 
    /// used by stream_sensor
    /// 
    /// type 0 and type 1
    /// 
    /// example sensors: 
    /// type 0: NH3_sensor, NH4_sensor, Sac_sensor, AcVsPro_sensor
    /// type 1: HRT_sensor
    /// </summary>
    /// <param name="time">current simulation time</param>
    /// <param name="id">id of sensor or sensor_array</param>
    /// <param name="x">could be state vector</param>
    /// <param name="id_in_array">id of sensor in sensor_array</param>
    /// <param name="par">some doubles</param>
    /// <returns>measured values</returns>
    /// <exception cref="exception">Unknown sensor id</exception>
    public physValue[] measureVec(double time, string id, //double deltatime,
                                  double[] x, string id_in_array, params double[] par)
    {
      sensor mySensor= get(id, id_in_array);

      return mySensor.measure(time, sampling_time, x, par);
    }



    /// <summary>
    /// Do measurements with the given sensor which are independent of a double vector x.
    /// 
    /// 2nd type
    /// 
    /// example sensor: 
    /// fitness_sensor
    /// </summary>
    /// <param name="time">current simulation time</param>
    /// <param name="id">id of sensor</param>
    /// <param name="param">some double, actually this is what is measured</param>
    /// <param name="value">first measured value</param>
    /// <exception cref="exception">Unknown sensor id</exception>
    public void measure(double time, string id, //double deltatime,
                        double param, out double value)
    {
      value= measure(time, id, param).Value;
    }
    /// <summary>
    /// Do measurements with the given sensor which are independent of a double vector x.
    /// 
    /// 2nd type
    /// 
    /// example sensor: 
    /// fitness_sensor
    /// </summary>
    /// <param name="time">current simulation time</param>
    /// <param name="id">id of sensor</param>
    /// <param name="param">some double, actually this is what is measured</param>
    /// <returns>first measured value</returns>
    /// <exception cref="exception">Unknown sensor id</exception>
    public physValue measure(double time, string id, //double deltatime,
                             double param)
    {
      physValue[] values= measureVec(time, id, param);

      return values[0];
    }
    /// <summary>
    /// Do measurements with the given sensor which are independent of a double vector x.
    /// 
    /// 2nd type
    /// 
    /// example sensor: 
    /// fitness_sensor
    /// </summary>
    /// <param name="time">current simulation time</param>
    /// <param name="id">id of sensor</param>
    /// <param name="param">some double, actually this is what is measured</param>
    /// <returns>measured values</returns>
    /// <exception cref="exception">Unknown sensor id</exception>
    public physValue[] measureVec(double time, string id, //double deltatime,
                                  double param)
    {
      return measureVec(time, id, "", param);
    }
    /// <summary>
    /// Do measurements with the given sensor which are independent of a double vector x.
    /// 
    /// 2nd type
    /// 
    /// example sensor: 
    /// fitness_sensor
    /// </summary>
    /// <param name="time">current simulation time</param>
    /// <param name="id">id of sensor or sensor_array</param>
    /// <param name="id_in_array">id of sensor in sensor_array</param>
    /// <param name="param">some double, actually this is what is measured</param>
    /// <returns>measured values</returns>
    /// <exception cref="exception">Unknown sensor id</exception>
    public physValue[] measureVec(double time, string id, //double deltatime,
                                  string id_in_array, double param)
    {
      sensor mySensor= get(id, id_in_array);

      return mySensor.measure(time, sampling_time, param);
    }



    /// <summary>
    /// measure a matrix of data for a complete time vector. x is a column vector
    /// at each time instance so in total a 2d matrix.
    /// 
    /// used by volumeflow sensors
    /// </summary>
    /// <param name="time">time vector</param>
    /// <param name="id">id of sensor</param>
    /// <param name="x">matrix</param>
    /// <exception cref="exception">Unknown sensor id</exception>
    /// <exception cref="exception">time.Length != x.GetLength(1)</exception>
    public void measureVecStream(double[] time, string id,
                                 double[,] x)
    {
      measureVecStream(time, id, x, "");
    }
    /// <summary>
    /// measure a matrix of data for a complete time vector. x is a column vector
    /// at each time instance so in total a 2d matrix.
    /// 
    /// used by volumeflow sensors
    /// </summary>
    /// <param name="time">time vector</param>
    /// <param name="id">id of sensor or sensor_array</param>
    /// <param name="x">matrix</param>
    /// <param name="id_in_array">id of sensor in sensor_array</param>
    /// <exception cref="exception">Unknown sensor id</exception>
    /// <exception cref="exception">time.Length != x.GetLength(1)</exception>
    public void measureVecStream(double[] time, string id,
                                 double[,] x, string id_in_array)
    {
      double[] par= new double[1];

      measureVecStream(time, id, x, id_in_array, par);
    }
    /// <summary>
    /// measure a matrix of data for a complete time vector. x is a column vector
    /// at each time instance so in total a 2d matrix.
    /// 
    /// used by volumeflow sensors
    /// </summary>
    /// <param name="time">time vector</param>
    /// <param name="id">id of sensor or sensor_array</param>
    /// <param name="x">matrix</param>
    /// <param name="id_in_array">id of sensor in sensor_array</param>
    /// <param name="par">some doubles</param>
    /// <exception cref="exception">Unknown sensor id</exception>
    /// <exception cref="exception">time.Length != x.GetLength(1)</exception>
    public void measureVecStream(double[] time, string id, 
                                 double[,] x, string id_in_array, 
                                 params double[] par)
    {
      sensor mySensor= get(id, id_in_array);

      if (time.Length != x.GetLength(1))
        throw new exception(String.Format(
        "Arrays time and x do not have the same size of dimension: {0} != {1}!", 
        time.Length, x.GetLength(1)));

      for (int itime= 0; itime < time.Length; itime++)
      {
        double[] x_current= new double[x.GetLength(0)];

        for (int ivalue= 0; ivalue < x_current.Length; ivalue++)
          x_current[ivalue]= x[ivalue, itime];

        mySensor.measure(time[itime], 0, x_current, par);
      }
    }



    /// <summary>
    /// Do measurements which depend on plant. 
    /// 
    /// used by Norg, TKN, Ntot sensors.
    /// 
    /// 5th type
    /// 
    /// example sensor: 
    /// at the end called by biogas_chp_plant
    /// d.h.: energyProduction_sensor
    /// </summary>
    /// <param name="time">current simulation time</param>
    /// <param name="id">id of sensor</param>
    /// <param name="myPlant"></param>
    /// <param name="u">could be biogas stream or state vector</param>
    /// <exception cref="exception">Unknown sensor id</exception>
    public void measure(double time, string id, //double deltatime,
                        biogas.plant myPlant, double[] u)
    {
      double value;

      measure(time, id, myPlant, u, out value);
    }
    /// <summary>
    /// Do measurements which depend on plant. 
    /// 
    /// used by Norg, TKN, Ntot sensors.
    /// 
    /// 5th type
    /// 
    /// example sensor: 
    /// at the end called by biogas_chp_plant
    /// d.h.: energyProduction_sensor
    /// </summary>
    /// <param name="time">current simulation time</param>
    /// <param name="id">id of sensor</param>
    /// <param name="myPlant"></param>
    /// <param name="u">could be biogas stream or state vector</param>
    /// <param name="value">measured value</param>
    /// <exception cref="exception">Unknown sensor id</exception>
    public void measure(double time, string id, //double deltatime,
                        biogas.plant myPlant, double[] u, out double value)
    {
      double[] vals;
      
      measureVec(time, id, myPlant, u, out vals);

      value = vals[0];
    }
    /// <summary>
    /// Do measurements which depend on plant. 
    /// 
    /// used by Norg, TKN, Ntot sensors.
    /// 
    /// 5th type
    /// 
    /// example sensor: 
    /// at the end called by biogas_chp_plant
    /// d.h.: energyProduction_sensor
    /// </summary>
    /// <param name="time">current simulation time</param>
    /// <param name="id">id of sensor</param>
    /// <param name="myPlant"></param>
    /// <param name="u">could be biogas stream or state vector</param>
    /// <param name="values">measured values</param>
    /// <exception cref="exception">Unknown sensor id</exception>
    public void measureVec(double time, string id, //double deltatime,
                           biogas.plant myPlant, double[] u, out double[] values)
    {
      string param= "";

      measureVec(time, id, myPlant, u, param, out values);
    }
    /// <summary>
    /// Do measurements which depend on plant. 
    /// 
    /// used by Norg, TKN, Ntot sensors.
    /// 
    /// 5th type
    /// 
    /// example sensor: 
    /// at the end called by biogas_chp_plant
    /// d.h.: energyProduction_sensor
    /// 
    /// called by chps.run(), former biogas2bhkw
    /// </summary>
    /// <param name="time">current simulation time</param>
    /// <param name="id">id of sensor</param>
    /// <param name="myPlant"></param>
    /// <param name="u">could be biogas stream or state vector</param>
    /// <param name="param">some string</param>
    /// <param name="values">measured valuse</param>
    /// <exception cref="exception">Unknown sensor id</exception>
    public void measureVec(double time, string id, //double deltatime,
                           biogas.plant myPlant, double[] u, string param, out double[] values)
    {
      physValue[] vals= measureVec(time, id, myPlant, u, param);

      values= physValue.getValues(vals);
    }
    /// <summary>
    /// Do measurements which depend on plant. 
    /// 
    /// used by Norg, TKN, Ntot sensors.
    /// 
    /// 5th type
    /// 
    /// example sensor: 
    /// at the end called by biogas_chp_plant
    /// d.h.: energyProduction_sensor
    /// </summary>
    /// <param name="time">current simulation time</param>
    /// <param name="id">id of sensor</param>
    /// <param name="myPlant"></param>
    /// <param name="u">could be biogas stream or state vector</param>
    /// <param name="param">some string</param>
    /// <returns>measured values</returns>
    /// <exception cref="exception">Unknown sensor id</exception>
    public physValue[] measureVec(double time, string id, //double deltatime,
                                  biogas.plant myPlant,
                                  double[] u, string param)
    {
      double[] par= new double[1];

      return measureVec(time, id, myPlant, u, param, par);
    }
    /// <summary>
    /// Do measurements which depend on plant. 
    /// 
    /// used by Norg, TKN, Ntot sensors.
    /// 
    /// 5th type
    /// 
    /// example sensor: 
    /// at the end called by biogas_chp_plant
    /// d.h.: energyProduction_sensor
    /// </summary>
    /// <param name="time">current simulation time</param>
    /// <param name="id">id of sensor</param>
    /// <param name="myPlant"></param>
    /// <param name="u">could be biogas stream or state vector</param>
    /// <param name="param">some string</param>
    /// <param name="par">some doubles</param>
    /// <returns>measured values</returns>
    /// <exception cref="exception">Unknown sensor id</exception>
    public physValue[] measureVec(double time, string id, //double deltatime,
                                  biogas.plant myPlant,
                                  double[] u, string param, params double[] par)
    {
      sensor mySensor= get(id);

      return mySensor.measure(time, sampling_time, myPlant, u, param, par);
    }



    /// <summary>
    /// Do measurements which depend on plant and substrates. 
    /// 
    /// 6th type
    /// 
    /// example sensor:
    /// wird von heatConsumption_sensor genutzt
    /// </summary>
    /// <param name="time">current simulation time</param>
    /// <param name="id">id of sensor</param>
    /// <param name="myPlant"></param>
    /// <param name="mySubstrates"></param>
    /// <param name="substrate_network"></param>
    /// <param name="digester_id">ID of digester</param>
    /// <returns>measured values</returns>
    /// <exception cref="exception">Unknown sensor id</exception>
    public physValue[] measureVec(double time, string id, //double deltatime,
                                  biogas.plant myPlant, biogas.substrates mySubstrates,
                                  double[,] substrate_network, string digester_id)
    {
      physValue[] Q_digester = getSubstrateMixFlowForFermenter(time, mySubstrates, myPlant,
                                  this, substrate_network, digester_id);

      // values are Q for all substrates
      double[] Q = physValue.getValues(Q_digester);
      
      return measureVec(time, id, myPlant, mySubstrates, Q);
    }
    /// <summary>
    /// Do measurements which depend on plant and substrates. 
    /// 
    /// 6th type
    /// 
    /// example sensor:
    /// wird von heatConsumption_sensor genutzt
    /// 
    /// heatConsumption_sensor benötigt call mit substrate_network, 
    /// damit getSubstrateMixFlowForFermenter
    /// aufgerufen werden kann, den haben wir direkt hier drüber
    /// </summary>
    /// <param name="time">current simulation time</param>
    /// <param name="id">id of sensor</param>
    /// <param name="myPlant"></param>
    /// <param name="mySubstrates"></param>
    /// <param name="values">measured values</param>
    /// <exception cref="exception">Unknown sensor id</exception>
    public void measureVec(double time, string id, //double deltatime,
                           biogas.plant myPlant, biogas.substrates mySubstrates, 
                           out double[] values)
    {
      physValue[] vals= measureVec(time, id, myPlant, mySubstrates);

      values= physValue.getValues(vals);
    }
    /// <summary>
    /// Do measurements which depend on plant and substrates. 
    /// 
    /// 6th type
    /// 
    /// example sensor:
    /// wird von heatConsumption_sensor genutzt
    /// </summary>
    /// <param name="time">current simulation time</param>
    /// <param name="id">id of sensor</param>
    /// <param name="myPlant"></param>
    /// <param name="mySubstrates"></param>
    /// <returns>measured values</returns>
    /// <exception cref="exception">Unknown sensor id</exception>
    public physValue[] measureVec(double time, string id, //double deltatime,
                                  biogas.plant myPlant, biogas.substrates mySubstrates)
    {
      double[] Q;

      // TODO !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
      // id_in_array einführen und durch "Q" ersetzen
      // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
      //getCurrentMeasurements("Q", "Q", mySubstrates, out Q);
      getMeasurementsAt("Q", "Q", time, mySubstrates, out Q);

      return measureVec(time, id, myPlant, mySubstrates,
                        Q);
    }
    /// <summary>
    /// Do measurements which depend on plant and substrates. 
    /// 
    /// 6th type
    /// 
    /// example sensor:
    /// wird von heatConsumption_sensor genutzt
    /// </summary>
    /// <param name="time">current simulation time</param>
    /// <param name="id">id of sensor</param>
    /// <param name="myPlant"></param>
    /// <param name="mySubstrates"></param>
    /// <param name="Q">zufuhr aller substrate in anlage, nicht in fermenter
    /// TODO: es wäre vermutlich besser wenn es nur in fermenter wäre, 
    /// da heatConsumption_sensor am fermenter angebracht ist</param>
    /// <returns>measured values</returns>
    /// <exception cref="exception">Unknown sensor id</exception>
    public physValue[] measureVec(double time, string id, //double deltatime,
                                  biogas.plant myPlant, biogas.substrates mySubstrates,
                                  double[] Q)
    {
      double[] par= new double[1];

      return measureVec(time, id, myPlant, mySubstrates,
                        Q, par);
    }
    /// <summary>
    /// Do measurements which depend on plant and substrates. 
    /// 
    /// 6th type
    /// 
    /// example sensor:
    /// wird von heatConsumption_sensor genutzt
    /// </summary>
    /// <param name="time">current simulation time</param>
    /// <param name="id">id of sensor</param>
    /// <param name="myPlant"></param>
    /// <param name="mySubstrates"></param>
    /// <param name="Q">could be substrate feed</param>
    /// <param name="par">some doubles</param>
    /// <returns>measured values</returns>
    /// <exception cref="exception">Unknown sensor id</exception>
    public physValue[] measureVec(double time, string id, //double deltatime,
                                  biogas.plant myPlant, biogas.substrates mySubstrates,
                                  double[] Q, params double[] par)
    {
      sensor mySensor= get(id);

      return mySensor.measure(time, sampling_time, myPlant, mySubstrates, Q, par);
    }



  }
}


