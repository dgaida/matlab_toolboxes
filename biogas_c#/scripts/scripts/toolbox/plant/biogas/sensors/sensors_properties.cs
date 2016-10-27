/**
 * This file is part of the partial class sensors and defines
 * the private fields and properties of the class.
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
using System.Xml;
using System.IO;
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
  /// List of sensors
  /// 
  /// is a list of sensors. The ids of the sensors inside this list
  /// are also saved inside the list ids. Next to sensors
  /// it also can contain sensor_arrays, which are an array of sensors.
  /// Sensors are grouped in different groups, dependent on the measure call syntax
  /// they have (those are the types: 0, 1, 2, ...).
  /// </summary>
  public partial class sensors : List<sensor>
  {

    // -------------------------------------------------------------------------------------
    //                            !!! PRIVATE FIELDS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// list with the sensor ids
    /// </summary>
    private List<string> _ids= new List<string>();

    /// <summary>
    /// list with sensor arrays
    /// </summary>
    private List<sensor_array> array= new List<sensor_array>();

    /// <summary>
    /// list with the sensor ids who use the 0st doMeasurement method:
    /// doMeasurement(double[] x) //, params double[] par)
    /// 
    /// Examples: Sva_sensor, VFA_sensor, ...
    /// </summary>
    private List<string> ids_type0 = new List<string>();

    /// <summary>
    /// list with the sensor ids who use the 1st doMeasurement method:
    /// doMeasurement(double[] x, params double[] par)
    /// 
    /// Example: HRT_sensor
    /// </summary>
    private List<string> ids_type1 = new List<string>();



    /// <summary>
    /// list with the sensor ids who use the 7th doMeasurement method:
    /// doMeasurement(double[] x, biogas.plant myPlant,
    ///               biogas.substrates mySubstrates,
    ///               biogas.sensors mySensors, 
    ///               double[] Q, params double[] par)
    ///               
    /// Example: TS_sensor, OLR_sensor
    /// </summary>
    private List<string> ids_type7 = new List<string>();

    /// <summary>
    /// list with the sensor ids who use the 8th doMeasurement method:
    ///               
    /// Example: many fitness sensors
    /// </summary>
    private List<string> ids_type8 = new List<string>();



    /// <summary>
    /// sampling time of all sensors, measured in days
    /// default: 12 hours
    /// </summary>
    private double _sampling_time= 12.0/24.0;



    // -------------------------------------------------------------------------------------
    //                        !!! PROTECTED STATIC FIELDS !!!
    // -------------------------------------------------------------------------------------

    

    // -------------------------------------------------------------------------------------
    //                        !!! PUBLIC STATIC FIELDS !!!
    // -------------------------------------------------------------------------------------



    // -------------------------------------------------------------------------------------
    //                              !!! PROPERTIES !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// id of the sensor
    /// </summary>
    public List<string> ids
    {
      get { return _ids; }
    }

    /// <summary>
    /// return ids, such that MATLAB can use them
    /// </summary>
    /// <returns>ids as array</returns>
    public string[] getIDs()
    {
      return _ids.ToArray();
    }



    /// <summary>
    /// sampling time of all sensors, measured in days
    /// </summary>
    public double sampling_time
    {
      get { return _sampling_time; }
      set { _sampling_time= value; }
    }



  }
}


