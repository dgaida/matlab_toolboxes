/**
 * This file is part of the partial class ADMstate and defines
 * all private methods.
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
  /// s. biogasM.ADMstate
  /// sollte mit math Klasse jetzt möglich sein
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
    //                              !!! PRIVATE METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// Get a value out of the state vector x in the given unit.
    /// </summary>
    /// <param name="x">ADM state vector</param>
    /// <param name="symbol">element of the state vector as defined in the ADM state vector</param>
    /// <param name="unit"></param>
    /// <returns></returns>
    /// <exception cref="exception">Unknown symbol</exception>
    private static physValue getFromADMstate(double[] x, string symbol, 
                                             string unit)
    {
      physValue value;

      if (isofkind(symbol, "acid"))
      {
        string Acid;
        string Base;
        string Sum;

        biogas.ADMstate.defineAcidBasePairs(symbol, out Acid, out Base, out Sum);

        double conc_base;
        double conc_sum;

        biogas.ADMstate.getADMstatevariables(x, out conc_base, Base);
        biogas.ADMstate.getADMstatevariables(x, out conc_sum, Sum);

        value= new science.physValue(symbol, conc_sum - conc_base, unit);
      }
      else
      {
        double conc;

        biogas.ADMstate.getADMstatevariables(x, out conc, symbol);

        value= new science.physValue(symbol, conc, unit);
      }
      
      return value;
    }

    /// <summary>
    /// Get a value out of the state vector x in the default unit defined in physValue class.
    /// </summary>
    /// <param name="x">ADM state vector</param>
    /// <param name="symbol">element of the state vector as defined in the ADM state vector</param>
    /// <returns></returns>
    /// <exception cref="exception">Unknown symbol</exception>
    private static physValue getFromADMstate(double[] x, string symbol)
    {
      string unit= physValue.getDefaultUnit(symbol);

      return getFromADMstate(x, symbol, unit);
    }



    /// <summary>
    /// Returns all acids, bases or 
    /// the sum parameters as string array.
    /// </summary>
    /// <param name="part">acid, base or sum</param>
    /// <returns></returns>
    /// <exception cref="exception">Unknown part</exception>
    private static string[] defineAcids(string part)
    {

      switch (part)
      { 
      
        case "acid":
          string[] retval= {"Shac", "Shpro", "Shbu", "Shva"};
          return retval;
          
        case "base":
          string[] retval2= { "Sac_", "Spro_", "Sbu_", "Sva_" };
          return retval2;

        case "sum":
          string[] retval3= { "Sac", "Spro", "Sbu", "Sva" };
          return retval3;

        default:
          throw new exception(String.Format("Not known: {0}!", part)); 
      }
            
    }

    /// <summary>
    /// Checks whether the candidate is an acid, base or the sum parameter
    /// </summary>
    /// <param name="candidate">element out of the ADM state vector</param>
    /// <param name="part">acid, base or sum</param>
    /// <returns>true, if candidate is of type part</returns>
    /// <exception cref="exception">Unknown part</exception>
    private static bool isofkind(string candidate, string part)
    {
      string[] acids= defineAcids(part);

      for (int iel= 0; iel < acids.Length; iel++)
      {
        if (acids[iel].CompareTo(candidate) == 0)
          return true;
      }

      return false;
    }

    /// <summary>
    /// Defines acid/base pairs. For the given symbol, which should be an VFA
    /// the Acid, Base or the Sum parameter is returned.
    /// </summary>
    /// <param name="symbol">an acid, base or sum of both</param>
    /// <param name="Acid"></param>
    /// <param name="Base"></param>
    /// <param name="Sum"></param>
    /// <exception cref="exception">Unknown symbol</exception>
    private static void defineAcidBasePairs(string symbol, out string Acid, 
                                            out string Base, out string Sum)
    {
  
      switch (symbol)
      {
        case "Sac":
        case "Shac":
        case "Sac_":
          Acid= "Shac";
          Base= "Sac_";
          Sum= "Sac";
          break;

        case "Spro":
        case "Shpro":
        case "Spro_":
          Acid= "Shpro";
          Base= "Spro_";
          Sum= "Spro";
          break;

        case "Sbu":
        case "Shbu":
        case "Sbu_":
          Acid= "Shbu";
          Base= "Sbu_";
          Sum= "Sbu";
          break;

        case "Sva":
        case "Shva":
        case "Sva_":
          Acid= "Shva";
          Base= "Sva_";
          Sum= "Sva";
          break;

        default:
          throw new exception(String.Format("Unknown symbol: {0}!", symbol)); 
      }

    }



  }
}


