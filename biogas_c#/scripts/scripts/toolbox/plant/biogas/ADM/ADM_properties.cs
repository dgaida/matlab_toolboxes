/**
 * This file defines the properties of the partial class ADM.
 * 
 * TODOs:
 * - set von parameters ist public - nicht schön
 * 
 * 
 * Apart from that FINISHED!
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
    //                            !!! PRIVATE FIELDS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// handle of the gui belonging to the AD model block
    /// </summary>
    private double _gui_handle;

    /// <summary>
    /// parameters of the AD model
    /// </summary>
    private double[] _parameters= new double[ADMparams.numParams];



    // -------------------------------------------------------------------------------------
    //                              !!! PROPERTIES !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// handle of the gui belonging to the AD model block
    /// </summary>
    public double gui_handle
    {
      get { return _gui_handle; }
      set { _gui_handle= value; }
    }

    /// <summary>
    /// parameters of the AD model
    /// </summary>
    public double[] parameters
    {
      get { return _parameters; }

      // TODO - nicht schöne, brauche ich aber für zusammen hängende Simulationen
      // bsp. bei NMPC. wo simulation nicht bei 0 beginnt, sondern da wo die
      // vorherige aufgehört hat. dann werden am ende der vorherigen simulation
      // parameter gespeichert und dann wieder geladen vor der nächsten simulation
      set
      {
        if (value.Length != biogas.ADMparams.numParams)
          throw new exception(String.Format(
            "value has not the correct dimension ({0}]. Must be {1}!",
            value.Length, biogas.ADMparams.numParams));

        _parameters = value;
      }
    }



  }
}


