/**
 * MATLAB Toolbox for Simulation, Control & Optimization of Biogas Plants
 * Copyright (C) 2014  Daniel Gaida
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
/**
* This file defines the objective object.
* 
* TODOs:
* - calculate OLR and HRT of plant
* - calculate stability of plant
* - improve documentation
* - propionic acid to acetic acid in fitness funktion einfügen
* - In optimierung C:N verhältnis der inputsubstrate als randbedingung berücksichtigen. 
*   Welche empfehlungen gibt es? Obere/untere Randwerte?
* - THG Emissionen in fitness funktion hinzufügen
* 
* 
* 
* Alternative Idee für eine Optimierung:
* - suche nach optimalem Substrat, welches GG optimiert. Dafür direkt Substratparameter
*   optimieren wie TS, oTS, NH4, ...
*   dann im 2. schritt erst schauen ob man dieses substrat aus anderen substraten mixen
*   kann oder ob es dieses substrat tatsächlich gibt
*   dann wäre das optimale substrat bestimmt, zumindest für das modell.
* 
* 
* - man könnte auch die Substratkosten als variabel über den prädiktionshorizont
*   ansehen. für langfristige prognosen wenn substratpreise steigen. prinzipiell
*   könnte man dem substraten auch einen weiteren parameter, preisansteig pro Jahr
*   oder ähnliches anbieten. 
* - je nach dem welche substrate man nutzt könnten stoffe ins biogas gelangen, welche
*   man herausfiltern muss. deshalb sind diese stoffe evtl. nicht so geeignet, bzw. in den kosten
*   muss man die mehrkosten für die reinigung des gases, unter der nutzung der substrate,
*   eingerechent werden. 
* 
* 
* 
* Wie berechnet man den Verlust, welchen man durch Überschussgas hat?
* 
* zum einen, ob mit oder ohne überschüssiges Gas, der Gewinn berechnet sich
* immer über:
* 
* Gewinn= Erlösbiogas - Substratkosten - Herstellkosten
* 
* 
* Den Verlust, welchen man durch überschüssiges Gas hat, berechnet man nie in den Gewinn 
* rein, sondern kann man separat berechnen und darstellen. Es gibt zwei Möglichkeiten:
* 
* 1) Verlustüberschussgas= Substratkosten für Überschussgas + Herstellkosten für Überschussgas
* 
* hier betrachtet man nur die Kosten, allerdings nicht den verloren gegangenen Erlös 
* (entgangener Gewinn), der wird
* hier durch berechnet:
* 
* 2) Verlustüberschussgas= entgangener Erlös Überschussgas - Substratkosten für Überschussgas - 
* - Herstellkosten für Überschussgas
* 
* Die zweite Variante ist besser und wird auch unten genutzt.
* 
* 
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
    //                              !!! PUBLIC METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// get all objectives 
    /// </summary>
    /// <param name="mySensors"></param>
    /// <param name="myPlant"></param>
    /// <param name="mySubstrates"></param>
    /// <param name="myFitnessParams"></param>
    /// <param name="Stability_punishment"></param>
    /// <param name="energyBalance">cost - benefit [1000 €/d]</param>
    /// <param name="energyProd_fitness"></param>
    /// <param name="energyConsumption">total el. energy consumption [kWh/d]</param>
    /// <param name="energyThConsumptionHeat">thermal energy consumption [kWh/d]</param>
    /// <param name="energyConsumptionPump">el. energy consumption for pumps [kWh/d]</param>
    /// <param name="energyConsumptionMixer">el. energy consumption for mixer [kWh/d]</param>
    /// <param name="energyProdMicro">thermal energy prod. microbiology [kWh/d]</param>
    /// <param name="moneyEnergy">
    /// money I get for selling the produced total energy (el. + therm.) in €/d
    /// </param>
    /// <param name="fitness_constraints">sum of fitness functions</param>
    /// <param name="fitness">fitness vector</param>
    public static void getObjectives(biogas.sensors mySensors, biogas.plant myPlant, 
      biogas.substrates mySubstrates, fitness_params myFitnessParams, 
      /*out double SS_COD_fitness, out double VS_COD_fitness,*/
      /*out double SS_COD_degradationRate, out double VS_COD_degradationRate, */
      /*out double CH4_fitness, */out double Stability_punishment, 
      out double energyBalance, out double energyProd_fitness, 
      out double energyConsumption, out double energyThConsumptionHeat,
      out double energyConsumptionPump, out double energyConsumptionMixer, 
      out double energyProdMicro, /*out double energyThermProduction,
      out double energyProduction,*/ out double moneyEnergy,
      out double fitness_constraints, out double[] fitness)
    {
      double pHvalue_fitness, VFA_TAC_fitness, TS_fitness,
      VFA_fitness, AcVsPro_fitness, TAC_fitness, OLR_fitness, HRT_fitness, N_fitness,
      biogasExcess_fitness, diff_setpoints, CH4_fitness, SS_COD_fitness, VS_COD_fitness;

      //
      // normalized between 0 and 1
      mySensors.getCurrentMeasurementD("SS_COD_fit", out SS_COD_fitness);
      // normalized between 0 and 1
      mySensors.getCurrentMeasurementD("VS_COD_fit", out VS_COD_fitness);

      // fitness > 0 if pH value under or over boundaries
      // normalized between 0 and 1
      mySensors.getCurrentMeasurementD("pH_fit", out pHvalue_fitness);

      // da mit tukey gearbeitet wird, kann der term auch etwas größer als 1 sein
      mySensors.getCurrentMeasurementD("VFA_TAC_fit", out VFA_TAC_fitness);

      // this is the fitness of the TS in the digester
      // da mit tukey gearbeitet wird, kann der term auch etwas größer als 1 sein
      mySensors.getCurrentMeasurementD("TS_fit", out TS_fitness);

      // TODO
      // Calculation of TS concentration in inflow

      // gibt es auch schon in Individuum Überprüfung: nonlcon_substrate
      // braucht hier dann eigentlich nicht mehr gemacht werden

      // verhältnis von propionic acid to acetic acid
      // max. grenze bei 1.4, s. PhD für Quellen
      // hier ist der Kehrwert, also min grenze, hier wird mit tukey gearbeitet
      mySensors.getCurrentMeasurementD("AcVsPro_fit", out AcVsPro_fitness);


      // da mit tukey gearbeitet wird, kann der term auch etwas größer als 1 sein
      mySensors.getCurrentMeasurementD("VFA_fit", out VFA_fitness);

      // tukey
      mySensors.getCurrentMeasurementD("TAC_fit", out TAC_fitness);
      // tukey
      mySensors.getCurrentMeasurementD("OLR_fit", out OLR_fitness);

      // da mit tukey gearbeitet wird, kann der term auch etwas größer als 1 sein
      mySensors.getCurrentMeasurementD("HRT_fit", out HRT_fitness);

      // sum of Snh4 + Snh3, mit tukey
      mySensors.getCurrentMeasurementD("N_fit", out N_fitness);

      
      // CH4 > 50 % als tukey implementiert
      mySensors.getCurrentMeasurementD("CH4_fit", out CH4_fitness);

      // biogasExcess_fitness is lossbiogasExcess / 1000
      // measured in tausend € / d
      mySensors.getCurrentMeasurementD("gasexcess_fit", out biogasExcess_fitness);


      // TODO
      // 
      // calculate OLR and HRT of plant



      // TODO - ich könnte auch faecal_fit_sensor schreiben
      // faecal bacteria removal capacity
      // intestinal enterococci
      // faecal coliforms
      double etaIE= 0, etaFC= 0;

      for (int idigester = 0; idigester < myPlant.getNumDigesters(); idigester++)
      {
        string digesterID= myPlant.getDigesterID(idigester + 1);

        etaIE += mySensors.getCurrentMeasurementDind("faecal_" + digesterID, 0);
        etaFC += mySensors.getCurrentMeasurementDind("faecal_" + digesterID, 1);
      }

      if (myPlant.getNumDigesters() > 0)
      {
        etaIE /= myPlant.getNumDigesters();
        etaFC /= myPlant.getNumDigesters();
      }

      // TODO - als ausgabeargumente definieren - nö
      double fitness_etaIE, fitness_etaFC;
      // wird in 100 % gemessen
      fitness_etaIE = 1.0f - etaIE / 100.0f;
      fitness_etaFC = 1.0f - etaFC / 100.0f;



      // TODO
      // stability

      //stateIsStable(1:n_fermenter,1)= 0;

      //for ifermenter= 1:n_fermenter

      //  %digester_id= char( plant.getDigesterID(ifermenter) );

      //  %% TODO !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

      //  stateIsStable(ifermenter,1)= 1;%...
      //      %getStateIsStable(measurements, digester_id, plant);

      //end

      //% d.h instabil?
      //if any(stateIsStable == 0)
      //    Stability_punishment= 1;
      //else
      //    Stability_punishment= 0;
      //end


      Stability_punishment= 0;    // TODO


      //
      double mbonus;

      mySensors.getCurrentMeasurementD("manurebonus", out mbonus);
      myFitnessParams.manurebonus= Convert.ToBoolean(mbonus);

      //

      energyConsumption= getElEnergyConsumption(myPlant, mySensors, 
        out energyConsumptionPump, out energyConsumptionMixer);
      
      // 
      double energyThProdMixer;

      double energyThConsumption = getThermalEnergyConsumption(myPlant, mySensors,
        out energyThConsumptionHeat, out energyThProdMixer, out energyProdMicro);

      // TODO: einheiten nicht sauber
      // costs for heating in €/d
      //
      // kosten für heizung werden direkt in geld umgerechnet
      // wenn thermisch produzierte wärme zum heizen des fermenters benutzt wird, 
      // dann werden hier virtuelle kosten berechnet mit kosten revenueTherm, 
      // welche unten bei sellEnergy wieder als erlös mit dem gleichen Wert
      // berechnet werden, d.h. +/- das gleiche.
      //
      double costs_heating = myPlant.calcCostsForHeating_Total(
        new physValue(energyThConsumption, "kWh/d"),
        myPlant.myFinances.revenueTherm.Value, myPlant.myFinances.priceElEnergy.Value);

      // 

      // total el. energy production in kWh/d
      double energyProduction= mySensors.getCurrentMeasurementDind("energyProdSum", 0);
      // total thermal energy production in kWh/d
      double energyThermProduction = mySensors.getCurrentMeasurementDind("energyProdSum", 1);

      //energyProduction= getEnergyProduction(myPlant, mySensors, out energyThermProduction);

      //

      double energyProductionMax = getMaxElEnergyProduction(myPlant);

      // measured in 100 %
      energyProd_fitness = (1 - energyProduction / energyProductionMax);

      // Calculation of costs of substrate inflow
      // € / d
      double substrate_costs;
      
      mySensors.getCurrentMeasurementD("substrate_cost", out substrate_costs);


      //

      double udot;

      mySensors.getCurrentMeasurementD("udot", out udot);

      //

      // TODO
      // was ist wenn wir weniger thermische energie im BHKW erzeugen als wir verbrauchen?
      // dann ist costs_heating (virt. kosten) > moneyEnergy thermisch (verkauf von thermischer Energie)
      // die differenz muss dann elektrisch erzeugt werden, wird allerdings nicht gemacht. 
      // die differenz wird aktuell alas virtuelle Kosten verbucht (Verlust den man hat da man nicht wärme verkauft) 
      // und nicht als reale kosten (erzeugungskosten: thermische energie erzeugt durch heizung)
      // um das zu lösen, warum ruft man nicht berechnung von costs_heating nach berechnung
      // von energyThermProduction auf und übergibt dann differenz zw. energyThConsumption und
      // energyThermProduction? 

      //
      // TODO - was ist wenn die produzierte elektrische energie von niemanden abgenommen wird
      // das ist der fall, wenn nach sollwert gefahren wird, dann wird nur so viel energie bezahlt
      // wie nach sollwert verlangt wurde, das geht so ab eeg 2012 - direktvermarktung

      // must be in kWh/d
      double energyElSold = 0;  // electrical energy that would be sold

      // dann gibt es eine referenz kurve welche angibt wieviel energie verkauft würde wenn sie produziert
      // würde, hier nur elektrische energie
      if (mySensors.exist("ref_energy_sold"))
      {
        // wichtig, dass man sich die messung zur aktuellen zeit holt, da
        // ref_energy_sold eine referenz vorgibt
        double time = mySensors.getCurrentTime();

        energyElSold= mySensors.getMeasurementDAt("ref_energy_sold", "", time, 0, false);

        energyElSold = Math.Min(energyElSold, energyProduction);
      }
      else
      {
        energyElSold = energyProduction;
      }

      // moneyEnergy : €/d
      moneyEnergy = biogas.gasexcess_fit_sensor.sellEnergy(energyElSold, energyThermProduction,
                              myPlant, myFitnessParams);
            
      // € / d
      // is negative when we make more money as we have to pay
      energyBalance= energyConsumption * myPlant.myFinances.priceElEnergy.Value 
                     + costs_heating - moneyEnergy + substrate_costs;

      // tausend € / d           
      energyBalance= energyBalance / 1000;

      //
      // TODO
      bool noisy = false;

      // calc setpoint control error
      //diff_setpoints = calc_setpoint_errors(mySensors, myPlant, myFitnessParams, noisy);
      mySensors.getCurrentMeasurementD("setpoint_fit", noisy, out diff_setpoints);

      // calc total fitness of all the constraints

      fitness_constraints = calcFitnessConstraints(myFitnessParams, SS_COD_fitness, 
        VS_COD_fitness, /*VS_COD_degradationRate,*/ pHvalue_fitness, VFA_TAC_fitness,
        TS_fitness, VFA_fitness, AcVsPro_fitness, TAC_fitness, OLR_fitness, HRT_fitness, N_fitness, 
        CH4_fitness, biogasExcess_fitness, Stability_punishment, energyProd_fitness,
        fitness_etaIE, fitness_etaFC, diff_setpoints);


      // calc fitness vector
      fitness = calcFitnessVector(myFitnessParams, energyBalance, fitness_constraints, udot);

    }



  }
}


