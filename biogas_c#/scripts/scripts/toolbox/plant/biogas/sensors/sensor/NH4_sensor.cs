/**
 * This file defines the class NH4_sensor.
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
  /// Sensor measuring the NH4 in g/l
  /// </summary>
  public class NH4_sensor : biogas.sensor
  {

    // -------------------------------------------------------------------------------------
    //                              !!! CONSTRUCTOR METHODS !!!
    // -------------------------------------------------------------------------------------
    
    /// <summary>
    /// Standard Constructor creating the sensor. Its id is NH4.
    /// id_suffix is here the digester ID in which the NH4 is measured, followed by 2 or 3,
    /// defining in respectively out.
    /// </summary>
    /// <param name="id_suffix">digester ID followed by _2 or _3</param>
    public NH4_sensor(string id_suffix) :
      base( String.Format("{0}_{1}", _spec, id_suffix),
            String.Format("Snh4 sensor {0}", id_suffix), id_suffix, 2 )
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
    public NH4_sensor(ref XmlTextReader reader, string id) : 
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
    static public string _spec = "Snh4";



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
    /// Measure NH4 content inside a digester
    /// 1st measurement is Snh4 in g/l
    /// 2nd : Snh4 + NH4 in Xc in g/l
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
      physValue[] values= new physValue[dimension];

      // hier wird umrechnungsfaktor 18 genutzt, deshalb nur ammonium und nicht
      // ammonium nitrogen
      values[0]= ADMstate.calcFromADMstate(x, "Snh4", "g/l");

      //
      // -2 wegen _2 bzw. _3
      string digester_id = id.Substring(("Snh4_").Length, id.Length - 2 - ("Snh4_").Length);

      // kmol N/m^3
      double NH4 = ADMstate.calcNH4(x, digester_id, myPlant);

      //
      // erstmal Snh4 nennen, damit convertUnit funktioniert
      // TODO - könnte es auch N nennen, dann wird allerdings nur mit 14 als
      // umrechnungsfaktor gerechnet und nicht wie jetzt mit 18. Vorsicht
      // bei vergleich mit Ntot, TKN und Norg, dort wird nur mit 14 gerechnet. 
      // da ich die Größe ammonium nitrogen nenne, wird umrechnungsfaktor 14 genutzt
      values[1] = new physValue("N", NH4, "mol/l", "total ammonium nitrogen");
      values[1] = values[1].convertUnit("g/l");
      values[1].Symbol = "NH4";

      return values;
    }



  }
}


