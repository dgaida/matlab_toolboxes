/**
 * This file defines the class energyProduction_sensor.
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
  /// Sensor measuring the produced energy (heat and electricity) at a chp
  /// 
  /// sensor is called by chps.run()
  /// </summary>
  public class energyProduction_sensor : biogas.sensor
  {

    // -------------------------------------------------------------------------------------
    //                              !!! CONSTRUCTOR METHODS !!!
    // -------------------------------------------------------------------------------------
    
    /// <summary>
    /// Standard Constructor creating the sensor. Its id is energyProduction.
    /// id_suffix is here the chp ID in which the energy is produced.
    /// </summary>
    /// <param name="id_suffix">chp ID</param>
    public energyProduction_sensor(string id_suffix) :
      base( String.Format("{0}_{1}", _spec, id_suffix),
            String.Format("energyProduction sensor {0}", id_suffix), id_suffix, 2)
    {
      // es werden zwei energieformen (wärme + Strom) betrachtet
      //dimension= 2;

      // TODO
      // type= ?
      _type = 95;
    }

    /// <summary>
    /// Constructor called by the constructor of biogas.sensors while 
    /// reading the sensors out of a XML file. So reader must be at the correct position, 
    /// which is &lt;sensor&gt; was just read. 
    /// </summary>
    /// <param name="reader"></param>
    /// <param name="id">id of sensor</param>
    public energyProduction_sensor(ref XmlTextReader reader, string id) : 
      base(ref reader, id, 2)
    {
      // es werden zwei energieformen (wärme + Strom) betrachtet
      //dimension = 2;

      // TODO
      // type= ?
      _type = 95;
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
    static public string _spec = "energyProduction";



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
    /// measures electrical and thermal energy produced by chp in kWh/d
    /// 
    /// type: 5
    /// </summary>
    /// <param name="myPlant"></param>
    /// <param name="u">biogas stream going through given chp</param>
    /// <param name="param">not used</param>
    /// <param name="par">not used</param>
    /// <returns>measured el. and thermal energy produced</returns>
    override protected physValue[] doMeasurement(biogas.plant myPlant,
                                                 double[] u, string param, 
                                                 params double[] par)
    {
      // wegen 2 siehe oben
      physValue[] values= new physValue[dimension];

      myPlant.burnBiogas(id_suffix, u, out values[0], out values[1]);
            
      return values;
    }



  }
}


