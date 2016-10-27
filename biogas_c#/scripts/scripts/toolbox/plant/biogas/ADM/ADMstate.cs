/**
 * This file is part of the partial class ADMstate and defines
 * all other methods not defined elsewhere.
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

namespace biogas
{
  /// <summary>
  /// TODO: Implement: calcPHOfADMstate as in MATLAB, 
  /// all other methods are as in MATLAB
  /// 
  /// 
  /// References:
  /// 
  /// 1) Schoen, M.A., Sperl, D., Gadermaier, M., Goberna, M., Franke-Whittle, I.,
  ///    Insam, H., Ablinger, J., and Wett B.: 
  ///    Population dynamics at digester overload conditions, 
  ///    Bioresource Technology 100, pp. 5648-5655, 2009
  ///
  /// </summary>
  public partial class ADMstate
  {

    // -------------------------------------------------------------------------------------
    //                              !!! PUBLIC METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// Standard Constructor does nothing
    /// </summary>
    public ADMstate()
    { 
    
    }

    

    /// <summary>
    /// Returns position of symbol in ADM statevector, 1-based
    /// </summary>
    /// <param name="symbol">variable</param>
    /// <returns>position of symbol in ADM state vector. 1, 2, ...</returns>
    /// <exception cref="exception">Unknown variable</exception>
    public static int getPosOfADMstatevariable(string symbol)
    {
      for (int ivar = 0; ivar < symADMstate.Length; ivar++)
      {
        if (symbol == symADMstate[ivar])
          return ivar + 1;
      }

      throw new exception(String.Format(
                          "The variable {0} was not found in ADM statevector!",
                          symbol));
    }

    /// <summary>
    /// Returns unit of symbol used in ADM1 model
    /// </summary>
    /// <param name="symbol">variable</param>
    /// <returns>unit of ADM state vector component</returns>
    public static string getUnitOfADMstatevariable(string symbol)
    {
      int pos = getPosOfADMstatevariable(symbol);

      return getUnitOfADMstatevariable(pos);
    }
    /// <summary>
    /// Returns unit of position in state vector used in ADM1 model
    /// </summary>
    /// <param name="pos">1-based position in state vector</param>
    /// <returns>unit of ADM state vector component</returns>
    public static string getUnitOfADMstatevariable(int pos)
    {
      if (pos < 1 || pos > _dim_state)
      {
        throw new exception(String.Format("pos must be: 1 <= {0} <= {1}", 
          pos, _dim_state));
      }

      return unitsADMstate[pos - 1];
    }



    /// <summary>
    /// Returns given symbol in ADM state vector x
    /// </summary>
    /// <param name="x">ADM state vector</param>
    /// <param name="variable"></param>
    /// <param name="symbol">variable</param>
    /// <exception cref="exception">Unknown variable</exception>
    public static void getADMstatevariables(double[] x, out double variable, string symbol)
    {
      double[] variables;
      string[] symbols= { symbol };

      getADMstatevariables(x, out variables, symbols);

      variable= variables[0];
    }
    /// <summary>
    /// Returns given symbols in ADM state vector x
    /// </summary>
    /// <param name="x">ADM state vector</param>
    /// <param name="variables"></param>
    /// <param name="symbols"></param>
    /// <exception cref="exception">Unknown variable</exception>
    /// <exception cref="exception">No input argument</exception>
    public static void getADMstatevariables(double[] x, out double[] variables, 
                                            params string[] symbols)
    {
      int nargin= symbols.Length;

      if (nargin > 0)
      {
        variables= new double[nargin];

        for (int iarg= 0; iarg < nargin; iarg++)
        {
          switch (symbols[iarg])
          {
            case "Ssu":   // monosaccarides [kg COD/m^3]
              variables[iarg]= x[biogas.ADMstate.pos_Ssu - 1];
              break;
            case "Saa":   // amino acids [kg COD/m3]
              variables[iarg]= x[biogas.ADMstate.pos_Saa - 1];
              break;
            case "Sfa":   // total LCFA [kg COD/m3]
              variables[iarg]= x[biogas.ADMstate.pos_Sfa - 1];
              break;
            case "Sva":   // valeric acid + valerate kg COD/m3 
              variables[iarg]= x[biogas.ADMstate.pos_Sva - 1];
              break;
            case "Sbu":   // butyric acid +bytyrate kg COD/m3 
              variables[iarg]= x[biogas.ADMstate.pos_Sbu - 1];
              break;
            case "Spro":  // propionic acid + propionate kg COD/m3 
              variables[iarg]= x[biogas.ADMstate.pos_Spro - 1];
              break;
            case "Sac":   // acetic acid + acetate kg COD/m3 
              variables[iarg]= x[biogas.ADMstate.pos_Sac - 1];
              break;
            case "Sh2":   // hydrogen kg COD/m3 
              variables[iarg]= x[biogas.ADMstate.pos_Sh2 - 1];
              break;
            case "Sch4":  // methane kg COD/m3 
              variables[iarg]= x[biogas.ADMstate.pos_Sch4 - 1];
              break;
            case "Sco2":  // carbon dioxide k mol C/m3 
              variables[iarg]= x[biogas.ADMstate.pos_Sco2 - 1];
              break;
            case "Snh4":  // Ammonium k mol N/m3 
              variables[iarg]= x[biogas.ADMstate.pos_Snh4 - 1];
              break;
            case "SI":    // soluble inerts kg COD/m3 
              variables[iarg]= x[biogas.ADMstate.pos_SI - 1];
              break;
            case "Xc":    // composite kg COD/m3 
              variables[iarg]= x[biogas.ADMstate.pos_Xc - 1];
              break;
            case "Xch":   // carbohydrates kg COD/m3 
              variables[iarg]= x[biogas.ADMstate.pos_Xch - 1];
              break;
            case "Xpr":   // proteins kg COD/m3 
              variables[iarg]= x[biogas.ADMstate.pos_Xpr - 1];
              break;
            case "Xli":   // lipids [kg COD/m^3]
              variables[iarg]= x[biogas.ADMstate.pos_Xli - 1];
              break;
            case "Xsu":   // Biomass Sugar degraders kg COD/m3 
              variables[iarg]= x[biogas.ADMstate.pos_Xsu - 1];
              break;
            case "Xaa":   // Biomass amino acids degraders kg COD/m3 
              variables[iarg]= x[biogas.ADMstate.pos_Xaa - 1];
              break;
            case "Xfa":   // Biomass LCFA degraders kg COD/m3 
              variables[iarg]= x[biogas.ADMstate.pos_Xfa - 1];
              break;
            case "Xc4":   // Biomass valerate, butyrate degraders kg COD/m3 
              variables[iarg]= x[biogas.ADMstate.pos_Xc4 - 1];
              break;
            case "Xpro":  // Biomass propionate degraders kg COD/m3 
              variables[iarg]= x[biogas.ADMstate.pos_Xpro - 1];
              break;
            case "Xac":   // Biomas acetate degraders kg COD/m3 
              variables[iarg]= x[biogas.ADMstate.pos_Xac - 1];
              break;
            case "Xh2":   // Biomass hydrogen degraders kg COD/m3 
              variables[iarg]= x[biogas.ADMstate.pos_Xh2 - 1];
              break;
            case "XI":    // particulate inerts kg COD/m3 
              variables[iarg]= x[biogas.ADMstate.pos_XI - 1];
              break;
            case "Xp":    // Particulate products arising from biomass decay kg COD/m^3 
              variables[iarg]= x[biogas.ADMstate.pos_Xp - 1];
              break;
            case "Scat":  // cations k mol/m3 
              variables[iarg]= x[biogas.ADMstate.pos_Scat - 1];
              break;
            case "San":   // Anions k mol/m3 
              variables[iarg]= x[biogas.ADMstate.pos_San - 1];
              break;
            case "Sva_":  // valerate kg COD/m3 
              variables[iarg]= x[biogas.ADMstate.pos_Sva_ - 1];
              break;
            case "Sbu_":  // Butyrate kg COD/m3 
              variables[iarg]= x[biogas.ADMstate.pos_Sbu_ - 1];
              break;
            case "Spro_": // propionate kg COD/m3 
              variables[iarg]= x[biogas.ADMstate.pos_Spro_ - 1];
              break;
            case "Sac_":  // acetate kg COD/m3 
              variables[iarg]= x[biogas.ADMstate.pos_Sac_ - 1];
              break;
            case "Shco3": // bicarbonate k mol C/m3 
              variables[iarg]= x[biogas.ADMstate.pos_Shco3 - 1];
              break;
            case "Snh3":  // Ammonia k mol N/m3 
              variables[iarg]= x[biogas.ADMstate.pos_Snh3 - 1];
              break;
            case "piSh2":  // partial pressure of molecular hydrogen bar
              variables[iarg]= x[biogas.ADMstate.pos_piSh2 - 1];
              break;
            case "piSch4": // partial pressure of methane bar
              variables[iarg]= x[biogas.ADMstate.pos_piSch4 - 1];
              break;
            case "piSco2": // partial pressure of carbon dioxide bar
              variables[iarg]= x[biogas.ADMstate.pos_piSco2 - 1];
              break;
            case "pTOTAL": // total pressure bar
              variables[iarg]= x[biogas.ADMstate.pos_pTOTAL - 1];
              break;

            default:
              throw new exception(String.Format(
                "getADMstatevariables: Unknown symbol: {0}!", symbols[iarg])); 
          }
        }
      }
      else 
      {
        variables= new double[ADMstate._dim_stream - 1];

        variables[0]= x[biogas.ADMstate.pos_Ssu - 1];

        // macht keinen Sinn, da Parameter als double array rein wie raus kommen

        throw new exception(
        "getADMstatevariables: You did not specify the symbols you want to have returned!"); 
      }
    }

    /// <summary>
    /// Returns lower and upper boundaries for ADM state vector.
    /// These boundaries are gotten from simulations. Maybe redo these simulations. TODO
    /// </summary>
    /// <param name="ADMstateLB"></param>
    /// <param name="ADMstateUB"></param>
    public static void getBoundsForADMstate(out double[] ADMstateLB, out double[] ADMstateUB)
    {
      double[] default_state= biogas.ADMstate.getDefaultADMstate();

      double[] min_eq= { 5.93e-004, 6.35e-004, 1.05e-002, 4.83e-004, 1.62e-003, 
                         2.16e-004, 8.62e-003, 1.74e-008, 1.89e-002, 3.84e-003, 
                         8.31e-002, 2.75e+000, 1.26e+000, 1.11e-001, 1.11e-001, 
                         1.67e-001, 8.46e-001, 2.99e-001, 1.19e-001, 1.25e-001, 
                         1.13e-001, 3.96e-001, 4.23e-001, 4.86e+000, 1.07e+000, 
                         1.26e-003, 3.84e-003, 9.42e-004, 1.62e-003, 8.81e-004, 
                         8.59e-003, 4.02e-004, 1.03e-005, 1.39e-006, 1.32e-001, 
                         2.37e-001, 3.03e-001 };

      if (min_eq.Length != biogas.ADMstate.dim_state || 
          min_eq.Length != default_state.Length)
        throw new exception(String.Format(
          "The length of min_eq (%i) is not equal to the length of default_state (%i). Both have to be: %i!", 
          min_eq.Length, default_state.Length, biogas.ADMstate.dim_state)); 

      ADMstateLB= math.min(default_state, min_eq);

      double[] max_eq= { 2.07e-002, 8.47e-003, 1.25e+001, 1.77e-002, 3.04e-002, 
                         1.00e+000, 1.13e+001, 1.96e-005, 6.21e-002, 8.86e-002, 
                         2.45e-001, 1.16e+001, 1.85e+001, 5.56e+000, 2.44e+000, 
                         7.31e+000, 4.73e+000, 1.41e+000, 1.37e+000, 7.17e-001, 
                         5.46e-001, 2.57e+000, 1.40e+000, 4.04e+001, 9.61e+000, 
                         3.10e-002, 1.62e-001, 1.77e-002, 3.03e-002, 5.77e-001, 
                         9.23e+000, 2.13e-001, 1.22e-002, 1.55e-003, 7.24e-001, 
                         7.16e-001, 9.62e-001 };

      if (max_eq.Length != biogas.ADMstate.dim_state || 
          max_eq.Length != default_state.Length)
        throw new exception(String.Format(
          "The length of max_eq (%i) is not equal to the length of default_state (%i). Both have to be: %i!", 
          max_eq.Length, default_state.Length, biogas.ADMstate.dim_state)); 

      ADMstateUB= math.max(default_state, max_eq);

      if ( math.any( math.gt(ADMstateLB, ADMstateUB) ) )
      {
        throw new exception( "The boundaries do not satisfy ADMstateUB >= ADMstateLB!" );
      }
    }

    /// <summary>
    /// Returns default ADM state vector
    /// </summary>
    /// <returns></returns>
    public static double[] getDefaultADMstate()
    {
      return getDefaultADMstate(-1);
    }
    /// <summary>
    /// Returns default ADM state vector of given length, always starting at the 1st position
    /// </summary>
    /// <param name="len">length of the ADM state vector</param>
    /// <returns></returns>
    /// <exception cref="exception">length of default ADM state != dim_state</exception>
    public static double[] getDefaultADMstate(int len)
    {

      double[] default_state= { 0.012,0.0053,0.1,
                                0.01,0.014,0.0168,0.1785,
                                2.4e-08,0.048,0.09,
                                0.23,5.53,5.5,0.055307,
                                0.055,0.083,0.855,0.637,
                                0.67,0.283,
                                0.13559,0.9,0.43,45,10,
                                0.039126,0.17846,0.01,0.014,
                                0.016,0.177,
                                0.083,0.00378,0,
                                0,0,1 };

      if (default_state.Length != biogas.ADMstate.dim_state)
        throw new exception(String.Format(
              "The length of the default_state is not equal to {0}, but is {1}!", 
              biogas.ADMstate.dim_state, default_state));

      if (len < biogas.ADMstate.dim_state && len >= 0)
      {
        double[] default_state_len= new double[len + 1];

        for (int iel= 0; iel <= len; iel++)
          default_state_len[iel]= default_state[iel];

        return default_state_len;
      }

      return default_state;
    }

    

  }
}


