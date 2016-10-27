/**
 * This file defines the class udot_sensor.
 * 
 * TODOs:
 * - should be ok
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
  /// Sensor measuring the udot of optimization runs
  /// </summary>
  public class udot_sensor : biogas.sensor
  {

    // -------------------------------------------------------------------------------------
    //                              !!! CONSTRUCTOR METHODS !!!
    // -------------------------------------------------------------------------------------
    
    /// <summary>
    /// Standard Constructor creating the sensor. Its id is udot.
    /// </summary>
    public udot_sensor() :
      base( _spec, "udot sensor", "")
    {
      // dimension ist hier 1

      // TODO
      // type= ?
      _type = 9;
    }

    /// <summary>
    /// Constructor called by the constructor of biogas.sensors while 
    /// reading the sensors out of a XML file. So reader must be at the correct position, 
    /// which is &lt;sensor&gt; was just read. 
    /// </summary>
    /// <param name="reader"></param>
    /// <param name="id">id of sensor</param>
    public udot_sensor(ref XmlTextReader reader, string id) : 
      base(ref reader, id)
    {
      // dimension ist hier 1

      // TODO
      // type= ?
      _type = 9;
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
    static public string _spec = "udot";



    // -------------------------------------------------------------------------------------
    //                            !!! PROTECTED METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// no need
    /// </summary>
    /// <param name="x"></param>
    /// <param name="par">not used</param>
    /// <returns></returns>
    override protected physValue[] doMeasurement(double[] x, params double[] par)
    {
      throw new exception("Not implemented!");
    }

    /// <summary>
    /// ...
    /// 
    /// type 9
    /// </summary>
    /// <param name="mySubstrates"></param>
    /// <param name="mySensors"></param>
    /// <param name="par">not used</param>
    /// <returns></returns>
    override protected physValue[] doMeasurement(biogas.substrates mySubstrates,
      biogas.sensors mySensors, params double[] par)
    { 
      physValue[] values= new physValue[1];

      // 
      double udot = calcudot(mySensors, mySubstrates);

      values[0] = new physValue("udot", udot, "-");

      return values;
    }



    /// <summary>
    /// Calc u' := ( u2 - u1 ) / ( t2 - t1 )
    /// </summary>
    /// <param name="t1">time t1 &lt; t2</param>
    /// <param name="t2">time t2 &gt; t1</param>
    /// <param name="u1">u1 := u(t1)</param>
    /// <param name="u2">u2 := u(t2)</param>
    /// <returns>u prime</returns>
    /// <exception cref="exception">t1 &gt;= t2</exception>
    private double calcudot(double t1, double t2, double u1, double u2)
    {
      if (t1 >= t2)
        throw new exception(String.Format("t1 >= t2 : {0} <= {1}", t1, t2));

      return (u2 - u1) / (t2 - t1);
    }

    /// <summary>
    /// Calc u prime for substrate feed of all substrates saved in sensors at the 
    /// current time
    /// </summary>
    /// <param name="mySensors"></param>
    /// <param name="mySubstrates"></param>
    /// <returns>|| u'(t) ||_2^2, where u is the vector of substrate feeds</returns>
    private double calcudot(biogas.sensors mySensors, biogas.substrates mySubstrates)
    {
      double t2 = mySensors.getCurrentTime();

      if (t2 < 0)   // no recorded value yet in no sensor
        return 0;

      double t1 = mySensors.getPreviousTime();

      double[] Q1, Q2;

      // TODO
      // wenn init substrate feed nicht gegeben ist, dann ist am anfang der simulation
      // Q2 = Q1
      // aktuell berechne ich in MATLAb noch init_substrate feed und addiere das am ende
      // zu udot hinzu, sollte erstmal ok sein
      mySensors.getMeasurementsAt("Q", "Q", t1, mySubstrates, out Q1);

      mySensors.getMeasurementsAt("Q", "Q", t2, mySubstrates, out Q2);

      //

      double udot = 0;

      for (int isubstrate = 0; isubstrate < mySubstrates.getNumSubstrates(); isubstrate++)
      {
        double u1 = Q1[isubstrate];
        double u2 = Q2[isubstrate];

        double udot1 = calcudot(t1, t2, u1, u2);

        udot += udot1 * udot1;
      }

      return udot;
    }



  }
}


