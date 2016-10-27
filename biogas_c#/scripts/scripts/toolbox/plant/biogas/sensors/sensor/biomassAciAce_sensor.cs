/**
 * This file defines the class biomassAciAce_sensor.
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
  /// Sensor measuring the biomass of the sum of Acidogens and Acetogens
  /// </summary>
  public class biomassAciAce_sensor : biogas.sensor
  {

    // -------------------------------------------------------------------------------------
    //                              !!! CONSTRUCTOR METHODS !!!
    // -------------------------------------------------------------------------------------
    
    /// <summary>
    /// Standard Constructor creating the sensor. Its id is biomassAciAce.
    /// id_suffix is here the digester ID in which the biomassAciAce is measured, 
    /// followed by 2 or 3, defining in respectively out.
    /// </summary>
    /// <param name="id_suffix"></param>
    public biomassAciAce_sensor(string id_suffix) :
      base( String.Format("{0}_{1}", _spec, id_suffix),
            String.Format("biomassAciAce sensor {0}", id_suffix), id_suffix )
    { 
      
    }

    /// <summary>
    /// Constructor called by the constructor of biogas.sensors while 
    /// reading the sensors out of a XML file. So reader must be at the correct position, 
    /// which is &lt;sensor&gt; was just read. 
    /// </summary>
    /// <param name="reader"></param>
    /// <param name="id">id of sensor</param>
    public biomassAciAce_sensor(ref XmlTextReader reader, string id) : 
      base(ref reader, id)
    {
      
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
    static public string _spec = "biomassAciAce";



    // -------------------------------------------------------------------------------------
    //                            !!! PROTECTED METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// biomass= Biomass Sugar degraders + Biomass amino acids degraders + 
    /// LCFA degraders + valerate, butyrate degraders + propionate degraders
    ///
    /// producing mainly acetate and hydrogen
    /// measured in kgCOD/m^3
    /// 
    /// type= 0;
    /// </summary>
    /// <param name="x">ADM state vector</param>
    /// <param name="par">not used</param>
    /// <returns>measured biomass</returns>
    override protected physValue[] doMeasurement(double[] x, params double[] par)
    { 
      physValue[] values= new physValue[1];

      values[0]= ADMstate.calcAciAceBiomassOfADMstate(x);

      return values;
    }



  }
}


