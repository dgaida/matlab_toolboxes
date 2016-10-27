/**
 * This file is part of the partial class biogas and defines
 * the class.
 * 
 * TODOs:
 * - es ist nicht schön, dass so viele parameter public sind
 * 
 * 
 * Because of that not yet FINISHED! 
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
  /// Defines biogas: a mix of CH4, CO2, H2 and H2S, ...
  /// 
  /// Definitions:
  /// 
  /// biogas is at least a three dimensional vector with the
  /// following components:
  /// 
  /// h2 at first position
  /// ch4 at 2nd position
  /// h2s at 3rd position
  /// 
  /// biogas could also be a higher dimensional vector
  /// then fourth position could e.g. be
  /// h2s, ...
  /// 
  /// </summary>
  public partial class BioGas
  {
    // -------------------------------------------------------------------------------------
    //                           !!! PROPERTIES !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// number of gases in the biogas (H2, CH4, CO2)
    /// 
    /// this is the minimal dimension of the biogas stream, could
    /// also be higher dimensional, only compare "&lt;" not ==
    /// 
    /// do not change, this is only the minimal dimension
    /// maybe define a maximal dimension as well?
    /// </summary>
    private static int _n_gases = 3;

    /// <summary>
    /// only for MATLAB, wird auch in C# methoden genutzt
    /// TODO: sollte gar nicht genutzt werden
    /// </summary>
    public static double n_gases = (double)_n_gases;

    /// <summary>
    /// position of hydrogen in the gaseous phase
    /// TODO: die nächsten 4 properties sollten private sein
    /// do not change
    /// </summary>
    public static int pos_h2 = 1;
    /// <summary>
    /// methane in the gaseous phase
    /// do not change
    /// </summary>
    public static int pos_ch4 = 2;
    /// <summary>
    /// carbon dioxide in the gaseous phase
    /// do not change
    /// </summary>
    public static int pos_co2 = 3;
    /// <summary>
    /// hydrogen sulphide in the gaseous phase
    /// do not change
    /// </summary>
    public static int pos_h2s = 4;


    /// <summary>
    /// Symbols for the biogas vector
    /// TODO: sollte private sein
    /// do not change, must match with definition of position above
    /// </summary>
    public static string[] symGases = { "H2", "CH4", "CO2", "H2S" };

    // <summary>
    /// Labels for the biogas vector
    /// TODO: sollte private sein
    /// do not change, must match with definition of position above
    /// </summary>
    public static string[] labelGases = { "hydrogen", "methane", 
                                          "carbon dioxide", "hydrogen sulphide" };



  }
}


