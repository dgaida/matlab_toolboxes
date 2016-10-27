/**
 * This file defines the set params methods of the setpoint object.
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
  /// defines all that is needed to implement a setpoint control
  /// 
  /// </summary>
  public partial class setpoint : set_get_interface
  {

    // -------------------------------------------------------------------------------------
    //                              !!! PUBLIC SET METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// Set value of setpoint. 
    /// Syntax: set_params_of( "location", "bhkw1", "index", 0, ... ).
    /// 
    /// </summary>
    /// <param name="symbols"></param>
    public override void set_params_of(params object[] symbols)
    {
      for (int iarg = 0; iarg < symbols.Length; iarg = iarg + 2)
      {
        switch ((string)symbols[iarg])
        {
          case "location":
            this._location = (string)symbols[iarg + 1];
            break;
          case "sensor_id":
            this._sensor_id = (string)symbols[iarg + 1];
            break;
          case "index":                
            this._index = (int)symbols[iarg + 1];
            break;
          case "s_operator":
            this._s_operator = (string)symbols[iarg + 1];
            break;
          case "scalefac":
            this._scalefac = (double)symbols[iarg + 1];
            break;
          
          default:
            throw new exception(String.Format("Unknown parameter: {0}!",
                                              (string)symbols[iarg]));
        }
      }
    }



    /// <summary>
    /// Get params as an array of objects.
    /// </summary>
    /// <param name="variables">values</param>
    /// <param name="symbols"></param>
    /// <exception cref="exception">Unknown parameter</exception>
    /// <exception cref="exception">No input argument</exception>
    public override void get_params_of(out object[] variables, params string[] symbols)
    {
      int nargin = symbols.Length;

      if (nargin > 0)
      {
        variables = new object[nargin];

        for (int iarg = 0; iarg < nargin; iarg++)
        {
          switch (symbols[iarg])
          {
            case "location":
              variables[iarg] = this.location;
              break;
            case "sensor_id":                        // 
              variables[iarg] = this.sensor_id;
              break;
            case "index":                         // 
              variables[iarg] = this.index;
              break;
            case "s_operator":                      // 
              variables[iarg] = this.s_operator;
              break;
            case "scalefac":                      // 
              variables[iarg] = this.scalefac;
              break;
            
            default:
              throw new exception(String.Format("Unknown parameter: {0}!", symbols[iarg]));
          }
        }
      }
      else
        throw new exception("You did not give an argument!");
    }



  }
}


