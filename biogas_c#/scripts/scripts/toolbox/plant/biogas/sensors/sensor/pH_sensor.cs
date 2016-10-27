/**
 * This file defines the class pH_sensor.
 * 
 * TODOs:
 * - depends on internal variables of ADM
 * 
 * Therefore actually not FINISHED!
 * 
 */

using System;
using System.Collections.Generic;
using System.Text;
using System.Xml;
using science;
using biogas;

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
  /// Sensor measuring the pH
  /// </summary>
  public class pH_sensor : biogas.sensor
  {

    // -------------------------------------------------------------------------------------
    //                              !!! CONSTRUCTOR METHODS !!!
    // -------------------------------------------------------------------------------------
    
    /// <summary>
    /// Standard Constructor creating the sensor. Its id is pH.
    /// id_suffix is here the digester ID in which the pH is measured, followed by 2 or 3,
    /// defining in respectively out.
    /// </summary>
    /// <param name="id_suffix"></param>
    public pH_sensor(string id_suffix) :
      base( String.Format("{0}_{1}", _spec, id_suffix),
            String.Format("pH sensor {0}", id_suffix), id_suffix )
    {
      // TODO
      // type= ?
      _type = 91;
    }

    /// <summary>
    /// Constructor called by the constructor of biogas.sensors while 
    /// reading the sensors out of a XML file. So reader must be at the correct position, 
    /// which is &lt;sensor&gt; was just read. 
    /// </summary>
    /// <param name="reader"></param>
    /// <param name="id">id of sensor</param>
    public pH_sensor(ref XmlTextReader reader, string id) : 
      base(ref reader, id)
    {
      // TODO
      // type= ?
      _type = 91;
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
    static public string _spec = "pH";



    // -------------------------------------------------------------------------------------
    //                            !!! PROTECTED METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// measures pH value inside given digester
    /// </summary>
    /// <param name="x">ADM1 internal variables ohne 3dim biogas vektor am anfang</param>
    /// <param name="par">not used</param>
    /// <returns>pH value inside digester</returns>
    override protected physValue[] doMeasurement(double[] x, params double[] par)
    { 
      physValue[] values= new physValue[1];

      // hydrogen (H+) concentration is the 20th variable, start counting at 1
      if (x[19] > 0)
        values[0]= new physValue("pH", -Math.Log10(x[19]), "-");
      else
        values[0]= new physValue("pH", 0, "-");

      return values;
    }



  }
}


