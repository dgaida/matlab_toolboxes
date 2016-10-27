/**
 * This file defines the objective object.
 * 
 * TODOs:
 * - berechnung energieverbrauch von rührwerke verbessern
 * - weitere ...
 * 
 * Because of that not FINISHED!
 * 
 */

using System;
using System.Collections.Generic;
using System.Text;
using science;

/**
 * namespace for biogas plant optimization
 * 
 * Definition of:
 * - fitness_params
 * - objective function
 * - weights used inside objective function
 * 
 */
namespace biooptim
{
  /// <summary>
  /// defines objective function
  /// </summary>
  public partial class objectives
  {

    // -------------------------------------------------------------------------------------
    //                              !!! PRIVATE METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// Calculation of total electrical energy consumption
    /// 
    /// returns energy consumption of 
    /// - pumps
    /// - mixer
    /// 
    /// in kWh/d
    /// </summary>
    /// <param name="myPlant"></param>
    /// <param name="mySensors"></param>
    /// <param name="energyConsumptionPump">el. energy consumption of pumps [kWh/d]</param>
    /// <param name="energyConsumptionMixer">el. energy consumption of stirrer [kWh/d]</param>
    /// <returns></returns>
    private static double getElEnergyConsumption(biogas.plant myPlant, biogas.sensors mySensors, 
      out double energyConsumptionPump, out double energyConsumptionMixer)
    {
      double energyConsumption = 0;
      energyConsumptionPump = 0;
      energyConsumptionMixer = 0;
      
      //
      
      int n_digester = myPlant.getNumDigesters();

      for (int idigester = 0; idigester < n_digester; idigester++)
      {
        string digester_id = myPlant.getDigesterID(idigester + 1);

        // Idee: zu energieverbrauch gehören auch Rührwerke, Rührwerksleistung soll
        // von TS im Fermenter abhängig sein.
        // folgende Formel:
        // Energieverbrauch [kWh/d] = V_fermenter * 1 kWh/(d * 100 m³) * TS [%]
        // 
        // frei nach der Quelle: 
        // Empfehlung für die Auswahl von Rührwerken...


        // mixer

        //double V_digester= myPlant.getDigesterParam(digester_id, "Vliq");
  
        //double TS= mySensors.getCurrentMeasurement("TS" + "_" + digester_id + "_3").Value;
         
        double Pel_mixer;

        physValue[] e_mixer = mySensors.getCurrentMeasurementVector("stirrer_" + digester_id);

        Pel_mixer = e_mixer[0].Value;

        energyConsumptionMixer += Pel_mixer;//V_digester / 100 * TS;
      }


      // pumps

      for (int ipump= 0; ipump < myPlant.getNumPumps(); ipump++)
      {
        string pump_id= myPlant.getPumpID(ipump + 1);
        
        double pump_energy;
        
        mySensors.getCurrentMeasurementD("pumpEnergy_" + pump_id, out pump_energy);
        
        // pump energy per day
        // P(t) [kWh/d]
        energyConsumptionPump += pump_energy;   
      }

      // substrate_transport

      for (int isubstrate_transport = 0; 
               isubstrate_transport < myPlant.getNumSubstrateTransports(); isubstrate_transport++)
      {
        string substrate_transport_id = myPlant.getSubstrateTransportID(isubstrate_transport + 1);

        double pump_energy;

        mySensors.getCurrentMeasurementD("pumpEnergy_" + substrate_transport_id, out pump_energy);

        // pump energy per day
        // P(t) [kWh/d]
        energyConsumptionPump += pump_energy;

        mySensors.getCurrentMeasurementD("transportEnergy_" + substrate_transport_id, out pump_energy);

        // pump energy per day
        // P(t) [kWh/d]
        energyConsumptionPump += pump_energy;
      }


      // sum in kWh/d
      // Vorsicht: energy von bakterien wird als produktion nicht als verbrauch
      // angesehen, deshalb hier neg. VZ
      energyConsumption= energyConsumptionPump + energyConsumptionMixer;

      return energyConsumption;
    }

    /// <summary>
    /// Calculation of total thermal energy consumption
    /// 
    /// returns thermal energy consumption of 
    /// - heating
    /// - microbiology (production)
    /// - mixer (production)
    /// 
    /// in kWh/d
    /// </summary>
    /// <param name="myPlant"></param>
    /// <param name="mySensors"></param>
    /// <param name="energyConsumptionHeat">thermal energy consumption of heat losses [kWh/d]</param>
    /// <param name="energyProdMixer">th. energy prod. of stirrer [kWh/d]</param>
    /// <param name="energyProdMicro">th. energy prod. by micros [kWh/d]</param>
    /// <returns></returns>
    private static double getThermalEnergyConsumption(biogas.plant myPlant, biogas.sensors mySensors,
      out double energyConsumptionHeat, 
      out double energyProdMixer, out double energyProdMicro)
    {
      double energyConsumption = 0;
      energyConsumptionHeat = 0;
      energyProdMixer = 0;      // heat energy dissipated to digester in kWh/d
      energyProdMicro = 0;

      //

      int n_digester = myPlant.getNumDigesters();

      for (int idigester = 0; idigester < n_digester; idigester++)
      {
        string digester_id = myPlant.getDigesterID(idigester + 1);

        biogas.digester myDigester = myPlant.getDigester(idigester + 1);

        // heating

        physValue[] heat_v = mySensors.getCurrentMeasurementVector("heatConsumption_" + digester_id);

        // inflow heating
        // thermal Energie welche benötigt wird um das Substrat aufzuheizen
        // \frac{kWh}{d}
        energyConsumptionHeat += heat_v[0].Value;

        // radiation loss energy
        // thermal Energie, welche die Heizungen benötigen um die
        // Wärmeverluste auszugleichen
        // \frac{kWh}{d}
        energyConsumptionHeat += heat_v[1].Value;

        // produced heat by bacteria in digester [kWh/d]
        // das ist eine thermische, keine elektrische energie
        energyProdMicro += heat_v[2].Value;

        // thermal energy production by stirrer through dissipation
        // \frac{kWh}{d}
        energyProdMixer += heat_v[3].Value;
      }

      // sum in kWh/d
      // Vorsicht: energy von bakterien wird als produktion nicht als verbrauch
      // angesehen, deshalb hier neg. VZ
      energyConsumption = energyConsumptionHeat - energyProdMicro - energyProdMixer;

      return energyConsumption;
    }

    ///// <summary>
    ///// Calculates electrical and thermal energy production in [kWh/d]
    ///// </summary>
    ///// <param name="myPlant"></param>
    ///// <param name="mySensors"></param>
    ///// <param name="energyThermProduction">thermal energy production [kWh/d]</param>
    ///// <returns>electrical energy production [kWh/d]</returns>
    //private static double getEnergyProduction(biogas.plant myPlant, biogas.sensors mySensors,
    //  out double energyThermProduction)
    //{ 
    //  // Calculation of overall electrical + thermal energy production

    //  double energyProduction= 0;

    //  energyThermProduction= 0;

    //  for (int ibhkw= 0; ibhkw < myPlant.getNumCHPs(); ibhkw++)
    //  {
    //    string bhkw_id= myPlant.getCHPID(ibhkw + 1);

    //    // electrical energy production

    //    physValue[] energy_v= mySensors.getCurrentMeasurementVector("energyProduction_" + bhkw_id);
        
    //    energyProduction += energy_v[0].Value;

    //    // thermal energy production

    //    energyThermProduction += energy_v[1].Value;
    //  }

    //  return energyProduction;
    //}

    /// <summary>
    /// Calc max electrical energy production possible on given plant
    /// </summary>
    /// <param name="myPlant"></param>
    /// <returns>max. el. energy production in [kWh/d]</returns>
    private static double getMaxElEnergyProduction(biogas.plant myPlant)
    {
      //double energyProductionMax = 0;

      //for (int ibhkw = 0; ibhkw < myPlant.getNumCHPs(); ibhkw++)
      //{
      //  string bhkw_id = myPlant.getCHPID(ibhkw + 1);

      //  energyProductionMax += myPlant.getCHPParam(bhkw_id, "Pel") * 24;
      //}

      //return energyProductionMax;

      return myPlant.getMaxElEnergy().Value;
    }

        

  }
}


