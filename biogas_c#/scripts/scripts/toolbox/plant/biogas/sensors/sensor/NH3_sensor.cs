/**
 * This file defines the class NH3_sensor.
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
  /// Sensor measuring the NH3 in g/l
  /// </summary>
  public class NH3_sensor : biogas.sensor
  {

    // -------------------------------------------------------------------------------------
    //                              !!! CONSTRUCTOR METHODS !!!
    // -------------------------------------------------------------------------------------
    
    /// <summary>
    /// Standard Constructor creating the sensor. Its id is NH3.
    /// id_suffix is here the digester ID in which the NH3 is measured, followed by 2 or 3,
    /// defining in respectively out.
    /// </summary>
    /// <param name="id_suffix">digester ID</param>
    public NH3_sensor(string id_suffix) : 
      base( String.Format("{0}_{1}", _spec, id_suffix),
            String.Format("Snh3 sensor {0}", id_suffix), id_suffix, 2 )
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
    public NH3_sensor(ref XmlTextReader reader, string id) : 
      base(ref reader, id, 2)
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
    static public string _spec = "Snh3";



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
    /// Measure NH3 content inside a digester
    /// 1st measurement is Snh3 in g/l
    /// 2nd : Snh3 + NH3 in Xc in g/l
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
      physValue[] values = new physValue[dimension];

      // ammonia
      values[0]= ADMstate.calcFromADMstate(x, "Snh3", "g/l");

      //
      // -2 wegen _2 bzw. _3
      string digester_id = id.Substring(("Snh3_").Length, id.Length - 2 - ("Snh3_").Length);

      // kmol N/m^3
      double NH3 = ADMstate.calcNH3(x, digester_id, myPlant);

      //
      // erstmal Snh3 nennen, damit convertUnit funktioniert
      // ammonia nitrogen, umrechnungsfaktor 14
      values[1] = new physValue("N", NH3, "mol/l", "total ammonia nitrogen");
      values[1] = values[1].convertUnit("g/l");
      values[1].Symbol = "NH3";

      return values;
    }



  }
}


