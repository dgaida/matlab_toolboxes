/**
 * This file is part of the partial class substrate and defines
 * all measure and doMeasurements methods.
 * 
 * TODOs:
 * - 
 * 
 * Except for that FINISHED!
 * 
 */

using System;
using System.Collections.Generic;
using System.Text;
using science;
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
  /// abstract class defining a sensor
  /// 
  /// A sensor can measure one or more physValues over time. To identify a 
  /// sensor it has an id and a id_suffix which indicates the location of the
  /// sensor. To measure a value use one of the measure methods. To get 
  /// a measured value at a given time use one of the getMeasurement methods. 
  /// </summary>
  public abstract partial class sensor
  {

    // -------------------------------------------------------------------------------------
    //                              !!! PUBLIC METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// Make (a) measurement/measurements and add the new measurement/s to the measurement stream
    /// Only make these measurements when between time and the last taken measurement
    /// at least a delta of deltatime exists.
    /// 
    /// type 0 and also type 1
    /// 
    /// example sensors: 
    /// type 0: NH3_sensor, NH4_sensor, Sac_sensor, AcVsPro_sensor
    /// type 1: HRT_sensor
    /// </summary>
    /// <param name="time">current simulation time [days]</param>
    /// <param name="deltatime">sample time of the sensor [days]</param>
    /// <param name="x">Could be the state vector.</param>
    /// <param name="par">some doubles</param>
    /// <returns>measured values</returns>
    public physValue[] measure(double time, double deltatime, 
                               double[] x, params double[] par)
    {
      physValue[] values;

      if (time - getCurrentTime() >= deltatime)
      {
        values= doMeasurement(x, par);  // call the do measurement method for the given sensor

        addMeasurement(time, values);   // add measurement to list
      }
      else    // return last measured values
        values= getCurrentMeasurementVector();
      
      return values;
    }

    /// <summary>
    /// Do measurements which are independent of a double vector x.
    /// 
    /// 2nd type
    /// 
    /// example sensor: 
    /// fitness_sensor
    /// </summary>
    /// <param name="time">current simulation time [days]</param>
    /// <param name="deltatime">sample time of the sensor [days]</param>
    /// <param name="param">some doubles</param>
    /// <returns>measured values</returns>
    public physValue[] measure(double time, double deltatime,
                               double param)
    {
      physValue[] values;

      if (time - getCurrentTime() >= deltatime)
      {
        values= doMeasurement(param);

        addMeasurement(time, values);
      }
      else
        values= getCurrentMeasurementVector();

      return values;
    }

    /// <summary>
    /// Do measurements which depend on substrates. 
    /// 
    /// 3rd type
    /// 
    /// example sensor: 
    /// substrate_sensor, VS_sensor
    /// </summary>
    /// <param name="time">current simulation time [days]</param>
    /// <param name="deltatime">sample time of the sensor [days]</param>
    /// <param name="x">could be the state vector</param>
    /// <param name="mySubstrates"></param>
    /// <param name="Q">could be stream of substrates [m^3/d]</param>
    /// <param name="par">some doubles</param>
    /// <returns>measured values</returns>
    public physValue[] measure(double time, double deltatime,
                               double[] x, biogas.substrates mySubstrates, 
                               double[] Q, params double[] par)
    {
      physValue[] values;

      if (time - getCurrentTime() >= deltatime)
      {
        values= doMeasurement(x, mySubstrates, Q, par);

        addMeasurement(time, values);
      }
      else
        values= getCurrentMeasurementVector();

      return values;
    }
    /// <summary>
    /// Do measurements which depend on substrates. 
    /// 
    /// 3rd type
    /// 
    /// example sensor: 
    /// substrate_sensor
    /// </summary>
    /// <param name="time">current simulation time [days]</param>
    /// <param name="deltatime">sample time of the sensor [days]</param>
    /// <param name="mySubstrates"></param>
    /// <param name="Q">could be stream of substrates [m^3/d]</param>
    /// <param name="par">some doubles</param>
    /// <returns>measured values</returns>
    public physValue[] measure(double time, double deltatime,
                               biogas.substrates mySubstrates,
                               double[] Q, params double[] par)
    {
      double[] x= new double[1];

      return measure(time, deltatime, x, mySubstrates, Q, par);
    }

    /// <summary>
    /// Do measurements which depend on plant. 
    /// 
    /// 4th type
    /// 
    /// example sensor:
    /// used by pumpEnergy_sensor
    /// </summary>
    /// <param name="time">current simulation time [days]</param>
    /// <param name="deltatime">sample time of the sensor [days]</param>
    /// <param name="myPlant"></param>
    /// <param name="u">could be gas stream or state vector</param>
    /// <param name="par">some doubles</param>
    /// <returns>measured values</returns>
    public physValue[] measure(double time, double deltatime,
                               biogas.plant myPlant,
                               double u, params double[] par)
    {
      physValue[] values;

      if (time - getCurrentTime() >= deltatime)
      {
        values = doMeasurement(myPlant, u, par);

        addMeasurement(time, values);
      }
      else
        values = getCurrentMeasurementVector();

      return values;
    }

    /// <summary>
    /// Do measurements which depend on plant. 
    /// 
    /// used by Norg, Ntot, TKN sensors
    /// 
    /// 5th type
    /// 
    /// example sensor: 
    /// at the end called by biogas_chp_plant
    /// d.h.: energyProduction_sensor
    /// </summary>
    /// <param name="time">current simulation time [days]</param>
    /// <param name="deltatime">sample time of the sensor [days]</param>
    /// <param name="myPlant"></param>
    /// <param name="u">could be gas stream or state vector</param>
    /// <param name="param">some string</param>
    /// <param name="par">some doubles</param>
    /// <returns>measured values</returns>
    public physValue[] measure(double time, double deltatime,
                               biogas.plant myPlant, 
                               double[] u, string param, params double[] par)
    {
      physValue[] values;

      if (time - getCurrentTime() >= deltatime)
      {
        values= doMeasurement(myPlant, u, param, par);

        addMeasurement(time, values);
      }
      else
        values= getCurrentMeasurementVector();

      return values;
    }

    /// <summary>
    /// Do measurements which depend on plant and substrates. 
    /// 
    /// 6th type
    /// 
    /// example sensor:
    /// wird von heatConsumption_sensor genutzt
    /// </summary>
    /// <param name="time">current simulation time [days]</param>
    /// <param name="deltatime">sample time of the sensor [days]</param>
    /// <param name="myPlant"></param>
    /// <param name="mySubstrates"></param>
    /// <param name="Q">could be substrate stream [m^3/d]</param>
    /// <param name="par">some doubles</param>
    /// <returns>measured values</returns>
    public physValue[] measure(double time, double deltatime,
                               biogas.plant myPlant, biogas.substrates mySubstrates,
                               double[] Q, params double[] par)
    {
      physValue[] values;

      if (time - getCurrentTime() >= deltatime)
      {
        values= doMeasurement(myPlant, mySubstrates, Q, par);

        addMeasurement(time, values);
      }
      else
        values= getCurrentMeasurementVector();

      return values;
    }

    /// <summary>
    /// Do measurements which depend on plant and substrates and other measurements. 
    /// 
    /// 7th type
    /// 
    /// example sensors:
    /// called by TS sensor
    /// OLR_sensor
    /// density_sensor
    /// </summary>
    /// <param name="time">current simulation time [days]</param>
    /// <param name="deltatime">sample time of the sensor [days]</param>
    /// <param name="x">could be state vector</param>
    /// <param name="myPlant"></param>
    /// <param name="mySubstrates"></param>
    /// <param name="mySensors"></param>
    /// <param name="Q">could be substrate stream [m^3/d]</param>
    /// <param name="par">some doubles</param>
    /// <returns>measured values</returns>
    public physValue[] measure(double time, double deltatime,
                               double[] x, biogas.plant myPlant, 
                               biogas.substrates mySubstrates,
                               biogas.sensors mySensors,
                               double[] Q, params double[] par)
    {
      physValue[] values;

      if (time - getCurrentTime() >= deltatime)
      {
        values = doMeasurement(x, myPlant, mySubstrates, mySensors, Q, par);

        addMeasurement(time, values);
      }
      else
        values = getCurrentMeasurementVector();

      return values;
    }

    /// <summary>
    /// Do measurements which depend on fitness_params. 
    /// 
    /// 8th type
    /// 
    /// example sensor:
    /// used by all fitness sensors
    /// </summary>
    /// <param name="time">current simulation time [days]</param>
    /// <param name="deltatime">sample time of the sensor [days]</param>
    /// <param name="myPlant"></param>
    /// <param name="myFitnessParams"></param>
    /// <param name="mySensors"></param>
    /// <param name="par">some doubles</param>
    /// <returns>measured values</returns>
    public physValue[] measure(double time, double deltatime,
                               biogas.plant myPlant, biooptim.fitness_params myFitnessParams,
                               biogas.sensors mySensors, params double[] par)
    {
      physValue[] values;

      if (time - getCurrentTime() >= deltatime)
      {
        values = doMeasurement(myPlant, myFitnessParams, mySensors, par);

        addMeasurement(time, values);
      }
      else
        values = getCurrentMeasurementVector();

      return values;
    }

    /// <summary>
    /// Do measurements which depend on substrate and sensors. 
    /// 
    /// 9th type
    /// 
    /// example sensor:
    /// used by manurebonus sensor
    /// </summary>
    /// <param name="time">current simulation time [days]</param>
    /// <param name="deltatime">sample time of the sensor [days]</param>
    /// <param name="mySubstrates"></param>
    /// <param name="mySensors"></param>
    /// <param name="par">some doubles</param>
    /// <returns>measured values</returns>
    public physValue[] measure(double time, double deltatime,
                               biogas.substrates mySubstrates,
                               biogas.sensors mySensors, params double[] par)
    {
      physValue[] values;

      if (time - getCurrentTime() >= deltatime)
      {
        values = doMeasurement(mySubstrates, mySensors, par);

        addMeasurement(time, values);
      }
      else
        values = getCurrentMeasurementVector();

      return values;
    }



    // -------------------------------------------------------------------------------------
    //                            !!! PROTECTED METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// this method must be implemented by every sensor
    /// 
    /// 0st type, sensors of type 0 call this method (stream sensors)
    /// examples: NH4, Sac, ...
    /// and also 1st type (with par: HRT sensor)
    /// </summary>
    /// <param name="x">could be state vector</param>
    /// <param name="par">some doubles: HRT (Vliq)</param>
    /// <returns>measured values</returns>
    abstract protected physValue[] doMeasurement(double[] x, params double[] par);

    /// <summary>
    /// the further doMeasurement methods are optional for the sensors
    /// 
    /// 2nd type, sensors of type 2 call this method
    /// 
    /// example: fitness_sensor
    /// </summary>
    /// <param name="param">some double</param>
    /// <returns>measured values</returns>
    /// <exception cref="exception">Not implemented</exception>
    virtual protected physValue[] doMeasurement(double param)
    {
      throw new exception("Not implemented!");
    }

    /// <summary>
    /// Do measurements which depend on substrates. 
    /// 
    /// type 3
    /// 
    /// Example: 
    /// substrate_sensor
    /// </summary>
    /// <param name="x">could be state vector</param>
    /// <param name="mySubstrates"></param>
    /// <param name="Q">could be substrate stream</param>
    /// <param name="par">some doubles</param>
    /// <returns>measured values</returns>
    /// <exception cref="exception">Not implemented</exception>
    virtual protected physValue[] doMeasurement(double[] x, biogas.substrates mySubstrates,
                                                double[] Q, params double[] par)
    {
      throw new exception("Not implemented!");
    }

    /// <summary>
    /// used by pumpEnergy_sensor
    /// 
    /// type 4
    /// </summary>
    /// <param name="myPlant"></param>
    /// <param name="u"></param>
    /// <param name="par">some doubles</param>
    /// <returns>measured values</returns>
    /// <exception cref="exception">Not implemented</exception>
    virtual protected physValue[] doMeasurement(biogas.plant myPlant,
                                                double u, params double[] par)
    {
      throw new exception("Not implemented!");
    }

    /// <summary>
    /// used by Norg, Ntot, TKN_sensor, there u is state vector
    /// 
    /// type 5
    ///
    /// Example: 
    /// at the end called by biogas_chp_plant
    /// d.h.: energyProduction_sensor
    /// </summary>
    /// <param name="myPlant"></param>
    /// <param name="u">could be biogas flow, could also be state vector</param>
    /// <param name="param">some string</param>
    /// <param name="par">some doubles</param>
    /// <returns>measured values</returns>
    /// <exception cref="exception">Not implemented</exception>
    virtual protected physValue[] doMeasurement(biogas.plant myPlant,
                                                double[] u, string param, 
                                                params double[] par)
    {
      throw new exception("Not implemented!");
    }

    /// <summary>
    /// type 6
    /// 
    /// Example:
    /// used by heatConsumption_sensor
    /// </summary>
    /// <param name="myPlant"></param>
    /// <param name="mySubstrates"></param>
    /// <param name="Q">could be substrate stream</param>
    /// <param name="par">some doubles</param>
    /// <returns>measured values</returns>
    /// <exception cref="exception">Not implemented</exception>
    virtual protected physValue[] doMeasurement(biogas.plant myPlant, 
                                                biogas.substrates mySubstrates,
                                                double[] Q, params double[] par)
    {
      throw new exception("Not implemented!");
    }

    /// <summary>
    /// called by TS sensor, OLR sensor, density sensor and heatConsumption_sensor
    /// 
    /// type 7
    /// </summary>
    /// <param name="x">stream vector</param>
    /// <param name="myPlant"></param>
    /// <param name="mySubstrates"></param>
    /// <param name="mySensors"></param>
    /// <param name="Q">substrate feed and recirculation sludge going into the digester</param>
    /// <param name="par">some doubles</param>
    /// <returns>measured values</returns>
    /// <exception cref="exception">Not implemented</exception>
    virtual protected physValue[] doMeasurement(double[] x, biogas.plant myPlant,
                                                biogas.substrates mySubstrates,
                                                biogas.sensors mySensors, 
                                                double[] Q, params double[] par)
    {
      throw new exception("Not implemented!");
    }

    /// <summary>
    /// used by all fitness sensors
    /// 
    /// type 8
    /// </summary>
    /// <param name="myPlant"></param>
    /// <param name="myFitnessParams"></param>
    /// <param name="mySensors"></param>
    /// <param name="par">some doubles</param>
    /// <returns>measured values</returns>
    /// <exception cref="exception">Not implemented</exception>
    virtual protected physValue[] doMeasurement(biogas.plant myPlant, 
      biooptim.fitness_params myFitnessParams, biogas.sensors mySensors, params double[] par)
    {
      throw new exception("Not implemented!");
    }

    /// <summary>
    /// used by manurebonus sensor
    /// 
    /// type 9
    /// </summary>
    /// <param name="mySubstrates"></param>
    /// <param name="mySensors"></param>
    /// <param name="par">some doubles</param>
    /// <returns>measured values</returns>
    /// <exception cref="exception">Not implemented</exception>
    virtual protected physValue[] doMeasurement(biogas.substrates mySubstrates,
      biogas.sensors mySensors, params double[] par)
    {
      throw new exception("Not implemented!");
    }



  }



}


