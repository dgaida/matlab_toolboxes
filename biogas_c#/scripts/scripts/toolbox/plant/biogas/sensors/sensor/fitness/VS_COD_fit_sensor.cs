/**
 * This file defines the class VS_COD_fit_sensor.
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
  /// Sensor measuring the VS_COD_fitness of optimization runs
  /// </summary>
  public class VS_COD_fit_sensor : biogas.sensor
  {

    // -------------------------------------------------------------------------------------
    //                              !!! CONSTRUCTOR METHODS !!!
    // -------------------------------------------------------------------------------------
    
    /// <summary>
    /// Standard Constructor creating the sensor. Its id is VS_COD_fit.
    /// </summary>
    public VS_COD_fit_sensor() :
      base( _spec, "VS_COD fitness sensor", "")
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
    public VS_COD_fit_sensor(ref XmlTextReader reader, string id) : 
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
    static public string _spec = "VS_COD_fit";



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

      // this is the fitness of the VS_COD in the digester
      double VS_COD_degradationRate;
      double VS_COD_fitness= getVS_COD_fitness(mySensors, out VS_COD_degradationRate);

      values[0] = new physValue("VS_COD_fitness", VS_COD_fitness, "-");

      return values;
    }



    /// <summary>
    /// Calculates VS_COD degradation rate and return its normalized
    /// value as VS_COD_fitness
    /// </summary>
    /// <param name="mySensors"></param>
    /// <param name="VS_COD_degradationRate"></param>
    /// <returns>VS_COD_fitness: normalized between 0 and 1</returns>
    private static double getVS_COD_fitness(biogas.sensors mySensors,
      out double VS_COD_degradationRate)
    {
      // Volatile Solids COD degradation
      // volatile COD in the final storage tank

      // TODO stimmt so nicht, masseabgang durch biogas
      // da der FLuss welcher in das Endlager rein geht immer identisch mit
      // dem Fluss der Eingangssubstrate ist, kürzen sich die beiden werte
      // immer raus, also hier nicht benötigt

      physValue Q_final_storage = mySensors.getCurrentMeasurement("Q_finalstorage_2");

      // gCOD/l
      physValue VS_COD_final_storage = mySensors.getCurrentMeasurement("VS_COD_finalstorage_2");

      // gCOD/l * m^3 == also eine Menge, keine Konzentration
      double VS_COD_amount_final = VS_COD_final_storage.Value * Q_final_storage.Value;

      // volatile COD in the substrate feed

      // TODO
      // measure Q_total_mix_2
      physValue Q_total_mix = mySensors.getCurrentMeasurement("Q_total_mix_2");

      // gCOD/l
      physValue VS_COD_substrate = mySensors.getCurrentMeasurement("VS_COD_total_mix_2");

      // gCOD/l * m^3 == also eine Menge, keine Konzentration
      double VS_COD_amount_total = VS_COD_substrate.Value * Q_total_mix.Value;

      //

      // a value between 0 and 100
      VS_COD_degradationRate =
         (1 - Math.Max(VS_COD_amount_final, 0) / Math.Max(VS_COD_amount_total, double.Epsilon)) * 100;

      //

      double VS_COD_degradationMin = 0;
      double VS_COD_degradationMax = 100;

      // values between 0 and 1
      double VS_COD_fitness = Math.Abs((1 - math.normalize(VS_COD_degradationRate,
                                      VS_COD_degradationMin, VS_COD_degradationMax)));

      return VS_COD_fitness;
    }

    

  }
}


