/**
 * This file defines the class HRT_sensor.
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
  /// Sensor measuring the hydraulic retention time for a digester
  /// 
  /// see also: SRT_sensor (not yet implemented)
  /// </summary>
  public class HRT_sensor : biogas.sensor
  {

    // -------------------------------------------------------------------------------------
    //                              !!! CONSTRUCTOR METHODS !!!
    // -------------------------------------------------------------------------------------
    
    /// <summary>
    /// Standard Constructor creating the sensor. Its id is HRT.
    /// id_suffix is here the digester ID in which the HRT is measured.
    /// </summary>
    /// <param name="id_suffix"></param>
    public HRT_sensor(string id_suffix) :
      base( String.Format("{0}_{1}", _spec, id_suffix),
            String.Format("HRT sensor {0}", id_suffix), id_suffix )
    {
      // TODO
      _type = 1;  // evtl. in type 0 umbenennen, da bis auf params identisch. 
      // s. auch measureInStream methode in sensors_measure.cs
    }

    /// <summary>
    /// Constructor called by the constructor of biogas.sensors while 
    /// reading the sensors out of a XML file. So reader must be at the correct position, 
    /// which is &lt;sensor&gt; was just read. 
    /// </summary>
    /// <param name="reader"></param>
    /// <param name="id">id of sensor</param>
    public HRT_sensor(ref XmlTextReader reader, string id) : 
      base(ref reader, id)
    {
      // TODO
      _type = 1;  // evtl. in type 0 umbenennen, da bis auf params identisch. 
      // s. auch measureInStream methode in sensors_measure.cs
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
    static public string _spec = "HRT";



    // -------------------------------------------------------------------------------------
    //                            !!! PROTECTED METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// Calculates hydraulic retention time of the digester measured in days
    /// 
    /// type 0 aktuell type 1
    /// </summary>
    /// <param name="x">ADM state vector</param>
    /// <param name="par">volume of the digester in m^3</param>
    /// <returns>measured HRT in days</returns>
    override protected physValue[] doMeasurement(double[] x, params double[] par)
    { 
      physValue[] values= new physValue[dimension];

      if (par.Length != 1)
      {
        throw new exception(String.Format(
        "Length of params is != 1: {0}!", par.Length));
      }

      double Vliq= par[0];

      values[0]= ADMstate.calcHRTOfADMstate(x, Vliq);

      return values;
    }



  }
}


