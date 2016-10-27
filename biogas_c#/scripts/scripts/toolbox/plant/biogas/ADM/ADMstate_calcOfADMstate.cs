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
* This file is part of the partial class ADMstate and defines
* all calc...OfADMstate methods.
* 
* TODOs:
* - biogas stream wird aus x berechnet, allerdings nur gültig für 3dim biogasvektor
* - improve documentation
* - calcNorg, Ntot, TKN verbessern
* 
* Except for that FINISHED!
* 
*/

using System;
using System.Collections.Generic;
using System.Text;
using science;
using toolbox;

namespace biogas
{
  /// <summary>
  /// TODO: Implement: calcPHOfADMstate as in MATLAB, 
  /// all other methods are as in MATLAB
  /// s. biogasM.ADMstate
  /// sollte mit math Klasse jetzt möglich sein
  /// 
  /// References:
  /// 
  /// 1) Schoen, M.A., Sperl, D., Gadermaier, M., Goberna, M., Franke-Whittle, I.,
  ///    Insam, H., Ablinger, J., and Wett B.: 
  ///    Population dynamics at digester overload conditions, 
  ///    Bioresource Technology 100, pp. 5648-5655, 2009
  ///
  /// </summary>
  public partial class ADMstate
  {

    // -------------------------------------------------------------------------------------
    //                              !!! PUBLIC METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// calc organic nitrogen in state vector x 
    /// measured in k mol N/m3
    /// </summary>
    /// <param name="x">ADM1 state or stream vector</param>
    /// <param name="digester_id">ID of digester</param>
    /// <param name="myPlant"></param>
    /// <returns>organic nitrogen</returns>
    public static double calcNorg(double[] x, string digester_id, plant myPlant)
    {
      // get ADM1 parameters
      // das sind die zuletzt upgedateten Parameter, nicht die default Werte
      double[] ADM1params = myPlant.getDefaultADMparams(digester_id);

      //

      // TODO - funktioniert nicht mehr wenn sich Positionen in vektor verschieben

      // TODO in ADMstate_properties wurden Positionen definiert, diese nutzen!!!

      // amino acids [kg COD/m3]
      double Saa = x[pos_Saa - 1];

      // soluble inerts kg COD/m3 
      double SI = x[11];
      // composite kg COD/m3 
      double Xc = x[12];

      // proteins kg COD/m3 
      double Xpr = x[14];

      double Xbio= calcBiomassOfADMstate(x).Value;

      // particulate inerts kg COD/m3 
      double XI = x[23];
      // Particulate products arising from biomass decay kg COD/m^3 
      double Xp = x[24];
      

      // TODO funktioniert nicht wenn ADM parameter sich verändern

      double fSI_XC = ADM1params[ADMparams.pos_fSI_XC - 1]; // fraction SI from XC

      double fCH_XC = ADM1params[ADMparams.pos_fCH_XC - 1]; // fraction Xch from XC
      double fPR_XC = ADM1params[ADMparams.pos_fPR_XC - 1]; // fraction Xpr from XC
      double fLI_XC = ADM1params[ADMparams.pos_fLI_XC - 1]; // fraction Xli from XC
      double fXP_XC = ADM1params[ADMparams.pos_fXP_XC - 1]; // fraction Xp from XC

      double fXI_XC = 1 - fSI_XC - fCH_XC - fPR_XC - fLI_XC - fXP_XC;

      double N_I = ADM1params[7];
      double N_aa = ADM1params[8];

      double N_XB = ADM1params[23];
      
      double N_Xp= ADM1params[103];


      // calc Norg
      // alle Verbindungen, welche Kohlenstoff beinhalten nennt man organisch
      // die anderen anorganisch. Ausnahme sind Oxide wie bspw. CO2 und ein paar weitere
      // Ausnahmen. damit sind hier alle verbindungen organisch, bspw. auch SI und XI.

      double Norg= N_aa * ( Saa + fPR_XC * Xc + Xpr ) + N_Xp * ( fXP_XC * Xc + Xp ) + 
                   N_XB * Xbio + N_I * ( SI + XI + fSI_XC * Xc + fXI_XC * Xc );

      return Norg;
    }

    /// <summary>
    /// calc TKN= Norg + NH4
    /// total Kjehldahl nitrogen in k mol N/m3
    /// </summary>
    /// <param name="x">ADM state vector</param>
    /// <param name="digester_id">digester ID</param>
    /// <param name="myPlant"></param>
    /// <returns>TKN</returns>
    public static double calcTKN(double[] x, string digester_id, plant myPlant)
    {
      double Norg = calcNorg( x, digester_id, myPlant);

      double NH4= calcNH4(x, digester_id, myPlant);
     
      // calc TKN= Norg + NH4
      double TKN = Norg + NH4;

      return TKN;
    }

    /// <summary>
    /// calc NH4 in ADM1 state, this is the sum:
    /// Snh4 + NH4 in Xc, measured in kmolN/m^3
    /// </summary>
    /// <param name="x">ADM state vector</param>
    /// <param name="digester_id">digester ID</param>
    /// <param name="myPlant"></param>
    /// <returns>NH4</returns>
    public static double calcNH4(double[] x, string digester_id, plant myPlant)
    {
      // get ADM1 parameters
      // das sind die zuletzt upgedateten Parameter, nicht die default Werte
      double[] ADM1params = myPlant.getDefaultADMparams(digester_id);

      // TODO - funktioniert nicht mehr wenn sich Positionen in vektor verschieben

      // Ammonium k mol N/m3 
      double Snh4 = x[10];

      // composite kg COD/m3 
      double Xc = x[12];

      // Ammonia k mol N/m3 
      double Snh3 = x[32];

      // enthält NH4 und NH3
      double fSIN_XC = ADM1params[6];    // ist immer 0

      
      // Verhältnis von NH3 zu NH4 im Fermenter, Annahme, dass es sich
      // mit NH3 und NH4 in Xc genauso verhält.
      // 
      // Herl:
      // Nsumme= NH4 + NH3= fSIN_Xc * Xc = 
      // = NH4 * (1 + r_N3_N4)
      // NH4= Nsumme / (1 + r_N3_N4)
      // TODO: kann C# eigentlich mit /0 rechnen?
      double r_N3_N4 = Snh3 / Snh4;

      double NH4 = Snh4 + fSIN_XC * Xc / (1 + r_N3_N4);

      // TODO - das ist falsch - Faktor hängt von pH Wert ab
      // NH4 ist dann eher fSIN_XC * Xc, hängt aber vom pH Wert ab
      if (Snh4 == 0)    // da wir dann durch unendlich geteilt haben, gibt es probleme
        NH4 = Snh4 + fSIN_XC * Xc * 0.9;    // 1/ unendlich scheint in C# nicht 0 zu sein, sondern evtl. n.def.

      return NH4;
    }
    
    /// <summary>
    /// returns NH4 in given unit
    /// </summary>
    /// <param name="x">ADM state vector</param>
    /// <param name="digester_id">digester id</param>
    /// <param name="myPlant"></param>
    /// <param name="unit">unit in which NH4 should be returned</param>
    /// <returns>NH4 in given unit</returns>
    /// <exception cref="exception">Conversion error</exception>
    /// <exception cref="exception">Unknown unit</exception>
    public static physValue calcNH4(double[] x, string digester_id, plant myPlant, string unit)
    {
      // NH4 in kmolN/m^3
      double NH4= calcNH4(x, digester_id, myPlant);

      physValue pNH4= new physValue("Snh4", NH4, "kmol/m^3");

      pNH4= pNH4.convertUnit(unit);

      return pNH4;
    }

    /// <summary>
    /// calc NH4 in ADM1 state, this is the sum:
    /// Snh4 + NH4 in Xc, measured in the given unit
    /// </summary>
    /// <param name="x">ADM state vector</param>
    /// <param name="digester_id">digester ID</param>
    /// <param name="myPlant"></param>
    /// <param name="unit">unit in which NH4N is returned</param>
    /// <param name="NH4">NH4 value in given unit</param>
    /// <returns></returns>
    public static void calcNH4(double[] x, string digester_id, plant myPlant, string unit, out double NH4)
    {
      NH4 = calcNH4(x, digester_id, myPlant, unit);
    }
    /// <summary>
    /// calc NH4 in ADM1 state, this is the sum:
    /// Snh4 + NH4 in Xc, measured in the given unit
    /// </summary>
    /// <param name="x">ADM state vector</param>
    /// <param name="digester_id">digester ID</param>
    /// <param name="myPlant"></param>
    /// <param name="unit">unit in which NH4N is returned</param>
    /// <returns>NH4</returns>
    public static double calcNH4(double[] x, string digester_id, plant myPlant, string unit)
    {
      double NH4 = calcNH4(x, digester_id, myPlant);

      if (unit != "mol/l")
      {
        physValue values= new physValue("N", NH4, "mol/l", "total ammonium nitrogen");
        values= values.convertUnit(unit);

        NH4 = values.Value;
      }

      return NH4;
    }

    /// <summary>
    /// calc Ntot= TKN + NH3
    /// total nitrogen in k mol N/m3
    /// </summary>
    /// <param name="x">ADM state vector</param>
    /// <param name="digester_id">digester ID</param>
    /// <param name="myPlant"></param>
    /// <returns>Ntot</returns>
    public static double calcNtot(double[] x, string digester_id, plant myPlant)
    {
      double TKN = calcTKN(x, digester_id, myPlant);

      double NH3 = calcNH3(x, digester_id, myPlant);

      // calc Ntot= TKN + NH3
      double Ntot = TKN + NH3;

      return Ntot;
    }

    /// <summary>
    /// calc NH3 in ADM1 state, this is the sum:
    /// Snh3 + NH3 in Xc, measured in kmolN/m^3
    /// </summary>
    /// <param name="x">ADM state vector</param>
    /// <param name="digester_id">digester ID</param>
    /// <param name="myPlant"></param>
    /// <returns>NH4</returns>
    public static double calcNH3(double[] x, string digester_id, plant myPlant)
    {
      // get ADM1 parameters
      // das sind die zuletzt upgedateten Parameter, nicht die default Werte
      double[] ADM1params = myPlant.getDefaultADMparams(digester_id);

      // TODO - funktioniert nicht mehr wenn sich Positionen in vektor verschieben

      // Ammonium k mol N/m3 
      double Snh4 = x[10];

      // composite kg COD/m3 
      double Xc = x[12];

      // Ammonia k mol N/m3 
      double Snh3 = x[32];

      // enthält NH4 und NH3
      double fSIN_XC = ADM1params[6];    // ist immer 0


      // Verhältnis von NH3 zu NH4 im Fermenter, Annahme, dass es sich
      // mit NH3 und NH4 in Xc genauso verhält.
      // 
      // Herl:
      // Nsumme= NH4 + NH3= fSIN_Xc * Xc = 
      // = NH3 * (1 + 1/r_N3_N4)
      // NH3= Nsumme / (1 + 1/r_N3_N4)
      // TODO: kann C# eigentlich mit /0 rechnen? denke schon
      // wenn ja, gibt es hier kein Problem, ob Snh3 oder Snh4 0 ist ist egal
      // C# rechnet richtig, scheinbar doch nicht, deshalb abfragen unten
      double r_N3_N4 = Snh3 / Snh4;

      double NH3 = Snh3 + fSIN_XC * Xc / (1 + 1/r_N3_N4);

      // TODO - das ist falsch - Faktor 0.1 hängt von pH Wert ab
      // NH3 ist dann eher fSIN_XC * Xc * faktor, faktor hängt aber vom pH Wert ab
      if (Snh3 == 0)    // da wir dann durch unendlich geteilt haben, gibt es probleme
        NH3 = Snh3 + fSIN_XC * Xc * 0.1;    // 1/ unendlich scheint in C# nicht 0 zu sein, sondern evtl. n.def.
      else if (Snh4 == 0)    // da wir dann durch unendlich geteilt haben, gibt es probleme
        NH3 = Snh3 + fSIN_XC * Xc * 0.1;    // 1/ unendlich scheint in C# nicht 0 zu sein, sondern evtl. n.def.

      return NH3;
    }

    /// <summary>
    /// returns NH3 in given unit
    /// </summary>
    /// <param name="x">ADM state vector</param>
    /// <param name="digester_id">digester id</param>
    /// <param name="myPlant"></param>
    /// <param name="unit">unit in which NH3 should be returned</param>
    /// <returns>NH3 in given unit</returns>
    /// <exception cref="exception">Conversion error</exception>
    /// <exception cref="exception">Unknown unit</exception>
    public static physValue calcNH3(double[] x, string digester_id, plant myPlant, string unit)
    {
      // NH3 in kmolN/m^3
      double NH3= calcNH3(x, digester_id, myPlant);

      physValue pNH3= new physValue("Snh3", NH3, "kmol/m^3");

      pNH3= pNH3.convertUnit(unit);

      return pNH3;
    }

    /// <summary>
    /// TODO!!!
    /// 
    /// Verstehe die funktion nicht, da x von einem Fermenter kommt, aber ich über anzahl fermenter
    /// in Anlage iteriere. komisch!
    /// </summary>
    /// <param name="x"></param>
    /// <param name="Digesters"></param>
    /// <param name="Qgas_h2"></param>
    /// <param name="Qgas_ch4"></param>
    /// <param name="Qgas_co2"></param>
    /// <param name="Qgas"></param>
    public static void calcBiogasCompositionOfADMstate(double[] x, digesters Digesters,
                                            out physValue[] Qgas_h2,  out physValue[] Qgas_ch4,
                                            out physValue[] Qgas_co2, out physValue[] Qgas)
    {
      // number of digesters
      int n_digester= Digesters.Count;

      // TODO: geht so nicht, Qgas muss ein 2dim array sein, das beliebig viele gase und nicht
      // nur die 3 enthalten kann
      Qgas_h2=  new physValue[n_digester];
      Qgas_ch4= new physValue[n_digester];
      Qgas_co2= new physValue[n_digester];
      Qgas=     new physValue[n_digester];

      //

      int idigester= 0;

      foreach (digester Digester in Digesters)
      {
        physValue Vliq= Digester.Vliq;

        physValue T= Digester.T;

        //

        calcBiogasOfADMstate(x, Vliq, T, out Qgas_h2[idigester] , out Qgas_ch4[idigester],
                                         out Qgas_co2[idigester], out Qgas[idigester]);

        // normalize
        // TODO - es gibt auch methoden in der BioGas klasse
        if (Qgas[idigester].Value != 0)
        {
          Qgas_h2[idigester]=  Qgas_h2[idigester]  / Qgas[idigester];
          Qgas_ch4[idigester]= Qgas_ch4[idigester] / Qgas[idigester];
          Qgas_co2[idigester]= Qgas_co2[idigester] / Qgas[idigester];
        }

        // convert from "100 %" to "%"
        Qgas_h2[idigester]=  Qgas_h2[ idigester].convertUnit("%");
        Qgas_ch4[idigester]= Qgas_ch4[idigester].convertUnit("%");
        Qgas_co2[idigester]= Qgas_co2[idigester].convertUnit("%");

        // 

        idigester++;
      }
    }

    /// <summary>
    /// TODO!!!
    /// </summary>
    /// <param name="x"></param>
    /// <param name="Vliq"></param>
    /// <param name="T"></param>
    /// <param name="Qgas_h2"></param>
    /// <param name="Qgas_ch4"></param>
    /// <param name="Qgas_co2"></param>
    /// <param name="Qgas"></param>
    /// <param name="dV_ch4_dx"></param>
    /// <param name="dV_co2_dx"></param>
    /// <param name="dQgas_dx"></param>
    public static void calcBiogasOfADMstate(double[] x, physValue Vliq, physValue T,
                                            out physValue Qgas_h2, out physValue Qgas_ch4,
                                            out physValue Qgas_co2, out physValue Qgas, 
                                            out double[] dV_ch4_dx, out double[] dV_co2_dx, 
                                            out double[] dQgas_dx)
    {
      calcBiogasOfADMstate(x, Vliq, T, out Qgas_h2, out Qgas_ch4, out Qgas_co2, out Qgas);

      // calc derivations
      // Qbiogas bzw. Qgas nach x abgeleitet

      dQgas_dx= new double[biogas.ADMstate._dim_state];

      physValue fac= new physValue(1000, "mol/kmol");

      physValue dQgas_dpTOTAL= digester.kp / ( chemistry.R * T / fac * chemistry.NQ ) * Vliq;

      dQgas_dx[biogas.ADMstate.pos_pTOTAL - 1]= dQgas_dpTOTAL.Value;

      //

      double piSh2=  x[biogas.ADMstate.pos_piSh2  - 1];
      double piSch4= x[biogas.ADMstate.pos_piSch4 - 1];
      double piSco2= x[biogas.ADMstate.pos_piSco2 - 1];

      double sum_pp= piSh2 + piSch4 + piSco2;

      // V_ch4= 100 * Qgas_ch4 / (Qgas_h2 + Qgas_ch4 + Qgas_co2) = 
      //      = 100 * piSch4 / ( piSh2 + piSch4 + piSco2 )
      dV_ch4_dx= new double[biogas.ADMstate._dim_state];

      dV_ch4_dx[biogas.ADMstate.pos_piSh2 - 1]= 
                   - piSch4 * 100 / Math.Pow( Math.Max(sum_pp, double.Epsilon), 2);
      dV_ch4_dx[biogas.ADMstate.pos_piSco2 - 1]= 
                   - piSch4 * 100 / Math.Pow( Math.Max(sum_pp, double.Epsilon), 2);
      dV_ch4_dx[biogas.ADMstate.pos_piSch4 - 1]= 
                   100 / Math.Max(sum_pp, double.Epsilon) + 
                   dV_ch4_dx[biogas.ADMstate.pos_piSco2 - 1];

      // V_co2= 100 * Qgas_co2 / (Qgas_h2 + Qgas_ch4 + Qgas_co2) = 
      //      = 100 * piSco2 / ( piSh2 + piSch4 + piSco2 )
      dV_co2_dx= new double[biogas.ADMstate._dim_state];

      dV_co2_dx[biogas.ADMstate.pos_piSh2 - 1]= 
                   -piSco2 * 100 / Math.Pow(Math.Max(sum_pp, double.Epsilon), 2);
      dV_co2_dx[biogas.ADMstate.pos_piSch4 - 1]= 
                   -piSco2 * 100 / Math.Pow(Math.Max(sum_pp, double.Epsilon), 2);
      dV_co2_dx[biogas.ADMstate.pos_piSco2 - 1]= 
                   100 / Math.Max(sum_pp, double.Epsilon) + 
                   dV_co2_dx[biogas.ADMstate.pos_piSch4 - 1];
    }
    /// <summary>
    /// TODO!!!
    /// </summary>
    /// <param name="x"></param>
    /// <param name="Vliq"></param>
    /// <param name="T"></param>
    /// <param name="Qgas_h2"></param>
    /// <param name="Qgas_ch4"></param>
    public static void calcBiogasOfADMstate(double[] x, physValue Vliq, physValue T,
                                            out physValue Qgas_h2, out physValue Qgas_ch4)
    {
      physValue Qgas_co2;

      calcBiogasOfADMstate(x, Vliq, T, out Qgas_h2 , out Qgas_ch4,
                                       out Qgas_co2);
    }
    /// <summary>
    /// TODO!!!
    /// </summary>
    /// <param name="x"></param>
    /// <param name="Vliq"></param>
    /// <param name="T"></param>
    /// <param name="Qgas_h2"></param>
    /// <param name="Qgas_ch4"></param>
    /// <param name="Qgas_co2"></param>
    public static void calcBiogasOfADMstate(double[] x, physValue Vliq, physValue T,
                                            out physValue Qgas_h2, out physValue Qgas_ch4,
                                            out physValue Qgas_co2)
    {
      physValue Qgas;

      calcBiogasOfADMstate(x, Vliq, T, out Qgas_h2,  out Qgas_ch4,
                                       out Qgas_co2, out Qgas);
    }
    /// <summary>
    /// TODO
    /// </summary>
    /// <param name="x"></param>
    /// <param name="Vliq"></param>
    /// <param name="T"></param>
    /// <param name="Qgas_h2">measured in m^3/d</param>
    /// <param name="Qgas_ch4">measured in m^3/d</param>
    /// <param name="Qgas_co2">measured in m^3/d</param>
    /// <param name="Qgas">measured in m^3/d</param>
    public static void calcBiogasOfADMstate(double[] x, physValue Vliq, physValue T,
                                            out double Qgas_h2, out double Qgas_ch4,
                                            out double Qgas_co2, out double Qgas)
    {
      physValue pQgas_h2, pQgas_ch4, pQgas_co2, pQgas;

      calcBiogasOfADMstate(x, Vliq, T, out pQgas_h2, out pQgas_ch4, 
                                       out pQgas_co2, out pQgas);

      Qgas_h2 = pQgas_h2.Value;
      Qgas_ch4 = pQgas_ch4.Value;
      Qgas_co2 = pQgas_co2.Value;
      Qgas = pQgas.Value;
    }
    /// <summary>
    /// TODO!!!
    /// </summary>
    /// <param name="x"></param>
    /// <param name="Vliq"></param>
    /// <param name="T"></param>
    /// <param name="Qgas_h2"></param>
    /// <param name="Qgas_ch4"></param>
    /// <param name="Qgas_co2"></param>
    /// <param name="Qgas"></param>
    public static void calcBiogasOfADMstate(double[] x, physValue Vliq, physValue T,
                                            out physValue Qgas_h2,  out physValue Qgas_ch4,
                                            out physValue Qgas_co2, out physValue Qgas)
    {
      // external pressure [bar]
      physValue pAtm= new physValue(chemistry.pAtm);

      physValue T_C= T.convertUnit("°C");
      physValue T_K= T.convertUnit("K");

      // temperature correction
      //
      // s. simba's initfox5gas.m
      //
      // Anmerkung: Formel aus dem ADM1 Report kommt dieser am nächsten, genaue
      // Umrechnung aber noch nicht möglich:
      //
      // ph2o= 0.0313 * exp( 5290 * ( 1/298 - 1/T ) )
      // ph2o= 0.0313 * exp( 5290/298 ) * exp( - 5290/T ) )
      // ph2o= 0.0313 * exp( 5290/298 ) * 1 / exp( T/5290 ) )
      // 
      //
      pAtm.Value= pAtm.Value - 0.0084147 * Math.Exp(0.054 * T_C.Value);

      //

      // Sum of all partial pressures [bar]
      physValue pTOTAL= new physValue("pTOTAL", x[biogas.ADMstate.pos_pTOTAL - 1], "bar");

      double piSh2=  x[biogas.ADMstate.pos_piSh2  - 1];
      double piSch4= x[biogas.ADMstate.pos_piSch4 - 1];
      double piSco2= x[biogas.ADMstate.pos_piSco2 - 1];

      // gas constant * temperature [bar m^3/kmol]
      physValue RT= chemistry.R * T_K;

      //

      physValue fac= new physValue(1000, "mol/kmol");

      // measured in m³/d
      Qgas= physValue.max(digester.kp * (pTOTAL - pAtm) / (RT / fac * chemistry.NQ) * Vliq, 
                          new physValue("Qgas_min", 0, "m^3/d"));

      //

      double sum_pp= piSh2 + piSch4 + piSco2;

      // calculate gas flow for each component
      // all measured in m^3/d
      Qgas_h2=   piSh2 / Math.Max(sum_pp, double.Epsilon) * Qgas;
      Qgas_ch4= piSch4 / Math.Max(sum_pp, double.Epsilon) * Qgas;
      Qgas_co2= piSco2 / Math.Max(sum_pp, double.Epsilon) * Qgas;

      //

      Qgas_h2.Symbol = "Qgas_h2";
      Qgas_ch4.Symbol= "Qgas_ch4";
      Qgas_co2.Symbol= "Qgas_co2";
    }

    /// <summary>
    /// Calculate hydraulic retention time from ADM state vector.
    /// Only component pos_Q is used. 
    /// </summary>
    /// <param name="x">ADM state vector</param>
    /// <param name="Vliq">must be measured in m^3</param>
    /// <returns></returns>
    public static physValue calcHRTOfADMstate(double[] x, double Vliq)
    {
      physValue pVliq= new physValue("Vliq", Vliq, "m^3");

      return calcHRTOfADMstate(x, pVliq);
    }
    /// <summary>
    /// Calculate hydraulic retention time from ADM state vector.
    /// Only component pos_Q is used.
    /// </summary>
    /// <param name="x">ADM state vector</param>
    /// <param name="Vliq">liquid volume of digester</param>
    /// <returns></returns>
    /// <exception cref="exception">x.Length &lt; _dim_stream</exception>
    public static physValue calcHRTOfADMstate(double[] x, physValue Vliq)
    {
      if (x.Length < _dim_stream)
        throw new exception(String.Format(
        "Length of x is < {0}: {1}!", _dim_stream, x.Length));

      return digester.calcHRT(x[pos_Q - 1], Vliq);
    }

    /// <summary>
    /// TODO:
    /// Quelle für dieses Verhältnis suchen!
    /// Einheit in mol/l oder g/l, oder...?
    /// 
    /// Calculate ratio of acetic to propionic acid in mol/l
    /// </summary>
    /// <param name="x">ADM state vector</param>
    /// <returns></returns>
    public static physValueBounded calcAcetic_vs_PropionicOfADMstate(double[] x)
    {
      string unit= "mol/l";

      // mol/l
      physValue Sac= biogas.ADMstate.calcFromADMstate(x, "Sac", unit);
      // mol/l
      physValue Spro= biogas.ADMstate.calcFromADMstate(x, "Spro", unit);


      physValueBounded Sac_vs_Spro;

      if (Spro != new science.physValue(0, unit))
        Sac_vs_Spro= new physValueBounded(Sac / Spro);
      else
        Sac_vs_Spro= new science.physValueBounded("Ac_vs_Pro", 0, "mol/mol");

      //
      Sac_vs_Spro.Symbol= "Ac_vs_Pro";
      Sac_vs_Spro= Sac_vs_Spro.convertUnit("mol/mol");

      //Sac_vs_Spro.setLB(0);

      Sac_vs_Spro.printIsOutOfBounds();

      return Sac_vs_Spro;
    }

    /// <summary>
    /// Calculate VFA/TA (volatile fatty acids / total alkalinity) value
    /// out of given ADM state vector x
    /// </summary>
    /// <param name="x">ADM state vector</param>
    /// <param name="FOS_TAC">VFA/TA value</param>
    public static void calcFOSTACOfADMstate(double[] x, out double FOS_TAC)
    {
      FOS_TAC= calcFOSTACOfADMstate(x).Value;
    }
    /// <summary>
    /// Calculate VFA/TA (volatile fatty acids / total alkalinity) value
    /// out of given ADM state vector x
    /// </summary>
    /// <param name="x">ADM state vector</param>
    /// <returns></returns>
    public static physValueBounded calcFOSTACOfADMstate(double[] x)
    {
      physValue FOS, TAC;

      return calcFOSTACOfADMstate(x, out FOS, out TAC);
    }
    /// <summary>
    /// Calculate VFA/TA (volatile fatty acids / total alkalinity) value
    /// out of given ADM state vector x
    /// 
    /// Erwin Voß: 
    /// FOS/TAC-Herleitung, Methodik und Praktische Anwendung, VE efficiency
    /// solutions GmbH
    /// 
    /// </summary>
    /// <param name="x">ADM state vector</param>
    /// <param name="FOS"></param>
    /// <param name="TAC"></param>
    /// <returns></returns>
    public static physValueBounded calcFOSTACOfADMstate(double[] x, out physValue FOS, 
                                                        out physValue TAC)
    {

      // see ref. 1)
      //
      FOS= biogas.ADMstate.calcVFAOfADMstate(x, "gHAceq/l");


      // see ref. 1)
      //
      TAC= biogas.ADMstate.calcTACOfADMstate(x, "gCaCO3eq/l");

      //

      physValueBounded FOS_TAC;

      if ( TAC != new science.physValue("TAC_min", 0, "gCaCO3eq/l") )
        FOS_TAC= new physValueBounded(FOS / TAC);
      else
        FOS_TAC= new science.physValueBounded("FOS_TAC", 0, "gHAceq/gCaCO3eq");
      
      //
      FOS_TAC.Symbol= "FOS_TAC";

      FOS_TAC.setLB(Double.NegativeInfinity);

      FOS_TAC.printIsOutOfBounds();

      return FOS_TAC;
    }

    /// <summary>
    /// Calculate pH value out of ADM state vector. 
    /// pH value as double returned.
    /// </summary>
    /// <param name="x">ADM state vector</param>
    /// <param name="pH">pH value</param>
    /// <returns></returns>
    public static void calcPHOfADMstate(double[] x, out double pH)
    {
      pH = calcPHOfADMstate(x);
    }
    /// <summary>
    /// Calculate pH value out of ADM state vector. 
    /// pH value as physValue returned.
    /// </summary>
    /// <param name="x">ADM state vector</param>
    /// <param name="pH">pH value</param>
    /// <returns></returns>
    public static void calcPHOfADMstate(double[] x, out physValue pH)
    {
      pH= new physValue("pH", calcPHOfADMstate(x), "-");
    }
    /// <summary>
    /// Calculate pH value out of ADM state vector. 
    /// pH value as double returned.
    /// </summary>
    /// <param name="x">ADM state vector</param>
    /// <returns></returns>
    public static double calcPHOfADMstate(double[] x)
    {
      double SH;
      double pfac_h;

      return calcPHOfADMstate(x, out SH, out pfac_h);
    }
    /// <summary>
    /// Calculate pH value out of ADM state vector. 
    /// pH value as double returned.
    /// </summary>
    /// <param name="x">ADM state vector</param>
    /// <param name="SH"></param>
    /// <param name="pfac_h"></param>
    /// <returns></returns>
    public static double calcPHOfADMstate(double[] x, out double SH, out double pfac_h)
    {
      // s. p_adm1xp.m file, eigentlich müsste das 1* 10^-14 sein???, da Kw
      // Temperatur abhängig ist, ist das ok, da der Wert mit steigender
      // Temperatur steigt
      // http://de.wikipedia.org/wiki/Eigenschaften_des_Wassers#Ionenprodukt
      // http://en.wikipedia.org/wiki/Dissociation_constant#Dissociation_constant_of_water
      double Kw= 2.08e-14;

      return calcPHOfADMstate(x, Kw, out SH, out pfac_h);
    }
    /// <summary>
    /// Calculate pH value out of ADM state vector. 
    /// pH value as double returned.
    /// </summary>
    /// <param name="x">ADM state vector</param>
    /// <param name="Kw"></param>
    /// <param name="SH"></param>
    /// <param name="pfac_h"></param>
    /// <returns></returns>
    public static double calcPHOfADMstate(double[] x, double Kw, 
                                          out double SH, out double pfac_h)
    {

      double pH;

      physValue Snh4= biogas.ADMstate.calcFromADMstate(x, "Snh4", "mol/l");

      // pfac_d dürfte meistens negativ sein, TAC ist meistens größer als NH4
      // obwohl in mol/l vielleicht nicht unbedingt, wegen molmasse
      // 
      pfac_h= -calcTACOfADMstate(x, "mol/l").Value + Snh4.Value;

      // SH ist immer positiv
      // da der zweite term immer größer als wie der erste term ist
      SH= -1 * pfac_h / 2 + 0.5 * Math.Pow( pfac_h * pfac_h + 4*Kw, 0.5 );

      pH= -Math.Log10(SH);

      return pH;

    }

    /// <summary>
    /// Calculate volumeflow out of ADM state vector in m³/d
    /// </summary>
    /// <param name="x">ADM state vector, dim_stream dimensional</param>
    /// <returns>Q in m^3/d</returns>
    /// <exception cref="exception">x.Length != _dim_stream</exception>
    public static physValue calcQOfADMstate(double[] x)
    {
      if (x.Length != _dim_stream)
        throw new exception(String.Format("x must be {0} dimensional, but is {1}!", 
          _dim_stream, x.Length));

      return new physValue("Q", x[pos_Q - 1], "m^3/d", "volumetric flow rate");
    }

    /// <summary>
    /// Calculates soluble solids out ADM state vector in kgCOD/m³.
    /// 
    /// To soluble solids belong:
    /// - monosaccharides, amino acids, long chain fatty acids,
    /// - valeric acid, butyric acid, propionic acid, acetic acid, 
    /// - acetic acid, hydrogen, methane, soluble inerts
    /// </summary>
    /// <param name="x">ADM state vector</param>
    /// <returns></returns>
    public static physValueBounded calcSSOfADMstate(double[] x)
    {
      string unit= "kgCOD/m^3";

      return calcSSOfADMstate(x, unit);
    }
    /// <summary>
    /// Calculates soluble solids out ADM state vector in given unit.
    /// 
    /// To soluble solids belong:
    /// - monosaccharides, amino acids, long chain fatty acids,
    /// - valeric acid, butyric acid, propionic acid, acetic acid, 
    /// - acetic acid, hydrogen, methane, soluble inerts
    /// </summary>
    /// <param name="x">ADM state vector</param>
    /// <param name="unit"></param>
    /// <returns></returns>
    public static physValueBounded calcSSOfADMstate(double[] x, string unit)
    {
      // monosaccharides measured in unit
      physValue Ssu=  biogas.ADMstate.calcFromADMstate(x, "Ssu",  unit);
      // amino acids measured in unit
      physValue Saa=  biogas.ADMstate.calcFromADMstate(x, "Saa",  unit);
      // LCFA measured in unit
      physValue Sfa=  biogas.ADMstate.calcFromADMstate(x, "Sfa",  unit);
      // sum parameter of valeric acid and valerate measured in unit
      physValue Sva=  biogas.ADMstate.calcFromADMstate(x, "Sva",  unit);
      // sum parameter of butyric acid and butyrate measured in unit
      physValue Sbu=  biogas.ADMstate.calcFromADMstate(x, "Sbu",  unit);
      // sum parameter of propionic acid and propionate measured in unit
      physValue Spro= biogas.ADMstate.calcFromADMstate(x, "Spro", unit);
      // sum parameter of acetic acid and acetate measured in unit
      physValue Sac=  biogas.ADMstate.calcFromADMstate(x, "Sac",  unit);
      // hydrogen measured in unit
      physValue Sh2=  biogas.ADMstate.calcFromADMstate(x, "Sh2",  unit);
      // methane measured in unit
      physValue Sch4= biogas.ADMstate.calcFromADMstate(x, "Sch4", unit);

      //

      physValue SI= biogas.ADMstate.calcFromADMstate(x, "SI", unit);

      //

      physValueBounded SS= new physValueBounded(Ssu + Saa + Sfa + Sva + Sbu + 
                                                Spro + Sac + Sh2 + Sch4 + SI);

      SS.Symbol= "SS_COD";

      //SS.setLB(0);

      SS.printIsOutOfBounds();

      return SS;
    }

    /// <summary>
    /// calc total biomass of ADM state
    /// </summary>
    /// <param name="x">ADM state vector</param>
    /// <returns>biomass: aci + ace + meth</returns>
    public static physValue calcBiomassOfADMstate(double[] x)
    {
      physValue AciAceBiomass = calcAciAceBiomassOfADMstate(x);
      physValue MethBiomass = calcMethBiomassOfADMstate(x);

      physValue biomass = AciAceBiomass + MethBiomass;
      biomass.Symbol = "Xbio";

      return biomass;
    }

    /// <summary>
    /// biomass= Biomass Sugar degraders + Biomass amino acids degraders + 
    /// LCFA degraders + valerate, butyrate degraders + propionate degraders
    ///
    /// producing mainly acetate and hydrogen
    /// 
    /// </summary>
    /// <param name="x">ADM state vector</param>
    /// <returns></returns>
    public static physValue calcAciAceBiomassOfADMstate(double[] x)
    {
      string unit= "kgCOD/m^3";

      return calcAciAceBiomassOfADMstate(x, unit);
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="x"></param>
    /// <param name="unit"></param>
    /// <returns></returns>
    public static physValue calcAciAceBiomassOfADMstate(double[] x, string unit)
    {
      // biomass sugar degraders measured in unit
      physValue Xsu= biogas.ADMstate.calcFromADMstate(x, "Xsu", unit);
      // biomass amino acids degraders measured in unit
      physValue Xaa= biogas.ADMstate.calcFromADMstate(x, "Xaa", unit);
      // biomass LCFA degraders measured in unit
      physValue Xfa= biogas.ADMstate.calcFromADMstate(x, "Xfa", unit);
      // biomass valerate, butyrate degraders measured in unit
      physValue Xc4= biogas.ADMstate.calcFromADMstate(x, "Xc4", unit);
      // biomass propionate degraders measured in unit
      physValue Xpro= biogas.ADMstate.calcFromADMstate(x, "Xpro", unit);

      physValue XbioAciAce= Xsu + Xaa + Xfa + Xc4 + Xpro;

      XbioAciAce.Symbol= "XbioAciAce";

      return XbioAciAce;
    }

    /// <summary>
    /// biomass= Biomass acetate degraders + Biomass hydrogen acids degraders
    /// 
    /// methane producers
    /// 
    /// </summary>
    /// <param name="x"></param>
    /// <returns></returns>
    public static physValue calcMethBiomassOfADMstate(double[] x)
    {
      string unit= "kgCOD/m^3";

      return calcMethBiomassOfADMstate(x, unit);
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="x"></param>
    /// <param name="unit"></param>
    /// <returns></returns>
    public static physValue calcMethBiomassOfADMstate(double[] x, string unit)
    {
      // biomass acetate degraders measured in unit
      physValue Xac= biogas.ADMstate.calcFromADMstate(x, "Xac", unit);
      // biomass hydrogen degraders measured in unit
      physValue Xh2= biogas.ADMstate.calcFromADMstate(x, "Xh2", unit);
      
      physValue XbioMeth= Xac + Xh2;

      XbioMeth.Symbol= "XbioMeth";

      return XbioMeth;
    }

    /// <summary>
    /// Calculates total alkalinity out of given ADM state vector
    /// 
    /// the buffer consists out of:
    /// - acetate of VFAs, HCO3, aniona and cations
    /// </summary>
    /// <param name="x">ADM state vector</param>
    /// <param name="unit">some unit</param>
    /// <param name="TAC">TAC value in given unit</param>
    /// <returns></returns>
    public static void calcTACOfADMstate(double[] x, string unit, out double TAC)
    {
      physValue pTAC = calcTACOfADMstate(x, unit);

      TAC = pTAC.Value;
    }
    /// <summary>
    /// Calculates total alkalinity out of given ADM state vector
    /// 
    /// the buffer consists out of:
    /// - acetate of VFAs, HCO3, aniona and cations
    /// </summary>
    /// <param name="x">ADM state vector</param>
    /// <param name="unit"></param>
    /// <returns></returns>
    public static physValueBounded calcTACOfADMstate(double[] x, string unit)
    {

      string unit_temp= "mol/l";

      // kmol/m³ = mol/l
      physValue San= new science.physValue( "San", x[biogas.ADMstate.pos_San - 1], "mol/l" );
      // mol/l
      physValue Shco3= biogas.ADMstate.calcFromADMstate(x, "Shco3", unit_temp);
      // mol/l
      physValue Sac_= biogas.ADMstate.calcFromADMstate(x, "Sac_", unit_temp);
      // mol/l
      physValue Spro_= biogas.ADMstate.calcFromADMstate(x, "Spro_", unit_temp);
      // mol/l
      physValue Sbu_= biogas.ADMstate.calcFromADMstate(x, "Sbu_", unit_temp);
      // mol/l
      physValue Sva_= biogas.ADMstate.calcFromADMstate(x, "Sva_", unit_temp);
      // kmol/m³ = mol/l
      physValue Scat= new science.physValue( "Scat", x[biogas.ADMstate.pos_Scat - 1], "mol/l" );

      //

      // mol/l
      physValueBounded TAC= new physValueBounded(San + Shco3 + Sac_ + Spro_ + Sva_ + Sbu_ - Scat);

      //

      TAC= TAC.convertUnit(unit);

      TAC.Symbol= "TAC";

      //TAC.setLB(-double.Epsilon);

      TAC.printIsOutOfBounds();

      return TAC;
    }

    /// <summary>
    /// Calculate volatile fatty acids out of given ADM state vector x
    /// </summary>
    /// <param name="x">ADM state vector</param>
    /// <param name="unit">some unit</param>
    /// <param name="VFA">VFA value in given unit</param>
    /// <returns></returns>
    public static void calcVFAOfADMstate(double[] x, string unit, out double VFA)
    {
      physValue pVFA = calcVFAOfADMstate(x, unit);

      VFA = pVFA.Value;
    }
    /// <summary>
    /// Calculate volatile fatty acids out of given ADM state vector x
    /// </summary>
    /// <param name="x">ADM state vector</param>
    /// <param name="unit"></param>
    /// <returns></returns>
    public static physValueBounded calcVFAOfADMstate(double[] x, string unit)
    {
      string unit_temp= "mol/l";

      // mol/l
      physValue Sac= biogas.ADMstate.calcFromADMstate(x, "Sac", unit_temp);
      // mol/l
      physValue Spro= biogas.ADMstate.calcFromADMstate(x, "Spro", unit_temp);
      // mol/l
      physValue Sbu= biogas.ADMstate.calcFromADMstate(x, "Sbu", unit_temp);
      // mol/l
      physValue Sva= biogas.ADMstate.calcFromADMstate(x, "Sva", unit_temp);

      // mol/l
      physValueBounded Svfa= new physValueBounded(Sac + Spro + Sbu + Sva);

      Svfa= Svfa.convertUnit(unit);

      Svfa.Symbol= "VFA";

      //Svfa.setLB(0);

      Svfa.printIsOutOfBounds();

      return Svfa;
    }

    /// <summary>
    /// sum of all particulate COD containing components of ADM state
    /// </summary>
    /// <param name="x">ADM state vector</param>
    /// <param name="unit"></param>
    /// <returns></returns>
    public static physValueBounded calcVSOfADMstate(double[] x, string unit)
    { 
      // composite (also contains SI and XI, because both of them
      // are inside volatile solids) [kgCOD/m^3 = gCOD/l]
      physValue Xc= biogas.ADMstate.calcFromADMstate(x, "Xc", unit);

      // carbohydrates [kgCOD/m^3 = gCOD/l]
      physValue Xch= biogas.ADMstate.calcFromADMstate(x, "Xch", unit);
      // proteins [kgCOD/m^3 = gCOD/l]
      physValue Xpr= biogas.ADMstate.calcFromADMstate(x, "Xpr", unit);
      // lipids [kgCOD/m^3 = gCOD/l]
      physValue Xli= biogas.ADMstate.calcFromADMstate(x, "Xli", unit);

      // biomass sugar degraders measured in unit
      physValue Xsu= biogas.ADMstate.calcFromADMstate(x, "Xsu", unit);
      // biomass amino acids degraders measured in unit
      physValue Xaa= biogas.ADMstate.calcFromADMstate(x, "Xaa", unit);
      // biomass LCFA degraders measured in unit
      physValue Xfa= biogas.ADMstate.calcFromADMstate(x, "Xfa", unit);
      // biomass valerate, butyrate degraders measured in unit
      physValue Xc4= biogas.ADMstate.calcFromADMstate(x, "Xc4", unit);
      // biomass propionate degraders measured in unit
      physValue Xpro= biogas.ADMstate.calcFromADMstate(x, "Xpro", unit);
      // biomass acetate degraders measured in unit
      physValue Xac= biogas.ADMstate.calcFromADMstate(x, "Xac", unit);
      // biomass hydrogen degraders measured in unit
      physValue Xh2= biogas.ADMstate.calcFromADMstate(x, "Xh2", unit);

      // particulate products arising from biomass decay [kgCOD/m^3 = gCOD/l]
      physValue Xp= biogas.ADMstate.calcFromADMstate(x, "Xp", unit);

      physValue XI= biogas.ADMstate.calcFromADMstate(x, "XI", unit);

      //
      //physValue SS= biogas.ADMstate.calcSSOfADMstate(x, unit);


      // sum of all particulate COD containing components
      physValueBounded VS= new physValueBounded(
                           Xc + Xch + Xpr + Xli +                      // composites + ...
                           Xsu + Xaa + Xfa + Xc4 + Xpro + Xac + Xh2 +  // biomass 
                           Xp + XI);// +                                   // biomass decay + inerts
                           //SS);                                        // soluble solids

      //

      VS.Symbol= "VS_COD";

      //VS.setLB(0);

      VS.printIsOutOfBounds();

      return VS;
    }



    /// <summary>
    /// Print state values to a string, to be displayed on a console
    /// </summary>
    /// <param name="x">state vector</param>
    /// <param name="digester_id"></param>
    /// <param name="myPlant"></param>
    /// <returns></returns>
    public static string print(double[] x, string digester_id, plant myPlant)
    {
      StringBuilder sb = new StringBuilder();
      
      sb.Append("  pH= " + calcPHOfADMstate(x).ToString("0.00") + "\t\t\t");
      sb.Append("NH4= " + calcNH4(x, digester_id, myPlant, "g/l").printValue() + "\n");

      sb.Append("  VFA/TA= " + calcFOSTACOfADMstate(x).printValue() + "\t\t\t");
      sb.Append("TA= " + calcTACOfADMstate(x, "gCaCO3eq/l").printValue() + "\t\t\t");
      sb.Append("VFA= " + calcVFAOfADMstate(x, "gHAceq/l").printValue() + "\n");
      
      sb.Append("  Sac= " + calcFromADMstate(x, "Sac", "g/l").printValue() + "\t\t\t");
      sb.Append("Sbu= " + calcFromADMstate(x, "Sbu", "g/l").printValue() + "\t\t\t");
      sb.Append("Spro= " + calcFromADMstate(x, "Spro", "g/l").printValue() + "\t\t\t");
      sb.Append("Sva= " + calcFromADMstate(x, "Sva", "g/l").printValue() + "\n");

      physValue T= myPlant.getDigesterByID(digester_id).get_params_of("T");
      physValue V= myPlant.getDigesterByID(digester_id).get_params_of("Vliq");
     
      physValue qgas_h2, qgas_ch4, qgas_co2, qgas;
      
      calcBiogasOfADMstate(x, V, T, out qgas_h2, out qgas_ch4, out qgas_co2, out qgas);

      sb.Append("  Qch4= " + qgas_ch4.printValue("0.000") + "\t\t");
      sb.Append("Qco2= " + qgas_co2.printValue("0.000") + "\t\t");
      sb.Append("Qh2= " + qgas_h2.printValue("0.0000") + "\t\t");
      sb.Append("Qgas= " + qgas.printValue("0.00") + "\n");

      return sb.ToString();
    }



  }
}


