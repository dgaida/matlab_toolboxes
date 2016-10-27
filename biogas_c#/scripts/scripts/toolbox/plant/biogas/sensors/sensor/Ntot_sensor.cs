/**
 * This file defines the class Ntot_sensor.
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
  /// Sensor measuring the total nitrogen
  /// </summary>
  public class Ntot_sensor : biogas.sensor
  {

    // -------------------------------------------------------------------------------------
    //                              !!! CONSTRUCTOR METHODS !!!
    // -------------------------------------------------------------------------------------
    
    /// <summary>
    /// Standard Constructor creating the sensor. Its id is Ntot.
    /// id_suffix is here the digester ID in which the Ntot is measured, followed by 2 or 3,
    /// defining in respectively out.
    /// </summary>
    /// <param name="id_suffix"></param>
    public Ntot_sensor(string id_suffix) :
      base( String.Format("{0}_{1}", _spec, id_suffix),
            String.Format("Ntot sensor {0}", id_suffix), id_suffix)
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
    public Ntot_sensor(ref XmlTextReader reader, string id) : 
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
    static public string _spec = "Ntot";



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
    /// Measure Ntot content inside a digester
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
      // -1 sowieso, -2 wegen _2 bzw. _3
      string digester_id = id.Substring(("Ntot_").Length, id.Length - 2 - ("Ntot_").Length);

      // kmol N/m^3
      double Ntot = ADMstate.calcNtot(x, digester_id, myPlant);

      //
      // erstmal N nennen, damit convertUnit funktioniert
      values[0] = new physValue("N", Ntot, "mol/l", "total nitrogen");
      values[0] = values[0].convertUnit("g/l");
      values[0].Symbol = "Ntot";

      //

      return values;
    }



  }
}


