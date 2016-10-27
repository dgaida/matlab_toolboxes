/**
 * This file defines the private methods of the fitness_params object.
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
using System.Xml;
using System.IO;

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
  /// definition of fitness parameters used in objective function
  /// </summary>
  public partial class fitness_params
  {

    // -------------------------------------------------------------------------------------
    //                              !!! PRIVATE METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// set fitness_params to default values
    /// </summary>
    /// <param name="numDigesters">number of digesters on plant</param>
    private void set_params_to_default(/*biogas.plant myPlant*/int numDigesters)
    { 
      // for each digester
      for (int idigester = 0; idigester < numDigesters; idigester++)
      {
        pH_min.Add(6);
        pH_max.Add(9);
        pH_optimum.Add(7.5);

        TS_max.Add(12); // [% FM]

        VFA_TAC_min.Add(0.0);   // [gHAcEq / gCaCO3]
        VFA_TAC_max.Add(0.3);   // [gHAcEq / gCaCO3]

        VFA_min.Add(0);         // [gHAcEq]
        VFA_max.Add(5);         // [gHAcEq]

        TAC_min.Add(5);         // [gCaCO3]

        HRT_min.Add(20);        // [d]
        HRT_max.Add(150);       // [d]

        OLR_max.Add(4);         // [kgVS / (m^3 * d)]

        Snh4_max.Add(3);        // [g/l]
        Snh3_max.Add(80e-3);     // [g/l]

        AcVsPro_min.Add(2);     // [mol/mol]
      }

      // andere Parameter werden in fitness_params_properties.cs auf default Werte
      // gesetzt
    }



  }
}


