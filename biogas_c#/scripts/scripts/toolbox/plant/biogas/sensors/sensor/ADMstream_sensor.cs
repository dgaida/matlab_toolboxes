/**
 * This file defines the class ADMstream_sensor.
 * 
 * TODOs:
 * - hängt natürlich auch von implementiertem ADM1 Modell ab
 * 
 * Because of that not FINISHED!
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
  /// Sensor measuring the ADMstream
  /// </summary>
  public class ADMstream_sensor : biogas.sensor
  {

    // -------------------------------------------------------------------------------------
    //                              !!! CONSTRUCTOR METHODS !!!
    // -------------------------------------------------------------------------------------
    
    /// <summary>
    /// Standard Constructor creating the sensor. Its id is ADMstream.
    /// id_suffix is here the digester ID in which the ADMstream is measured
    /// followed by 2 for in- and 3 for output measurement
    /// </summary>
    /// <param name="id_suffix"></param>
    public ADMstream_sensor(string id_suffix) :
      base( String.Format("{0}_{1}", _spec, id_suffix),
            String.Format("ADMstream sensor {0}", id_suffix), id_suffix,
      (int)ADMstate.dim_stream - 1)
    {
      // 
      _type = 0;
    }

    /// <summary>
    /// Constructor called by the constructor of biogas.sensors while 
    /// reading the sensors out of a XML file. So reader must be at the correct position, 
    /// which is &lt;sensor&gt; was just read. 
    /// </summary>
    /// <param name="reader"></param>
    /// <param name="id">id of sensor</param>
    public ADMstream_sensor(ref XmlTextReader reader, string id) :
      base(ref reader, id, (int)ADMstate.dim_stream - 1)
    {
      // 
      _type = 0;
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
    static public string _spec = "ADMstream";



    // -------------------------------------------------------------------------------------
    //                            !!! PROTECTED METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// Measure ADM stream vector in default units of the model
    /// 
    /// is a type 0, because u is the stream vector
    /// </summary>
    /// <param name="u">33 or 34 dim stream vector</param>
    /// <param name="par">not used</param>
    /// <returns>measured ADM stream vector</returns>
    /// <exception cref="exception">u.Length &lt; ADMstate.dim_stream - 1</exception>
    override protected physValue[] doMeasurement(double[] u, params double[] par)
    { 
      physValue[] values= new physValue[dimension];

      if (u.Length < ADMstate.dim_stream - 1)
      {
        throw new exception(String.Format(
                "u has not the correct dimension! is: {0}, must be at least: {1}!", 
                u.Length, ADMstate.dim_stream - 1));
      }

      for (int idim= 0; idim < dimension; idim++)
      {
        values[idim]= new physValue(ADMstate.symADMstate[idim], u[idim],
                                    ADMstate.getUnitOfADMstatevariable(idim + 1));
      }

      return values;
    }



  }
}


