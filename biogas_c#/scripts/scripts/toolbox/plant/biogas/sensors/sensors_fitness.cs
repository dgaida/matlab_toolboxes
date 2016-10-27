/**
 * This file is part of the partial class sensors and defines
 * fitness methods of the class.
 * 
 * TODOs:
 * - should be ok
 * 
 * Apart from that FINISHED!
 * 
 */

using System;
using System.Collections.Generic;
using System.Text;
using science;
using toolbox;
using biooptim;



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
  /// List of sensors
  /// 
  /// is a list of sensors. The ids of the sensors inside this list
  /// are also saved inside the list ids. Next to sensors
  /// it also can contain sensor_arrays, which are an array of sensors.
  /// Sensors are grouped in different groups, dependent on the measure call syntax
  /// they have (those are the types: 0, 1, 2, ...).
  /// </summary>
  public partial class sensors : List<sensor>
  {

    // -------------------------------------------------------------------------------------
    //                              !!! PUBLIC METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// called by fitness_sensor in MATLAB
    /// </summary>
    /// <param name="time">current simulation time in days</param>
    /// <param name="myPlant"></param>
    /// <param name="myFitnessParams"></param>
    /// <param name="mySubstrates"></param>
    /// <param name="par"></param>
    public void measure_optim_params(double time, biogas.plant myPlant, 
      biooptim.fitness_params myFitnessParams, biogas.substrates mySubstrates, double par)
    {
      // measure substrate costs
      // Calculation of costs of substrate inflow
      // € / d
      double substrate_costs, manurebonus, udot;

      measure(time, "substrate_cost", mySubstrates, out substrate_costs);

      // measure whether current substrate feed qualifies for EEG2009 manure bonus
      measure(time, "manurebonus", mySubstrates, 0, out manurebonus);

      measure(time, "udot", mySubstrates, 0, out udot);

      // measure all other fitness sensors
      measure_type8(time, myPlant, myFitnessParams, par);
    }



    /// <summary>
    /// Calculate fitness value of digester measurements which must be between min and/or max
    /// </summary>
    /// <param name="myPlant"></param>
    /// <param name="mySensors"></param>
    /// <param name="var_id">"pH", "TS", ...</param>
    /// <param name="min_max">"min", "max" or "min_max"</param>
    /// <param name="myFitnessParams"></param>
    /// <param name="append_var_id">"_2" or "_3"</param>
    /// <param name="use_tukey">if true, then tukey function is used, leads to
    /// that returned value can be > 1. if false, then the fitness value
    /// is between 0 and 1.</param>
    /// <returns></returns>
    public static double calcFitnessDigester_min_max(biogas.plant myPlant, biogas.sensors mySensors,
      string var_id, string min_max, fitness_params myFitnessParams,
      string append_var_id, bool use_tukey)
    {
      double fitness = 0;

      int n_digester = myPlant.getNumDigesters();

      for (int idigester = 0; idigester < n_digester; idigester++)
      {
        string digester_id = myPlant.getDigesterID(idigester + 1);

        double variable;

        mySensors.getCurrentMeasurementD(var_id + "_" + digester_id + append_var_id, out variable);

        // 

        double punish_digester = 0;

        if ((min_max == "min") || (min_max == "min_max"))
        {
          double min_bound = myFitnessParams.get_param_of(var_id + "_min", idigester);

          if (!use_tukey)
          {
            punish_digester = Convert.ToDouble(variable < min_bound);
          }
          else
          {
            // if a boundary is violated then the penalty is at least 1, and bounded
            // by tukey biweight rho function
            // TODO : warum wollte ich das 1 + ... haben??? das macht die sache
            // nicht stetig, was sehr schlecht ist für skalierung und auch
            // für kriging
            punish_digester = Convert.ToDouble(variable < min_bound) *
                (0*1 + math.tukeybiweight(variable - min_bound));
          }
        }

        if ((min_max == "max") || (min_max == "min_max"))
        {
          double max_bound = myFitnessParams.get_param_of(var_id + "_max", idigester);

          if (!use_tukey)
          {
            punish_digester = Math.Max(punish_digester, Convert.ToDouble(variable > max_bound));
          }
          else
          {
            // if a boundary is violated then the penalty is at least 1, and bounded
            // by tukey biweight rho function
            // TODO : warum wollte ich das 1 + ... haben??? das macht die sache
            // nicht stetig, was sehr schlecht ist für skalierung und auch
            // für kriging
            punish_digester = Math.Max(punish_digester, Convert.ToDouble(variable > max_bound) *
                (0*1 + math.tukeybiweight(variable - max_bound)));
          }
        }

        fitness += punish_digester;
      }

      // values between 0 and 1, but if tukey function used, then may also be > 1
      fitness = fitness / n_digester;

      return fitness;
    }



  }
}


