/**
 * This file defines public set methods for the partial class ADM.
 * 
 * TODOs:
 * - maybe add further methods
 * 
 * Except for that FINISHED!
 * 
 */

using System;
using System.Collections.Generic;
using System.Text;
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
  /// Class defining the Anaerobic Digestion Model
  /// 
  /// At the moment it defines two things:
  /// - the ADM parameters
  /// - handle of the MATLAB gui for the ADM block
  /// 
  /// TODO:
  /// Using the child class ADM1DE different ADM models should
  /// be implementable, but this won't work, because in ADMstate
  /// static properties such as dim_state, dim_stream are defined,
  /// which cannot be overwritten. We need the static props in MATLAB.
  /// 
  /// </summary>
  public partial class ADM
  {

    // -------------------------------------------------------------------------------------
    //                              !!! SET METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// Set ADM parameter at given position to given value. pos is 1-based.
    /// </summary>
    /// <param name="pos">from 1 to ADMparams.numParams</param>
    /// <param name="value">value of the ADM parameter</param>
    /// <exception cref="exception">Invalid pos</exception>
    public void setADMparameter(int pos, double value)
    {
      if (pos < 1 || pos > biogas.ADMparams.numParams)
        throw new exception(String.Format(
          "pos must be between 1 and {0}, but is {1}!", biogas.ADMparams.numParams, pos));

      _parameters[pos - 1] = value;
    }

    /// <summary>
    /// Set ADM parameter at given position to given value. pos is 1-based.
    /// </summary>
    /// <param name="pos1">from 1 to ADMparams.numParams</param>
    /// <param name="value1">value of the ADM parameter</param>
    /// <param name="pos2">from 1 to ADMparams.numParams</param>
    /// <param name="value2">value of the ADM parameter</param>
    /// <exception cref="exception">Invalid pos1 or pos2</exception>
    public void setADMparameter(int pos1, double value1, int pos2, double value2)
    {
      setADMparameter(pos1, value1);
      setADMparameter(pos2, value2);
    }



  }
}


