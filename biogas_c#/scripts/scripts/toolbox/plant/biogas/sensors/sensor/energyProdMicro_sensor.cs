/**
 * This file defines the class energyProdMicro_sensor.
 * 
 * TODOs:
 * - clearly depeds on ADM1
 * 
 * should be FINISHED!
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
  /// Sensor measuring the heat energy produced by micro organisms for a digester
  /// 
  /// </summary>
  public class energyProdMicro_sensor : biogas.sensor
  {

    // -------------------------------------------------------------------------------------
    //                              !!! CONSTRUCTOR METHODS !!!
    // -------------------------------------------------------------------------------------
    
    /// <summary>
    /// Standard Constructor creating the sensor. Its id is energyProdMicro.
    /// id_suffix is here the digester ID in which the heat energy is measured.
    /// </summary>
    /// <param name="id_suffix"></param>
    public energyProdMicro_sensor(string id_suffix) :
      base(String.Format("{0}_{1}", _spec, id_suffix),
            String.Format("Energy Production Microorganisms sensor {0}", id_suffix), id_suffix)
    {
      // TODO
      _type = 77;  // 
    }

    /// <summary>
    /// Constructor called by the constructor of biogas.sensors while 
    /// reading the sensors out of a XML file. So reader must be at the correct position, 
    /// which is &lt;sensor&gt; was just read. 
    /// </summary>
    /// <param name="reader"></param>
    /// <param name="id">id of sensor</param>
    public energyProdMicro_sensor(ref XmlTextReader reader, string id) : 
      base(ref reader, id)
    {
      // TODO
      _type = 77;  // 
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
    static public string _spec = "energyProdMicro";



    // -------------------------------------------------------------------------------------
    //                            !!! PROTECTED METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// Calculates the heat energy produced by bacteria inside the digester measured in kWh/d
    /// 
    /// nicht type 0 und auch nicht type 1, da x ist vektor aus ADM1 beschreibend die reaktions
    /// raten p oder rho genannt
    /// </summary>
    /// <param name="p">ADM reaction rates vector</param>
    /// <param name="par">volume of the digester in m^3</param>
    /// <returns>measured energy in kWh/d</returns>
    override protected physValue[] doMeasurement(double[] p, params double[] par)
    { 
      physValue[] values= new physValue[dimension];

      if (par.Length != 1)
      {
        throw new exception(String.Format(
        "Length of params is != 1: {0}!", par.Length));
      }

      double Vliq= par[0];

      values[0] = new physValue("Pprodmic", 
                  ADMstate.calcProdEnergyOfMicroOrganisms(p, Vliq), "kWh/d", 
                  "thermal energy prod. of microorganisms");

      return values;
    }



  }
}


