/**
 * This file is part of the partial class digester and defines
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
  /// Defines a digester on a biogas plant. To each digester a heating belongs, which is
  /// either switched on or off.
  /// 
  /// Furthermore each digester is modelled by an anaerobic digestion model (ADM).
  /// This ADM object is accessible through this class.
  /// 
  /// </summary>
  public partial class digester : set_get_interface
  {

    // -------------------------------------------------------------------------------------
    //                              !!! PUBLIC METHODS !!!
    // -------------------------------------------------------------------------------------
    
    /// <summary>
    /// Get parameters as objects
    /// 
    /// attention: params for stirrers cannot be gotten using this method, and it does not
    /// have to
    /// </summary>
    /// <param name="variables">return value</param>
    /// <param name="symbols">"Vliq"</param>
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
              variables[iarg]= this.id;
              break;
            case "name":                    // name of digester
              variables[iarg]= this.name;
              break;
            case "Vtot":                    // 
              variables[iarg]= this.Vtot;
              break;
            case "Vliq":                    // 
              variables[iarg]= this.Vliq;
              break;
            case "Vliqmax":                 // 
              variables[iarg]= this.Vliqmax;
              break;
            case "Vgas":                    // 
              variables[iarg]= this.Vgas;
              break;
            case "Vgasmax":                 // 
              variables[iarg]= this.Vgasmax;
              break;
            case "T":                       // 
              variables[iarg]= this.T;
              break;
            case "diam":                    // diameter of digester
              variables[iarg]= this.diam;
              break;
            case "height":                    // height of tank of digester
              variables[iarg] = this.height;
              break;
            case "h_roof":                    // max heigth of roof of digester
              variables[iarg] = this.h_roof;
              break;
            case "k_wall":                    // 
              variables[iarg]= this.k_wall;
              break;
            case "k_roof":                    // 
              variables[iarg] = this.k_roof;
              break;
            case "k_ground":                    // 
              variables[iarg] = this.k_ground;
              break;

            case "accum_s":                    // 
              variables[iarg] = this.accum_s;
              break;
            case "accum_x":                    // 
              variables[iarg] = this.accum_x;
              break;

            default:
              //try
              //{
                // if parameter is for mixer, then this method throws an error
                heating.get_params_of(out variables, symbols);
              //}
              //catch
              //{
              //  mixer.get_params_of(out variables, symbols);
              //}
               
              break;
          }
        }
      }
      else
        throw new exception("You did not give an argument!");
    }



  }
}


