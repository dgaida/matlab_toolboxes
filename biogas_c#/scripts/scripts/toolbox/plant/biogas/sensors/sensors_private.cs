/**
 * This file is part of the partial class sensors and defines
 * the private methods of the class.
 * 
 * TODOs:
 * - getPumpedInputFlowForFermenter: hier wird eine nicht gültige Annahme gemacht, ist jetzt OK
 * 
 * FINISHED!
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
    //                              !!! PRIVATE METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// Calculates the volumeflow of each substrate going into the given digester digester_id.
    /// The substrate flows are returned as a vector.
    /// 
    /// TODO: ist nicht mehr private
    /// </summary>
    /// <param name="t">current simulation time</param>
    /// <param name="mySubstrates"></param>
    /// <param name="myPlant"></param>
    /// <param name="mySensors"></param>
    /// <param name="substrate_network"></param>
    /// <param name="digester_id">id of the digester which is fed</param>
    /// <returns>
    /// always a vector with as many elements as there are substrates on the plant
    /// </returns>
    public static physValue[] getSubstrateMixFlowForFermenter(double t, biogas.substrates mySubstrates, 
                        biogas.plant myPlant, sensors mySensors, double[,] substrate_network, 
                        string digester_id)
    {
      int digester_index= myPlant.getDigesterIndex(digester_id) - 1;

      // get recorded substrate feeds in m³/d
      physValue[] Q= mySensors.getMeasurementsAt("Q", "Q", t, mySubstrates);

      // make the sum over the 2nd dimension, the digesters
      double[] norm_vec= math.sum(substrate_network, 1);

      double[] substrate_digester= new double[substrate_network.GetLength(0)];

      for (int isubstrate= 0; isubstrate < substrate_network.GetLength(0); isubstrate++)
      {
        // what is if norm_vec is 0 for an element
        // then we have 0/0. 
        if (norm_vec[isubstrate] != 0)
        {
          substrate_digester[isubstrate] =
                    substrate_network[isubstrate, digester_index] /
                             norm_vec[isubstrate];
        }
        else
        {
          substrate_digester[isubstrate] = 0;
        }
      }

      // this is the amount of each substrate going into the given digester
      Q= physValue.times(Q, substrate_digester);

      return Q;
    }

    /// <summary>
    /// Calculates the slduge input of the given digester. It checks for each digester
    /// whether it is connected to the input of the given digester. If so the flow
    /// coming from the digester is returned in the vector at the corresponding position. 
    /// </summary>
    /// <param name="t">some simulation time in days</param>
    /// <param name="mySubstrates"></param>
    /// <param name="myPlant"></param>
    /// <param name="mySensors"></param>
    /// <param name="substrate_network"></param>
    /// <param name="plant_network"></param>
    /// <param name="digester_id">
    /// digester for which the sludge input is calculated
    /// </param>
    /// <returns>dimension: number of digesters</returns>
    private physValue[] getPumpedInputFlowForFermenter(double t, biogas.substrates mySubstrates,
                        biogas.plant myPlant, sensors mySensors,
                        double[,] substrate_network, double[,] plant_network,
                        string digester_id)
    {
      int digester_index= myPlant.getDigesterIndex(digester_id) - 1;
      
      // vector tells us what input connections the given fermenter has
      double[] digester_network= new double[myPlant.getNumDigesters()];

      for (int idigester= 0; idigester < plant_network.GetLength(0); idigester++)
      {
        digester_network[idigester]= plant_network[idigester, digester_index];
      }

      string digester_id_in = digester_id;// myPlant.getDigesterID(digester_index + 1);

      int n_digester= myPlant.getNumDigesters();

      physValue[] Q= physValue.zeros(n_digester);

      //

      for (int idigester= 0; idigester < n_digester; idigester++)
      {
        if ((digester_network[idigester] > 0) && (digester_index != idigester))
        {
          string digester_id_out= myPlant.getDigesterID(idigester + 1);

          string digester_conn= digester_id_out + "_" + digester_id_in;

          try
          {
            // wenn wir eine pumpverbindung mit einem split haben, dann gibt es diese
            // messung, weil diese aus datei geholt wird: volumeflow_...mat
            Q[idigester]= mySensors.getMeasurementAt("Q", "Q_" + digester_conn, t);
          }
          catch
          {
            // macht hier die Annahme, dass das was in fermenter_id_out rein geht
            // auch mengenmaäßig raus geht und dann in fermenter_id_in rein geht.
            // diee annahme geht nur, wenn volumen constant ist.
            // TODO: und biogasstrom vernachlässigt wird
            //Q[idigester]= 
              //physValue.sum(getInputVolumeflowForFermenter(
              //              t, mySubstrates, myPlant, mySensors,
              //              substrate_network, plant_network, digester_id_out));

            // das sollte so viel einfacher möglich sein, und vor allem auch korrekt
            Q[idigester] = mySensors.getMeasurementAt("Q_" + digester_id_out + "_3", "", t);
          }

        }
        else
          Q[idigester]= new physValue(0, "m^3/d");
      }

      //

      return Q;

    }

    /// <summary>
    /// Returns a vector of volumeflows for the given digester digester_id.
    /// first elements are the feeds for each substrate followed by the flows
    /// going over each incoming connection to the digester.
    /// </summary>
    /// <param name="t">current simulation time</param>
    /// <param name="mySubstrates"></param>
    /// <param name="myPlant"></param>
    /// <param name="mySensors"></param>
    /// <param name="substrate_network"></param>
    /// <param name="plant_network"></param>
    /// <param name="digester_id"></param>
    /// <returns></returns>
    private physValue[] getInputVolumeflowForFermenter(double t, biogas.substrates mySubstrates,
                        biogas.plant myPlant, sensors mySensors,
                        double[,] substrate_network, double[,] plant_network,
                        string digester_id)
    {
      // get volumeflow of substrates into fermenter as column vector

      physValue[] Q_digester= getSubstrateMixFlowForFermenter(t, mySubstrates, myPlant, 
                                  mySensors, substrate_network, digester_id);


      // get recirculated volumflow of other fermenters into this fermenter as
      // column vector

      physValue[] Q_pumped= getPumpedInputFlowForFermenter(t, mySubstrates,
                                  myPlant, mySensors, 
                                  substrate_network, plant_network, digester_id);

      // concatenate both vectors vertically

      return physValue.concat(Q_digester, Q_pumped);
    }
    


  }
}


