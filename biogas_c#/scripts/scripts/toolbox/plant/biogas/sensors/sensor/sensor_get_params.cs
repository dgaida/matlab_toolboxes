/**
 * This file is part of the partial class sensor and defines
 * methods to get the params of the sensor.
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
    /// Get params as an array of objects.
    /// </summary>
    /// <param name="variables"></param>
    /// <param name="symbols"></param>
    /// <exception cref="exception">Unknown parameter</exception>
    /// <exception cref="exception">No input argument</exception>
    public override void get_params_of(out object[] variables, params string[] symbols)
    {
      int nargin= symbols.Length;

      if (nargin > 0)
      {
        variables= new object[nargin];

        for (int iarg= 0; iarg < nargin; iarg++)
        {
          switch (symbols[iarg])
          {
            case "id":
              variables[iarg] = this.id;
              break;
            case "name":
              variables[iarg]= this.name;
              break;
            case "dimension":
              variables[iarg] = this.dimension;
              break;
            case "id_suffix":
              variables[iarg] = this.id_suffix;
              break;
            
            default:
              throw new exception(String.Format("Unknown parameter: {0}!", symbols[iarg]));
          }
        }
      }
      else
        throw new exception("You did not give an argument!");
    }



    /// <summary>
    /// get a param of the recorded physValue such as Label, Unit or Symbol
    /// </summary>
    /// <param name="index">index in dimension: 0, 1, ...</param>
    /// <param name="param">Unit, Label or Symbol</param>
    /// <returns>content of the parameter</returns>
    /// <exception cref="exception">no measurement taken</exception>
    /// <exception cref="exception">invalid index or param</exception>
    public string get_physValue_param(int index, string param)
    {
      physValue[] myvals;

      if (values.Count != 0)
        myvals= values[0];
      else
        throw new exception("No measurements taken!");

      if (index < 0 || index >= myvals.Length)
        throw new exception(String.Format("index must be between 0 and {0} but is {1}!", 
          myvals.Length - 1, index));

      switch (param)
      {
        case "Symbol":
          return myvals[index].Symbol;
        case "Label":
          return myvals[index].Label;
        case "Unit":
          return myvals[index].Unit;

        default:
          throw new exception(String.Format("Unknown parameter: {0}!", param));
      }

    }



  }
}


