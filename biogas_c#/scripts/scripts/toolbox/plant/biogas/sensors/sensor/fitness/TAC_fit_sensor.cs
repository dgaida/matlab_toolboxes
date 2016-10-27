/**
 * This file defines the class TAC_fit_sensor.
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
  /// Sensor measuring the TAC_fitness of optimization runs
  /// </summary>
  public class TAC_fit_sensor : biogas.sensor
  {

    // -------------------------------------------------------------------------------------
    //                              !!! CONSTRUCTOR METHODS !!!
    // -------------------------------------------------------------------------------------
    
    /// <summary>
    /// Standard Constructor creating the sensor. Its id is TAC_fit.
    /// </summary>
    public TAC_fit_sensor() :
      base( _spec, "TAC fitness sensor", "")
    {
      // dimension ist hier 1

      // TODO
      // type= ?
      _type = 8;
    }

    /// <summary>
    /// Constructor called by the constructor of biogas.sensors while 
    /// reading the sensors out of a XML file. So reader must be at the correct position, 
    /// which is &lt;sensor&gt; was just read. 
    /// </summary>
    /// <param name="reader"></param>
    /// <param name="id">id of sensor</param>
    public TAC_fit_sensor(ref XmlTextReader reader, string id) : 
      base(ref reader, id)
    {
      // dimension ist hier 1

      // TODO
      // type= ?
      _type = 8;
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
    static public string _spec = "TAC_fit";



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
    /// type 8
    /// </summary>
    /// <param name="myPlant"></param>
    /// <param name="myFitnessParams"></param>
    /// <param name="mySensors"></param>
    /// <param name="par">not used</param>
    /// <returns></returns>
    override protected physValue[] doMeasurement(biogas.plant myPlant,
      biooptim.fitness_params myFitnessParams, biogas.sensors mySensors, params double[] par)
    { 
      physValue[] values= new physValue[1];

      // Grenzwerte, welche ich mal auf einer Konferenz (vermutlich VDI Tagung) aufgeschnappt habe
      // 
      // TAC &lt; 50 mmol/l              gefährlich
      // 50 &lt; TAC &lt; 100 mmol/l     gering Warnung
      // 100 &lt; TAC &lt; 250 mmol/l    OK
      
      // da mit tukey gearbeitet wird, kann der term auch etwas größer als 1 sein
      double TAC_fitness = sensors.calcFitnessDigester_min_max(myPlant, mySensors, "TAC",
        "min", myFitnessParams, "_3", true);

      values[0] = new physValue("TAC_fitness", TAC_fitness, "-");

      return values;
    }



  }
}


