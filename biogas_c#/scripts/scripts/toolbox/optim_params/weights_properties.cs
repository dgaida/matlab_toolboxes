/**
 * This file defines the properties of the weights object.
 * 
 * TODOs:
 * - maybe add more weights
 * 
 * Except for that FINISHED!
 * 
 */

using System;
using System.Collections.Generic;
using System.Text;

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
  public partial class weights
  {

    // -------------------------------------------------------------------------------------
    //                            !!! PRIVATE FIELDS !!!
    // -------------------------------------------------------------------------------------
    
    /// <summary>
    /// weight for COD degradation SS and VS
    /// </summary>
    private double _w_CSB = 0.1;

    /// <summary>
    /// weight for minimal CH4 concentration in biogas
    /// </summary>
    private double _w_CH4 = 0.1;

    /// <summary>
    /// weight for cost vs. benefit ratio
    /// </summary>
    private double _w_money = 0.1;

    /// <summary>
    /// weight for setpoint max. energy production control
    /// </summary>
    private double _w_energy = 0.0;

    /// <summary>
    /// weight for pH values in digesters
    /// </summary>
    private double _w_pH = 0.1;

    /// <summary>
    /// weight for TS concentration in digester and input TS concentration of 
    /// substrates (non-liquid)
    /// </summary>
    private double _w_TS = 0.1;

    /// <summary>
    /// weight for volatile fatty acid boundaries
    /// </summary>
    private double _w_VFA = 0.1;

    /// <summary>
    /// weight for hydraulic retention time boundaries for digesters
    /// and HRT of complete plant
    /// </summary>
    private double _w_HRT = 0.1;

    /// <summary>
    /// weight for total alkalinity concentration boundaries in digesters
    /// </summary>
    private double _w_TAC = 0.05;

    /// <summary>
    /// weight for organic loading rate boundary for digesters
    /// and complete plant
    /// </summary>
    private double _w_OLR = 0.1;

    /// <summary>
    /// weight for NH4N and NH3 concentration inside digesters
    /// </summary>
    private double _w_N = 0.1;

    /// <summary>
    /// weight for biogas excess
    /// </summary>
    private double _w_gasexc = 0.1;

    /// <summary>
    /// weight for FOS/TAC value inside digesters
    /// 
    /// because of normalize() method we do not care anymore that 
    /// sum of weights are 1.
    /// </summary>
    private double _w_FOS_TAC= 0.1;

    /// <summary>
    /// weight for faecal bacteria removal capacity
    /// 
    /// - intestinal enterococci
    /// - faecal coliforms
    /// </summary>
    private double _w_faecal = 0;

    /// <summary>
    /// weight for ratio of acetic vs. propionic acid
    /// </summary>
    private double _w_AcVsPro = 0;

    /// <summary>
    /// weight for setpoint, if we have a setpoint control
    /// </summary>
    private double _w_setpoint = 0;

    /// <summary>
    /// weight for substrate feed (control input) change udot
    /// </summary>
    private double _w_udot = 0;



    // -------------------------------------------------------------------------------------
    //                              !!! PROPERTIES !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// weight for COD degradation SS and VS
    /// </summary>
    public double w_CSB
    {
      get { return _w_CSB; }
    }

    /// <summary>
    /// weight for minimal CH4 concentration in biogas
    /// </summary>
    public double w_CH4
    {
      get { return _w_CH4; }
    }

    /// <summary>
    /// weight for cost vs. benefit ratio
    /// </summary>
    public double w_money
    {
      get { return _w_money; }
    }

    /// <summary>
    /// weight for setpoint max. energy production control
    /// </summary>
    public double w_energy
    {
      get { return _w_energy; }
    }

    /// <summary>
    /// weight for pH values in digesters
    /// </summary>
    public double w_pH
    {
      get { return _w_pH; }
    }

    /// <summary>
    /// weight for TS concentration in digester and input TS concentration of 
    /// substrates (non-liquid)
    /// </summary>
    public double w_TS
    {
      get { return _w_TS; }
    }

    /// <summary>
    /// weight for volatile fatty acid boundaries
    /// </summary>
    public double w_VFA
    {
      get { return _w_VFA; }
    }

    /// <summary>
    /// weight for hydraulic retention time boundaries for digesters
    /// </summary>
    public double w_HRT
    {
      get { return _w_HRT; }
    }

    /// <summary>
    /// weight for total alkalinity concentration boundaries in digesters
    /// </summary>
    public double w_TAC
    {
      get { return _w_TAC; }
    }

    /// <summary>
    /// weight for organic loading rate boundary for digesters
    /// </summary>
    public double w_OLR
    {
      get { return _w_OLR; }
    }

    /// <summary>
    /// weight for NH4N and NH3 concentration inside digesters
    /// </summary>
    public double w_N
    {
      get { return _w_N; }
    }

    /// <summary>
    /// weight for biogas excess
    /// </summary>
    public double w_gasexc
    {
      get { return _w_gasexc; }
    }

    /// <summary>
    /// weight for FOS/TAC value inside digesters
    /// </summary>
    public double w_FOS_TAC
    {
      get { return _w_FOS_TAC; }
    }

    /// <summary>
    /// weight for faecal bacteria removal capacity
    /// 
    /// - intestinal enterococci
    /// - faecal coliforms
    /// </summary>
    public double w_faecal
    {
      get { return _w_faecal; }
    }

    /// <summary>
    /// weight for ratio of acetic vs. propionic acid
    /// </summary>
    public double w_AcVsPro
    {
      get { return _w_AcVsPro; }
    }

    /// <summary>
    /// weight for setpoint, if we have a setpoint control
    /// </summary>
    public double w_setpoint
    {
      get { return _w_setpoint; }
    }

    /// <summary>
    /// weight for substrate feed (control input) change udot
    /// </summary>
    public double w_udot
    {
      get { return _w_udot; }
    }


    
  }
}
