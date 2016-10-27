/**
 * This file defines the class aceto_hydro_sensor.
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
  /// Sensor measuring the ratio of acetoclastic to hydrogenotrophic methanogenesis
  /// </summary>
  public class aceto_hydro_sensor : biogas.sensor
  {

    // -------------------------------------------------------------------------------------
    //                              !!! CONSTRUCTOR METHODS !!!
    // -------------------------------------------------------------------------------------
    
    /// <summary>
    /// Standard Constructor creating the sensor. Its id is aceto_hydro.
    /// id_suffix is here the digester ID in which the aceto_hydro is measured.
    /// </summary>
    /// <param name="id_suffix"></param>
    public aceto_hydro_sensor(string id_suffix) :
      base( String.Format("{0}_{1}", _spec, id_suffix),
            String.Format("aceto_hydro sensor {0}", id_suffix), id_suffix, 2 )
    {
      // TODO
      // type= ?
      _type = 911;
    }

    /// <summary>
    /// Constructor called by the constructor of biogas.sensors while 
    /// reading the sensors out of a XML file. So reader must be at the correct position, 
    /// which is &lt;sensor&gt; was just read. 
    /// </summary>
    /// <param name="reader"></param>
    /// <param name="id">id of sensor</param>
    public aceto_hydro_sensor(ref XmlTextReader reader, string id) : 
      base(ref reader, id, 2)
    {
      // TODO
      // type= ?
      _type = 911;
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
    static public string _spec = "aceto_hydro";



    // -------------------------------------------------------------------------------------
    //                            !!! PROTECTED METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// measures ratio of acetoclastic to hydrogenotrophic methanogenesis of 
    /// given digester
    /// </summary>
    /// <param name="intvars">ADM1 internal variables</param>
    /// <param name="par">2dim.
    /// 0: Yac
    /// 1: Yh2
    /// </param>
    /// <returns>ratio of acetoclastic to hydrogenotrophic methanogenesis 
    /// inside digester</returns>
    override protected physValue[] doMeasurement(double[] intvars, params double[] par)
    { 
      physValue[] values= new physValue[dimension];

      // Uptake of acetate
      double p_ac= intvars[48];
      // Uptake of hydrogen
      double p_h2= intvars[49];

      double Yac = par[0];// ADMparams.Get(46 - 1);
      double Yh2 = par[1];// ADMparams.Get(47 - 1);

      double ch4_prod_ac= p_ac*(1 - Yac);
      double ch4_prod_h2= p_h2*(1 - Yh2);

      double aceto_ratio, hydro_ratio;

      if (ch4_prod_ac + ch4_prod_h2 != 0)
      {
        aceto_ratio= Math.Round( ch4_prod_ac / (ch4_prod_ac + ch4_prod_h2) * 100.0, 2 );
                         
        hydro_ratio= Math.Round( ch4_prod_h2 / (ch4_prod_ac + ch4_prod_h2) * 100.0, 2 );                 
      } 
      else
      { 
        aceto_ratio= 0;
        hydro_ratio= 0;
      }

      values[0] = new physValue("aceto", aceto_ratio, "100 %", "acetoclastic methanogenesis");
      values[1] = new physValue("hydro", hydro_ratio, "100 %", "hydrogenotrophic methanogenesis");

      return values;
    }



  }
}


