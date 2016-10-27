/**
 * This file is part of the partial class sensors and defines
 * special get measurements methods of the class.
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
    /// Returns measurement at a given time t of a sensor_array
    /// </summary>
    /// <param name="mySubstrates">list of substrates that are included in the sum, mean</param>
    /// <param name="id_sensor_array">id of sensor_array</param>
    /// <param name="s_operator">operator: mean or sum</param>
    /// <param name="t">simulation time in days</param>
    /// <param name="index">index inside sensor: 0, 1, 2, ...</param>
    /// <param name="noisy">if true, then noisy measurement values are returned. 
    /// they are only noisy if the parameter apply_real_sensor was true before and during
    /// the simulation</param>
    /// <returns></returns>
    /// <exception cref="exception">Unknown sensor array id</exception>
    /// <exception cref="exception">Invalid index</exception>
    public double getArrayMeasurementDAt(substrates mySubstrates, string id_sensor_array, 
                                         string s_operator, double t, int index, bool noisy)
    {
      sensor_array mySensorArray = getArray(id_sensor_array);

      return mySensorArray.getMeasurementDAt(mySubstrates, s_operator, t, index, noisy);
    }



    /// <summary>
    /// Returns measurement at a given time t of a sensor. Dependent on the operator
    /// the sum or mean is returned for all chps or all digesters. 
    /// </summary>
    /// <param name="myPlant">plant object</param>
    /// <param name="sensor_id">id of sensor</param>
    /// <param name="s_operator">operator: mean or sum for chps or digesters</param>
    /// <param name="t">simulation time in days</param>
    /// <param name="index">index inside sensor: 0, 1, 2, ...</param>
    /// <param name="noisy">if true, then noisy measurement values are returned. 
    /// they are only noisy if the parameter apply_real_sensor was true before and during
    /// the simulation</param>
    /// <returns></returns>
    /// <exception cref="exception">Unknown sensor id</exception>
    /// <exception cref="exception">Invalid index</exception>
    public double getMeasurementDAt(plant myPlant, string sensor_id,
                                    string s_operator, double t, int index, bool noisy)
    {
      List<double> values = new List<double>();

      if (s_operator.StartsWith("chps"))
      {
        foreach (chp myCHP in myPlant.myCHPs)
        {
          values.Add( getMeasurementDAt(sensor_id + "_" + myCHP.id, "", t, index, noisy) );
        }      
      }
      else if (s_operator.StartsWith("digesters"))
      {
        foreach (digester myDigester in myPlant.myDigesters)
        {
          values.Add( getMeasurementDAt(sensor_id + "_" + myDigester.id, "", t, index, noisy) );
        }
      }
      else
      {
        throw new exception(String.Format("Invalid operator: {0}. Must start with chps or digesters!", 
            s_operator), "sensors_getMeasurements_special.cs");
      }

      if (s_operator.EndsWith("sum"))
        return math.sum(values);
      else if (s_operator.EndsWith("mean"))
        return math.mean(values);
      else
        throw new exception(String.Format("Invalid operator: {0}. Must end with sum or mean!",
          s_operator), "sensors_getMeasurements_special.cs");

    }
    
    /// <summary>
    /// Returns current measurement of a sensor. Dependent on the operator
    /// the sum or mean is returned for all chps or all digesters. 
    /// </summary>
    /// <param name="myPlant">plant object</param>
    /// <param name="sensor_id">id of sensor</param>
    /// <param name="s_operator">operator: mean or sum for chps or digesters</param>
    /// <param name="index">index inside sensor: 0, 1, 2, ...</param>
    /// <param name="noisy">if true, then noisy measurement values are returned. 
    /// they are only noisy if the parameter apply_real_sensor was true before and during
    /// the simulation</param>
    /// <returns></returns>
    /// <exception cref="exception">Unknown sensor id</exception>
    /// <exception cref="exception">Invalid index</exception>
    public double getCurrentMeasurementDind(plant myPlant, string sensor_id,
                                            string s_operator, int index, bool noisy)
    {
      List<double> values = new List<double>();

      if (s_operator.StartsWith("chps"))
      {
        foreach (chp myCHP in myPlant.myCHPs)
        {
          values.Add(getCurrentMeasurementDind(sensor_id + "_" + myCHP.id, index, noisy));
        }
      }
      else if (s_operator.StartsWith("digesters"))
      {
        foreach (digester myDigester in myPlant.myDigesters)
        {
          values.Add(getCurrentMeasurementDind(sensor_id + "_" + myDigester.id, index, noisy));
        }
      }
      else
      {
        throw new exception(String.Format("Invalid operator: {0}. Must start with chps or digesters!",
            s_operator), "sensors_getMeasurements_special.cs");
      }

      if (s_operator.EndsWith("sum"))
        return math.sum(values);
      else if (s_operator.EndsWith("mean"))
        return math.mean(values);
      else
        throw new exception(String.Format("Invalid operator: {0}. Must end with sum or mean!",
          s_operator), "sensors_getMeasurements_special.cs");

    }

    /// <summary>
    /// Returns current measurement of a sensor. Dependent on the operator
    /// the sum or mean is returned for all chps or all digesters. 
    /// </summary>
    /// <param name="myPlant">plant object</param>
    /// <param name="sensor_id">id of sensor</param>
    /// <param name="s_operator">operator: mean or sum for chps or digesters</param>
    /// <param name="noisy">if true, then noisy measurement values are returned. 
    /// they are only noisy if the parameter apply_real_sensor was true before and during
    /// the simulation</param>
    /// <returns></returns>
    /// <exception cref="exception">Unknown sensor id</exception>
    /// <exception cref="exception">Invalid index</exception>
    public double getCurrentMeasurementD(plant myPlant, string sensor_id,
                                         string s_operator, bool noisy)
    {
      return getCurrentMeasurementDind(myPlant, sensor_id, s_operator, 0, noisy);
    }


    /// <summary>
    /// Returns current measurement of a sensor. Dependent on the operator
    /// the sum or mean is returned for all chps or all digesters. 
    /// </summary>
    /// <param name="myPlant">plant object</param>
    /// <param name="sensor_id">id of sensor</param>
    /// <param name="s_operator">operator: mean or sum for chps or digesters</param>
    /// <param name="index">index inside sensor: 0, 1, 2, ...</param>
    /// <param name="noisy">if true, then noisy measurement values are returned. 
    /// they are only noisy if the parameter apply_real_sensor was true before and during
    /// the simulation</param>
    /// <param name="values_op">double array with values</param>
    /// <exception cref="exception">Unknown sensor id</exception>
    /// <exception cref="exception">Invalid index</exception>
    public void getMeasurementStream(plant myPlant, string sensor_id,
                                     string s_operator, int index, bool noisy, out double[] values_op)
    {
      double[] values;
      values_op = new double[0];

      if (s_operator.StartsWith("chps"))
      {
        foreach (chp myCHP in myPlant.myCHPs)
        {
          getMeasurementStream(sensor_id + "_" + myCHP.id, index, noisy, out values);

          if (values_op.Length == 0)
          {
            values_op= new double[values.Length];

            for(int iel= 0; iel < values.Length; iel++)
              values_op[iel]= values[iel];
          }
          else
          {
            if (s_operator.EndsWith("sum"))
              values_op= math.plus(values_op, values);
            else
              throw new exception(String.Format("Invalid operator: {0}. Must end with sum!",
                s_operator), "sensors_getMeasurements_special.cs");
          }
        }
      }
      else if (s_operator.StartsWith("digesters"))
      {
        foreach (digester myDigester in myPlant.myDigesters)
        {
          getMeasurementStream(sensor_id + "_" + myDigester.id, index, noisy, out values);

          if (values_op.Length == 0)
          {
            values_op = new double[values.Length];

            for (int iel = 0; iel < values.Length; iel++)
              values_op[iel] = values[iel];
          }
          else
          {
            if (s_operator.EndsWith("sum"))
              values_op = math.plus(values_op, values);
            else
              throw new exception(String.Format("Invalid operator: {0}. Must end with sum!",
                s_operator), "sensors_getMeasurements_special.cs");
          }
        }
      }
      else
      {
        throw new exception(String.Format("Invalid operator: {0}. Must start with chps or digesters!",
            s_operator), "sensors_getMeasurements_special.cs");
      }
    }



  }
}


