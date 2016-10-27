/**
 * This file defines the objective object.
 * 
 * TODOs:
 * - measure Q_total_mix_2, should be OK but not tested
 * - pH value fitness
 * - fitness berechnung als gewichtete summe
 * - weitere ...
 * 
 * Apart of that FINISHED!
 * 
 */

using System;
using System.Collections.Generic;
using System.Text;
using science;
using toolbox;

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
    /// Calc weighted sum of fitness values
    /// </summary>
    /// <param name="myFitnessParams"></param>
    /// <param name="SS_COD_fitness"></param>
    /// <param name="VS_COD_fitness"></param>
    /// <param name="pHvalue_fitness"></param>
    /// <param name="VFA_TAC_fitness"></param>
    /// <param name="TS_fitness"></param>
    /// <param name="VFA_fitness"></param>
    /// <param name="AcVsPro_fitness"></param>
    /// <param name="TAC_fitness"></param>
    /// <param name="OLR_fitness"></param>
    /// <param name="HRT_fitness"></param>
    /// <param name="N_fitness">NH3 and NH4 boundaries</param>
    /// <param name="CH4_fitness"></param>
    /// <param name="biogasExcess_fitness">wird in 1000 €/d Verlust gerechnet</param>
    /// <param name="Stability_punishment"></param>
    /// <param name="energyProd_fitness">is produced energy near max. producable energy</param>
    /// <param name="fitness_etaIE">
    /// fitness of removal capacity of intestinal enterococci: 0, ..., 1
    /// </param>
    /// <param name="fitness_etaFC">
    /// fitness of removal capacity of faecal coliforms: 0, ..., 1
    /// </param>
    /// <param name="diff_setpoints"></param>
    /// <returns></returns>
    private static double calcFitnessConstraints(fitness_params myFitnessParams, 
      double SS_COD_fitness, double VS_COD_fitness,
      //double VS_COD_degradationRate,
      double pHvalue_fitness, double VFA_TAC_fitness, double TS_fitness,
      double VFA_fitness, double AcVsPro_fitness, double TAC_fitness, double OLR_fitness,
      double HRT_fitness, double N_fitness, double CH4_fitness,
      double biogasExcess_fitness, double Stability_punishment,
      double energyProd_fitness, double fitness_etaIE, double fitness_etaFC, 
      double diff_setpoints)
    { 
      // TODO
      // anstatt biogasExcess / 20000
      // prüfen ob biogasExcess > 10 % der max. zu verarbietenden Biogasmenge,
      // d.h. > 110 % produzierte biogasmenge isngesamt, dann mit 1 * gewicht
      // bestrafen 

      double fitness_constraints=
                 myFitnessParams.myWeights.w_CSB * (SS_COD_fitness + VS_COD_fitness) +
                 // TODO macht der term sinn?
                 //myFitnessParams.myWeights.w_CSB * 1 / 3 * Convert.ToDouble(VS_COD_degradationRate < 65) +
                 myFitnessParams.myWeights.w_pH * pHvalue_fitness +
                 myFitnessParams.myWeights.w_TS * TS_fitness + 
                 // TODO - falls einfluss zu stark, dann noch mit w_money multiplizieren
                 myFitnessParams.myWeights.w_gasexc * biogasExcess_fitness + // wegen finanziellem Verlust
                 // und wegen Umweltbelastung, falls Biogas nicht ideal verbrennt, so oder so
                 // es wird CO2 erzeugt, was vorher mit energieaufwand angebaut wurde
                 // dieser term ist für umweltbelastung, einfach eine konstante -> 1
                 // linearer anstieg mit biogasExcess_fitness ist ja schon oben, muss nicht doppelt
                 // nicht > 0 machen, da matlab berechnung von excess gas komischerweise werte
                 // ganz knapp über 0 zurück gibt auch wenn sie 0 sind. wo da der fehler
                 // ist muss ich mal prüfen
                 // TODO - da ich keine Sprünge mag habe ich das auskommentiert!!!
                 //myFitnessParams.myWeights.w_gasexc * 1 / 2 * Convert.ToDouble(biogasExcess_fitness > 0.001) +
                 myFitnessParams.myWeights.w_CH4 * CH4_fitness +
                 myFitnessParams.myWeights.w_FOS_TAC * VFA_TAC_fitness +
                 myFitnessParams.myWeights.w_VFA * VFA_fitness +
                 myFitnessParams.myWeights.w_AcVsPro * AcVsPro_fitness +
                 myFitnessParams.myWeights.w_TAC * TAC_fitness +
                 myFitnessParams.myWeights.w_OLR * OLR_fitness +
                 myFitnessParams.myWeights.w_HRT * HRT_fitness +
                 myFitnessParams.myWeights.w_N * N_fitness +
                 myFitnessParams.myWeights.w_energy * energyProd_fitness + 
                 Stability_punishment + 
                 myFitnessParams.myWeights.w_faecal * (fitness_etaIE + fitness_etaFC) +
                 myFitnessParams.myWeights.w_setpoint * diff_setpoints;

      return fitness_constraints;
    }


    /// <summary>
    /// calculate finale fitness vector, for so-optimization this is a vector with
    /// one element only
    /// </summary>
    /// <param name="myFitnessParams"></param>
    /// <param name="energyBalance"></param>
    /// <param name="fitness_constraints"></param>
    /// <param name="udot"></param>
    /// <returns>fitness vector</returns>
    private static double[] calcFitnessVector(fitness_params myFitnessParams, 
      double energyBalance, double fitness_constraints, double udot)
    { 
      
      double[] fitness= new double[myFitnessParams.nObjectives];

      if (myFitnessParams.nObjectives == 1)
      {
        // TODO - der vorfaktor vor udot muss immer identisch sein zu dem
        // welcher in matlab genutzt wird
        fitness[0] = myFitnessParams.myWeights.w_money * energyBalance +
                     fitness_constraints + myFitnessParams.myWeights.w_udot * udot;
      }
      else if (myFitnessParams.nObjectives == 2)
      {
        fitness[0] = energyBalance; // 1000 €/d
        // TODO - der vorfaktor vor udot muss immer identisch sein zu dem
        // welcher in matlab genutzt wird
        fitness[1] = fitness_constraints + myFitnessParams.myWeights.w_udot * udot;
      }
      else if (myFitnessParams.nObjectives == 3)
      {
        fitness[0] = energyBalance; // 1000 €/d
        // TODO - der vorfaktor vor udot muss immer identisch sein zu dem
        // welcher in matlab genutzt wird
        fitness[1] = fitness_constraints;
        fitness[2] = myFitnessParams.myWeights.w_udot * udot;
      }
      else
      {
        throw new exception(String.Format("myFitnessParams.nObjectives == {0}", myFitnessParams.nObjectives));
      }
    
      return fitness;
    }



  }
}


