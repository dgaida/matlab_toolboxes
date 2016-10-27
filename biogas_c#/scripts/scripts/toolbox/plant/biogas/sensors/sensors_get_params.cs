/**
 * This file is part of the partial class sensors and defines
 * public get_params_of methods.
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
    /// Get a string param of the by index specified sensor. index is 1-based.
    /// </summary>
    /// <param name="index">sensor index</param>
    /// <param name="symbol">parameter</param>
    /// <returns></returns>
    /// <exception cref="exception">Invalid sensor index</exception>
    /// <exception cref="exception">Unknown parameter</exception>
    /// <exception cref="exception">Conversion to string not possible</exception>
    public string get_param_of_s(int index, string symbol)
    {
      if (index <= 0 || index > getNumSensors())
        throw new exception(String.Format(
          "index out of bounds: {0}! Must be between 1 ... {1}", index, getNumSensors()));

      return this[index - 1].get_param_of_s(symbol);
    }
    /// <summary>
    /// Get a double param of the by index specified sensor. index is 1-based.
    /// </summary>
    /// <param name="index">sensor index</param>
    /// <param name="symbol">parameter</param>
    /// <returns></returns>
    /// <exception cref="exception">Invalid sensor index</exception>
    /// <exception cref="exception">Unknown parameter</exception>
    /// <exception cref="exception">Conversion to double not possible</exception>
    public double get_param_of_d(int index, string symbol)
    {
      if (index <= 0 || index > getNumSensors())
        throw new exception(String.Format(
          "index out of bounds: {0}! Must be between 1 ... {1}", index, getNumSensors()));

      return this[index - 1].get_param_of_d(symbol);
    }
    /// <summary>
    /// Get the Value of a physValue param of the by index specified sensor. 
    /// index is 1-based.
    /// </summary>
    /// <param name="index">sensor index</param>
    /// <param name="symbol">parameter</param>
    /// <returns></returns>
    /// <exception cref="exception">Invalid sensor index</exception>
    /// <exception cref="exception">Unknown parameter</exception>
    /// <exception cref="exception">Conversion to double not possible</exception>
    public double get_param_of(int index, string symbol)
    {
      if (index <= 0 || index > getNumSensors())
        throw new exception(String.Format(
          "index out of bounds: {0}! Must be between 1 ... {1}", index, getNumSensors()));

      return this[index - 1].get_param_of(symbol);
    }

    /// <summary>
    /// Get a string param of the by id specified sensor.
    /// </summary>
    /// <param name="id">sensor id</param>
    /// <param name="symbol">parameter</param>
    /// <returns></returns>
    /// <exception cref="exception">Unknown sensor id</exception>
    /// <exception cref="exception">Unknown parameter</exception>
    /// <exception cref="exception">Conversion to string not possible</exception>
    public string get_param_of_s(string id, string symbol)
    {
      return get(id).get_param_of_s(symbol);
    }
    /// <summary>
    /// Get a double param of the by id specified sensor.
    /// </summary>
    /// <param name="id">sensor id</param>
    /// <param name="symbol">parameter</param>
    /// <returns></returns>
    /// <exception cref="exception">Unknown sensor id</exception>
    /// <exception cref="exception">Unknown parameter</exception>
    /// <exception cref="exception">Conversion to double not possible</exception>
    public double get_param_of_d(string id, string symbol)
    {
      return get(id).get_param_of_d(symbol);
    }
    /// <summary>
    /// Get a int param of the by id specified sensor.
    /// </summary>
    /// <param name="id">sensor id</param>
    /// <param name="symbol">parameter</param>
    /// <returns></returns>
    /// <exception cref="exception">Unknown sensor id</exception>
    /// <exception cref="exception">Unknown parameter</exception>
    /// <exception cref="exception">Conversion to int not possible</exception>
    public int get_param_of_i(string id, string symbol)
    {
      return get(id).get_param_of_i(symbol);
    }
    /// <summary>
    /// Get the Value of a physValue param of the by id specified sensor.
    /// </summary>
    /// <param name="id">sensor id</param>
    /// <param name="symbol">parameter</param>
    /// <returns></returns>
    /// <exception cref="exception">Unknown sensor id</exception>
    /// <exception cref="exception">Unknown parameter</exception>
    /// <exception cref="exception">Conversion to double not possible</exception>
    public double get_param_of(string id, string symbol)
    {
      return get(id).get_param_of(symbol);
    }



    /// <summary>
    /// get a param of the recorded physValue such as Label, Unit or Symbol
    /// </summary>
    /// <param name="id">sensor id</param>
    /// <param name="index">index in dimension: 0, 1, ...</param>
    /// <param name="param">Unit, Label or Symbol</param>
    /// <returns>content of the parameter</returns>
    /// <exception cref="exception">Unknown sensor id</exception>
    /// <exception cref="exception">no measurement taken</exception>
    /// <exception cref="exception">invalid index or param</exception>
    public string get_physValue_param(string id, int index, string param)
    {
      return get(id).get_physValue_param(index, param);
    }

    

  }
}


