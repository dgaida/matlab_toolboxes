/**
 * This file defines the class pH_stream_sensor.
 * 
 * TODOs:
 * - habe id pH auf pH_stream geändert, gibt sonst konflikt mit
 * pH_sensor. wenn ich pH_sensor mal lösche, dann wieder umbenennen in pH
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
  /// Sensor measuring the pH inside the ADM stream
  /// </summary>
  public class pH_stream_sensor : biogas.sensor
  {

    // -------------------------------------------------------------------------------------
    //                              !!! CONSTRUCTOR METHODS !!!
    // -------------------------------------------------------------------------------------
    
    /// <summary>
    /// Standard Constructor creating the sensor. Its id is pH_stream.
    /// id_suffix is here the digester ID in which the pH_stream is measured, 
    /// followed by 2 or 3, defining in respectively out.
    /// </summary>
    /// <param name="id_suffix"></param>
    public pH_stream_sensor(string id_suffix) :
      base( String.Format("{0}_{1}", _spec, id_suffix),
            String.Format("pH sensor {0}", id_suffix), id_suffix )
    { 
      
    }

    /// <summary>
    /// Constructor called by the constructor of biogas.sensors while 
    /// reading the sensors out of a XML file. So reader must be at the correct position, 
    /// which is &lt;sensor&gt; was just read. 
    /// </summary>
    /// <param name="reader"></param>
    /// <param name="id">id of sensor</param>
    public pH_stream_sensor(ref XmlTextReader reader, string id) : 
      base(ref reader, id)
    {
      
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
    static public string _spec = "pH_stream";



    // -------------------------------------------------------------------------------------
    //                            !!! PROTECTED METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// measures pH value inside ADM stream
    /// 
    /// type 0
    /// </summary>
    /// <param name="x">ADM state vector, could be 37 or 34 dim.</param>
    /// <param name="par">not used</param>
    /// <returns>pH value inside ADM stream</returns>
    override protected physValue[] doMeasurement(double[] x, params double[] par)
    { 
      physValue[] values= new physValue[1];

      biogas.ADMstate.calcPHOfADMstate(x, out values[0]);
      
      return values;
    }



  }
}


