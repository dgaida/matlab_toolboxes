/**
 * This file defines the class pumpEnergy_sensor.
 * 
 * TODOs:
 * - improve documentation
 * 
 * otherwise should be FINISHED!
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
  /// sensor measuring the energy consumption due to transport 
  /// of substrates
  /// </summary>
  public class transportEnergy_sensor : biogas.sensor
  {

    // -------------------------------------------------------------------------------------
    //                              !!! CONSTRUCTOR METHODS !!!
    // -------------------------------------------------------------------------------------
    
    /// <summary>
    /// Standard Constructor creating the sensor. Its id is transportEnergy.
    /// id_suffix is here the combination out of
    /// the two units where the substrates are pumped from and to.
    /// unit_start + "_" + unit_destiny
    /// </summary>
    /// <param name="id_suffix"></param>
    public transportEnergy_sensor(string id_suffix) :
      base(String.Format("{0}_{1}", _spec, id_suffix),
            String.Format("transportEnergy sensor {0}", id_suffix), id_suffix)
    {
      // TODO
      // type= ?
      _type = 80;

      // unit_start is always "substratemix"
    }

    /// <summary>
    /// Constructor called by the constructor of biogas.sensors while 
    /// reading the sensors out of a XML file. So reader must be at the correct position, 
    /// which is &lt;sensor&gt; was just read. 
    /// </summary>
    /// <param name="reader"></param>
    /// <param name="id">id of sensor</param>
    public transportEnergy_sensor(ref XmlTextReader reader, string id) : 
      base(ref reader, id)
    {
      // TODO
      // type= ?
      _type = 80;

      // unit_start is always "substratemix"
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
    static public string _spec = "transportEnergy";



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
    /// aktuell type 4
    /// </summary>
    /// <param name="myPlant"></param>
    /// <param name="u">Qin in m³/d</param>
    /// <param name="par">
    /// par[0] is the density of the substrate in kg/m^3
    /// </param>
    /// <returns></returns>
    override protected physValue[] doMeasurement(biogas.plant myPlant,
                                                 double u, params double[] par)
    {
      // 
      physValue[] values= new physValue[1];

      // 1. komponente ist rho als double, unten in density def. dann anstatt 
      // 1000 einsetzen
      if (par.Length != 1)    // 2, da rho auch übergeben werden muss
      {
        throw new exception(String.Format(
        "Length of par is != 1: {0}!", par.Length));
      }

      transportation myTransportations = myPlant.myTransportation;

      // get pump from transportation class using id
      biogas.substrate_transport mySubsTransport = myTransportations.getSubstrateTransportByID(id_suffix);

      // is the energy_per_ton [kWh/t]
      double energy_per_ton = mySubsTransport.energy_per_ton;

      // calc energy consumption in kWh/d
      // hier muss man schon rho der zu fördernden menge kennen
      values[0] = new physValue("Pel_trans", u * par[0] / 1000 * energy_per_ton, "kWh/d", 
                                "transport energy");
      
      return values;
    }



  }
}


