/**
 * This file defines the set params methods of the setpoints object.
 * 
 * TODOs:
 * - die set_params_of und get_params_of methoden werden noch nirgends aufgerufen
 * 
 * Except for that FINISHED!
 * 
 */

using System;
using System.Collections.Generic;
using System.Text;
using System.Xml;
using System.IO;
using toolbox;

/**
 * namespace for biogas plant optimization
 * 
 * Definition of:
 * - fitness_params
 * - objective function
 * - weights used inside objective function
 * 
 */
namespace biooptim
{
  /// <summary>
  /// defines all that is needed to implement setpoint controls
  /// 
  /// </summary>
  public partial class setpoints : List<setpoint>
  {

    // -------------------------------------------------------------------------------------
    //                              !!! PUBLIC SET METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// Set value of specified setpoint. 
    /// Syntax: set_params_of(0, "location", "bhkw1", "index", 0, ... ).
    /// 
    /// </summary>
    /// <param name="index">index of setpoint in list: 0, 1, ...</param>
    /// <param name="symbols"></param>
    /// <exception cref="exception">Invalid index</exception>
    public void set_params_of(int index, params object[] symbols)
    {
      setpoint mySetpoint = get(index);

      mySetpoint.set_params_of(symbols);
    }



    /// <summary>
    /// Get params as an array of objects.
    /// </summary>
    /// <param name="index">index of setpoint in list: 0, 1, ...</param>
    /// <param name="variables">values</param>
    /// <param name="symbols"></param>
    /// <exception cref="exception">Invalid index</exception>
    /// <exception cref="exception">Unknown parameter</exception>
    /// <exception cref="exception">No input argument</exception>
    public void get_params_of(int index, out object[] variables, params string[] symbols)
    {
      setpoint mySetpoint = get(index);

      mySetpoint.get_params_of(out variables, symbols);
    }



  }
}


