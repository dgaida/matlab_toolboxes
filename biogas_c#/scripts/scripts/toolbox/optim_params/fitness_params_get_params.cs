/**
 * This file defines the get_params methods of the fitness_params object.
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
  /// definition of fitness parameters used in objective function
  /// </summary>
  public partial class fitness_params : set_get_interface
  {

    // -------------------------------------------------------------------------------------
    //                              !!! PUBLIC GET METHODS !!!
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
      int nargin = symbols.Length;

      if (nargin > 0)
      {
        variables = new object[nargin];

        for (int iarg = 0; iarg < nargin; iarg++)
        {
          switch (symbols[iarg])
          {
            case "TS_feed_max":
              variables[iarg] = this.TS_feed_max;
              break;
            case "HRT_plant_min":                        // 
              variables[iarg] = this.HRT_plant_min;
              break;
            case "HRT_plant_max":                         // 
              variables[iarg] = this.HRT_plant_max;
              break;
            case "OLR_plant_max":                      // 
              variables[iarg] = this.OLR_plant_max;
              break;
            case "manurebonus":                      // 
              variables[iarg] = this.manurebonus;
              break;
            case "fitness_function":                   // 
              variables[iarg] = this.fitness_function;
              break;
            case "nObjectives":                   // 
              variables[iarg] = this.nObjectives;
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
    /// return the value of the spcified parameter for the given digester
    /// </summary>
    /// <param name="symbol">symbol of the parameter</param>
    /// <param name="digester_index">index of digester: 0-based</param>
    /// <returns></returns>
    /// <exception cref="exception">Invalid digester index</exception>
    /// <exception cref="exception">Unknown parameter</exception>
    public double get_param_of(string symbol, int digester_index)
    {
      if (digester_index >= pH_min.Count)
        throw new exception(String.Format("digester_index >= pH_min.Count: {0} >= {1}", 
          digester_index, pH_min.Count));

      switch (symbol)
      {
        case "pH_min":
          // TODO - check that digester_index < pH_min.Count
          return pH_min[digester_index];
        case "pH_max":
          // TODO - check that digester_index < pH_min.Count
          return pH_max[digester_index];
        case "pH_optimum":
          // TODO - check that digester_index < pH_min.Count
          return pH_optimum[digester_index];
        case "TS_max":
          // TODO - check that digester_index < pH_min.Count
          return TS_max[digester_index];
        case "VFA_TAC_min":
          // TODO - check that digester_index < pH_min.Count
          return VFA_TAC_min[digester_index];
        case "VFA_TAC_max":
          // TODO - check that digester_index < pH_min.Count
          return VFA_TAC_max[digester_index];
        case "VFA_min":
          // TODO - check that digester_index < pH_min.Count
          return VFA_min[digester_index];
        case "VFA_max":
          // TODO - check that digester_index < pH_min.Count
          return VFA_max[digester_index];
        case "TAC_min":
          // TODO - check that digester_index < pH_min.Count
          return TAC_min[digester_index];
        case "HRT_min":
          // TODO - check that digester_index < pH_min.Count
          return HRT_min[digester_index];
        case "HRT_max":
          // TODO - check that digester_index < pH_min.Count
          return HRT_max[digester_index];
        case "OLR_max":
          // TODO - check that digester_index < pH_min.Count
          return OLR_max[digester_index];
        case "Snh4_max":
          // TODO - check that digester_index < pH_min.Count
          return Snh4_max[digester_index];
        case "Snh3_max":
          // TODO - check that digester_index < pH_min.Count
          return Snh3_max[digester_index];
        case "AcVsPro_min":
          // TODO - check that digester_index < pH_min.Count
          return AcVsPro_min[digester_index];

        default:
          throw new exception(String.Format("Unknown parameter: {0}!", symbol));
      }
    }

  }
}


