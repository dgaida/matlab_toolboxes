/**
 * This file defines parivate method for the class gasexcess_fit_sensor.
 * 
 * TODOs:
 * - alle methoden sind abhängig von definitionen anderswo, hier insbesondere
 *   biogas produktion
 * 
 * Apart of that FINISHED!
 * 
 */

using System;
using System.Collections.Generic;
using System.Text;
using science;

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
    //                              !!! PUBLIC METHODS !!!
    // -------------------------------------------------------------------------------------
    
    /// <summary>
    /// Sell produced electrical and thermal energy.
    /// returns money we make by selling the energy in [€/d]
    /// </summary>
    /// <param name="energyProduction">electrical energy production in kWh/d</param>
    /// <param name="energyThermProduction">thermal energy production in kWh/d</param>
    /// <param name="myPlant"></param>
    /// <param name="myFitnessParams"></param>
    /// <returns></returns>
    public static double sellEnergy(double energyProduction, double energyThermProduction,
      biogas.plant myPlant, biooptim.fitness_params myFitnessParams)
    {
      // how much is paid for electrical energy production in €/kWh
      // sellCurrent measured in €/kWh
      double sellCurrent = myPlant.getVerguetung(energyProduction / 24, myFitnessParams.manurebonus);

      // energyProduction : produced electrical energy (power) [kWh/d]
      // energyThermProduction : produced thermal energy (power) [kWh/d]
      //
      // moneyEnergy is the money you get by selling electrical and thermal power
      // €/d = kWh/d * €/kWh
      double moneyEnergy = energyProduction * sellCurrent +
                          energyThermProduction * myPlant.myFinances.revenueTherm.Value;

      return moneyEnergy;
    }



    // -------------------------------------------------------------------------------------
    //                              !!! PRIVATE METHODS !!!
    // -------------------------------------------------------------------------------------
        
    /// <summary>
    /// Calc loss in €/d due to in excess produced biogas
    /// </summary>
    /// <param name="biogas_v">measured biogas vector gotten out of sensors</param>
    /// <param name="substrate_costs">costs for substrates in [€/d]</param>
    /// <param name="myPlant"></param>
    /// <param name="myFitnessParams"></param>
    /// <param name="biogasExcess">in excess produced biogas [m^3/d]</param>
    /// <returns></returns>
    private static double calcLossDueToBiogasExcess(physValue[] biogas_v, double substrate_costs,
      biogas.plant myPlant, biooptim.fitness_params myFitnessParams, out double biogasExcess)
    {
    
      double H2Concentration= biogas_v[1].Value;         // ppm
      double methaneConcentration= biogas_v[2].Value;    // %
      double CO2Concentration= biogas_v[3].Value;        // %

      // in excess produced biogas in [m^3/d]
      biogasExcess= biogas_v[biogas_v.Length - 1].Value;

      //

      double[] u= new double[3];

      // biogas excess in m³/d
      u[0]= biogasExcess * H2Concentration / 1000000;
      u[1]= biogasExcess * methaneConcentration / 100;
      u[2]= biogasExcess * CO2Concentration / 100;

      
      // €/d : get monetary value of in excess produced biogas. which amount of
      // money would we earn when we had sell the energy produced by the in excess
      // produced biogas? 
      double valueMethaneExcess= calcValueOfMethaneExcess(u, myPlant, myFitnessParams);

      
      // m³/d : total biogas production
      double total_biogas_prod= biogas_v[0].Value;

      
      // costs of substrates needed to produce the excess methane amount in €/d
      double substrateCostsMethaneExcess= 
        calcSubstrateCostsForMethaneExcess(biogasExcess, methaneConcentration, 
                                           substrate_costs, total_biogas_prod);

      
      // since complete substrate costs are already included in fitness function.
      // therefore we only may add the difference of the value of the methane and
      // the substrate costs needed to produce it. this value is always positive,
      // because methane is more worse then the substates needed to produce it. 
      double lossBiogasExcess= valueMethaneExcess - substrateCostsMethaneExcess;

      //

      if (lossBiogasExcess < 0)
      {
        // TODO - throw error
        //error('loss: %f < 0, value: %f, costs: %f', ...
        //lossBiogasExcess, valueMethaneExcess, substrateCostsMethaneExcess);
        //throw new toolbox.exception(String.Format("lossBiogasExcess < 0: {0}", lossBiogasExcess));
      }

      return lossBiogasExcess;
    }

    /// <summary>
    /// Calc monetary value of in excess produced methane in €/d
    /// </summary>
    /// <param name="u">u - 3dim vector of in excess produced biogas in m³/d 
    /// h2, ch4, co2</param>
    /// <param name="myPlant"></param>
    /// <param name="myFitnessParams"></param>
    /// <returns></returns>
    private static double calcValueOfMethaneExcess(double[] u, biogas.plant myPlant,
      biooptim.fitness_params myFitnessParams)
    {
      string bhkw_id= myPlant.getCHPID(1);

      // electrical and thermal energy produced by in excess produced biogas
      // measured in kWh/d
      double Pel_kWh_d, Ptherm_kWh_d;
      
      myPlant.burnBiogas( bhkw_id, u, out Pel_kWh_d, out Ptherm_kWh_d );

      //

      // €/d : get money that we would get by selling produced energy
      double valueMethaneExcess= sellEnergy(Pel_kWh_d, Ptherm_kWh_d, 
                                     myPlant, myFitnessParams);

      return valueMethaneExcess;
    }

    /// <summary>
    /// Calculate substrate costs for in excess produced methane in €/d
    /// </summary>
    /// <param name="biogasExcess">in excess produced biogas in m³/d</param>
    /// <param name="methaneConcentration">CH4 concentration in the biogas in %</param>
    /// <param name="substrate_costs">costs of substrates in €/d</param>
    /// <param name="total_biogas_prod">total biogas production in m³/d</param>
    /// <returns></returns>
    private static double calcSubstrateCostsForMethaneExcess(double biogasExcess, 
      double methaneConcentration, double substrate_costs, double total_biogas_prod)
    {
      // biogasExcess : in excess produced biogas in m³/d
      // methaneConcentration : CH4 concentration in the biogas in %
      // substrate_costs : costs of substrates in €/d
      // total_biogas_prod : total biogas production in m³/d
            
      // methane content in excess biogas in m³/d
      double methaneExcess= biogasExcess * methaneConcentration / 100;
      // total methane production in m³/d
      double total_methane_prod= total_biogas_prod * methaneConcentration / 100;

      double substrateCostsMethaneExcess;
      
      // €/d = €/d / m³/d * m³/d
      // substrateCostsMethaneExcess : costs of substrate amount which produced in
      // excess produced methane
      if (total_methane_prod > 0)
        substrateCostsMethaneExcess= substrate_costs / total_methane_prod * methaneExcess;
      else
        substrateCostsMethaneExcess= 0;

      return substrateCostsMethaneExcess;
    }



  }
}


