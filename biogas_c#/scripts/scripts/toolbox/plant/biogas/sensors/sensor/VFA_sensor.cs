/**
 * This file defines the class VFA_sensor.
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
  /// Sensor measuring the VFA in gHAceq/l
  /// </summary>
  public class VFA_sensor : biogas.sensor
  {

    // -------------------------------------------------------------------------------------
    //                              !!! CONSTRUCTOR METHODS !!!
    // -------------------------------------------------------------------------------------
    
    /// <summary>
    /// Standard Constructor creating the sensor. Its id is VFA.
    /// id_suffix is here the digester ID in which the VFA is measured, followed by 2 or 3,
    /// defining in respectively out.
    /// </summary>
    /// <param name="id_suffix"></param>
    public VFA_sensor(string id_suffix) : 
      base( String.Format("{0}_{1}", _spec, id_suffix),
            String.Format("VFA sensor {0}", id_suffix), id_suffix )
    { 
      
    }

    /// <summary>
    /// Constructor called by the constructor of biogas.sensors while 
    /// reading the sensors out of a XML file. So reader must be at the correct position, 
    /// which is &lt;sensor&gt; was just read. 
    /// </summary>
    /// <param name="reader"></param>
    /// <param name="id">id of sensor</param>
    public VFA_sensor(ref XmlTextReader reader, string id) : 
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
    static public string _spec = "VFA";



    // -------------------------------------------------------------------------------------
    //                            !!! PROTECTED METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// Measures volatile fatty acid concentration in digester
    /// 
    /// type 0
    /// </summary>
    /// <param name="x">ADM state vector</param>
    /// <param name="par">not used</param>
    /// <returns>volatile fatty acid concentration in gHAceq/l</returns>
    override protected physValue[] doMeasurement(double[] x, params double[] par)
    { 
      physValue[] values= new physValue[1];

      values[0]= ADMstate.calcVFAOfADMstate(x, "gHAceq/l");

      values[0].Symbol = "Svfa";

      return values;
    }



  }
}


