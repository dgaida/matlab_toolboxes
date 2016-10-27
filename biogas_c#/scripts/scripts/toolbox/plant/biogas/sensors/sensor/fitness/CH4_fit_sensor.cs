/**
 * This file defines the class CH4_fit_sensor.
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
  /// Sensor measuring the CH4_fitness of optimization runs
  /// </summary>
  public class CH4_fit_sensor : biogas.sensor
  {

    // -------------------------------------------------------------------------------------
    //                              !!! CONSTRUCTOR METHODS !!!
    // -------------------------------------------------------------------------------------
    
    /// <summary>
    /// Standard Constructor creating the sensor. Its id is CH4_fit.
    /// </summary>
    public CH4_fit_sensor() :
      base( _spec, "CH4 fitness sensor", "")
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
    public CH4_fit_sensor(ref XmlTextReader reader, string id) : 
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
    static public string _spec = "CH4_fit";



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

      // this is the fitness of the CH4 in the digester
      // da mit tukey gearbeitet wird, kann der term auch etwas größer als 1 sein
      double CH4_fitness;
      getBiogas_fitness(mySensors, out CH4_fitness);

      values[0] = new physValue("CH4_fitness", CH4_fitness, "-");

      return values;
    }



    /// <summary>
    /// calculates fitness values that have to do with biogas production
    /// at the moment two fitness values are calculated:
    /// - methane concentration smaller 50 %
    /// - biogas excess
    /// 
    /// TODO: erweitern um H2_fitness? use a H2_max boundary
    /// / da simulation für h2 bisher teilweise recht ungenau, macht
    /// die nutzun einer upper boundary momentan nicht so viel sinn
    /// </summary>
    /// <param name="mySensors"></param>
    /// <param name="CH4_fitness">1 if CH4 concentration is smaller 50 %</param>
    private static void getBiogas_fitness(biogas.sensors mySensors, out double CH4_fitness)
    {
      // Calculation of methane amount in Biogas

      physValue[] biogas_v = mySensors.getCurrentMeasurementVector("total_biogas_");

      double methaneConcentration = biogas_v[2].Value;


      CH4_fitness = Convert.ToDouble(methaneConcentration < 50) *
                (0 * 1 + math.tukeybiweight(methaneConcentration - 50));

      //CH4_fitness = Convert.ToDouble(methaneConcentration < 50);
    }



  }
}


