/**
 * This file defines the class pH_fit_sensor.
 * 
 * TODOs:
 * - see TODO in last method
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
  /// Sensor measuring the pH_fitness of optimization runs
  /// </summary>
  public class pH_fit_sensor : biogas.sensor
  {

    // -------------------------------------------------------------------------------------
    //                              !!! CONSTRUCTOR METHODS !!!
    // -------------------------------------------------------------------------------------
    
    /// <summary>
    /// Standard Constructor creating the sensor. Its id is pH_fit.
    /// </summary>
    public pH_fit_sensor() :
      base( _spec, "pH fitness sensor", "")
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
    public pH_fit_sensor(ref XmlTextReader reader, string id) : 
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
    static public string _spec = "pH_fit";



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

      // fitness > 0 if pH value under or over boundaries
      double pHvalue_fitness = getpHvalue_fitness(mySensors, myPlant, myFitnessParams);

      values[0] = new physValue("pH_fitness", pHvalue_fitness, "-");

      return values;
    }



    // -------------------------------------------------------------------------------------
    //                            !!! PRIVATE METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// returns a value between 0 and 1. if the pH value is lower or upper
    /// some constraints, then the value is greater 0, else 0.
    /// 
    /// TODO: diese methode überdenken
    /// </summary>
    /// <param name="mySensors"></param>
    /// <param name="myPlant"></param>
    /// <param name="myFitnessParams"></param>
    /// <returns></returns>
    private static double getpHvalue_fitness(biogas.sensors mySensors, biogas.plant myPlant,
      biooptim.fitness_params myFitnessParams)
    {
      double pH_Punishment = 0;
      double pH_value;

      int n_digester = myPlant.getNumDigesters();

      for (int idigester = 0; idigester < n_digester; idigester++)
      {
        string digester_id = myPlant.getDigesterID(idigester + 1);

        mySensors.getCurrentMeasurementD("pH_" + digester_id + "_3", out pH_value);

        // punish values bigger than 8 or smaller than 7
        // Der Faktor gibt die Steilheit der Strafe an, bei max. 2, dann ist
        // schon bei 8 bzw. 7 der Ausdruck ( 2.0 .* (pH(ifermenter,1) - 7.5) )
        // == 1

        // TODO - maybe use tukey function here instead
        // macht es überhaupt sinn mit optimal values zu arbeiten?
        // oder einfacher die calcFitnessDigester_min_max() methode nutzen

        double pH_punish_digester = Math.Min(1 / (10 ^ 4) * (
           Math.Pow(1.8 * (pH_value -
             myFitnessParams.get_param_of("pH_optimum", idigester)), 12)),
                 Math.Abs(pH_value - myFitnessParams.get_param_of("pH_optimum", idigester)));

        pH_punish_digester = Math.Max(pH_punish_digester,
          Convert.ToDouble(pH_value < myFitnessParams.get_param_of("pH_min", idigester)));
        pH_punish_digester = Math.Max(pH_punish_digester,
          Convert.ToDouble(pH_value > myFitnessParams.get_param_of("pH_max", idigester)));

        // diese zeile begrenzt pH Strafe zwischen 0 und 1
        pH_Punishment = pH_Punishment + Math.Min(pH_punish_digester, 1);
      }

      if (n_digester > 0)
        pH_Punishment = pH_Punishment / n_digester;

      // values between 0 and 1, can be hard constraints
      return pH_Punishment;
    }



  }
}


