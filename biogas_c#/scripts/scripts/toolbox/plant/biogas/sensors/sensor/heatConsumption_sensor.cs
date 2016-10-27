/**
 * This file defines the class heatConsumption_sensor.
 * 
 * TODOs:
 * - wärme welche durch bakterien erzeugt wird, muss hier noch abgezogen werden, OK
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
  /// Sensor measuring the heat consumption at a digester
  /// this is mainly due to
  /// - heating substrates
  /// - compensating heat loss due to radiation
  /// </summary>
  public class heatConsumption_sensor : biogas.sensor
  {

    // -------------------------------------------------------------------------------------
    //                              !!! CONSTRUCTOR METHODS !!!
    // -------------------------------------------------------------------------------------
    
    /// <summary>
    /// Standard Constructor creating the sensor. Its id is heatConsumption.
    /// id_suffix is here the digester ID in which the heat is consumed.
    /// </summary>
    /// <param name="id_suffix"></param>
    public heatConsumption_sensor(string id_suffix) :
      base( String.Format("{0}_{1}", _spec, id_suffix),
            String.Format("heatConsumption sensor {0}", id_suffix), id_suffix, 4)
    {
      // aktuell werden vier Effekte betrachtet, dimension erhöhen
      // wenn weitere Effekte betrachtet werden
      //dimension= 4;

      // TODO
      // type= ?
      _type = 7;
    }

    /// <summary>
    /// Constructor called by the constructor of biogas.sensors while 
    /// reading the sensors out of a XML file. So reader must be at the correct position, 
    /// which is &lt;sensor&gt; was just read. 
    /// </summary>
    /// <param name="reader"></param>
    /// <param name="id">id of sensor</param>
    public heatConsumption_sensor(ref XmlTextReader reader, string id) : 
      base(ref reader, id, 4)
    {
      // aktuell werden vier Effekte betrachtet, dimension erhöhen
      // wenn weitere Effekte betrachtet werden
      //dimension = 4;

      // TODO
      // type= ?
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
    static public string _spec = "heatConsumption";



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
    /// called in ADMstate_stoichiometry.cs
    /// 
    /// unterschied zu typ 7 ist, dass Q hier nur aus Substraten besteht und nicht
    /// aus zusätzlichem sludge, da sludge nicht aufgewärmt werden muss,
    /// nein ist jetzt ein Typ 7 sensor, sludge wird ignoriert
    /// </summary>
    /// <param name="x">not used</param>
    /// <param name="myPlant"></param>
    /// <param name="mySubstrates"></param>
    /// <param name="mySensors"></param>
    /// <param name="Q">zufuhr aller substrate in fermenter (nicht in Anlage), 
    /// da heatConsumption_sensor am fermenter angebracht ist</param>
    /// <param name="par">not used</param>
    /// <returns>measured values</returns>
    override protected physValue[] doMeasurement(double[] x, biogas.plant myPlant,
                                                 biogas.substrates mySubstrates,
                                                 biogas.sensors mySensors,
                                                 double[] Q, params double[] par)
    {
      // wegen 4 siehe oben
      // 1. Ptherm kWh/d for heating substrates
      // 2. Ptherm kWh/d loss due to radiation
      // 3. Ptherm kWh/d produced by microbiology
      // 4. Ptherm kWh/d produced by stirrer dissipation
      physValue[] values= new physValue[dimension];

      // TODO - rufe hier calcThermalEnergyBalance auf von digester_energy.cs
      // benötigt als weiteren Parameter allerdings mySensors

      digester myDigester= myPlant.getDigesterByID(id_suffix);

      // Q ist nur das was in fermenter rein geht
      // bspw. gäbe es bei einem nicht gefütterten aber beheiztem fermenter
      // keine substrate welche aufgeheizt werden müssten
      //myDigester.heatInputSubstrates(Q, mySubstrates, out values[0]);

      myDigester.calcThermalEnergyBalance(Q, mySubstrates, myPlant.Tout, mySensors,
        out values[0], out values[1], out values[2], out values[3]);

      //

      values[0].Label = "thermal energy to heat substrates";
      values[1].Label = "thermal energy loss due to radiation";
      values[2].Label = "thermal energy produced by microorganisms";
      values[3].Label = "thermal energy dissipated by stirrer";

      //physValue P_radiation_loss_kW;
      // because in heating first power in kW is calculated, it does not
      // make the code faster to not have power in kW as parameter
      //myPlant.compensateHeatLossDueToRadiation(id_suffix, 
      //        out P_radiation_loss_kW, out values[1]);

      //

      return values;
    }



  }
}


