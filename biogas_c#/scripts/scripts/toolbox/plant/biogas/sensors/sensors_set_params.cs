/**
 * This file is part of the partial class sensors and defines
 * public set_params_of methods.
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
using System.Xml;
using toolbox;
using science;

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
    /// Set a string param of the by index specified sensor. index is 1-based.
    /// </summary>
    /// <param name="index">sensor index</param>
    /// <param name="symbol">parameter</param>
    /// <param name="value"></param>
    /// <exception cref="exception">Invalid sensor index</exception>
    /// <exception cref="exception">Unknown parameter</exception>
    public void set_params_of(int index, string symbol, string value)
    {
      object[] values= { symbol, value };

      if (index <= 0 || index > getNumSensors())
        throw new exception(String.Format(
          "index out of bounds: {0}! Must be between 1 ... {1}", index, getNumSensors()));

      this[index - 1].set_params_of(values);
    }
    /// <summary>
    /// Set the Value of a physValue param of the by index specified sensor. index is 1-based.
    /// </summary>
    /// <param name="index">sensor index</param>
    /// <param name="symbol">parameter</param>
    /// <param name="value"></param>
    /// <exception cref="exception">Invalid sensor index</exception>
    /// <exception cref="exception">Unknown parameter</exception>
    public void set_params_of(int index, string symbol, physValue value)
    {
      object[] values= { symbol, value.Value };

      if (index <= 0 || index > getNumSensors())
        throw new exception(String.Format(
          "index out of bounds: {0}! Must be between 1 ... {1}", index, getNumSensors()));

      this[index - 1].set_params_of(values);
    }
    /// <summary>
    /// Set a double param of the by index specified sensor. index is 1-based.
    /// </summary>
    /// <param name="index">sensor index</param>
    /// <param name="symbol">parameter</param>
    /// <param name="value"></param>
    /// <exception cref="exception">Invalid sensor index</exception>
    /// <exception cref="exception">Unknown parameter</exception>
    public void set_params_of(int index, string symbol, double value)
    {
      object[] values= { symbol, value };

      if (index <= 0 || index > getNumSensors())
        throw new exception(String.Format(
          "index out of bounds: {0}! Must be between 1 ... {1}", index, getNumSensors()));

      this[index - 1].set_params_of(values);
    }
    /// <summary>
    /// Set a string param of the by id specified sensor.
    /// </summary>
    /// <param name="id">sensor id</param>
    /// <param name="symbol">parameter</param>
    /// <param name="value"></param>
    /// <exception cref="exception">Unknown sensor id</exception>
    /// <exception cref="exception">Unknown parameter</exception>
    public void set_params_of(string id, string symbol, string value)
    {
      object[] values= { symbol, value };

      get(id).set_params_of(values);
    }
    /// <summary>
    /// Set the Value of a physValue param of the by id specified sensor.
    /// </summary>
    /// <param name="id">sensor id</param>
    /// <param name="symbol">parameter</param>
    /// <param name="value"></param>
    /// <exception cref="exception">Unknown sensor id</exception>
    /// <exception cref="exception">Unknown parameter</exception>
    public void set_params_of(string id, string symbol, physValue value)
    {
      object[] values= { symbol, value.Value };

      get(id).set_params_of(values);
    }
    /// <summary>
    /// Set a double param of the by id specified sensor.
    /// </summary>
    /// <param name="id">sensor id</param>
    /// <param name="symbol">parameter</param>
    /// <param name="value"></param>
    /// <exception cref="exception">Unknown sensor id</exception>
    /// <exception cref="exception">Unknown parameter</exception>
    public void set_params_of(string id, string symbol, double value)
    {
      object[] values= { symbol, value };

      get(id).set_params_of(values);
    }


    
  }
}


