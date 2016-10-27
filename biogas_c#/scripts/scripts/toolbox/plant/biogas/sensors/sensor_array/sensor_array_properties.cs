/**
 * This file defines the class sensor_array.
 * 
 * TODOs:
 * - only Q sensors are possible for sensor_arrays
 * 
 * Should be FINISHED!
 * 
 */

using System;
using System.Collections.Generic;
using System.Text;
using System.Xml;
using science;
using biogas;
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
 * - Sensors
 * 
 */
namespace biogas
{
  /// <summary>
  /// an array of sensors
  /// </summary>
  public partial class sensor_array : List<biogas.sensor>
  {

    // -------------------------------------------------------------------------------------
    //                            !!! PRIVATE FIELDS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// id of the sensor array
    /// </summary>
    private string _id= "";



    // -------------------------------------------------------------------------------------
    //                              !!! PROPERTIES !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// id of the sensor array
    /// </summary>
    public string id
    {
      get { return _id; }
    }



  }

}


