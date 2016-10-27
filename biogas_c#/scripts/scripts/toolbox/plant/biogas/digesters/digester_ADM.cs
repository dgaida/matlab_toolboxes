/**
 * This file is part of the partial class digester and defines
 * public methods related to the Anaerobic Digestion Model.
 * 
 * TODOs:
 * - maybe add further methods
 * - improve documentation
 * 
 * Except for that FINISHED!
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
  public partial class digester
  {

    // -------------------------------------------------------------------------------------
    //                              !!! PUBLIC GET METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// Returns the ADM params vector, depending on the current substrate feed.
    /// The current substrate feed is taken out of the current substrate feed 
    /// measurement in mySensors
    /// 
    /// Attention!!! Changes the values of the ADM params!!!
    /// 
    /// the following params depend on the substrate feed:
    /// - XC fractions (fCH_XC, fLI_XC, ...]
    /// - disintegration constant: kdis
    /// - hydrolysis constant: khyd_ch, khyd_pr, khyd_li
    /// </summary>
    /// <param name="t">current simulation time measured in days</param>
    /// <param name="mySensors"></param>
    /// <param name="mySubstrates"></param>
    /// <param name="substrate_network_digester"></param>
    /// <returns></returns>
    public double[] getADMparams(double t, sensors mySensors, substrates mySubstrates,
                                 double[] substrate_network_digester/*, double deltatime*/)
    {
      return AD_Model.getParams(t, mySensors, mySubstrates, substrate_network_digester, id);
    }

    /// <summary>
    /// Returns the ADM params vector, depending on the current substrate feed
    /// 
    /// Attention!!! Changes the values of the ADM params!!!
    /// 
    /// the following params depend on the substrate feed:
    /// - XC fractions (fCH_XC, fLI_XC, ...]
    /// - disintegration constant: kdis
    /// - hydrolysis constant: khyd_ch, khyd_pr, khyd_li
    /// 
    /// this only works if simulation starts at time t= 0, at the moment this function
    /// is not called
    /// </summary>
    /// <param name="t">current simulation time in days</param>
    /// <param name="Q">substrate feed measured in m^3/d</param>
    /// <param name="QdigesterIn">total volumetric flow rate in digester in m^3/d</param>
    /// <param name="mySubstrates"></param>
    /// <returns>ADM params</returns>
    public double[] getADMparams(double t, double[] Q, double QdigesterIn, substrates mySubstrates)
    {
      return AD_Model.getParams(t, Q, QdigesterIn, mySubstrates);
    }
    
    /// <summary>
    /// Returns default values of ADM params vector, not dependent on substrate feed
    /// 
    /// if getADMparams method was called before (see below], then
    /// this method returns the last updated ADM params
    /// </summary>
    /// <returns></returns>
    public double[] getDefaultADMparams()
    {
      return AD_Model.getDefaultParams();
    }

    /// <summary>
    /// Get ADM parameter at given position as given out value. pos is 1-based.
    /// </summary>
    /// <param name="pos">from 1 to ADMparams.numParams</param>
    /// <param name="value">value of the ADM parameter</param>
    /// <exception cref="exception">Invalid pos</exception>
    public void getADMparameter(int pos, out double value)
    {
      AD_Model.getADMparameter(pos, out value);
    }

    /// <summary>
    /// Returns handle of the gui belonging to the AD model block
    /// </summary>
    /// <returns></returns>
    public double get_gui_handle()
    {
      return AD_Model.gui_handle;
    }



    // -------------------------------------------------------------------------------------
    //                              !!! PUBLIC SET METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// Set ADM parameter at given position to given value. pos is 1-based.
    /// </summary>
    /// <param name="pos">from 1 to ADMparams.numParams</param>
    /// <param name="value">value of the ADM parameter</param>
    /// <exception cref="exception">Invalid pos</exception>
    public void setADMparameter(int pos, double value)
    {
      AD_Model.setADMparameter(pos, value);
    }

    /// <summary>
    /// Set ADM parameter at given position to given value. pos is 1-based.
    /// </summary>
    /// <param name="pos1">from 1 to ADMparams.numParams</param>
    /// <param name="value1">value of the ADM parameter</param>
    /// <param name="pos2">from 1 to ADMparams.numParams</param>
    /// <param name="value2">value of the ADM parameter</param>
    /// <exception cref="exception">Invalid pos</exception>
    public void setADMparameter(int pos1, double value1, int pos2, double value2)
    {
      AD_Model.setADMparameter(pos1, value1, pos2, value2);
    }

    /// <summary>
    /// Sets default values of ADM params vector, not dependent on substrate feed
    /// </summary>
    /// <param name="ADM1params">the ADM1 parameter vector, must have the correct dimension
    /// </param>
    /// <exception cref="exception">vector has not correct dimension</exception>
    public void setDefaultADMparams(double[] ADM1params)
    {
      AD_Model.parameters= ADM1params;
    }


    /// <summary>
    /// Sets handle of the gui belonging to the AD model block
    /// </summary>
    /// <param name="gui_handle"></param>
    public void set_gui_handle(double gui_handle)
    {
      _AD_Model.gui_handle= gui_handle;
    }



  }
}


