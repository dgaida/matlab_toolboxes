/**
 * This file defines the class inhibition_sensor.
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
  /// Sensor measuring inhibition terms
  /// </summary>
  public class inhibition_sensor : biogas.sensor
  {

    // -------------------------------------------------------------------------------------
    //                              !!! CONSTRUCTOR METHODS !!!
    // -------------------------------------------------------------------------------------
    
    /// <summary>
    /// Standard Constructor creating the sensor. Its id is inhibition.
    /// id_suffix is here the digester ID in which the inhibition is measured.
    /// </summary>
    /// <param name="id_suffix"></param>
    public inhibition_sensor(string id_suffix) :
      base( String.Format("{0}_{1}", _spec, id_suffix),
            String.Format("inhibition sensor {0}", id_suffix), id_suffix, 8 )
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
    public inhibition_sensor(ref XmlTextReader reader, string id) : 
      base(ref reader, id, 8)
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
    static public string _spec = "inhibition";



    // -------------------------------------------------------------------------------------
    //                            !!! PROTECTED METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// measures inhibition terms of given digester
    /// </summary>
    /// <param name="intvars">3dim biogas vektor danach, ADM1 internal variables</param>
    /// <param name="par">not used</param>
    /// <returns>inhibition inside digester</returns>
    override protected physValue[] doMeasurement(double[] intvars, params double[] par)
    { 
      physValue[] values= new physValue[dimension];

      // pH value inhibition
      values[0] = new physValue("IpH_a",  intvars[27], "100 %", "IpH_a");
      values[1] = new physValue("IpH_h2", intvars[29], "100 %", "IpH_h2");
      values[2] = new physValue("IpH_ac", intvars[31], "100 %", "IpH_ac");
      values[3] = new physValue("IpH",    intvars[27] * intvars[29] * intvars[31], "100 %", "IpH");
      // nitrogen (nh4 + nh3) inhibition
      values[4] = new physValue("Iin",    intvars[23], "100 %", "Iin");
      // nh3 inhibition
      values[5] = new physValue("I_NH3",  intvars[24], "100 %", "I_NH3");
      values[6] = new physValue("Iin * I_NH3", intvars[23] * intvars[24], "100 %", "Iin * I_NH3");
      // hydrogen inhibition
      values[7] = new physValue("I_H2_c4", intvars[25], "100 %", "I_H2_c4");

      return values;
    }



  }
}


