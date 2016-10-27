/**
 * This file defines the class pumpEnergy_sensor.
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
  /// sensor measuring the energy consumption due to pumping
  /// of substrates and sludge
  /// </summary>
  public class pumpEnergy_sensor : biogas.sensor
  {

    // -------------------------------------------------------------------------------------
    //                              !!! CONSTRUCTOR METHODS !!!
    // -------------------------------------------------------------------------------------
    
    /// <summary>
    /// Standard Constructor creating the sensor. Its id is pumpEnergy.
    /// id_suffix is here the combination out of
    /// the two units where the sludge is pumped from and to.
    /// unit_start + "_" + unit_destiny
    /// </summary>
    /// <param name="id_suffix"></param>
    public pumpEnergy_sensor(string id_suffix) :
      base(String.Format("{0}_{1}", _spec, id_suffix),
            String.Format("pumpEnergy sensor {0}", id_suffix), id_suffix)
    {
      // TODO
      // type= ?
      _type = 90;
    }

    /// <summary>
    /// Constructor called by the constructor of biogas.sensors while 
    /// reading the sensors out of a XML file. So reader must be at the correct position, 
    /// which is &lt;sensor&gt; was just read. 
    /// </summary>
    /// <param name="reader"></param>
    /// <param name="id">id of sensor</param>
    public pumpEnergy_sensor(ref XmlTextReader reader, string id) : 
      base(ref reader, id)
    {
      // TODO
      // type= ?
      _type = 90;
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
    static public string _spec = "pumpEnergy";



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
    /// par[0] is the to be pumped amount in m³/d
    /// par[1] is the density of the sludge in kg/m^3 (gilt nur für substrate_transport)
    /// für pump Aufruf, par ist nur 1dim.
    /// </param>
    /// <returns></returns>
    override protected physValue[] doMeasurement(biogas.plant myPlant,
                                                 double u, params double[] par)
    {
      // 
      physValue[] values= new physValue[1];

      // sobald in MATLAB die neuen pumps genutzt werden, ist par 2dim
      // 2. komponente ist rho als double, unten in density def. dann anstatt 
      // 1000 einsetzen
      if ((par.Length <= 0) || (par.Length > 2))    // 2, da rho auch übergeben werden muss
      {
        throw new exception(String.Format(
        "Length of par must be 1 or 2: {0}!", par.Length));
      }

      transportation myTransportations = myPlant.myTransportation;

      // get gravitational constant
      physValue g = myPlant.g;

      if (par.Length == 2)
      {
        // get pump from transportation class using id
        biogas.substrate_transport mySubstrateTransport = 
          myTransportations.getSubstrateTransportByID(id_suffix);

        // muss hier nicht gemacht werden, wird schon in pump gemacht
        // basierend auf id_suffix, bzw. dem Startort entscheidet man
        // wie groß die Dichte ist
        // wenn Start: substratemix ist, dann Dichte über Mittelwerte der zu pumpenden
        // Substrate wählen, dazu getSubstrateMixFlowForFermenter nutzen
        // wenn Start ein Digester oder storagetank ist, dann ist Dichte immer 1000 kg/m^3
        // gemessene Dichte des density_sensors interessiert nicht, weil das die Dichte des
        // Inputs von einem digester ist.

        physValue density = new physValue("rho", par[1], "kg/m^3", "density");

        // calc energy consumption in kWh/d
        // hier muss man schon rho der zu fördernden menge kennen
        values[0] = mySubstrateTransport.calcEnergyConsumption(u, par[0], g, density);
      }
      else if (par.Length == 1)   // called from pump, we pump sludge
      {
        // get pump from transportation class using id
        biogas.pump myPump = myTransportations.getPumpByID(id_suffix);

        physValue density = new physValue("rho", 1000, "kg/m^3", "density");

        // calc energy consumption in kWh/d
        // hier muss man schon rho der zu fördernden menge kennen
        values[0] = myPump.calcEnergyConsumption(u, par[0], g, density);
      }
      else
      {
        throw new exception("par must be one- or two-dimensional!");
      }

      return values;
    }



  }
}


