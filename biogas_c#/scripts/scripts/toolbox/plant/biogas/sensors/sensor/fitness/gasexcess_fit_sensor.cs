/**
 * This file defines the class gasexcess_fit_sensor.
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
  /// Sensor measuring the gasexcess_fitness of optimization runs
  /// </summary>
  public partial class gasexcess_fit_sensor : biogas.sensor
  {

    // -------------------------------------------------------------------------------------
    //                              !!! CONSTRUCTOR METHODS !!!
    // -------------------------------------------------------------------------------------
    
    /// <summary>
    /// Standard Constructor creating the sensor. Its id is gasexcess_fit.
    /// </summary>
    public gasexcess_fit_sensor() :
      base( _spec, "gasexcess fitness sensor", "")
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
    public gasexcess_fit_sensor(ref XmlTextReader reader, string id) : 
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
    static public string _spec = "gasexcess_fit";



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

      //

      // <param name="biogasExcess_fitness">lost money due to biogas excess [1000 €/d]</param>
      // <param name="biogasExcess">in excess produced biogas [m^3/d]</param>
      // <param name="lossBiogasExcess">lost money due to biogas excess [€/d]</param>

      physValue[] biogas_v = mySensors.getCurrentMeasurementVector("total_biogas_");

      //
      // excess biogas in [m^3/d]
      double biogasExcess;// = biogas_v[biogas_v.Length - 1].Value;

      //
      // Calculation of costs of substrate inflow
      // € / d
      double substrate_costs;

      mySensors.getCurrentMeasurementD("substrate_cost", out substrate_costs);


      // loss of excess methane prod. in €/d
      // if there is a loss, then positive value
      // if there is a gain, then negative value, should not be the case
      double lossBiogasExcess = calcLossDueToBiogasExcess(biogas_v, substrate_costs, myPlant,
        myFitnessParams, out biogasExcess);

      // tausend € / d
      double biogasExcess_fitness = lossBiogasExcess / 1000;

      //

      values[0] = new physValue("biogasExcess_fitness", biogasExcess_fitness, "-");

      return values;
    }



  }
}


