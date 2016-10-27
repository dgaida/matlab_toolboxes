/**
 * This file defines the class VS_sensor.
 * 
 * TODOs:
 * - bei der messung werden einige Annahmen gemacht, vielleicht kann man da 
 *   noch was besseres machen
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
  /// Sensor measuring the Volatile Solids
  /// </summary>
  public class VS_sensor : biogas.sensor
  {

    // -------------------------------------------------------------------------------------
    //                              !!! CONSTRUCTOR METHODS !!!
    // -------------------------------------------------------------------------------------
    
    /// <summary>
    /// Standard Constructor creating the sensor. Its id is VS.
    /// id_suffix is here the digester ID in which the VS is measured, followed by 2 or 3,
    /// defining in respectively out.
    /// </summary>
    /// <param name="id_suffix"></param>
    public VS_sensor(string id_suffix) :
      base( String.Format("{0}_{1}", _spec, id_suffix),
            String.Format("VS sensor {0}", id_suffix), id_suffix )
    {
      // TODO
      // type= ?
      // müsste typ 3 sein, warum habe ich das noch nicht umgenannt?
      _type = 85;
    }
        
    /// <summary>
    /// Constructor called by the constructor of biogas.sensors while 
    /// reading the sensors out of a XML file. So reader must be at the correct position, 
    /// which is &lt;sensor&gt; was just read. 
    /// </summary>
    /// <param name="reader"></param>
    /// <param name="id">id of sensor</param>
    public VS_sensor(ref XmlTextReader reader, string id) : 
      base(ref reader, id)
    {
      // TODO
      // type= ?
      // müsste typ 3 sein, warum habe ich das noch nicht umgenannt?
      _type = 85;
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
    static public string _spec = "VS";



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
    /// Calculated volatile solids inside digester
    /// 
    /// called in ADMstate_stoichiometry
    /// 
    /// scheint mir typ 3 zu sein, ist auch so
    /// </summary>
    /// <param name="x">ADM state vector</param>
    /// <param name="mySubstrates">list of all substrates of plant</param>
    /// <param name="Q">substrate feed of total plant in m³/d</param>
    /// <param name="par">not used</param>
    /// <returns>volatile solids inside digester in % TS</returns>
    override protected physValue[] doMeasurement(double[] x, biogas.substrates mySubstrates,
                                                 double[] Q, params double[] par)
    {
      physValue[] values= new physValue[1];

      // durch diesen Aufruf werden einige Annahmen gemacht
      // der TS Gehalt in dem Fermenter wird berechnet aus dem COD Gehalt im Fermenter
      // mit der Annahme, dass die Verteilung von RF, RP, RL, .. in dem Fermenter
      // so ist wie die der gesamten Substratzufuhr der Anlage, also unabhängig davon
      // ob fermenter überhaupt gefüttert wird oder nicht
      // weiterhin wird angenommen, das Asche Gehalt in jedem Fermenter so groß ist
      // wie der Asche Gehalt der gesamten Substratzufuhr. das ist nur eine Annahme, 
      // könnte auch völlig anders sein. bspw. bei 2 fermentern müsste in jedem Fermenter
      // Asche der Substrate halbe sein...
      values[0]= biogas.digester.calcVS(x, mySubstrates, Q);

      return values;
    }



  }
}


