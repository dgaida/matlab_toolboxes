/**
 * This file defines the class energyProdSum_sensor.
 * 
 * TODOs:
 * - 
 * 
 * Apart from that FINISHED!
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
 * 
 */
namespace biogas
{

  /// <summary>
  /// Sensor measuring the energyProdSum in kWh/d
  /// measures total produced electrical and thermal energy on plant
  /// </summary>
  public class energyProdSum_sensor : biogas.sensor
  {

    // -------------------------------------------------------------------------------------
    //                              !!! CONSTRUCTOR METHODS !!!
    // -------------------------------------------------------------------------------------
    
    /// <summary>
    /// Standard Constructor creating the sensor. Its id is energyProdSum.
    /// </summary>
    public energyProdSum_sensor() : 
      base( _spec, "energyProdSum sensor", "", 2 )
    {
      // type
      _type = 543;
    }

    /// <summary>
    /// Constructor called by the constructor of biogas.sensors while 
    /// reading the sensors out of a XML file. So reader must be at the correct position, 
    /// which is &lt;sensor&gt; was just read. 
    /// </summary>
    /// <param name="reader"></param>
    /// <param name="id">id of sensor</param>
    public energyProdSum_sensor(ref XmlTextReader reader, string id) : 
      base(ref reader, id, 2)
    {
      // type
      _type = 543;
    }



    // -------------------------------------------------------------------------------------
    //                              !!! PROPERTIES !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// defines specification of sensor
    /// </summary>
    override public string spec { get { return _spec; } }

    /// <summary>
    /// defines specification of sensor
    /// </summary>
    static public string _spec = "energyProdSum";



    // -------------------------------------------------------------------------------------
    //                            !!! PROTECTED METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// 
    /// </summary>
    /// <param name="x">first component el. energy production in kWh/d
    /// 2nd component thermal energy production in kWh/d</param>
    /// <param name="par"></param>
    /// <returns></returns>
    override protected physValue[] doMeasurement(double[] x, params double[] par)
    {
      physValue[] values = new physValue[dimension];

      values[0] = new physValue("Pel_sum", x[0], "kWh/d", "Total el. energy production");
      values[1] = new physValue("Pth_sum", x[1], "kWh/d", "Total th. energy production");

      return values;
    }



  }
}


