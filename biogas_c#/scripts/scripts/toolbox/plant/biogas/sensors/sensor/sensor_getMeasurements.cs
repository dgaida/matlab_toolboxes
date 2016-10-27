/**
 * This file is part of the partial class substrate and defines
 * all getMeasurements methods.
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
  public abstract partial class sensor
  {

    // -------------------------------------------------------------------------------------
    //                              !!! PUBLIC METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// Returns the current time in the list, so the time when last saved in the list.
    /// as default time is measured in days. If the list is empty -infinity is returned.
    /// </summary>
    /// <returns>current time in days</returns>
    public double getCurrentTime()
    {
      if (time.Count > 0)
        return time[time.Count - 1];
      else
        return double.NegativeInfinity;
    }

    /// <summary>
    /// Returns the previous time in the list, so the time when before the last saved in the list.
    /// as default time is measured in days. If the list is empty -infinity is returned.
    /// If only one element is saved, then a day before the one element is returned
    /// </summary>
    /// <returns>previous time in days</returns>
    public double getPreviousTime()
    {
      if (time.Count > 1)
        return time[time.Count - 2];
      else if (time.Count > 0)
        return time[time.Count - 1] - 1;    // current time - 1 day
      else
        return double.NegativeInfinity;     // 
    }

    /// <summary>
    /// Returns the current measurement in the list, so the value last saved in the list.
    /// What is returned is the first measurement with respect to the dimension of the 
    /// sensor.
    /// </summary>
    /// <returns>current measurement value</returns>
    public physValue getCurrentMeasurement()    
    {
      return getCurrentMeasurement(0);
    }
    /// <summary>
    /// Returns the current measurement in the list, so the value last saved in the list.
    /// What is returned is the first measurement with respect to the dimension of the 
    /// sensor.
    /// </summary>
    /// <param name="noisy">if true, then noisy measurement values are returned. 
    /// they are only noisy if the parameter apply_real_sensor was true before and during
    /// the simulation</param>
    /// <returns>current measurement value</returns>
    public physValue getCurrentMeasurement(bool noisy)    
    {
      return getCurrentMeasurement(0, noisy);
    }
    /// <summary>
    /// Returns the current measurement in the list, so the value last saved in the list.
    /// What is returned is the measurement at position index (0-based) with 
    /// respect to the dimension (dim) of the sensor.
    /// </summary>
    /// <param name="index">index insid dimension of sensor: 0, 1, 2, ...</param>
    /// <returns>current measurement value</returns>
    /// <exception cref="exception">Invalid index</exception>
    public physValue getCurrentMeasurement(int index)
    {
      return getCurrentMeasurement(index, false);
    }
    /// <summary>
    /// Returns the current measurement in the list, so the value last saved in the list.
    /// What is returned is the measurement at position index (0-based) with 
    /// respect to the dimension (dim) of the sensor.
    /// </summary>
    /// <param name="index">index insid dimension of sensor: 0, 1, 2, ...</param>
    /// <param name="noisy">if true, then noisy measurement values are returned. 
    /// they are only noisy if the parameter apply_real_sensor was true before and during
    /// the simulation</param>
    /// <returns>current measurement value</returns>
    /// <exception cref="exception">Invalid index</exception>
    public physValue getCurrentMeasurement(int index, bool noisy)    
    {
      physValue[] values= getCurrentMeasurementVector(noisy);

      if (index >= 0 && index < values.Length)
        return values[index];
      else
        throw new exception(String.Format(
        "index {0} is bigger or equal as/to the size of values {1} (or < 0)!", index, values.Length));
    }
    /// <summary>
    /// Returns the current measurement vector in the list, so the values last saved 
    /// in the list. If list is empty a zero vector with dimension dimension is returned.
    /// </summary>
    /// <returns>current measurement vector</returns>
    public physValue[] getCurrentMeasurementVector()    
    {
      return getCurrentMeasurementVector(false);
    }
    /// <summary>
    /// Returns the current measurement vector in the list, so the values last saved 
    /// in the list. If list is empty a zero vector with dimension dimension is returned.
    /// </summary>
    /// <param name="noisy">if true, then noisy measurement values are returned. 
    /// they are only noisy if the parameter apply_real_sensor was true before and during
    /// the simulation</param>
    /// <returns>current measurement vector</returns>
    public physValue[] getCurrentMeasurementVector(bool noisy)    
    {
      if (values.Count > 0)
      {
        if (noisy)
          return values_noise[values_noise.Count - 1];      // return noisy values
        else
          return values[values.Count - 1];      // return normal values
      }
      else
      {
        physValue[] myValues = new physValue[dimension];

        for (int ivalue = 0; ivalue < dimension; ivalue++)
          myValues[ivalue] = new physValue();

        return myValues;
      }
    }


    /// <summary>
    /// Get measurement at the specified time t of the first variable
    /// </summary>
    /// <param name="t">simulation time in days</param>
    /// <returns>measurement value at time t at position 0</returns>
    public physValue getMeasurementAt(double t)    
    {
      return getMeasurementAt(t, false);
    }
    /// <summary>
    /// Get measurement at the specified time t of the first variable
    /// </summary>
    /// <param name="t">simulation time in days</param>
    /// <param name="noisy">if true, then noisy measurement values are returned. 
    /// they are only noisy if the parameter apply_real_sensor was true before and during
    /// the simulation</param>
    /// <returns>measurement value at time t at position 0</returns>
    public physValue getMeasurementAt(double t, bool noisy)    
    {
      return getMeasurementAt(0, t, noisy);
    }
    /// <summary>
    /// Get measurement at the specified time t of the by index specified variable
    /// </summary>
    /// <param name="index">index is 0-based: 0, 1, 2, ...</param>
    /// <param name="t">simulation time in days</param>
    /// <returns>measurement value at time t at position index</returns>
    /// <exception cref="exception">Invalid index</exception>
    public physValue getMeasurementAt(int index, double t)
    {
      return getMeasurementAt(index, t, false);
    }
    /// <summary>
    /// Get measurement at the specified time t of the by index specified variable
    /// </summary>
    /// <param name="index">index is 0-based: 0, 1, 2, ...</param>
    /// <param name="t">simulation time in days</param>
    /// <param name="noisy">if true, then noisy measurement values are returned. 
    /// they are only noisy if the parameter apply_real_sensor was true before and during
    /// the simulation</param>
    /// <returns>measurement value at time t at position index</returns>
    /// <exception cref="exception">Invalid index</exception>
    public physValue getMeasurementAt(int index, double t, bool noisy)    
    {
      physValue[] values= getMeasurementVectorAt(t, noisy);

      if (index >= 0 && index < values.Length)
        return values[index];
      else
        throw new exception(String.Format(
        "index {0} is bigger or equal as/to the size of values {1} (or < 0)!", index, values.Length));
    }

    /// <summary>
    /// Get measurement at the specified time t of the by index specified variable
    /// </summary>
    /// <param name="index">index is 0-based: 0, 1, 2, ...</param>
    /// <param name="t">simulation time in days</param>
    /// <param name="noisy">if true, then noisy measurement values are returned. 
    /// they are only noisy if the parameter apply_real_sensor was true before and during
    /// the simulation</param>
    /// <returns>measurement value at time t at position index</returns>
    /// <exception cref="exception">Invalid index</exception>
    public double getMeasurementDAt(int index, double t, bool noisy)
    {
      return getMeasurementAt(index, t, noisy).Value;
    }

    /// <summary>
    /// Get measurement vector at the specified time t. 
    /// If nothing measured yet an 0 vector is returned. 
    /// </summary>
    /// <param name="t">simulation time in days</param>
    /// <returns>measurement values at time t</returns>
    public physValue[] getMeasurementVectorAt(double t)
    {
      return getMeasurementVectorAt(t, false);
    }
    /// <summary>
    /// Get measurement vector at the specified time t. 
    /// If nothing measured yet an 0 vector is returned. 
    /// </summary>
    /// <param name="t">simulation time in days</param>
    /// <param name="noisy">if true, then noisy measurement values are returned. 
    /// they are only noisy if the parameter apply_real_sensor was true before and during
    /// the simulation</param>
    /// <returns>measurement values at time t</returns>
    public physValue[] getMeasurementVectorAt(double t, bool noisy)    
    {
      if (values.Count > 0)
      {
        //physValue[] returnValues= new physValue[values.ToArray().GetLength(0)];

        //bool isconst= true;

        //// dimension 0 ist die Zeitdimension, dimension 1, die Dimension über die verschiedenen Größen
        //// welche meistens 1 ist
        //for (int irow= 0; irow < values.Count; irow++)
        //{
        //  physValue[] myList= values.;

        //  if (physValue.min(myList) == physValue.max(myList))
        //    returnValues[irow]= myList[0];
        //  else
        //    isconst= false;
        //}

        //if (isconst)
        //  return returnValues;

        //

        int k_act;

        double min_val= math.min(math.abs(math.minus(time.ToArray(), t)), out k_act);

        // großer Fehler, da min_val eine Zeitdifferenz ist!!!
        //k_act= Math.Max(k_act - Convert.ToInt32(t < min_val), 0);

        k_act = Math.Max(k_act - Convert.ToInt32(time[k_act] > t), 0);

        // TODO - kann der Fehler auftreten?
        if (k_act >= values.Count)
          throw new exception(String.Format(
          "k_act {0} is bigger then the size of values {1}!", k_act, values.Count));

        if (noisy)
          return values_noise[k_act];     // return noisy values
        else
          return values[k_act];           // return normal values
      }
      else
      {
        physValue[] myValues= new physValue[dimension];

        for (int ivalue= 0; ivalue < dimension; ivalue++)
          myValues[ivalue]= new physValue();

        return myValues;
      }
    }



    /// <summary>
    /// Get complete measured data over time of the by index specified variable. if nothing
    /// yet measured a one dimensional empty vector is returned. 
    /// </summary>
    /// <param name="index">index inside dimension of sensor, 0-based</param>
    /// <returns>measured variables over time for given index</returns>
    /// <exception cref="exception">Invalid index</exception>
    public physValue[] getMeasurementStream(int index)    
    {
      return getMeasurementStream(index, false);
    }
    /// <summary>
    /// Get complete measured data over time of the by index specified variable. if nothing
    /// yet measured a one dimensional empty vector is returned. 
    /// </summary>
    /// <param name="index">index inside dimension of sensor, 0-based</param>
    /// <param name="noisy">if true, then noisy measurement values are returned. 
    /// they are only noisy if the parameter apply_real_sensor was true before and during
    /// the simulation</param>
    /// <returns>measured variables over time for given index</returns>
    /// <exception cref="exception">Invalid index</exception>
    public physValue[] getMeasurementStream(int index, bool noisy) 
    {
      if (values.Count > 0) // already something measured
      {
        // collect the measured data of the specified index inside dimension
        physValue[] data= new physValue[values.Count];

        // values[0].Length is the dimension of the sensor
        // 0 stands here for the 1st measurement, so must be < values.Count
        if (index >= 0 && index < values[0].Length)
        {
          // go through all measurements
          if (noisy)    // noisy measurements
          {
            for (int idata = 0; idata < values.Count; idata++)
              data[idata] = (values_noise[idata])[index];
          }
          else
          {
            for (int idata = 0; idata < values.Count; idata++)
              data[idata] = (values[idata])[index];
          }

          return data;
        }        
        else
          throw new exception(String.Format(
          "index {0} is bigger or equal as/to the length of values {1} (or < 0)!", index, values[0].Length));
      }
      else
      {
        physValue[] data= new physValue[1];
        data[0]= new physValue();

        return data;
      }
    }

    /// <summary>
    /// Get complete measured data of all variables the sensor measures
    /// </summary>
    /// <returns>complete measured data</returns>
    public List<physValue[]> getMeasurementStream()    
    {
      return getMeasurementStream(false);
    }
    /// <summary>
    /// Get complete measured data of all variables the sensor measures
    /// </summary>
    /// <param name="noisy">if true, then noisy measurement values are returned. 
    /// they are only noisy if the parameter apply_real_sensor was true before and during
    /// the simulation</param>
    /// <returns>complete measured data</returns>
    public List<physValue[]> getMeasurementStream(bool noisy)  
    {
      List<physValue[]> myValues= new List<physValue[]>();

      for (int idim= 0; idim < dimension; idim++)
      {
        myValues.Add( getMeasurementStream(idim, noisy) );
      }

      return myValues;
    }

    /// <summary>
    /// Return time stream containing recorded time instances. if nothing yet measured 
    /// a one dimensional double 0 vector is returned. 
    /// </summary>
    /// <returns>time vector</returns>
    public double[] getTimeStream()
    {
      if (time.Count > 0)
      {
        return time.ToArray();
      }
      else
        return math.zeros(1);
    }


    /// <summary>
    /// Get current value of measured variable with the id: param. 
    /// e.g. used by biogas_sensor. 
    /// These methods are more flexible in usage, because
    /// you can also return values which are not measured directly but are
    /// calculated out of a measured value. For example: a measured value
    /// in a different unit as it was measured. Or the total bioags production of a 
    /// digester which is calculated out of the single biogas components (CH4, CO2, H2).
    /// </summary>
    /// <param name="param">id of the variable, the correct values of the
    /// ids are defined inside this function, respectively its overriden
    /// functions</param>
    /// <returns>current measurement value</returns>
    /// <exception cref="exception">Not implemented</exception>
    virtual public physValue getCurrentMeasurement(string param)
    {
      return getCurrentMeasurement(param, false);
    }
    /// <summary>
    /// Get current value of measured variable with the id: param. 
    /// e.g. used by biogas_sensor. 
    /// These methods are more flexible in usage, because
    /// you can also return values which are not measured directly but are
    /// calculated out of a measured value. For example: a measured value
    /// in a different unit as it was measured. Or the total bioags production of a 
    /// digester which is calculated out of the single biogas components (CH4, CO2, H2).
    /// </summary>
    /// <param name="param">id of the variable, the correct values of the
    /// ids are defined inside this function, respectively its overriden
    /// functions</param>
    /// <param name="noisy">if true, then noisy measurement values are returned. 
    /// they are only noisy if the parameter apply_real_sensor was true before and during
    /// the simulation</param>
    /// <returns>current measurement value</returns>
    /// <exception cref="exception">Not implemented</exception>
    virtual public physValue getCurrentMeasurement(string param, bool noisy)
    {
      throw new exception("Not implemented!");
    }

    /// <summary>
    /// Get all values of measured variable with the id: param. 
    /// e.g. used by biogas_sensor. 
    /// These methods are more flexible in usage, because
    /// you can also return values which are not measured directly but are
    /// calculated out of a measured value. For example: a measured value
    /// in a different unit as it was measured. Or the total bioags production of a 
    /// digester which is calculated out of the single biogas components (CH4, CO2, H2).
    /// </summary>
    /// <param name="param">id of the variable, the correct values of the
    /// ids are defined inside this function, respectively its overriden
    /// functions</param>
    /// <returns>measured variables over time</returns>
    /// <exception cref="exception">Not implemented</exception>
    virtual public physValue[] getMeasurementStream(string param) 
    {
      return getMeasurementStream(param, false);
    }
    /// <summary>
    /// Get all values of measured variable with the id: param. 
    /// e.g. used by biogas_sensor. 
    /// These methods are more flexible in usage, because
    /// you can also return values which are not measured directly but are
    /// calculated out of a measured value. For example: a measured value
    /// in a different unit as it was measured. Or the total bioags production of a 
    /// digester which is calculated out of the single biogas components (CH4, CO2, H2).
    /// </summary>
    /// <param name="param">id of the variable, the correct values of the
    /// ids are defined inside this function, respectively its overriden
    /// functions</param>
    /// <param name="noisy">if true, then noisy measurement values are returned. 
    /// they are only noisy if the parameter apply_real_sensor was true before and during
    /// the simulation</param>
    /// <returns>measured variables over time</returns>
    /// <exception cref="exception">Not implemented</exception>
    virtual public physValue[] getMeasurementStream(string param, bool noisy)
    {
      throw new exception("Not implemented!");
    }

    /// <summary>
    /// Get value at time t of measured variable with the id: param. 
    /// e.g. used by biogas_sensor. 
    /// These methods are more flexible in usage, because
    /// you can also return values which are not measured directly but are
    /// calculated out of a measured value. For example: a measured value
    /// in a different unit as it was measured. Or the total bioags production of a 
    /// digester which is calculated out of the single biogas components (CH4, CO2, H2).
    /// </summary>
    /// <param name="param">id of the variable, the correct values of the
    /// ids are defined inside this function, respectively its overriden
    /// functions</param>
    /// <param name="t">simulation time in days</param>
    /// <returns>measurement value at time t</returns>
    /// <exception cref="exception">Not implemented</exception>
    virtual public physValue getMeasurementAt(string param, double t)
    {
      return getMeasurementAt(param, t, false);
    }
    /// <summary>
    /// Get value at time t of measured variable with the id: param. 
    /// e.g. used by biogas_sensor. 
    /// These methods are more flexible in usage, because
    /// you can also return values which are not measured directly but are
    /// calculated out of a measured value. For example: a measured value
    /// in a different unit as it was measured. Or the total bioags production of a 
    /// digester which is calculated out of the single biogas components (CH4, CO2, H2).
    /// </summary>
    /// <param name="param">id of the variable, the correct values of the
    /// ids are defined inside this function, respectively its overriden
    /// functions</param>
    /// <param name="t">simulation time in days</param>
    /// <param name="noisy">if true, then noisy measurement values are returned. 
    /// they are only noisy if the parameter apply_real_sensor was true before and during
    /// the simulation</param>
    /// <returns>measurement value at time t</returns>
    /// <exception cref="exception">Not implemented</exception>
    virtual public physValue getMeasurementAt(string param, double t, bool noisy)
    {
      throw new exception("Not implemented!");
    }



  }



}


