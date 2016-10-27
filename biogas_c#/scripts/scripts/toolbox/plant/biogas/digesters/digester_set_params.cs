/**
 * This file is part of the partial class digester and defines
 * public set_params_of methods.
 * 
 * TODOs:
 * - 
 * 
 * FINISHED
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
    /// Set params of digester.
    /// 
    /// attention: params for stirrers cannot be set using this method, and it does not
    /// have to
    /// </summary>
    /// <param name="symbols">objects to be set</param>
    /// <exception cref="exception">Unknown parameter</exception>
    public override void set_params_of(params object[] symbols)
    {
      for (int iarg= 0; iarg < symbols.Length; iarg= iarg + 2)
      {
        switch ((string)symbols[iarg])
        {
          case "id":
            this._id=  (string)symbols[iarg + 1];
            break;
          case "name":
            this._name= (string)symbols[iarg + 1];
            break;

          case "Vtot":                // total volume [m^3]
            this.Vtot.Value=    (double)symbols[iarg + 1];
            break;
          case "Vliq":                // current liquid volume [m^3]
            this._Vliq.Value=   (double)symbols[iarg + 1];
            break;
          case "Vliqmax":             // maximal liquid volume [m^3]
            this.Vliqmax.Value= (double)symbols[iarg + 1];
            break;
          case "Vgas":                // current volume of the gas space [m^3]
            this.Vgas.Value=    (double)symbols[iarg + 1];
            break;
          case "Vgasmax":             // current volume of the gas space [m^3]
            this.Vgasmax.Value= (double)symbols[iarg + 1];
            break;
          case "T":                   // digestion temperature [°C]
            this._T.Value=      (double)symbols[iarg + 1];
            break;
          case "diam":                // diameter of tank [m]
            this._diam.Value=   (double)symbols[iarg + 1];
            break;
          //case "height":                // height of tank [m]
          //  this._height.Value = (double)symbols[iarg + 1];
          //  break;
          //case "h_roof":                // roof height of tank [m]
          //  this._h_roof.Value = (double)symbols[iarg + 1];
          //  break;
          case "k_wall":                // heat transfer coefficient of wall [W/(m^2 * K)]
            this._k_wall.Value=   (double)symbols[iarg + 1];
            break;
          case "k_roof":                // heat transfer coefficient of roof [W/(m^2 * K)]
            this._k_roof.Value = (double)symbols[iarg + 1];
            break;
          case "k_ground":                // heat transfer coefficient of ground [W/(m^2 * K)]
            this._k_ground.Value = (double)symbols[iarg + 1];
            break;

          case "accum_s":
            this._accum_s = (double)symbols[iarg + 1];
            break;
          case "accum_x":
            this._accum_x = (double)symbols[iarg + 1];
            break;

          // heating
          default:
            //try
            //{
              // if param is for stirrer, then this method throws an error
              heating.set_params_of((string)symbols[iarg], symbols[iarg + 1]);
            //}
            //catch
            //{
            //  // set_params for stirrers
            //  mixers.set_params_of((string)symbols[iarg], symbols[iarg + 1]);
            //}

            break;
        }
      }
    }



  }
}


