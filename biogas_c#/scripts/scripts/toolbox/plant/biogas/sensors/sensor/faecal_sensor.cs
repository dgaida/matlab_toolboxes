/**
 * This file defines the class faecal_sensor.
 * 
 * TODOs:
 * - to be tested
 * 
 * otherwise FINISHED!
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
  /// Sensor measuring the faecal bacteria removal capacity for a digester
  /// 
  /// - intestinal enterococci
  /// - faecal coliforms
  /// </summary>
  public class faecal_sensor : biogas.sensor
  {

    // -------------------------------------------------------------------------------------
    //                              !!! CONSTRUCTOR METHODS !!!
    // -------------------------------------------------------------------------------------
    
    /// <summary>
    /// Standard Constructor creating the sensor. Its id is faecal.
    /// id_suffix is here the digester ID in which the faecal is measured.
    /// </summary>
    /// <param name="id_suffix"></param>
    public faecal_sensor(string id_suffix) :
      base( String.Format("{0}_{1}", _spec, id_suffix),
            String.Format("faecal sensor {0}", id_suffix), id_suffix, 2 )
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
    public faecal_sensor(ref XmlTextReader reader, string id) : 
      base(ref reader, id, 2)
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
    static public string _spec = "faecal";



    // -------------------------------------------------------------------------------------
    //                            !!! PROTECTED METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// Calculates faecal bacteria removal capacity of the digester, measured in %
    /// 
    /// type 0 aktuell type 1
    /// </summary>
    /// <param name="x">ADM state vector</param>
    /// <param name="par">HRT of the digester in m^3, temperature inside the digester in °C</param>
    /// <returns>measured faecal bacteria removal capacity in %</returns>
    override protected physValue[] doMeasurement(double[] x, params double[] par)
    { 
      physValue[] values= new physValue[dimension];

      if (par.Length != 2)
      {
        throw new exception(String.Format(
        "Length of params is != 2: {0}!", par.Length));
      }

      double HRT= par[0];
      double T = par[1];

      if (HRT == 0)
        throw new exception("HRT == 0");

      // intestinal enterococci
      values[0]= new physValue("eta_IE", 98.29 - 2.2 * Math.Pow(1 / HRT, 2) + 0.031 * T, "%");
      // faecal coliforms
      values[1] = new physValue("eta_FC", 98.29 - 1.0 * Math.Pow(1 / HRT, 2) + 0.031 * T, "%");

      return values;
    }



  }
}


