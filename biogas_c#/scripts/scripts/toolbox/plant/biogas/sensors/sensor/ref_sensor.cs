/**
 * This file defines the class ref_sensor.
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
  /// Sensor used for setpoint control
  /// saves the reference values
  /// </summary>
  public class ref_sensor : biogas.sensor
  {

    // -------------------------------------------------------------------------------------
    //                              !!! CONSTRUCTOR METHODS !!!
    // -------------------------------------------------------------------------------------
    
    /// <summary>
    /// Standard Constructor creating the sensor. Its id is ref.
    /// id_suffix is here the spec of the referenced sensor (or the sensor_id, both are possible), 
    /// followed by _index in sensor
    /// </summary>
    /// <param name="id_suffix">digester ID</param>
    public ref_sensor(string id_suffix) : 
      base( String.Format("{0}_{1}", _spec, id_suffix),
            String.Format("ref sensor {0}", id_suffix), id_suffix, 1 )
    {
      // type
      _type = 588;
    }

    /// <summary>
    /// Constructor called by the constructor of biogas.sensors while 
    /// reading the sensors out of a XML file. So reader must be at the correct position, 
    /// which is &lt;sensor&gt; was just read. 
    /// </summary>
    /// <param name="reader"></param>
    /// <param name="id">id of sensor</param>
    public ref_sensor(ref XmlTextReader reader, string id) : 
      base(ref reader, id, 1)
    {
      // type
      _type = 588;

      // should never be called, maybe call exception
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
    static public string _spec = "ref";



    // -------------------------------------------------------------------------------------
    //                            !!! PROTECTED METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// not implemented
    /// </summary>
    /// <param name="x">one dimensional vector with reference value</param>
    /// <param name="par"></param>
    /// <returns></returns>
    override protected physValue[] doMeasurement(double[] x, params double[] par)
    {
      physValue[] values = new physValue[dimension];

      // TODO
      // I do not know the unit
      values[0] = new physValue("ref", x[0], "-");

      return values;
    }

    

  }
}


