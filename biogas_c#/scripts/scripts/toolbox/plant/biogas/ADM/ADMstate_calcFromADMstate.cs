/**
 * This file is part of the partial class ADMstate and defines
 * all calcFromADMstate methods.
 * 
 * TODOs:
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
    /// Calculates the given symbol from the ADM state vector stream x and
    /// returns it in the given unit ToUnit.
    /// </summary>
    /// <param name="x">2dim array: 
    /// 1st dimension: time
    /// 2nd dimension: ADM state vector</param>
    /// <param name="symbol">component of the ADM state vector</param>
    /// <param name="ToUnit"></param>
    /// <param name="values"></param>
    public static void calcFromADMstate(double[,] x, string symbol,
                                        string ToUnit, out double[] values)
    {
      physValueBounded[] myValues= calcFromADMstate(x, symbol, ToUnit);

      values= physValue.getValues(myValues);
    }
    /// <summary>
    /// Calculates the given symbol from the ADM state vector stream x and
    /// returns it in the given unit ToUnit. 
    /// </summary>
    /// <param name="x">2dim array: 
    /// 1st dimension: time
    /// 2nd dimension: ADM state vector</param>
    /// <param name="symbol">component of the ADM state vector</param>
    /// <param name="ToUnit"></param>
    /// <returns></returns>
    public static physValueBounded[] calcFromADMstate(double[,] x, string symbol,
                                                      string ToUnit)
    {
      // dim 0: assumed to be time
      physValueBounded[] values= new physValueBounded[x.GetLength(0)];

      for (int itime = 0; itime < x.GetLength(0); itime++)
      {
        // dim 1: assumed to be ADMstate.dim_stream or dim_state or similar
        double[] x_current= new double[x.GetLength(1)];

        for (int iel = 0; iel < x_current.Length; iel++)
        { 
          x_current[iel]= x[itime, iel];
        }

        values[itime]= calcFromADMstate(x_current, symbol, ToUnit);
      }

      return values;
    }

    
    /// <summary>
    /// Calculates given symbol out of state vector x. The symbol in the state vector
    /// must be measured in FromUnit and is returned in default unit
    /// </summary>
    /// <param name="x">ADM state vector</param>
    /// <param name="symbol">component inside the ADM state vector</param>
    /// <param name="FromUnit">must be the unit in which the component is measured inside
    /// the state vector x</param>
    /// <param name="value"></param>
    public static void calcFromADMstate(double[] x, string symbol,
                                        string FromUnit, out double value)
    {
      string ToUnit= physValue.getDefaultUnit(symbol);

      value= calcFromADMstate(x, symbol, FromUnit, ToUnit).Value;
    }
    /// <summary>
    /// Calculates given symbol out of state vector x. The symbol in the state vector
    /// must be measured in FromUnit and is returned in ToUnit. Only returns the double value.
    /// </summary>
    /// <param name="x">ADM state vector</param>
    /// <param name="symbol">component inside the ADM state vector</param>
    /// <param name="FromUnit">must be the unit in which the component is measured inside
    /// the state vector x</param>
    /// <param name="ToUnit"></param>
    /// <param name="value"></param>
    public static void calcFromADMstate(double[] x, string symbol,
                                        string FromUnit, string ToUnit, 
                                        out double value)
    {
      physValueBounded pvalue= calcFromADMstate(x, symbol, FromUnit, ToUnit);

      value= pvalue.Value;
    }
    /// <summary>
    /// Calculates given symbol out of state vector x. The symbol in the state vector
    /// must be measured in FromUnit and is returned in ToUnit
    /// </summary>
    /// <param name="x">ADM state vector</param>
    /// <param name="symbol">component inside the ADM state vector</param>
    /// <param name="FromUnit">must be the unit in which the component is measured inside
    /// the state vector x</param>
    /// <param name="ToUnit"></param>
    /// <returns></returns>
    public static physValueBounded calcFromADMstate(double[] x, string symbol, 
                                                    string FromUnit, string ToUnit)
    {
      physValueBounded myValue;

      if ( isofkind(symbol, "sum") )
      {
        string Acid;
        string Base;
        string Sum;

        // get the chars for the corresponding acid and base
        biogas.ADMstate.defineAcidBasePairs(symbol, out Acid, out Base, out Sum);

        // get concentration of acid and base in the state vector in kgCOD/m^3
        physValue acid_value= biogas.ADMstate.getFromADMstate(x, Acid, FromUnit);
        physValue base_value= biogas.ADMstate.getFromADMstate(x, Base, FromUnit);

        // sum parameter measured in unit
        myValue= new physValueBounded(acid_value.convertUnit(ToUnit) + 
                                      base_value.convertUnit(ToUnit));                  
      }
      // acid or base or some other physical value                
      else
      {
        // concentration of the physical value in kgCOD/m^3
        physValue c_physValue= biogas.ADMstate.getFromADMstate(x, symbol, FromUnit);

        // physical value measured in unit
        myValue= new physValueBounded(c_physValue.convertUnit(ToUnit));
      }

      // wegen Numerik bei Simulation können Werte schon mal negativ sein...
      //myValue.setLB(-1);

      myValue.printIsOutOfBounds();

      return myValue;
    }



    /// <summary>
    /// Calculates given symbol out of state vector x. The symbol in the state vector
    /// must be measured in the unit of the ADM state vector (as defined in variable
    /// unitsADMstate) and is returned in ToUnit
    /// 
    /// </summary>
    /// <param name="x"></param>
    /// <param name="symbol"></param>
    /// <param name="ToUnit"></param>
    /// <returns></returns>
    public static physValueBounded calcFromADMstate(double[] x, string symbol,
                                                    string ToUnit)
    {
      
      // nicht so gut den defaultUnit von physValue zu holen, da ein anderes AD
      // Model andere Einheiten haben könnte
      //string FromUnit= physValue.getDefaultUnit(symbol);
      // so ist es OK!
      string FromUnit = ADMstate.getUnitOfADMstatevariable(symbol);

      return calcFromADMstate(x, symbol, FromUnit, ToUnit);
    }



  }
}


