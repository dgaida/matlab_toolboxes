/**
 * This file defines the set params methods of the fitness_params object.
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
    //                              !!! PUBLIC SET METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// Set params of fitness_params. 
    /// Syntax: set_params_of( "TS_feed_max", 5, "nObjective", 1, ... ).
    /// </summary>
    /// <param name="symbols"></param>
    public override void set_params_of(params object[] symbols)
    {
      for (int iarg = 0; iarg < symbols.Length; iarg = iarg + 2)
      {
        switch ((string)symbols[iarg])
        {
          case "TS_feed_max":
            this._TS_feed_max = (double)symbols[iarg + 1];
            break;
          case "HRT_plant_min":
            this._HRT_plant_min = (double)symbols[iarg + 1];
            break;
          case "HRT_plant_max":                
            this._HRT_plant_max = (double)symbols[iarg + 1];
            break;
          case "OLR_plant_max":
            this._OLR_plant_max = (double)symbols[iarg + 1];
            break;
          case "manurebonus":
            this._manurebonus = (bool)symbols[iarg + 1];
            break;
          case "fitness_function":           
            this._fitness_function = (string)symbols[iarg + 1];
            break;
          case "nObjectives":           
            this._nObjectives = (int)symbols[iarg + 1];
            break;
          //case "Ndelta":             
          //  this._Ndelta = (int)symbols[iarg + 1];
          //  break;

          default:
            //throw new exception(String.Format("Unknown parameter: {0}!",
            //                                  (string)symbols[iarg]));
            _myWeights.set_params_of((string)symbols[iarg], (double)symbols[iarg + 1]);
            break;
        }
      }
    }



    /// <summary>
    /// set fitness parameter to the given vlaue which belongs
    /// to the given digester
    /// </summary>
    /// <param name="symbol"></param>
    /// <param name="digester_index">index of digester: 0-based</param>
    /// <param name="value"></param>
    public void set_list_params_of(string symbol, int digester_index, double value)
    {
      object[] values = { symbol, digester_index, value };

      this.set_list_params_of(values);
    }
    /// <summary>
    /// Set params of fitness_params. 
    /// Syntax: set_params_of( "pH_min", 0, 5.3, ... ).
    /// </summary>
    /// <param name="symbols"></param>
    /// <exception cref="exception">Invalid index</exception>
    /// <exception cref="exception">Unknown parameter</exception>
    public void set_list_params_of(params object[] symbols)
    {
      for (int iarg = 0; iarg < symbols.Length; iarg = iarg + 3)
      {
        int digester_index= (int)symbols[iarg + 1];

        if (digester_index >= pH_min.Count)
          throw new exception(String.Format("digester_index >= pH_min.Count: {0} >= {1}",
            digester_index, pH_min.Count));

        switch ((string)symbols[iarg])
        {
          case "pH_min":
            // TODO - eigentlich sollte man überall checken ob
            // digester_index < pH_min.Count ist
            this.pH_min[digester_index] = (double)symbols[iarg + 2];
            break;
          case "pH_max":
            this.pH_max[digester_index] = (double)symbols[iarg + 2];
            break;
          case "pH_optimum":
            this.pH_optimum[digester_index] = (double)symbols[iarg + 2];
            break;
          case "TS_max":
            this.TS_max[digester_index] = (double)symbols[iarg + 2];
            break;
          case "VFA_TAC_min":
            this.VFA_TAC_min[digester_index] = (double)symbols[iarg + 2];
            break;
          case "VFA_TAC_max":
            this.VFA_TAC_max[digester_index] = (double)symbols[iarg + 2];
            break;
          case "VFA_min":
            this.VFA_min[digester_index] = (double)symbols[iarg + 2];
            break;
          case "VFA_max":
            this.VFA_max[digester_index] = (double)symbols[iarg + 2];
            break;
          case "TAC_min":
            this.TAC_min[digester_index] = (double)symbols[iarg + 2];
            break;
          case "HRT_min":
            this.HRT_min[digester_index] = (double)symbols[iarg + 2];
            break;
          case "HRT_max":
            this.HRT_max[digester_index] = (double)symbols[iarg + 2];
            break;
          case "OLR_max":
            this.OLR_max[digester_index] = (double)symbols[iarg + 2];
            break;
          case "Snh4_max":
            this.Snh4_max[digester_index] = (double)symbols[iarg + 2];
            break;
          case "Snh3_max":
            this.Snh3_max[digester_index] = (double)symbols[iarg + 2];
            break;
          case "AcVsPro_min":
            this.AcVsPro_min[digester_index] = (double)symbols[iarg + 2];
            break;

          default:
            throw new exception(String.Format("Unknown parameter: {0}!",
                                              (string)symbols[iarg]));
        }
      }
    }



  }
}


