/**
 * This file is part of the partial class sensors and defines
 * measure_type methods of the class.
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
    /// call measure of all type0 sensors
    /// 
    /// type 0
    /// 
    /// TODO : evtl. type 0 and type 1 mal zusammen fassen, geht aber nicht
    /// so lange von einem sammelsensor von matlab aus aufgerufen wird
    /// </summary>
    /// <param name="time">current simulation time in days</param>
    /// <param name="x">stream vector usually 34 dim.</param>
    /// <param name="digester_id">ID of digester</param>
    /// <param name="in_out">2 for in, 3 for out</param>
    public void measure_type0(double time, //double deltatime, 
                              double[] x, string digester_id, int in_out)
    {
      foreach (string id in ids_type0)
      {
        // only those who are in or out and who belong to given digester
        // TODO weiterhin ein Problem, wenn 1. Dig: dig1 und zweiter digester
        // dummy_dig1 heißt, hatten wir nicht ohnehin definiert, dass digester
        // ID keinen Unterstrich haben darf? s. gui_plant??? dann wäre das hier ok.
        if (id.EndsWith("_" + digester_id + "_" + Convert.ToString(in_out)) &&
            id.Contains(digester_id))
        {
          measure(time, id, x);
        }
      }
    }

    /// <summary>
    /// Call measure of all type 1 sensors
    /// Methode macht nicht so viel Sinn...
    /// 
    /// type 1
    /// 
    /// eigentlich nur von HRT Sensor genutzt
    /// </summary>
    /// <param name="time">current simulation time in days</param>
    /// <param name="x">stream vector usually 34 dim.</param>
    /// <param name="digester_id">ID of digester</param>
    /// <param name="par">used by HRT sensor: Vliq</param>
    public void measure_type1(double time, //double deltatime, 
      double[] x, string digester_id, params double[] par)
    {
      foreach (string id in ids_type1)
      {
        // TODO weiterhin ein Problem, wenn 1. Dig: dig1 und zweiter digester
        // dummy_dig1 heißt, hatten wir nicht ohnehin definiert, dass digester
        // ID keinen Unterstrich haben darf? s. gui_plant??? dann wäre das hier ok.
        if (id.Contains("_" + digester_id))
          measure(time, id, x, par);
      }
    }



    /// <summary>
    /// Call measure of all type 7 sensors
    /// 
    /// type 7
    /// 
    /// used by OLR, TS and density sensor
    /// </summary>
    /// <param name="time">current simulation time in days</param>
    /// <param name="x">stream vector usually 34 dim.</param>
    /// <param name="myPlant"></param>
    /// <param name="mySubstrates"></param>
    /// <param name="mySensors"></param>
    /// <param name="substrate_network"></param>
    /// <param name="plant_network"></param>
    /// <param name="digester_id">ID of digester</param>
    public void measure_type7(double time, //double deltatime, 
      double[] x, biogas.plant myPlant, biogas.substrates mySubstrates,
                        biogas.sensors mySensors,
                        double[,] substrate_network, double[,] plant_network,
                        string digester_id)
    {
      double value;

      foreach (string id in ids_type7)
      {
        // TODO weiterhin ein Problem, wenn 1. Dig: dig1 und zweiter digester
        // dummy_dig1 heißt, hatten wir nicht ohnehin definiert, dass digester
        // ID keinen Unterstrich haben darf? s. gui_plant??? dann wäre das hier ok.
        if (id.Contains("_" + digester_id))
          measure(time, id, x, myPlant, mySubstrates, mySensors,
                  substrate_network, plant_network, digester_id, out value);
      }
    }

    /// <summary>
    /// Call measure of all type 8 sensors
    /// 
    /// type 8
    /// 
    /// used by fitness sensors
    /// </summary>
    /// <param name="time">current simulation time in days</param>
    /// <param name="myPlant"></param>
    /// <param name="myFitnessParams"></param>
    /// <param name="par"></param>
    public void measure_type8(double time, //double deltatime, 
      biogas.plant myPlant, biooptim.fitness_params myFitnessParams, double par)
    {
      double value;

      foreach (string id in ids_type8)
      {
        measure(time, id, myPlant, myFitnessParams, par, out value);
      }
    }



  }
}


