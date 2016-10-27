/**
 * This file defines the class SS_COD_fit_sensor.
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
  /// Sensor measuring the SS_COD_fitness of optimization runs
  /// </summary>
  public class SS_COD_fit_sensor : biogas.sensor
  {

    // -------------------------------------------------------------------------------------
    //                              !!! CONSTRUCTOR METHODS !!!
    // -------------------------------------------------------------------------------------
    
    /// <summary>
    /// Standard Constructor creating the sensor. Its id is SS_COD_fit.
    /// </summary>
    public SS_COD_fit_sensor() :
      base( _spec, "SS_COD fitness sensor", "")
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
    public SS_COD_fit_sensor(ref XmlTextReader reader, string id) : 
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
    static public string _spec = "SS_COD_fit";



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

      // this is the fitness of the SS_COD in the digester
      double SS_COD_degradationRate;
      double SS_COD_fitness= getSS_COD_fitness(mySensors, out SS_COD_degradationRate);

      // normalized between 0 and 1
      values[0] = new physValue("SS_COD_fitness", SS_COD_fitness, "-");

      return values;
    }



    /// <summary>
    /// Calculates SS_COD degradation rate and return its normalized
    /// value as SS_COD_fitness
    /// </summary>
    /// <param name="mySensors"></param>
    /// <param name="SS_COD_degradationRate"></param>
    /// <returns>SS_COD_fitness: normalized between 0 and 1</returns>
    private static double getSS_COD_fitness(biogas.sensors mySensors,
      out double SS_COD_degradationRate)
    {
      // Soluble Solids COD degradation
      // soluble COD in the final storage tank

      // TODO stimmt so nicht, masseabgang durch biogas
      // da der FLuss welcher in das Endlager rein geht immer identisch mit
      // dem Fluss der Eingangssubstrate ist, kürzen sich die beiden werte
      // immer raus, also hier nicht benötigt

      physValue Q_final_storage = mySensors.getCurrentMeasurement("Q_finalstorage_2");

      // gCOD/l
      physValue SS_COD_final_storage = mySensors.getCurrentMeasurement("SS_COD_finalstorage_2");

      // gCOD/l * m^3 == also eine Menge, keine Konzentration
      double SS_COD_amount_final = SS_COD_final_storage.Value * Q_final_storage.Value;

      // soluble COD in the substrate feed

      // TODO
      // measure Q_total_mix_2
      physValue Q_total_mix = mySensors.getCurrentMeasurement("Q_total_mix_2");

      // gCOD/l
      physValue SS_COD_substrate = mySensors.getCurrentMeasurement("SS_COD_total_mix_2");

      // gCOD/l * m^3 == also eine Menge, keine Konzentration
      double SS_COD_amount_total = SS_COD_substrate.Value * Q_total_mix.Value;

      //

      // a value between 0 and 100
      SS_COD_degradationRate =
         (1 - Math.Max(SS_COD_amount_final, 0) / Math.Max(SS_COD_amount_total, double.Epsilon)) * 100;

      //

      double SS_COD_degradationMin = 0;
      double SS_COD_degradationMax = 100;

      // values between 0 and 1
      double SS_COD_fitness = Math.Abs((1 - math.normalize(SS_COD_degradationRate,
                                      SS_COD_degradationMin, SS_COD_degradationMax)));

      return SS_COD_fitness;
    }



  }
}


