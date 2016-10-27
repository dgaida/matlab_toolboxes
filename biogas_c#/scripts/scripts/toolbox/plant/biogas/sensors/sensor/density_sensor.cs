/**
 * This file defines the class density_sensor.
 * 
 * TODOs:
 * - einige parameter der doMeasurement methode werden nicht genutzt (egal)
 * - momentan wird nur dichte der (substrat)zufuhr in einen fermenter gemessen (und nicht im fermenter). 
 *   will man das? was wäre die Alternative. Wir nehmen an, dass die Dichte des Inputs
 *   so ist wie die Dichte im Fermenter. Bzw. eigentlich ist die Annahme, dass die Dichte
 *   im Fermenter 1000 kg/m^3 ist. Also macht es nur Sinn Dichte des Inputs zu messen.
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
  /// Sensor measuring the density of the substrate feed of a digester
  /// </summary>
  public class density_sensor : biogas.sensor
  {

    // -------------------------------------------------------------------------------------
    //                              !!! CONSTRUCTOR METHODS !!!
    // -------------------------------------------------------------------------------------
    
    /// <summary>
    /// Standard Constructor creating the sensor. Its id is density.
    /// id_suffix is here the digester ID in which the density is measured. 
    /// </summary>
    /// <param name="id_suffix"></param>
    public density_sensor(string id_suffix) :
      base( String.Format("{0}_{1}", _spec, id_suffix),
            String.Format("density sensor {0}", id_suffix), id_suffix)
    { 
      // type
      // TODO : evtl. bleibt es nicht dabei, das ist OK
      _type = 7;
    }

    /// <summary>
    /// Constructor called by the constructor of biogas.sensors while 
    /// reading the sensors out of a XML file. So reader must be at the correct position, 
    /// which is &lt;sensor&gt; was just read. 
    /// </summary>
    /// <param name="reader"></param>
    /// <param name="id">id of sensor</param>
    public density_sensor(ref XmlTextReader reader, string id) : 
      base(ref reader, id)
    {
      // type
      // TODO : evtl. bleibt es nicht dabei, das ist OK
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
    static public string _spec = "density";



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
    /// measures the density of the substrate feed of a given digester
    /// 
    /// type 7
    /// 
    /// TODO: mySensors wird hier eigentlich nicht benötigt
    /// wenn mySensors gelöscht wird, dann ist das keine type 7 funktion mehr, OK
    /// 
    /// </summary>
    /// <param name="x">ADM state vector</param>
    /// <param name="myPlant"></param>
    /// <param name="mySubstrates"></param>
    /// <param name="mySensors"></param>
    /// <param name="Q">
    /// substrate feed and recirculation sludge going into the digester
    /// first values are Q for substrates, then pumped sludge going into digester
    /// dimension: always number of substrates + number of digesters
    /// </param>
    /// <param name="par">not used</param>
    /// <returns></returns>
    override protected physValue[] doMeasurement(double[] x, biogas.plant myPlant,
                                                 biogas.substrates mySubstrates, biogas.sensors mySensors, 
                                                 double[] Q, params double[] par)
    {
      physValue[] values= new physValue[1];

      // number of substrates
      int n_substrate= mySubstrates.getNumSubstrates();

      double Qsum= math.sum(Q);

      // das ist feed in fermenter
      if (Q.Length < n_substrate)
        throw new exception( String.Format(
          "Q.Length < n_substrate: {0} < {1}!", Q.Length, n_substrate) );

      double[] Qsubstrates= new double[n_substrate];

      // volumeflow for substrates
      for (int isubstrate= 0; isubstrate < n_substrate; isubstrate++)
        Qsubstrates[isubstrate]= Q[isubstrate];

      //

      physValue rhoSubstrate;
      
      // wenn fermenter nicht mit substraten gefüttert wird
      if (math.sum(Qsubstrates) == 0)
        rhoSubstrate = new physValue(0, "kg/d");
      else
      {
        mySubstrates.get_weighted_sum_of(Qsubstrates, "rho", out rhoSubstrate);
        rhoSubstrate = rhoSubstrate.convertUnit("kg/d");
      }
      
      //

      physValue rhoSludge= new physValue("rho", 1000, "kg/m^3");

      for (int isubstrate= n_substrate; isubstrate < Q.Length; isubstrate++)
      { 
        rhoSubstrate += rhoSludge * new physValue( Q[isubstrate], "m^3/d" );
      }

      //

      if (Qsum != 0)
        values[0]= rhoSubstrate / new physValue(Qsum, "m^3/d");
      else
        values[0]= new physValue(0, "kg/m^3");

      //

      values[0].Symbol= "rho";

      //

      return values;
    }



  }
}


