/**
 * This file is part of the partial class digesters and defines
 * public methods related to the Anaerobic Digestion Model.
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
using System.Xml;
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
  /// list of digesters
  /// </summary>
  public partial class digesters : List<digester>
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
    /// <param name="index">1-based index of digester</param>
    /// <param name="t">current simulation time measured in days</param>
    /// <param name="mySensors"></param>
    /// <param name="mySubstrates"></param>
    /// <param name="substrate_network_digester"></param>
    /// <returns></returns>
    /// <exception cref="exception">Invalid digester index</exception>
    public double[] getADMparams(int index, double t, sensors mySensors, 
                                 substrates mySubstrates, 
                                 double[] substrate_network_digester/*, 
                                 double deltatime*/)
    {
      return get(index).getADMparams(t, mySensors, 
                                     mySubstrates, substrate_network_digester);
    }

    /// <summary>
    /// Returns default values of ADM params vector, not dependent on substrate feed
    /// 
    /// if getADMparams method was called before (see below], then
    /// this method returns the last updated ADM params
    /// </summary>
    /// <param name="id">id of digester</param>
    /// <returns></returns>
    /// <exception cref="exception">Unknown digester id</exception>
    public double[] getDefaultADMparams(string id)
    {
      return get(id).getDefaultADMparams();
    }

    /// <summary>
    /// Returns default values of ADM params vector, not dependent on substrate feed
    /// 
    /// if getADMparams method was called before (see below], then
    /// this method returns the last updated ADM params
    /// </summary>
    /// <param name="index">index of digester</param>
    /// <returns></returns>
    /// <exception cref="exception">Invalid digester index</exception>
    public double[] getDefaultADMparams(int index)
    {
      return get(index).getDefaultADMparams();
    }

    /// <summary>
    /// Get ADM parameter at given position as given out value. pos is 1-based.
    /// </summary>
    /// <param name="id">id of digester</param>
    /// <param name="pos">from 1 to ADMparams.numParams</param>
    /// <param name="value">value of the ADM parameter</param>
    /// <exception cref="exception">Unknown digester id</exception>
    /// <exception cref="exception">Invalid pos</exception>
    public void getADMparameter(string id, int pos, out double value)
    {
      get(id).getADMparameter(pos, out value);
    }

    /// <summary>
    /// Get ADM parameter at given position as given out value. pos is 1-based.
    /// </summary>
    /// <param name="index">1-based index of digester</param>
    /// <param name="pos">from 1 to ADMparams.numParams</param>
    /// <param name="value">value of the ADM parameter</param>
    /// <exception cref="exception">Invalid digester index</exception>
    /// <exception cref="exception">Invalid pos</exception>
    public void getADMparameter(int index, int pos, out double value)
    {
      get(index).getADMparameter(pos, out value);
    }

    /// <summary>
    /// Returns handle of the gui belonging to the AD model block
    /// </summary>
    /// <param name="index">1-based index of digester</param>
    /// <returns></returns>
    /// <exception cref="exception">Invalid digester index</exception>
    public double get_gui_handle(int index)
    {
      return get(index).get_gui_handle();
    }



    // -------------------------------------------------------------------------------------
    //                              !!! PUBLIC SET METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// Set ADM parameter at given position to given value. pos is 1-based.
    /// </summary>
    /// <param name="id">id of digester</param>
    /// <param name="pos">from 1 to ADMparams.numParams</param>
    /// <param name="value">value of the ADM parameter</param>
    /// <exception cref="exception">Unknown digester id</exception>
    /// <exception cref="exception">Invalid pos</exception>
    public void setADMparameter(string id, int pos, double value)
    {
      get(id).setADMparameter(pos, value);
    }

    /// <summary>
    /// Set ADM parameter at given position to given value. pos is 1-based.
    /// </summary>
    /// <param name="index">1-based index of digester</param>
    /// <param name="pos">from 1 to ADMparams.numParams</param>
    /// <param name="value">value of the ADM parameter</param>
    /// <exception cref="exception">Invalid digester index</exception>
    /// <exception cref="exception">Invalid pos</exception>
    public void setADMparameter(int index, int pos, double value)
    {
      get(index).setADMparameter(pos, value);
    }

    /// <summary>
    /// Set ADM parameter at given position to given value. pos is 1-based.
    /// </summary>
    /// <param name="index">1-based index of digester</param>
    /// <param name="pos1">from 1 to ADMparams.numParams</param>
    /// <param name="value1">value of the ADM parameter</param>
    /// <param name="pos2">from 1 to ADMparams.numParams</param>
    /// <param name="value2">value of the ADM parameter</param>
    /// <exception cref="exception">Invalid digester index</exception>
    /// <exception cref="exception">Invalid pos</exception>
    public void setADMparameter(int index, int pos1, double value1, int pos2, double value2)
    {
      get(index).setADMparameter(pos1, value1, pos2, value2);
    }

    /// <summary>
    /// Sets default values of ADM params vector, not dependent on substrate feed
    /// </summary>
    /// <param name="id">id of digester</param>
    /// <param name="ADM1params">the ADM1 parameter vector, must have the correct dimension
    /// </param>
    /// <exception cref="exception">Unknown digester id</exception>
    /// <exception cref="exception">vector has not correct dimension</exception>
    public void setDefaultADMparams(string id, double[] ADM1params)
    {
      get(id).setDefaultADMparams(ADM1params);
    }

    /// <summary>
    /// Sets default values of ADM params vector, not dependent on substrate feed
    /// </summary>
    /// <param name="index">1-based index of digester</param>
    /// <param name="ADM1params">the ADM1 parameter vector, must have the correct dimension
    /// </param>
    /// <exception cref="exception">Invalid digester index</exception>
    /// <exception cref="exception">vector has not correct dimension</exception>
    public void setDefaultADMparams(int index, double[] ADM1params)
    {
      get(index).setDefaultADMparams(ADM1params);
    }

    
    /// <summary>
    /// Sets handle of the gui belonging to the AD model block
    /// </summary>
    /// <param name="index">1-based index of digester</param>
    /// <param name="gui_handle"></param>
    /// <exception cref="exception">Invalid digester index</exception>
    public void set_gui_handle(int index, double gui_handle)
    {
      get(index).set_gui_handle(gui_handle);
    }



  }
}


