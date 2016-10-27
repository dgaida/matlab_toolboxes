/**
 * This file defines the class final_storage_tank
 * 
 * TODOs:
 * - maybe add further methods 
 * 
 * OK!
 * 
 */

using System;
using System.Collections.Generic;
using System.Text;
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
  /// defines a final storage tank
  /// </summary>
  public class final_storage_tank
  {

    /// <summary>
    /// run (emulate) the final storage tank
    /// just measures concentration of SS and VS COD in output
    /// stream as well as Q.
    /// </summary>
    /// <param name="t">current simulation time in days</param>
    /// <param name="x">ADM stream vector</param>
    /// <param name="mySensors"></param>
    public static void run(double t, double[] x, biogas.sensors mySensors/*, 
      double deltatime*/)
    {
      // measure COD SS and VS and Q of outlet stream

      mySensors.measure(t, "SS_COD_finalstorage_2", x);

      mySensors.measure(t, "VS_COD_finalstorage_2", x);

      mySensors.measure(t, "Q_finalstorage_2", x);

      // TODO - messen von volatile solids
      // TODO - substrate müsste noch als parameter übergeben werden



    }



  }
}


