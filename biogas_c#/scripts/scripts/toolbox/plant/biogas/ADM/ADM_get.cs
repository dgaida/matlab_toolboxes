/**
 * This file defines public get methods for the partial class ADM.
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
    /// Get ADM parameter at given position as given out value. pos is 1-based.
    /// </summary>
    /// <param name="pos">from 1 to ADMparams.numParams</param>
    /// <param name="value">value of the ADM parameter</param>
    /// <exception cref="exception">Invalid pos</exception>
    public void getADMparameter(int pos, out double value)
    {
      if (pos < 1 || pos > biogas.ADMparams.numParams)
        throw new exception(String.Format(
          "pos must be between 1 and {0}, but is {1}!", biogas.ADMparams.numParams, pos));

      value= _parameters[pos - 1];
    }

    

  }
}


