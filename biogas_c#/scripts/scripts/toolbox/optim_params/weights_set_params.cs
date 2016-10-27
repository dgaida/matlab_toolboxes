/**
 * This file defines the set params methods of the weights object.
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
  /// weights used in optimization
  /// 
  /// the multi-objective optimization problem is solved by weighting the 
  /// different objectives with weights and then sum them up
  /// 
  /// sum_i=1^N weight_i * objective_i
  /// 
  /// </summary>
  public partial class weights : set_get_interface
  {

    // -------------------------------------------------------------------------------------
    //                              !!! PUBLIC SET METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// Set value of weights. 
    /// Syntax: set_params_of( "w_CSB", 0.5, "w_money", 0.3, ... ).
    /// 
    /// sfter setting the parameters all parameters are normalized
    /// </summary>
    /// <param name="symbols"></param>
    public override void set_params_of(params object[] symbols)
    {
      for (int iarg = 0; iarg < symbols.Length; iarg = iarg + 2)
      {
        switch ((string)symbols[iarg])
        {
          case "w_CSB":
            this._w_CSB = (double)symbols[iarg + 1];
            break;
          case "w_CH4":
            this._w_CH4 = (double)symbols[iarg + 1];
            break;
          case "w_money":                
            this._w_money = (double)symbols[iarg + 1];
            break;
          case "w_pH":
            this._w_pH = (double)symbols[iarg + 1];
            break;
          case "w_TS":
            this._w_TS = (double)symbols[iarg + 1];
            break;
          case "w_VFA":           
            this._w_VFA = (double)symbols[iarg + 1];
            break;
          case "w_HRT":           
            this._w_HRT = (double)symbols[iarg + 1];
            break;
          case "w_TAC":             
            this._w_TAC = (double)symbols[iarg + 1];
            break;
          case "w_OLR":
            this._w_OLR = (double)symbols[iarg + 1];
            break;
          case "w_N":
            this._w_N = (double)symbols[iarg + 1];
            break;
          case "w_gasexc":
            this._w_gasexc = (double)symbols[iarg + 1];
            break;
          case "w_FOS_TAC":
            this._w_FOS_TAC = (double)symbols[iarg + 1];
            break;
          case "w_faecal":
            this._w_faecal = (double)symbols[iarg + 1];
            break;
          case "w_AcVsPro":
            this._w_AcVsPro = (double)symbols[iarg + 1];
            break;
          case "w_setpoint":
            this._w_setpoint = (double)symbols[iarg + 1];
            break;
          case "w_udot":
            this._w_udot = (double)symbols[iarg + 1];
            break;

          default:
            throw new exception(String.Format("Unknown parameter: {0}!",
                                              (string)symbols[iarg]));
        }
      }

      normalize();
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
            case "w_CSB":
              variables[iarg] = this.w_CSB;
              break;
            case "w_CH4":                        // 
              variables[iarg] = this.w_CH4;
              break;
            case "w_money":                         // 
              variables[iarg] = this.w_money;
              break;
            case "w_pH":                      // 
              variables[iarg] = this.w_pH;
              break;
            case "w_TS":                      // 
              variables[iarg] = this.w_TS;
              break;
            case "w_VFA":                   // 
              variables[iarg] = this.w_VFA;
              break;
            case "w_HRT":                      // 
              variables[iarg] = this.w_HRT;
              break;
            case "w_TAC":                      // 
              variables[iarg] = this.w_TAC;
              break;
            case "w_OLR":                   // 
              variables[iarg] = this.w_OLR;
              break;
            case "w_N":                      // 
              variables[iarg] = this.w_N;
              break;
            case "w_gasexc":                      // 
              variables[iarg] = this.w_gasexc;
              break;
            case "w_FOS_TAC":                   // 
              variables[iarg] = this.w_FOS_TAC;
              break;
            case "w_faecal":                   // 
              variables[iarg] = this.w_faecal;
              break;
            case "w_AcVsPro":                   // 
              variables[iarg] = this.w_AcVsPro;
              break;
            case "w_setpoint":                   // 
              variables[iarg] = this.w_setpoint;
              break;
            case "w_udot":                   // 
              variables[iarg] = this.w_udot;
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


