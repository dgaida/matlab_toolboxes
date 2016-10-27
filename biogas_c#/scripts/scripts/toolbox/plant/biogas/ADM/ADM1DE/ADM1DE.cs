/**
 * MATLAB Toolbox for Simulation, Control & Optimization of Biogas Plants
 * Copyright (C) 2014  Daniel Gaida
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
/**
* This file defines the class ADM1DE.
* 
* TODOs:
* - maybe add further methods, not yet clear how this class should be used
* - only defines ADM params and sets them depending on the substrate feed
* 
* 
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
  /// TODO:
  /// Define what this class should be used for
  /// 
  /// </summary>
  public class ADM1DE : ADM
  {

    // -------------------------------------------------------------------------------------
    //                            !!! PRIVATE FIELDS !!!
    // -------------------------------------------------------------------------------------
        
    ///// <summary>
    ///// parameters of the AD model
    ///// </summary>
    //double[] _parameters= new double[ADM1DEparams.numParams];



    //// -------------------------------------------------------------------------------------
    ////                              !!! PROPERTIES !!!
    //// -------------------------------------------------------------------------------------
        
    //new public double[] parameters
    //{      
    //  set 
    //  {
    //    if (value.Length != biogas.ADM1DEparams.numParams)
    //      throw new exception(String.Format(
    //        "value has not the correct dimension ({0}). Must be {1}!",
    //        value.Length, biogas.ADM1DEparams.numParams));

    //    _parameters= value; 
    //  }
    //}



    // -------------------------------------------------------------------------------------
    //                              !!! CONSTRUCTOR METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// 
    /// </summary>
    /// <param name="T"></param>
    public ADM1DE(physValue T) : base(T)
    { }



    // -------------------------------------------------------------------------------------
    //                              !!! GET METHODS !!!
    // -------------------------------------------------------------------------------------

    //public double[] getDefaultParams()
    //{
    //  return _parameters;
    //}

    //public double[] getParams(double[] Q, substrates mySubstrates)
    //{
    //  double fCH_XC, fLI_XC, fPR_XC,
    //         fSI_XC, fXI_XC, fXP_XC;

    //  mySubstrates.calcfFactors(Q, out fCH_XC, out fPR_XC, out fLI_XC,
    //                               out fXI_XC, out fSI_XC, out fXP_XC);

    //  _parameters[ADMparams.pos_fSI_XC - 1]= fSI_XC;
    //  _parameters[ADMparams.pos_fXI_XC - 1]= fXI_XC;
    //  _parameters[ADMparams.pos_fCH_XC - 1]= fCH_XC;
    //  _parameters[ADMparams.pos_fPR_XC - 1]= fPR_XC;
    //  _parameters[ADMparams.pos_fLI_XC - 1]= fLI_XC;
    //  _parameters[ADMparams.pos_fXP_XC - 1]= fXP_XC;
      
    //  return _parameters;
    //}
    
    

    // -------------------------------------------------------------------------------------
    //                              !!! PUBLIC METHODS !!!
    // -------------------------------------------------------------------------------------



    // -------------------------------------------------------------------------------------
    //                              !!! PRIVATE METHODS !!!
    // -------------------------------------------------------------------------------------



  }
}


