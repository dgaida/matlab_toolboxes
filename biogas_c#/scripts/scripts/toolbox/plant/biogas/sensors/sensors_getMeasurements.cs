/**
 * This file is part of the partial class sensors and defines
 * get measurements methods of the class.
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
    /// Get the current measurement value, so the value last saved in the sensor valuelist. 
    /// Before returning the value the unit of the value is converted into the given unit.
    /// The returned value has an accuracy of digits digits.
    /// </summary>
    /// <param name="id">id of a sensor</param>
    /// <param name="digits">number of digits of the returned value</param>
    /// <param name="unit">unit of the returned value</param>
    /// <returns></returns>
    /// <exception cref="exception">Unknown sensor id</exception>
    public physValue getCurrentMeasurement(string id, int digits, string unit)
    {
      return getCurrentMeasurement(id, digits, unit, false);
    }
    /// <summary>
    /// Get the current measurement value, so the value last saved in the sensor valuelist. 
    /// Before returning the value the unit of the value is converted into the given unit.
    /// The returned value has an accuracy of digits digits.
    /// </summary>
    /// <param name="id">id of a sensor</param>
    /// <param name="digits">number of digits of the returned value</param>
    /// <param name="unit">unit of the returned value</param>
    /// <param name="noisy">if true, then noisy measurement values are returned. 
    /// they are only noisy if the parameter apply_real_sensor was true before and during
    /// the simulation</param>
    /// <returns></returns>
    /// <exception cref="exception">Unknown sensor id</exception>
    public physValue getCurrentMeasurement(string id, int digits, string unit, bool noisy)
    {
      physValue value= getCurrentMeasurement(id, noisy);

      value= value.convertUnit(unit);

      value= physValue.round(value, digits);

      return value;
    }
    /// <summary>
    /// Get the current measurement value, so the value last saved in the sensor valuelist. 
    /// Before returning the value the unit of the value is converted into the given unit.
    /// The returned value has an accuracy of digits digits.
    /// Only the double value is returned.
    /// </summary>
    /// <param name="id">id of sensor</param>
    /// <param name="digits">number of digits of the returned value</param>
    /// <param name="value">returned value</param>
    /// <exception cref="exception">Unknown sensor id</exception>
    public void getCurrentMeasurementD(string id, int digits, out double value)
    {
      getCurrentMeasurementD(id, digits, false, out value);
    }
    /// <summary>
    /// Get the current measurement value, so the value last saved in the sensor valuelist. 
    /// Before returning the value the unit of the value is converted into the given unit.
    /// The returned value has an accuracy of digits digits.
    /// Only the double value is returned.
    /// </summary>
    /// <param name="id">id of sensor</param>
    /// <param name="digits">number of digits of the returned value</param>
    /// <param name="noisy">if true, then noisy measurement values are returned. 
    /// they are only noisy if the parameter apply_real_sensor was true before and during
    /// the simulation</param>
    /// <param name="value">returned value</param>
    /// <exception cref="exception">Unknown sensor id</exception>
    public void getCurrentMeasurementD(string id, int digits, bool noisy, out double value)
    {
      value= getCurrentMeasurement(id, digits, noisy).Value;
    }
    /// <summary>
    /// Get the current measurement value, so the value last saved in the sensor valuelist. 
    /// The returned value has an accuracy of digits digits.
    /// </summary>
    /// <param name="id">id of sensor</param>
    /// <param name="digits">number of digits of the returned value</param>
    /// <returns></returns>
    /// <exception cref="exception">Unknown sensor id</exception>
    public physValue getCurrentMeasurement(string id, int digits)
    {
      return getCurrentMeasurement(id, digits, false);
    }
    /// <summary>
    /// Get the current measurement value, so the value last saved in the sensor valuelist. 
    /// The returned value has an accuracy of digits digits.
    /// </summary>
    /// <param name="id">id of sensor</param>
    /// <param name="digits">number of digits of the returned value</param>
    /// <param name="noisy">if true, then noisy measurement values are returned. 
    /// they are only noisy if the parameter apply_real_sensor was true before and during
    /// the simulation</param>
    /// <returns></returns>
    /// <exception cref="exception">Unknown sensor id</exception>
    public physValue getCurrentMeasurement(string id, int digits, bool noisy)
    {
      physValue value= getCurrentMeasurement(id, noisy);

      value= physValue.round(value, digits);

      return value;
    }
    /// <summary>
    /// Get the current measurement value, so the value last saved in the sensor valuelist. 
    /// Only the double value is returned. 
    /// </summary>
    /// <param name="id">id of sensor</param>
    /// <param name="value">returned double value</param>
    /// <exception cref="exception">Unknown sensor id</exception>
    public void getCurrentMeasurementD(string id, out double value)
    {
      getCurrentMeasurementD(id, false, out value);
    }
    /// <summary>
    /// Get the current measurement value, so the value last saved in the sensor valuelist. 
    /// Only the double value is returned. 
    /// </summary>
    /// <param name="id">id of sensor</param>
    /// <param name="noisy">if true, then noisy measurement values are returned. 
    /// they are only noisy if the parameter apply_real_sensor was true before and during
    /// the simulation</param>
    /// <param name="value">returned double value</param>
    /// <exception cref="exception">Unknown sensor id</exception>
    public void getCurrentMeasurementD(string id, bool noisy, out double value)
    {
      value= getCurrentMeasurement(id, noisy).Value;
    }
    /// <summary>
    /// Get the current measurement value, so the value last saved in the sensor valuelist.
    /// </summary>
    /// <param name="id">id of sensor</param>
    /// <returns></returns>
    /// <exception cref="exception">Unknown sensor id</exception>
    public physValue getCurrentMeasurement(string id)
    {
      return getCurrentMeasurement(id, false);
    }
    /// <summary>
    /// Get the current measurement value, so the value last saved in the sensor valuelist.
    /// </summary>
    /// <param name="id">id of sensor</param>
    /// <param name="noisy">if true, then noisy measurement values are returned. 
    /// they are only noisy if the parameter apply_real_sensor was true before and during
    /// the simulation</param>
    /// <returns></returns>
    /// <exception cref="exception">Unknown sensor id</exception>
    public physValue getCurrentMeasurement(string id, bool noisy) 
    {
      return getCurrentMeasurement(id, "", noisy);
    }
    /// <summary>
    /// Get the current measurement value, so the value last saved in the sensor valuelist.
    /// </summary>
    /// <param name="id">id of sensor or sensor array</param>
    /// <param name="id_in_array">id of sensor in sensor_array</param>
    /// <returns></returns>
    /// <exception cref="exception">Unknown sensor id</exception>
    public physValue getCurrentMeasurement(string id, string id_in_array)
    {
      return getCurrentMeasurement(id, id_in_array, false);
    }
    /// <summary>
    /// Get the current measurement value, so the value last saved in the sensor valuelist.
    /// </summary>
    /// <param name="id">id of sensor or sensor array</param>
    /// <param name="id_in_array">id of sensor in sensor_array</param>
    /// <param name="noisy">if true, then noisy measurement values are returned. 
    /// they are only noisy if the parameter apply_real_sensor was true before and during
    /// the simulation</param>
    /// <returns></returns>
    /// <exception cref="exception">Unknown sensor id</exception>
    public physValue getCurrentMeasurement(string id, string id_in_array, bool noisy)
    {
      sensor mySensor= get(id, id_in_array);

      return mySensor.getCurrentMeasurement(noisy);
    }
    /// <summary>
    /// Get the current measurement value, so the value last saved in the sensor valuelist.
    /// </summary>
    /// <param name="id">id of sensor or sensor array</param>
    /// <param name="id_in_array">id of sensor in sensor_array</param>
    /// <param name="noisy">if true, then noisy measurement values are returned. 
    /// they are only noisy if the parameter apply_real_sensor was true before and during
    /// the simulation</param>
    /// <returns></returns>
    /// <exception cref="exception">Unknown sensor id</exception>
    public double getCurrentMeasurementD(string id, string id_in_array, bool noisy)
    {
      return getCurrentMeasurement(id, id_in_array, noisy).Value;
    }

    /// <summary>
    /// Get current value of given sensor id / id_in_array at position index
    /// </summary>
    /// <param name="id">id of sensor or sensor array</param>
    /// <param name="id_in_array">id of sensor in sensor_array</param>
    /// <param name="index">index inside sensor: 0, 1, ...</param>
    /// <param name="noisy">if true, then noisy measurement values are returned. 
    /// they are only noisy if the parameter apply_real_sensor was true before and during
    /// the simulation</param>
    /// <returns>current value of sensor id as double</returns>
    /// <exception cref="exception">Unknown sensor id</exception>
    /// <exception cref="exception">Invalid index</exception>
    public double getCurrentMeasurementDind(string id, string id_in_array, int index, bool noisy)
    {
      double[] values;

      getCurrentMeasurementVectorD(id, id_in_array, noisy, out values);

      if (index < 0 || index >= values.Length)
        throw new exception(String.Format("index must be between 0 and {0}, but is {1}!",
          values.Length - 1, index));

      return values[index];
    }



    /// <summary>
    /// Get the current measurement value, so the value last saved in the sensor valuelist.
    /// 
    /// e.g. used by VFAmatrix_sensor, substrateparams_sensor
    /// </summary>
    /// <param name="id">id of sensor or sensor_array</param>
    /// <param name="id_in_array">id of sensor in sensor_array</param>
    /// <param name="param">e.g. a substrate parameter</param>
    /// <param name="value"></param>
    /// <exception cref="exception">Unknown sensor id</exception>
    public void getCurrentMeasurementD(string id, string id_in_array, string param,
                                       out double value)
    {
      getCurrentMeasurementD(id, id_in_array, param, false, out value);
    }
    /// <summary>
    /// Get the current measurement value, so the value last saved in the sensor valuelist.
    /// 
    /// e.g. used by VFAmatrix_sensor, substrateparams_sensor
    /// </summary>
    /// <param name="id">id of sensor or sensor_array</param>
    /// <param name="id_in_array">id of sensor in sensor_array</param>
    /// <param name="param">e.g. a substrate parameter</param>
    /// <param name="noisy">if true, then noisy measurement values are returned. 
    /// they are only noisy if the parameter apply_real_sensor was true before and during
    /// the simulation</param>
    /// <param name="value"></param>
    /// <exception cref="exception">Unknown sensor id</exception>
    public void getCurrentMeasurementD(string id, string id_in_array, string param,
                                       bool noisy, out double value)
    {
      value= getCurrentMeasurement(id, id_in_array, param, noisy).Value;
    }
    /// <summary>
    /// Get the current measurement value, so the value last saved in the sensor valuelist.
    /// 
    /// e.g. used by VFAmatrix_sensor, substrateparams_sensor
    /// </summary>
    /// <param name="id">id of sensor or sensor_array</param>
    /// <param name="id_in_array">id of sensor in sensor_array</param>
    /// <param name="param">e.g. a substrate parameter</param>
    /// <returns></returns>
    /// <exception cref="exception">Unknown sensor id</exception>
    public physValue getCurrentMeasurement(string id, string id_in_array, string param)
    {
      return getCurrentMeasurement(id, id_in_array, param, false);
    }
    /// <summary>
    /// Get the current measurement value, so the value last saved in the sensor valuelist.
    /// 
    /// e.g. used by VFAmatrix_sensor, substrateparams_sensor
    /// </summary>
    /// <param name="id">id of sensor or sensor_array</param>
    /// <param name="id_in_array">id of sensor in sensor_array</param>
    /// <param name="param">e.g. a substrate parameter</param>
    /// <param name="noisy">if true, then noisy measurement values are returned. 
    /// they are only noisy if the parameter apply_real_sensor was true before and during
    /// the simulation</param>
    /// <returns></returns>
    /// <exception cref="exception">Unknown sensor id</exception>
    public physValue getCurrentMeasurement(string id, string id_in_array, string param, bool noisy)
    {
      sensor mySensor= get(id, id_in_array);

      return mySensor.getCurrentMeasurement(param, noisy);
    }



    /// <summary>
    /// get current measurement value at given index. round to 2 decimals.
    /// </summary>
    /// <param name="id">id of sensor</param>
    /// <param name="index">index inside sensor: 0, 1, ...</param>
    /// <returns>measured value at given index</returns>
    /// <exception cref="exception">Unknown sensor id</exception>
    /// <exception cref="exception">Invalid index</exception>
    public double getCurrentMeasurementDind(string id, int index)
    {
      return getCurrentMeasurementDind(id, index, 2, false);
    }
    /// <summary>
    /// get current measurement value at given index. 
    /// </summary>
    /// <param name="id">id of sensor</param>
    /// <param name="index">index inside sensor: 0, 1, ...</param>
    /// <param name="digits">decimals of returned value</param>
    /// <returns>measured value at given index</returns>
    /// <exception cref="exception">Unknown sensor id</exception>
    /// <exception cref="exception">Invalid index</exception>
    public double getCurrentMeasurementDind(string id, int index, int digits)
    {
      return getCurrentMeasurementDind(id, index, digits, false);
    }
    /// <summary>
    /// get current measurement value at given index. 
    /// </summary>
    /// <param name="id">id of sensor</param>
    /// <param name="index">index inside sensor: 0, 1, ...</param>
    /// <param name="digits">decimals of returned value</param>
    /// <param name="noisy">if true, then noisy measurement values are returned. 
    /// they are only noisy if the parameter apply_real_sensor was true before and during
    /// the simulation</param>
    /// <returns>measured value at given index</returns>
    /// <exception cref="exception">Unknown sensor id</exception>
    /// <exception cref="exception">Invalid index</exception>
    public double getCurrentMeasurementDind(string id, int index, int digits, bool noisy)
    {
      double value= getCurrentMeasurementDind(id, index, noisy);

      return Math.Round(value, digits);
    }
    /// <summary>
    /// get current measurement value at given index. 
    /// </summary>
    /// <param name="id">id of sensor</param>
    /// <param name="index">index inside sensor: 0, 1, ...</param>
    /// <param name="noisy">if true, then noisy measurement values are returned. 
    /// they are only noisy if the parameter apply_real_sensor was true before and during
    /// the simulation</param>
    /// <returns>measured value at given index</returns>
    /// <exception cref="exception">Unknown sensor id</exception>
    /// <exception cref="exception">Invalid index</exception>
    public double getCurrentMeasurementDind(string id, int index, bool noisy)
    {
      double[] values;

      getCurrentMeasurementVectorD(id, noisy, out values);

      if (index < 0 || index >= values.Length)
        throw new exception(String.Format("index must be between 0 and {0}, but is {1}!",
          values.Length - 1, index));

      return values[index];
    }
    /// <summary>
    /// get current measurement value at given index. 
    /// </summary>
    /// <param name="id">id of sensor</param>
    /// <param name="index">index inside sensor: 0, 1, ...</param>
    /// <param name="digits">decimals of returned value</param>
    /// <returns>measured value at given index</returns>
    /// <exception cref="exception">Unknown sensor id</exception>
    /// <exception cref="exception">Invalid index</exception>
    public physValue getCurrentMeasurementind(string id, int index, int digits)
    {
      return getCurrentMeasurementind(id, index, digits, false);
    }
    /// <summary>
    /// get current measurement value at given index. 
    /// </summary>
    /// <param name="id">id of sensor</param>
    /// <param name="index">index inside sensor: 0, 1, ...</param>
    /// <param name="digits">decimals of returned value</param>
    /// <param name="noisy">if true, then noisy measurement values are returned. 
    /// they are only noisy if the parameter apply_real_sensor was true before and during
    /// the simulation</param>
    /// <returns>measured value at given index</returns>
    /// <exception cref="exception">Unknown sensor id</exception>
    /// <exception cref="exception">Invalid index</exception>
    public physValue getCurrentMeasurementind(string id, int index, int digits, bool noisy)
    {
      physValue[] values= getCurrentMeasurementVector(id, noisy);

      if (index < 0 || index >= values.Length)
        throw new exception(String.Format("index must be between 0 and {0}, but is {1}!",
          values.Length - 1, index));

      return physValue.round(values[index], digits);
    }



    /// <summary>
    /// Return current measurement vector as doubles. 
    /// for MATLAB
    /// </summary>
    /// <param name="id">id of sensor</param>
    /// <param name="values">returned measured vector</param>
    /// <exception cref="exception">Unknown sensor id</exception>
    public void getCurrentMeasurementVectorD(string id, out double[] values)
    {
      getCurrentMeasurementVectorD(id, false, out values);
    }
    /// <summary>
    /// Return current measurement vector as doubles. 
    /// for MATLAB
    /// </summary>
    /// <param name="id">id of sensor</param>
    /// <param name="noisy">if true, then noisy measurement values are returned. 
    /// they are only noisy if the parameter apply_real_sensor was true before and during
    /// the simulation</param>
    /// <param name="values">returned measured vector</param>
    /// <exception cref="exception">Unknown sensor id</exception>
    public void getCurrentMeasurementVectorD(string id, bool noisy, out double[] values)
    {
      getCurrentMeasurementVectorD(id, "", noisy, out values);
    }
    /// <summary>
    /// Return current measurement vector as doubles. 
    /// for MATLAB
    /// </summary>
    /// <param name="id">id of sensor</param>
    /// <param name="id_in_array">id in sensor array</param>
    /// <param name="noisy">if true, then noisy measurement values are returned. 
    /// they are only noisy if the parameter apply_real_sensor was true before and during
    /// the simulation</param>
    /// <param name="values">returned measured vector</param>
    /// <exception cref="exception">Unknown sensor id</exception>
    public void getCurrentMeasurementVectorD(string id, string id_in_array, bool noisy, out double[] values)
    {
      values = physValue.getValues(getCurrentMeasurementVector(id, id_in_array, noisy));
    }    
    /// <summary>
    /// Get the current measurement vector up to digits accuracy. 
    /// So the vector of the last measurements.
    /// </summary>
    /// <param name="id">id of sensor</param>
    /// <param name="digits">number of digits the returned values have</param>
    /// <returns></returns>
    /// <exception cref="exception">Unknown sensor id</exception>
    public physValue[] getCurrentMeasurementVector(string id, int digits)
    {
      return getCurrentMeasurementVector(id, digits, false);
    }
    /// <summary>
    /// Get the current measurement vector up to digits accuracy. 
    /// So the vector of the last measurements.
    /// </summary>
    /// <param name="id">id of sensor</param>
    /// <param name="digits">number of digits the returned values have</param>
    /// <returns></returns>
    /// <param name="noisy">if true, then noisy measurement values are returned. 
    /// they are only noisy if the parameter apply_real_sensor was true before and during
    /// the simulation</param>
    /// <exception cref="exception">Unknown sensor id</exception>
    public physValue[] getCurrentMeasurementVector(string id, int digits, bool noisy)
    {
      physValue[] myValues= getCurrentMeasurementVector(id, noisy);

      myValues= physValue.round(myValues, digits);
      
      return myValues;
    }
    /// <summary>
    /// Get the current measurement vector. So the vector of the last measurements.
    /// </summary>
    /// <param name="id">id of sensor</param>
    /// <returns></returns>
    /// <exception cref="exception">Unknown sensor id</exception>
    public physValue[] getCurrentMeasurementVector(string id)
    {
      return getCurrentMeasurementVector(id, false);
    }
    /// <summary>
    /// Get the current measurement vector. So the vector of the last measurements.
    /// </summary>
    /// <param name="id">id of sensor</param>
    /// <param name="noisy">if true, then noisy measurement values are returned. 
    /// they are only noisy if the parameter apply_real_sensor was true before and during
    /// the simulation</param>
    /// <returns></returns>
    /// <exception cref="exception">Unknown sensor id</exception>
    public physValue[] getCurrentMeasurementVector(string id, bool noisy)
    {
      return getCurrentMeasurementVector(id, "", noisy);
    }
    /// <summary>
    /// Get the current measurement vector. So the vector of the last measurements.
    /// </summary>
    /// <param name="id">id of sensor or sensor_array</param>
    /// <param name="id_in_array">id of sensor in sensor_array</param>
    /// <returns></returns>
    /// <exception cref="exception">Unknown sensor id</exception>
    public physValue[] getCurrentMeasurementVector(string id, string id_in_array)
    {
      return getCurrentMeasurementVector(id, id_in_array, false);
    }
    /// <summary>
    /// Get the current measurement vector. So the vector of the last measurements.
    /// </summary>
    /// <param name="id">id of sensor or sensor_array</param>
    /// <param name="id_in_array">id of sensor in sensor_array</param>
    /// <param name="noisy">if true, then noisy measurement values are returned. 
    /// they are only noisy if the parameter apply_real_sensor was true before and during
    /// the simulation</param>
    /// <returns></returns>
    /// <exception cref="exception">Unknown sensor id</exception>
    public physValue[] getCurrentMeasurementVector(string id, string id_in_array, bool noisy)
    {
      sensor mySensor= get(id, id_in_array);

      return mySensor.getCurrentMeasurementVector(noisy);
    }


    /// <summary>
    /// Get the current measurement value for all substrates as a vector. Vector
    /// has number of substrates elements. 
    /// </summary>
    /// <param name="id">id of (sensor or) sensor_array</param>
    /// <param name="id_in_array">id of sensor in sensor_array</param>
    /// <param name="mySubstrates"></param>
    /// <param name="values"></param>
    public void getCurrentMeasurements(string id, string id_in_array,
                                       substrates mySubstrates,
                                       out double[] values) // TODO überladen
    {
      // TODO - getCurrentMeasurements darf nie für substrate Q aufgerufen werden
      // da zu beginn der simulation alle Qs bereits in den sensor geschrieben werden
      // und damit current immer das letzte element im sensor ist.
      throw new exception("getCurrentMeasurements may not be called for Q_substrates");

      physValue[] pValues= getCurrentMeasurements(id, id_in_array, mySubstrates);

      values= physValue.getValues(pValues);
    }
    /// <summary>
    /// Get the current measurement value for all substrates as a vector. Vector
    /// has number of substrates elements. 
    /// e.g. returns recorded substrate feeds Q, Q_maize, ...
    /// </summary>
    /// <param name="id">id of (sensor or) sensor_array</param>
    /// <param name="id_in_array">id of sensor in sensor_array</param>
    /// <param name="mySubstrates"></param>
    /// <returns></returns>
    public physValue[] getCurrentMeasurements(string id, string id_in_array,
                                              substrates mySubstrates) // TODO überladen
    {
      // TODO - getCurrentMeasurements darf nie für substrate Q aufgerufen werden
      // da zu beginn der simulation alle Qs bereits in den sensor geschrieben werden
      // und damit current immer das letzte element im sensor ist.
      throw new exception("getCurrentMeasurements may not be called for Q_substrates");

      physValue[] returnValues= new physValue[mySubstrates.getNumSubstrates()];

      for (int isubstrate= 0; isubstrate < mySubstrates.getNumSubstrates(); isubstrate++)
      {
        string myID_in_array= id_in_array + "_" + mySubstrates.getID(isubstrate + 1);

        sensor mySensor= get(id, myID_in_array);

        returnValues[isubstrate]= mySensor.getCurrentMeasurement();
      }

      return returnValues;
    }



    /// <summary>
    /// Returns first measurement at a given time t
    /// </summary>
    /// <param name="id">id of sensor or sensor_array</param>
    /// <param name="t">simulation time in days</param>
    /// <param name="value"></param>
    /// <exception cref="exception">Unknown sensor id</exception>
    public void getMeasurementAt(string id, double t, out double value)
    {
      getMeasurementAt(id, "", t, out value);
    }
    /// <summary>
    /// Returns first measurement at a given time t
    /// </summary>
    /// <param name="id">id of sensor or sensor_array</param>
    /// <param name="id_in_array">id of sensor in sensor_array</param>
    /// <param name="t">simulation time in days</param>
    /// <param name="value"></param>
    /// <exception cref="exception">Unknown sensor id</exception>
    public void getMeasurementAt(string id, string id_in_array, double t, out double value)
    {
      getMeasurementAt(id, id_in_array, t, false, out value);
    }
    /// <summary>
    /// Returns first measurement at a given time t
    /// </summary>
    /// <param name="id">id of sensor or sensor_array</param>
    /// <param name="t">simulation time in days</param>
    /// <param name="noisy">if true, then noisy measurement values are returned. 
    /// they are only noisy if the parameter apply_real_sensor was true before and during
    /// the simulation</param>
    /// <param name="value"></param>
    /// <exception cref="exception">Unknown sensor id</exception>
    public void getMeasurementAt(string id, double t, bool noisy, out double value)
    {
      getMeasurementAt(id, "", t, noisy, out value);
    }
    /// <summary>
    /// Returns first measurement at a given time t
    /// </summary>
    /// <param name="id">id of sensor or sensor_array</param>
    /// <param name="id_in_array">id of sensor in sensor_array</param>
    /// <param name="t">simulation time in days</param>
    /// <param name="noisy">if true, then noisy measurement values are returned. 
    /// they are only noisy if the parameter apply_real_sensor was true before and during
    /// the simulation</param>
    /// <param name="value"></param>
    /// <exception cref="exception">Unknown sensor id</exception>
    public void getMeasurementAt(string id, string id_in_array, double t, bool noisy, out double value)
    {
      value= getMeasurementAt(id, id_in_array, t, noisy).Value;
    }
    /// <summary>
    /// Returns first measurement at a given time t
    /// </summary>
    /// <param name="id">id of sensor or sensor_array</param>
    /// <param name="id_in_array">id of sensor in sensor_array</param>
    /// <param name="t">simulation time in days</param>
    /// <returns></returns>
    /// <exception cref="exception">Unknown sensor id</exception>
    public physValue getMeasurementAt(string id, string id_in_array, double t)
    {
      return getMeasurementAt(id, id_in_array, t, false);
    }
    /// <summary>
    /// Returns first measurement at a given time t
    /// </summary>
    /// <param name="id">id of sensor or sensor_array</param>
    /// <param name="id_in_array">id of sensor in sensor_array</param>
    /// <param name="t">simulation time in days</param>
    /// <param name="noisy">if true, then noisy measurement values are returned. 
    /// they are only noisy if the parameter apply_real_sensor was true before and during
    /// the simulation</param>
    /// <returns></returns>
    /// <exception cref="exception">Unknown sensor id</exception>
    public physValue getMeasurementAt(string id, string id_in_array, double t, bool noisy)
    {
      return getMeasurementAt(id, id_in_array, t, 0, noisy);
    }
    /// <summary>
    /// Returns first measurement at a given time t
    /// </summary>
    /// <param name="id">id of sensor or sensor_array</param>
    /// <param name="id_in_array">id of sensor in sensor_array</param>
    /// <param name="t">simulation time in days</param>
    /// <param name="index">index inside sensor: 0, 1, 2, ...</param>
    /// <param name="noisy">if true, then noisy measurement values are returned. 
    /// they are only noisy if the parameter apply_real_sensor was true before and during
    /// the simulation</param>
    /// <returns></returns>
    /// <exception cref="exception">Unknown sensor id</exception>
    /// <exception cref="exception">Invalid index</exception>
    public physValue getMeasurementAt(string id, string id_in_array, double t, int index, bool noisy)
    {
      physValue[] values= getMeasurementVectorAt(id, id_in_array, t, noisy);

      if (index < 0 || index >= values.Length)
        throw new exception(String.Format("index must be between 0 and {0}, but is {1}!",
          values.Length - 1, index));
      
      return values[index];
    }

    /// <summary>
    /// Returns indexth measurement at a given time t
    /// </summary>
    /// <param name="id">id of sensor or sensor_array</param>
    /// <param name="id_in_array">id of sensor in sensor_array</param>
    /// <param name="t">simulation time in days</param>
    /// <param name="index">index inside sensor: 0, 1, 2, ...</param>
    /// <param name="noisy">if true, then noisy measurement values are returned. 
    /// they are only noisy if the parameter apply_real_sensor was true before and during
    /// the simulation</param>
    /// <returns></returns>
    /// <exception cref="exception">Unknown sensor id</exception>
    /// <exception cref="exception">Invalid index</exception>
    public double getMeasurementDAt(string id, string id_in_array, double t, int index, bool noisy)
    {
      physValue value = getMeasurementAt(id, id_in_array, t, index, noisy);

      return value.Value;
    }



    /// <summary>
    /// Returns measurement vector at a given time t as double vector
    /// </summary>
    /// <param name="id">id of sensor</param>
    /// <param name="t">simulation time in days</param>
    /// <param name="values">double vector</param>
    /// <exception cref="exception">Unknown sensor id</exception>
    public void getMeasurementVectorAt(string id, double t, out double[] values)
    {
      physValue[] pValues = getMeasurementVectorAt(id, t);

      values = physValue.getValues(pValues);
    }
    /// <summary>
    /// Returns measurement vector at a given time t as double vector
    /// </summary>
    /// <param name="id">id of sensor</param>
    /// <param name="t">simulation time in days</param>
    /// <param name="noisy">if true, then noisy measurement values are returned. 
    /// they are only noisy if the parameter apply_real_sensor was true before and during
    /// the simulation</param>
    /// <param name="values">double vector</param>
    /// <exception cref="exception">Unknown sensor id</exception>
    public void getMeasurementVectorAt(string id, double t, bool noisy, out double[] values)
    {
      physValue[] pValues = getMeasurementVectorAt(id, t, noisy);

      values = physValue.getValues(pValues);
    }
    /// <summary>
    /// Returns measurement vector at a given time t as double vector
    /// </summary>
    /// <param name="id">id of sensor or sensor_array</param>
    /// <param name="id_in_array">id of sensor in sensor_array</param>
    /// <param name="t">simulation time in days</param>
    /// <param name="values">double vector</param>
    /// <exception cref="exception">Unknown sensor id</exception>
    public void getMeasurementVectorAt(string id, string id_in_array, double t, out double[] values)
    {
      physValue[] pValues = getMeasurementVectorAt(id, id_in_array, t);

      values = physValue.getValues(pValues);
    }
    /// <summary>
    /// Returns measurement vector at a given time t as double vector
    /// </summary>
    /// <param name="id">id of sensor or sensor_array</param>
    /// <param name="id_in_array">id of sensor in sensor_array</param>
    /// <param name="t">simulation time in days</param>
    /// <param name="noisy">if true, then noisy measurement values are returned. 
    /// they are only noisy if the parameter apply_real_sensor was true before and during
    /// the simulation</param>
    /// <param name="values">double vector</param>
    /// <exception cref="exception">Unknown sensor id</exception>
    public void getMeasurementVectorAt(string id, string id_in_array, double t, bool noisy, 
      out double[] values)
    {
      physValue[] pValues = getMeasurementVectorAt(id, id_in_array, t, noisy);

      values = physValue.getValues(pValues);
    }
    /// <summary>
    /// Returns measurement vector at a given time t
    /// </summary>
    /// <param name="id">id of sensor</param>
    /// <param name="t">simulation time in days</param>
    /// <returns></returns>
    /// <exception cref="exception">Unknown sensor id</exception>
    public physValue[] getMeasurementVectorAt(string id, double t)
    {
      return getMeasurementVectorAt(id, t, false);
    }
    /// <summary>
    /// Returns measurement vector at a given time t
    /// </summary>
    /// <param name="id">id of sensor</param>
    /// <param name="t">simulation time in days</param>
    /// <param name="noisy">if true, then noisy measurement values are returned. 
    /// they are only noisy if the parameter apply_real_sensor was true before and during
    /// the simulation</param>
    /// <returns></returns>
    /// <exception cref="exception">Unknown sensor id</exception>
    public physValue[] getMeasurementVectorAt(string id, double t, bool noisy)
    {
      return getMeasurementVectorAt(id, "", t, noisy);
    }
    /// <summary>
    /// Returns measurement vector at a given time t
    /// </summary>
    /// <param name="id">id of sensor or sensor_array</param>
    /// <param name="id_in_array">id of sensor in sensor_array</param>
    /// <param name="t">simulation time in days</param>
    /// <returns></returns>
    /// <exception cref="exception">Unknown sensor id</exception>
    public physValue[] getMeasurementVectorAt(string id, string id_in_array, double t)
    {
      return getMeasurementVectorAt(id, id_in_array, t, false);
    }
    /// <summary>
    /// Returns measurement vector at a given time t
    /// </summary>
    /// <param name="id">id of sensor or sensor_array</param>
    /// <param name="id_in_array">id of sensor in sensor_array</param>
    /// <param name="t">simulation time in days</param>
    /// <param name="noisy">if true, then noisy measurement values are returned. 
    /// they are only noisy if the parameter apply_real_sensor was true before and during
    /// the simulation</param>
    /// <returns></returns>
    /// <exception cref="exception">Unknown sensor id</exception>
    public physValue[] getMeasurementVectorAt(string id, string id_in_array, double t, bool noisy)
    {
      sensor mySensor= get(id, id_in_array);

      return mySensor.getMeasurementVectorAt(t, noisy);
    }



    /// <summary>
    /// Get the measurement value for all substrates at the given time as a vector. Vector
    /// has number of substrates elements. 
    /// e.g. returns recorded substrate feeds Q, Q_maize, ...
    /// </summary>
    /// <param name="id">id of (sensor or) sensor_array</param>
    /// <param name="id_in_array">id of sensor in sensor_array</param>
    /// <param name="t">simulation time in days</param>
    /// <param name="mySubstrates"></param>
    /// <param name="values"></param>
    /// <exception cref="exception">Unknown sensor id</exception>
    public void getMeasurementsAt(string id, string id_in_array,
                                  double t, substrates mySubstrates,
                                  out double[] values)
    {
      getMeasurementsAt(id, id_in_array, t, mySubstrates, false, out values);
    }
    /// <summary>
    /// Get the measurement value for all substrates at the given time as a vector. Vector
    /// has number of substrates elements. 
    /// e.g. returns recorded substrate feeds Q, Q_maize, ...
    /// </summary>
    /// <param name="id">id of (sensor or) sensor_array</param>
    /// <param name="id_in_array">id of sensor in sensor_array</param>
    /// <param name="t">simulation time in days</param>
    /// <param name="mySubstrates"></param>
    /// <param name="noisy">if true, then noisy measurement values are returned. 
    /// they are only noisy if the parameter apply_real_sensor was true before and during
    /// the simulation</param>
    /// <param name="values"></param>
    /// <exception cref="exception">Unknown sensor id</exception>
    public void getMeasurementsAt(string id, string id_in_array,
                                  double t, substrates mySubstrates,
                                  bool noisy, out double[] values)
    {
      physValue[] pValues= getMeasurementsAt(id, id_in_array, t, mySubstrates);

      values= physValue.getValues(pValues);
    }
    /// <summary>
    /// Get the measurement value for all substrates at the given time as a vector. Vector
    /// has number of substrates elements. 
    /// e.g. returns recorded substrate feeds Q, Q_maize, ... at a given time t
    /// </summary>
    /// <param name="id">id of (sensor or) sensor_array</param>
    /// <param name="id_in_array">id of sensor in sensor_array</param>
    /// <param name="t">simulation time in days</param>
    /// <param name="mySubstrates"></param>
    /// <returns></returns>
    /// <exception cref="exception">Unknown sensor id</exception>
    public physValue[] getMeasurementsAt(string id, string id_in_array,
                                         double t, substrates mySubstrates) // TODO überladen
    {
      return getMeasurementsAt(id, id_in_array, t, mySubstrates, false);
    }
    /// <summary>
    /// Get the measurement value for all substrates at the given time as a vector. Vector
    /// has number of substrates elements. 
    /// e.g. returns recorded substrate feeds Q, Q_maize, ... at a given time t
    /// </summary>
    /// <param name="id">id of (sensor or) sensor_array</param>
    /// <param name="id_in_array">id of sensor in sensor_array</param>
    /// <param name="t">simulation time in days</param>
    /// <param name="mySubstrates"></param>
    /// <param name="noisy">if true, then noisy measurement values are returned. 
    /// they are only noisy if the parameter apply_real_sensor was true before and during
    /// the simulation</param>
    /// <returns></returns>
    /// <exception cref="exception">Unknown sensor id</exception>
    public physValue[] getMeasurementsAt(string id, string id_in_array, 
                                         double t, substrates mySubstrates, bool noisy)
    {
      physValue[] returnValues= new physValue[mySubstrates.getNumSubstrates()];

      for (int isubstrate= 0; isubstrate < mySubstrates.getNumSubstrates(); isubstrate++)
      {
        string myID_in_array= id_in_array + "_" + mySubstrates.getID(isubstrate + 1);

        sensor mySensor= get(id, myID_in_array);

        returnValues[isubstrate]= mySensor.getMeasurementAt(t, noisy);
      }

      return returnValues;
    }



    /// <summary>
    /// Returns the current time value with digits accuracy. 
    /// The value of the 1st sensor is returned.
    /// If empty, then 0 is returned.
    /// </summary>
    /// <param name="digits"></param>
    /// <returns></returns>
    public double getCurrentTime(int digits)
    {
      return Math.Round( getCurrentTime(), digits );
    }
    /// <summary>
    /// Returns the current time value. The value of the 1st sensor is returned.
    /// If empty, then 0 is returned.
    /// </summary>
    /// <returns>time in days</returns>
    public double getCurrentTime()
    {
      if (this.Count > 0)
        return this[0].getCurrentTime();
      else
        return 0;
    }
    /// <summary>
    /// Returns the current time value. The value of the 1st sensor is returned.
    /// If empty, then -1 is returned.
    /// </summary>
    /// <returns>time in days</returns>
    public double getPreviousTime()
    {
      if (this.Count > 0)
        return this[0].getPreviousTime();
      else
        return -1;
    }

    /// <summary>
    /// Return current time of given sensor. 
    /// </summary>
    /// <param name="id">id of sensor</param>
    /// <returns></returns>
    /// <exception cref="exception">Unknown sensor id</exception>
    public double getCurrentTime(string id)
    {
      return getCurrentTime(id, "");
    }
    /// <summary>
    /// Return current time of given sensor or given sensor in sensor_array. 
    /// </summary>
    /// <param name="id">id of sensor or sensor_array</param>
    /// <param name="id_in_array">id of sensor in sensor_array</param>
    /// <returns></returns>
    /// <exception cref="exception">Unknown sensor id</exception>
    public double getCurrentTime(string id, string id_in_array)
    {
      sensor mySensor= get(id, id_in_array);

      return mySensor.getCurrentTime();
    }


    /// <summary>
    /// Returns a double array with the current measurement vectors of all
    /// sensors (not sensor_array), concatenated.
    /// Furthermore returns the corresponding symbol and unit in the string
    /// array symbols_units. unit and symbol are cleaned from special characters.
    /// </summary>
    /// <param name="symbols_units"></param>
    /// <returns></returns>
    public double[] getCurrentMeasurements(out string[] symbols_units)
    {
      return getCurrentMeasurements(false, out symbols_units);
    }
    /// <summary>
    /// Returns a double array with the current measurement vectors of all
    /// sensors (not sensor_array), concatenated.
    /// Furthermore returns the corresponding symbol and unit in the string
    /// array symbols_units. unit and symbol are cleaned from special characters.
    /// </summary>
    /// <param name="noisy">if true, then noisy measurement values are returned. 
    /// they are only noisy if the parameter apply_real_sensor was true before and during
    /// the simulation</param>
    /// <param name="symbols_units"></param>
    /// <returns></returns>
    public double[] getCurrentMeasurements(bool noisy, out string[] symbols_units)
    { 
      List<double> values=         new List<double>();
      List<string> Lsymbols_units= new List<string>();

      foreach( sensor mySensor in this )
      {
        physValue[] pValues= mySensor.getCurrentMeasurementVector(noisy);

        for (int ivalue= 0; ivalue < pValues.Length; ivalue++)
        {
          values.Add(         pValues[ivalue].Value );

          string unit= pValues[ivalue].getUnit_wo_sp_ch();

          if (unit.Equals(""))
            Lsymbols_units.Add( pValues[ivalue].getSymbol_wo_sp_ch() + "_" + 
                                mySensor.id_suffix );
          else
            Lsymbols_units.Add( pValues[ivalue].getSymbol_wo_sp_ch() + "_" +
                                mySensor.id_suffix + "_" +
                                unit );

        }
      }

      symbols_units= Lsymbols_units.ToArray();

      return values.ToArray();
    }



    /// <summary>
    /// Get complete measurement stream of the given sensor as double array.
    /// Furthermore the corresponding symbols and units are returned in the
    /// string array symbols_units. unit and symbol are cleaned from special 
    /// characters.
    /// </summary>
    /// <param name="id">id of sensor</param>
    /// <param name="symbols_units"></param>
    /// <returns></returns>
    /// <exception cref="exception">Unknown sensor id</exception>
    public double[,] getMeasurementStreams(string id,
                                           out string[] symbols_units)
    {
      return getMeasurementStreams(id, false, out symbols_units);
    }
    /// <summary>
    /// Get complete measurement stream of the given sensor as double array.
    /// Furthermore the corresponding symbols and units are returned in the
    /// string array symbols_units. unit and symbol are cleaned from special 
    /// characters.
    /// </summary>
    /// <param name="id">id of sensor</param>
    /// <param name="noisy">if true, then noisy measurement values are returned. 
    /// they are only noisy if the parameter apply_real_sensor was true before and during
    /// the simulation</param>
    /// <param name="symbols_units"></param>
    /// <returns></returns>
    /// <exception cref="exception">Unknown sensor id</exception>
    public double[,] getMeasurementStreams(string id, bool noisy, 
                                           out string[] symbols_units)
    {
      return getMeasurementStreams(id, "", noisy, out symbols_units);
    }
    /// <summary>
    /// Get complete measurement stream of the given sensor as double array.
    /// Furthermore the corresponding symbols and units are returned in the
    /// string array symbols_units. unit and symbol are cleaned from special 
    /// characters.
    /// </summary>
    /// <param name="id">id of sensor or sensor_array</param>
    /// <param name="id_in_array">id of sensor in sensor_array</param>
    /// <param name="symbols_units"></param>
    /// <returns></returns>
    /// <exception cref="exception">Unknown sensor id</exception>
    public double[,] getMeasurementStreams(string id, string id_in_array,
                                           out string[] symbols_units)
    {
      return getMeasurementStreams(id, id_in_array, false, out symbols_units);
    }
    /// <summary>
    /// Get complete measurement stream of the given sensor as double array.
    /// Furthermore the corresponding symbols and units are returned in the
    /// string array symbols_units. unit and symbol are cleaned from special 
    /// characters.
    /// </summary>
    /// <param name="id">id of sensor or sensor_array</param>
    /// <param name="id_in_array">id of sensor in sensor_array</param>
    /// <param name="noisy">if true, then noisy measurement values are returned. 
    /// they are only noisy if the parameter apply_real_sensor was true before and during
    /// the simulation</param>
    /// <param name="symbols_units"></param>
    /// <returns></returns>
    /// <exception cref="exception">Unknown sensor id</exception>
    public double[,] getMeasurementStreams(string id, string id_in_array, bool noisy, 
                                           out string[] symbols_units)
    {
      sensor mySensor= get(id, id_in_array);

      List<physValue[]> pValues= mySensor.getMeasurementStream(noisy);

      //
      // size number of measurements x dimension
      double[,] myValues= new double[pValues.Count, pValues[0].Length];
      // size dimension x 1
      symbols_units= new string[pValues[0].Length];

      //

      for (int idim= 0; idim < pValues[0].Length; idim++)
      {
        for (int idata= 0; idata < pValues.Count; idata++)
          myValues[idata, idim]= ((pValues[idata])[idim]).Value;

        string unit= (pValues[0])[idim].getUnit_wo_sp_ch();

        if (unit.Equals(""))
          symbols_units[idim]= (pValues[0])[idim].getSymbol_wo_sp_ch() + "_" + 
                             mySensor.id_suffix;
        else
          symbols_units[idim] = (pValues[0])[idim].getSymbol_wo_sp_ch() + "_" +
                             mySensor.id_suffix + "_" + unit;
      }
      
      //

      return myValues;
    }


    /// <summary>
    /// Get measurement stream of first variable of given sensor as double array
    /// </summary>
    /// <param name="id">id of sensor or sensor_array</param>
    /// <param name="id_in_array">id of sensor in sensor_array</param>
    /// <param name="values"></param>
    /// <exception cref="exception">Unknown sensor id</exception>
    public void getMeasurementStream(string id, string id_in_array, out double[] values)
    {
      getMeasurementStream(id, id_in_array, false, out values);
    }
    /// <summary>
    /// Get measurement stream of first variable of given sensor as double array
    /// </summary>
    /// <param name="id">id of sensor or sensor_array</param>
    /// <param name="id_in_array">id of sensor in sensor_array</param>
    /// <param name="noisy">if true, then noisy measurement values are returned. 
    /// they are only noisy if the parameter apply_real_sensor was true before and during
    /// the simulation</param>
    /// <param name="values"></param>
    /// <exception cref="exception">Unknown sensor id</exception>
    public void getMeasurementStream(string id, string id_in_array, bool noisy, out double[] values)
    {
      physValue[] pvalues= getMeasurementStream(id, id_in_array, noisy);

      values= physValue.getValues(pvalues);
    }
    /// <summary>
    /// Get measurement stream of indexed variable of given sensor as double array
    /// </summary>
    /// <param name="id">id of sensor</param>
    /// <param name="index">0, 1, ...</param>
    /// <param name="values"></param>
    /// <exception cref="exception">Unknown sensor id</exception>
    public void getMeasurementStream(string id, int index, out double[] values)
    {
      getMeasurementStream(id, index, false, out values);
    }
    /// <summary>
    /// Get measurement stream of indexed variable of given sensor as double array
    /// </summary>
    /// <param name="id">id of sensor</param>
    /// <param name="index">0, 1, ...</param>
    /// <param name="noisy">if true, then noisy measurement values are returned. 
    /// they are only noisy if the parameter apply_real_sensor was true before and during
    /// the simulation</param>
    /// <param name="values"></param>
    /// <exception cref="exception">Unknown sensor id</exception>
    public void getMeasurementStream(string id, int index, bool noisy, out double[] values)
    {
      physValue[] pvalues= getMeasurementStream(id, index, noisy);

      values= physValue.getValues(pvalues);
    }
    /// <summary>
    /// Get measurement stream of first variable of given sensor as double array
    /// </summary>
    /// <param name="id">id of sensor</param>
    /// <param name="values"></param>
    /// <exception cref="exception">Unknown sensor id</exception>
    public void getMeasurementStream(string id, out double[] values)
    {
      getMeasurementStream(id, false, out values);
    }
    /// <summary>
    /// Get measurement stream of first variable of given sensor as double array
    /// </summary>
    /// <param name="id">id of sensor</param>
    /// <param name="noisy">if true, then noisy measurement values are returned. 
    /// they are only noisy if the parameter apply_real_sensor was true before and during
    /// the simulation</param>
    /// <param name="values"></param>
    /// <exception cref="exception">Unknown sensor id</exception>
    public void getMeasurementStream(string id, bool noisy, out double[] values)
    {
      getMeasurementStream(id, 0, noisy, out values);
    }
    /// <summary>
    /// Get measurement stream of first variable of given sensor as physValue array
    /// </summary>
    /// <param name="id">id of sensor</param>
    /// <param name="index">0, 1, ...</param>
    /// <returns></returns>
    /// <exception cref="exception">Unknown sensor id</exception>
    public physValue[] getMeasurementStream(string id, int index)
    {
      return getMeasurementStream(id, index, false);
    }
    /// <summary>
    /// Get measurement stream of first variable of given sensor as physValue array
    /// </summary>
    /// <param name="id">id of sensor</param>
    /// <param name="index">0, 1, ...</param>
    /// <param name="noisy">if true, then noisy measurement values are returned. 
    /// they are only noisy if the parameter apply_real_sensor was true before and during
    /// the simulation</param>
    /// <returns></returns>
    /// <exception cref="exception">Unknown sensor id</exception>
    public physValue[] getMeasurementStream(string id, int index, bool noisy)
    {
      return getMeasurementStream(id, "", index, noisy);
    }
    /// <summary>
    /// Get measurement stream of first variable of given sensor as physValue array
    /// </summary>
    /// <param name="id">id of sensor</param>
    /// <returns></returns>
    /// <exception cref="exception">Unknown sensor id</exception>
    public physValue[] getMeasurementStream(string id)
    {
      return getMeasurementStream(id, false);
    }
    /// <summary>
    /// Get measurement stream of first variable of given sensor as physValue array
    /// </summary>
    /// <param name="id">id of sensor</param>
    /// <param name="noisy">if true, then noisy measurement values are returned. 
    /// they are only noisy if the parameter apply_real_sensor was true before and during
    /// the simulation</param>
    /// <returns></returns>
    /// <exception cref="exception">Unknown sensor id</exception>
    public physValue[] getMeasurementStream(string id, bool noisy)
    {
      return getMeasurementStream(id, "", 0, noisy);
    }
    /// <summary>
    /// Get measurement stream of first variable of given sensor as physValue array
    /// </summary>
    /// <param name="id">id of sensor or sensor_array</param>
    /// <param name="id_in_array">id of sensor in sensor_array</param>
    /// <returns></returns>
    /// <exception cref="exception">Unknown sensor id</exception>
    public physValue[] getMeasurementStream(string id, string id_in_array)
    {
      return getMeasurementStream(id, id_in_array, false);
    }
    /// <summary>
    /// Get measurement stream of first variable of given sensor as physValue array
    /// </summary>
    /// <param name="id">id of sensor or sensor_array</param>
    /// <param name="id_in_array">id of sensor in sensor_array</param>
    /// <param name="noisy">if true, then noisy measurement values are returned. 
    /// they are only noisy if the parameter apply_real_sensor was true before and during
    /// the simulation</param>
    /// <returns></returns>
    /// <exception cref="exception">Unknown sensor id</exception>
    public physValue[] getMeasurementStream(string id, string id_in_array, bool noisy)
    {
      return getMeasurementStream(id, id_in_array, 0, noisy);
    }
    /// <summary>
    /// Get measurement stream of indexed variable of given sensor as physValue array
    /// </summary>
    /// <param name="id">id of sensor or sensor_array</param>
    /// <param name="id_in_array">id of sensor in sensor_array</param>
    /// <param name="index">0, 1, ...</param>
    /// <returns></returns>
    /// <exception cref="exception">Unknown sensor id</exception>
    public physValue[] getMeasurementStream(string id, string id_in_array, int index)
    {
      return getMeasurementStream(id, id_in_array, index, false);
    }
    /// <summary>
    /// Get measurement stream of indexed variable of given sensor as physValue array
    /// </summary>
    /// <param name="id">id of sensor or sensor_array</param>
    /// <param name="id_in_array">id of sensor in sensor_array</param>
    /// <param name="index">0, 1, ...</param>
    /// <param name="noisy">if true, then noisy measurement values are returned. 
    /// they are only noisy if the parameter apply_real_sensor was true before and during
    /// the simulation</param>
    /// <returns></returns>
    /// <exception cref="exception">Unknown sensor id</exception>
    public physValue[] getMeasurementStream(string id, string id_in_array, int index, bool noisy)
    {
      sensor mySensor= get(id, id_in_array);

      return mySensor.getMeasurementStream(index, noisy);
    }


    /// <summary>
    /// Get measurement stream of given sensor as double array
    /// </summary>
    /// <param name="id">id of sensor or sensor_array</param>
    /// <param name="id_in_array">id of sensor in sensor_array</param>
    /// <param name="param"></param>
    /// <param name="values"></param>
    /// <exception cref="exception">Unknown sensor id</exception>
    public void getMeasurementStream(string id, string id_in_array, string param,
                                     out double[] values)
    {
      getMeasurementStream(id, id_in_array, param, false, out values);
    }
    /// <summary>
    /// Get measurement stream of given sensor as double array
    /// </summary>
    /// <param name="id">id of sensor or sensor_array</param>
    /// <param name="id_in_array">id of sensor in sensor_array</param>
    /// <param name="param"></param>
    /// <param name="noisy">if true, then noisy measurement values are returned. 
    /// they are only noisy if the parameter apply_real_sensor was true before and during
    /// the simulation</param>
    /// <param name="values"></param>
    /// <exception cref="exception">Unknown sensor id</exception>
    public void getMeasurementStream(string id, string id_in_array, string param, 
                                     bool noisy, out double[] values)
    {
      physValue[] pvalues= getMeasurementStream(id, id_in_array, param, noisy);

      values= physValue.getValues(pvalues);
    }
    /// <summary>
    /// Get measurement stream of given sensor as physValue array
    /// </summary>
    /// <param name="id">id of sensor or sensor_array</param>
    /// <param name="id_in_array">id of sensor in sensor_array</param>
    /// <param name="param"></param>
    /// <returns></returns>
    /// <exception cref="exception">Unknown sensor id</exception>
    public physValue[] getMeasurementStream(string id, string id_in_array, string param)
    {
      return getMeasurementStream(id, id_in_array, param, false);
    }
    /// <summary>
    /// Get measurement stream of given sensor as physValue array
    /// </summary>
    /// <param name="id">id of sensor or sensor_array</param>
    /// <param name="id_in_array">id of sensor in sensor_array</param>
    /// <param name="param"></param>
    /// <param name="noisy">if true, then noisy measurement values are returned. 
    /// they are only noisy if the parameter apply_real_sensor was true before and during
    /// the simulation</param>
    /// <returns></returns>
    /// <exception cref="exception">Unknown sensor id</exception>
    public physValue[] getMeasurementStream(string id, string id_in_array, string param, bool noisy)
    {
      sensor mySensor= get(id, id_in_array);

      // 
      return mySensor.getMeasurementStream(param, noisy);    
    }



    /// <summary>
    /// Get time stream of first sensor
    /// </summary>
    /// <returns></returns>
    /// <exception cref="exception">list of sensors empty</exception>
    public double[] getTimeStream()
    {
      if (this.Count < 1)
        throw new exception("getTimeStream:List of sensors is empty!");

      sensor mySensor= this[0];

      return mySensor.getTimeStream();
    }
    /// <summary>
    /// get time stream of specified sensor
    /// </summary>
    /// <param name="id">id of sensor</param>
    /// <returns></returns>
    /// <exception cref="exception">Unknown sensor id</exception>
    public double[] getTimeStream(string id)
    {
      return getTimeStream(id, "");
    }
    /// <summary>
    /// get time stream of specified sensor
    /// </summary>
    /// <param name="id">id of sensor or sensor_array</param>
    /// <param name="id_in_array">id of sensor in sensor_array</param>
    /// <returns></returns>
    /// <exception cref="exception">Unknown sensor id</exception>
    public double[] getTimeStream(string id, string id_in_array)
    {
      sensor mySensor= get(id, id_in_array);

      return mySensor.getTimeStream();
    }


    
  }
}


