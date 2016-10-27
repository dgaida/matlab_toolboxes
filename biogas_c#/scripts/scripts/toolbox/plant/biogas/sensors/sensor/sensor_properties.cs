/**
 * This file is part of the partial class sensor and defines
 * all private fields and properties.
 * 
 * TODOs:
 * - maybe make a physValue out of time vector, but not important
 * - da sensor mehrdimensionale Daten messen kann, sollten alle skalaren größen
 *   als listen bzw. vektoren definiert werden. bspw. noise_level, apply_real_sensor, 
 *   y_min, ... muss dann auch entsprechend in xml datei gespeichert werden, wird jetzt in
 *   sensor_config gemacht
 * 
 * Except for that FINISHED!
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
  /// abstract class defining a sensor
  /// 
  /// A sensor can measure one or more physValues over time. To identify a 
  /// sensor it has an id and a id_suffix which indicates the location of the
  /// sensor. To measure a value use one of the measure methods. To get 
  /// a measured value at a given time use one of the getMeasurement methods. 
  /// </summary>
  public abstract partial class sensor
  {

    // -------------------------------------------------------------------------------------
    //                            !!! PRIVATE FIELDS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// identical identifier (id) of the sensor
    /// e.g.: HRT, Snh3, Snh4, ...
    /// plus id_suffix, thus id: spec + _ + id_suffix
    /// </summary>
    private string _id= "";

    /// <summary>
    /// id_suffix of the sensor, usually the id of the digester 
    /// where the sensor is located, additionally in and out if necessary
    /// if we measure stuff for the substrate mix use: "substratemix"
    /// for a stream sensor: "substratemix_2"
    /// if we measure stuff for the final storage tank use: "storagetank"
    /// for a stream sensor: "storagetank_2"
    /// could also be the id of a substrate, if a substrate parameter
    /// is measured
    /// </summary>
    private string _id_suffix= "";

    /// <summary>
    /// arbitrary descriptive name of the sensor
    /// </summary>
    private string _name= "";

    /// <summary>
    /// time vector of the measurements, time is measured in days
    /// 
    /// TODO: maybe make a physValue out of this, but not important
    /// </summary>
    private List<double> time= new List<double>();

    /// <summary>
    /// the measurement values. A sensor can measure more than only one value at the same time.
    /// But all measurements in the vector are measured at the same time.
    /// </summary>
    private List<physValue[]> values= new List<physValue[]>();

    /// <summary>
    /// the noisy easurement values. A sensor can measure more than only one value at the same time.
    /// But all measurements in the vector are measured at the same time.
    /// if no real sensor is used, then values are the same as in values
    /// </summary>
    private List<physValue[]> values_noise = new List<physValue[]>();
    
    /// <summary>
    /// sensor configuration needed for real measurements with noise, drift, etc.
    /// </summary>
    private sensor_config[] myConfigs;

    /// <summary>
    /// dimension of the sensor, could also be >= 1, dimension of values
    /// </summary>
    private int _dimension = 1;



    // -------------------------------------------------------------------------------------
    //                        !!! PROTECTED FIELDS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// defines which doMeasurement method this sensor uses
    /// </summary>
    protected int _type = 0;

    //protected List<physValue[]> valuesP
    //{
    //  get { return values; }
    //}

    

    // -------------------------------------------------------------------------------------
    //                              !!! PROPERTIES !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// defines specification of sensor
    /// geht nicht static
    /// e.g.: HRT, Snh3, Snh4, ...
    /// </summary>
    abstract public string spec{ get; }

    /// <summary>
    /// identical identifier (id) of the sensor
    /// e.g.: HRT, Snh3, Snh4, ...
    /// plus id_suffix, thus id: spec + _ + id_suffix
    /// </summary>
    public string id
    {
      get { return _id; }
    }

    /// <summary>
    /// id_suffix of the sensor, usually the id of the digester 
    /// where the sensor is located, additionally in and out if necessary
    /// if we measure stuff for the substrate mix use: "substratemix"
    /// for a stream sensor: "substratemix_2"
    /// if we measure stuff for the final storage tank use: "storagetank"
    /// for a stream sensor: "storagetank_2"
    /// could also be the id of a substrate, if a substrate parameter
    /// is measured
    /// </summary>
    public string id_suffix
    {
      get { return _id_suffix; }
    }

    /// <summary>
    /// arbitrary descriptive name of the sensor
    /// </summary>
    public string name
    {
      get { return _name; }
    }

    /// <summary>
    /// dimension of the sensor, could also be >= 1, dimension of values
    /// </summary>
    public int dimension
    {
      get { return _dimension; }
    }

    /// <summary>
    /// defines which doMeasurement method this sensor uses
    /// </summary>
    public int type
    {
      get { return _type; }
    }
    


  }
}


