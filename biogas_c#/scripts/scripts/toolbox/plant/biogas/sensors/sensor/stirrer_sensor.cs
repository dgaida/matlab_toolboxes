/**
 * This file defines the class stirrer_sensor.
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
  /// Sensor measuring the electrical power needed for all stirrer in a digester
  /// </summary>
  public class stirrer_sensor : biogas.sensor
  {

    // -------------------------------------------------------------------------------------
    //                              !!! CONSTRUCTOR METHODS !!!
    // -------------------------------------------------------------------------------------
    
    /// <summary>
    /// Standard Constructor creating the sensor. Its id is stirrer.
    /// id_suffix is here the digester ID in which the stirrer exist.
    /// </summary>
    /// <param name="id_suffix"></param>
    public stirrer_sensor(string id_suffix) :
      base(String.Format("{0}_{1}", _spec, id_suffix),
            String.Format("stirrer sensor {0}", id_suffix), id_suffix, 2)
    {
      //dimension= 2;

      // OK
      _type = 7;
    }

    /// <summary>
    /// Constructor called by the constructor of biogas.sensors while 
    /// reading the sensors out of a XML file. So reader must be at the correct position, 
    /// which is &lt;sensor&gt; was just read. 
    /// </summary>
    /// <param name="reader"></param>
    /// <param name="id">id of sensor</param>
    public stirrer_sensor(ref XmlTextReader reader, string id) : 
      base(ref reader, id, 2)
    {
      //dimension = 2;

      // OK
      _type = 7;
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
    static public string _spec = "stirrer";



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
    /// type 7
    /// 
    /// called in ADMstate_stoichiometry.cs -> measure_type7
    /// </summary>
    /// <param name="x">ADM state vector - not used</param>
    /// <param name="myPlant"></param>
    /// <param name="mySubstrates">not yet used</param>
    /// <param name="mySensors">used to get TS inside digester</param>
    /// <param name="Q">not used</param>
    /// <param name="par">not used</param>
    /// <returns>measured values</returns>
    override protected physValue[] doMeasurement(double[] x, biogas.plant myPlant,
                                                biogas.substrates mySubstrates,
                                                biogas.sensors mySensors,
                                                double[] Q, params double[] par)
    {
      // 1st Pel in kWh/d for mixing digester
      // 2nd Pdissipated in kWh/d for mixing digester, dissipated in digester
      physValue[] values= new physValue[dimension];

      //

      digester myDigester= myPlant.getDigesterByID(id_suffix);

      // calc stirrer(s) power for digester in kWh/d
      values[0]= myDigester.calcStirrerPower(mySensors);

      // calc stirrer(s) power dissipated to digester in kWh/d
      values[1] = myDigester.calcStirrerDissipation(mySensors);

      values[0].Label = "electrical energy of stirrer";
      values[1].Label = "thermal energy dissipated by stirrer";

      //

      return values;
    }



  }
}


