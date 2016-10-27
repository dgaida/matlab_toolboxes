/**
 * This file is part of the partial class substrate and defines
 * private methods.
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
using System.Xml;
using System.IO;

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
  /// Defines the physicochemical characteristics of a substrate used on biogas plants.
  /// </summary>
  public partial class substrate
  {
    
    // -------------------------------------------------------------------------------------
    //                              !!! PRIVATE METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// Convert myValue from % TS to % FM using the TS of the substrate.
    /// </summary>
    private physValue convertFrom_TS_To_FM(physValue myValue)
    {
      return convertFrom_TS_To_FM(myValue, Phys.TS);
    }

    /// <summary>
    /// Convert myValue from % TS to % FM using the TS of the substrate.
    /// Method is public.
    /// </summary>
    /// <param name="myValue">a physValue measured in % TS</param>
    /// <param name="TS">total solids</param>
    /// <returns>myValue measured in % FM</returns>
    public static physValue convertFrom_TS_To_FM(physValue myValue, physValue TS)
    {
      if (myValue.Unit == "% TS" && TS.Unit == "% FM")
      {
        physValue pTS= TS.convertUnit("100 %");

        return myValue * pTS * new physValue(1, "% FM / % TS");
      }
      else
        return myValue;
    }
    


  }
}


