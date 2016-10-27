/**
 * This file defines private methods of the setpoint_fit_sensor class.
 * 
 * TODOs:
 * - 
 * 
 * Apart of that FINISHED!
 * 
 */

using System;
using System.Collections.Generic;
using System.Text;
using science;
using biogas;

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
  /// Sensor measuring the setpoint_fitness of optimization runs
  /// </summary>
  public partial class setpoint_fit_sensor : biogas.sensor
  {

    // -------------------------------------------------------------------------------------
    //                              !!! PRIVATE METHODS !!!
    // -------------------------------------------------------------------------------------
        
    /// <summary>
    /// Calculates sum of setpoint control errors
    /// </summary>
    /// <param name="mySensors">sensors object with all measurements</param>
    /// <param name="myPlant">plant object</param>
    /// <param name="myFitnessParams">fitness params</param>
    /// <param name="noisy">if true then noisy measurements are used</param>
    /// <returns></returns>
    private static double calc_setpoint_errors(sensors mySensors, plant myPlant, 
                                               biooptim.fitness_params myFitnessParams, bool noisy)
    {
      double diff_setpoints = 0;  // to be returned value: control setpoint error

      double[] sim_t = mySensors.getTimeStream();
      
      double t= mySensors.getCurrentTime();

      double sim_val, ref_val;      // last simulated value and reference value at time t

      //

      if (sim_t.Length > 3)
      {
        foreach (biooptim.setpoint mySetpoint in myFitnessParams.mySetpoints)
        {

          if (mySetpoint.s_operator == "")    // then compare measurement of one sensor
          {
            string sensor_id= mySetpoint.sensor_id + "_" + mySetpoint.location;

            // get reference values always not noisy
            ref_val = mySensors.getMeasurementDAt(String.Format("ref_{0}_{1}", sensor_id, mySetpoint.index), 
                                                  "", t, 0, false);

            sim_val= mySensors.getCurrentMeasurementDind(sensor_id, mySetpoint.index, noisy);
          }
          else // compare measurement of a group of sensors, energy of all chps, gas of all digesters, ...
          {
            string s_operator= mySetpoint.location + "_" + mySetpoint.s_operator;

            // get reference values always not noisy
            ref_val = mySensors.getMeasurementDAt(
              String.Format("ref_{0}_{1}", mySetpoint.sensor_id, mySetpoint.index), 
              "", t, 0, false);

            sim_val= mySensors.getCurrentMeasurementDind(myPlant, mySetpoint.sensor_id, s_operator, 
                                                         mySetpoint.index, noisy);
          }

          diff_setpoints += mySetpoint.scalefac * Math.Pow(ref_val - sim_val, 2);

        }
      }

      return diff_setpoints;
    }



  }
}


