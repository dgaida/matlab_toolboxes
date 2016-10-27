/**
 * This file defines the class TKN_sensor.
 * 
 * TODOs:
 * - improve documentation a bit
 * 
 * Except for that FINISHED!
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
  /// Sensor measuring the total Kjehldahl nitrogen
  /// </summary>
  public class TKN_sensor : biogas.sensor
  {

    // -------------------------------------------------------------------------------------
    //                              !!! CONSTRUCTOR METHODS !!!
    // -------------------------------------------------------------------------------------
    
    /// <summary>
    /// Standard Constructor creating the sensor. Its id is TKN.
    /// id_suffix is here the digester ID in which the TKN is measured, followed by 2 or 3,
    /// defining in respectively out.
    /// </summary>
    /// <param name="id_suffix"></param>
    public TKN_sensor(string id_suffix) :
      base( String.Format("{0}_{1}", _spec, id_suffix),
            String.Format("TKN sensor {0}", id_suffix), id_suffix)
    {
      // type
      _type = 5;
    }

    /// <summary>
    /// Constructor called by the constructor of biogas.sensors while 
    /// reading the sensors out of a XML file. So reader must be at the correct position, 
    /// which is &lt;sensor&gt; was just read. 
    /// </summary>
    /// <param name="reader"></param>
    /// <param name="id">id of sensor</param>
    public TKN_sensor(ref XmlTextReader reader, string id) : 
      base(ref reader, id)
    {
      // type
      _type = 5;
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
    static public string _spec = "TKN";



    // -------------------------------------------------------------------------------------
    //                            !!! PROTECTED METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// not implemented
    /// </summary>
    /// <param name="x"></param>
    /// <param name="par"></param>
    /// <returns></returns>
    override protected physValue[] doMeasurement(double[] x, params double[] par)
    {
      throw new exception("Not implemented!");
    }

    /// <summary>
    /// Measure TKN content inside a digester
    /// 
    /// type 5
    /// </summary>
    /// <param name="myPlant"></param>
    /// <param name="x">ADM state vector</param>
    /// <param name="param">not used - but OK</param>
    /// <param name="par">not used</param>
    /// <returns></returns>
    override protected physValue[] doMeasurement(biogas.plant myPlant, double[] x, 
                                                 string param, params double[] par)
    {
      physValue[] values= new physValue[1];

      //
      // -2 wegen _2 bzw. _3
      string digester_id = id.Substring(("TKN_").Length, id.Length - 2 - ("TKN_").Length);

      // kmol N/m^3
      double TKN = ADMstate.calcTKN(x, digester_id, myPlant);

      //
      // erstmal N nennen, damit convertUnit funktioniert
      values[0] = new physValue("N", TKN, "mol/l", "total Kjehldahl nitrogen");
      values[0] = values[0].convertUnit("g/l");
      values[0].Symbol= "TKN";

      //

      return values;
    }



  }
}


