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
* This file is part of the partial class pump and defines
* all methods not defined elsewhere.
* 
* TODOs:
* - improve documentation
* - neue berechnung methoden sind noch nicht fertig, sollten ok sein
* - parameter sind noch nicht substratabhängig
* 
* Except for that FINISHED!
* 
*/

using System;
using System.Collections.Generic;
using System.Text;
using science;
using System.Xml;
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
  /// Pumpen können zwischen
  /// 
  /// - (Substratzufuhr und Fermenter (substratemix -> digester_id) nicht mehr, s. substrate_transport)
  /// - verschiedenen Fermentern
  /// - Fermenter und Endlager (digester_id -> storagetank)
  /// 
  /// angebracht werden.
  /// 
  /// Pumps basically just calculate the energy needed to pump the stuff.
  /// 
  /// energy is needed for two reasons:
  /// - to pump over a distance -> friction
  /// - to liften stuff -> potential energy
  /// 
  /// A pump is only used to pump sludge, not to pump substrate (substrate_transport).
  /// Even if manure is fed the needed energy is calculated using (substrate_transport).
  /// </summary>
  public partial class pump
  {
    
    // -------------------------------------------------------------------------------------
    //                              !!! PUBLIC METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// TODO
    /// </summary>
    /// <param name="t">current simulation time in days</param>
    /// <param name="mySensors"></param>
    /// <param name="u">stream going into the pump measured in m^3/d</param>
    /// <param name="unit_start"></param>
    /// <param name="unit_destiny"></param>
    /// <param name="myPlant"></param>
    /// <param name="Q_pump">to be pumped amount in m^3/d</param>
    /// <returns></returns>
    public static double run(double t, //double deltatime,
      biogas.sensors mySensors, double u, 
      string unit_start, string unit_destiny,
      biogas.plant myPlant, /*biogas.substrates mySubstrates,
      double[,] substrate_network,*/ out double Q_pump)
    {
      string pump_id = getid(unit_start, unit_destiny);

      // determine Q
      //double Q_pump;      // to be pumped amount

      mySensors.getMeasurementAt("Q", "Q_" + pump_id, t, out Q_pump);

      return run(t, mySensors, u, Q_pump, unit_start, unit_destiny, 
        myPlant);//, mySubstrates, substrate_network);
    }

    /// <summary>
    /// TODO
    /// </summary>
    /// <param name="t">current simulation time in days</param>
    /// <param name="mySensors"></param>
    /// <param name="u">stream going into the pump measured in m^3/d</param>
    /// <param name="Q_pump">to be pumped amount in m^3/d</param>
    /// <param name="unit_start"></param>
    /// <param name="unit_destiny"></param>
    /// <param name="myPlant"></param>
    /// <returns></returns>
    public static double run(double t, //double deltatime,
      biogas.sensors mySensors, double u, double Q_pump, 
      string unit_start, string unit_destiny,
      biogas.plant myPlant/*, biogas.substrates mySubstrates, 
      double[,] substrate_network*/)
    {
      string pump_id = getid(unit_start, unit_destiny);
           
      // determine rho - default value for digester or storagetank
      //physValue density = new physValue("rho", 1000, "kg/m^3", "density");

      if (unit_start == "substratemix")
      {
        throw new exception("pumps may not pump the substratemix");

        // get mean rho out of substrates and double[] Q
        // nutze hier getSubstrateMixFlowForFermenter

        //double[] Q;

        // TODO !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        // id_in_array einführen und durch "Q" ersetzen
        // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        //mySensors.getCurrentMeasurements("Q", "Q", mySubstrates, out Q);
        //getMeasurementsAt("Q", "Q", time, mySubstrates, out Q);

        // unit_destiny here must be a digester_id, because you cannot
        // pump substratemix directly into final storage tank
        //physValue[] Q_digester = 
        //  sensors.getSubstrateMixFlowForFermenter(t, mySubstrates, myPlant,
        //                          mySensors, substrate_network, unit_destiny);

        //// values are Q for all substrates
        //double[] Q = physValue.getValues(Q_digester);

        //mySubstrates.get_weighted_mean_of(Q, "rho", out density);
      }


      // measure energy needed to pump stuff 

      double P_kWh_d;

      // es ist wichtig, dass hier rho nicht mit übergeben wird
      // wird genutzt als erkennungsmerkmal in pumpEnergy_sensor
      // im unterschied zu substrate_transport
      double[] parvec = { Q_pump };//, density.Value };

      mySensors.measure(t, "pumpEnergy_" + pump_id, 
        myPlant, u, parvec, out P_kWh_d);

      // TODO - DEFINE WHAT SHOULD be returned
      //double[] retvals = { P_kWh_d, Q_pump };

      return P_kWh_d;// retvals;
    }

    /// <summary>
    /// Calculate energy consumption needed to pump the amount min(Qin, Q_pump)
    /// </summary>
    /// <param name="Qin">
    /// Menge welche in Pumpe rein geht
    /// must be measured in m^3/d
    /// </param>
    /// <param name="Q_pump">
    /// Menge welche gepumpt werden soll
    /// aber nur gepumpt werden kann, wenn Q_pump kleiner gleich Qin
    /// must be measured in m^3/d
    /// </param>
    /// <param name="g">gravitational constant</param>
    /// <param name="density">density of material to be pumped</param>
    public physValue calcEnergyConsumption(double Qin, double Q_pump, 
      physValue g, physValue density)
    {
      physValue pQin= new physValue(Qin, "m^3/d");
      physValue pQ_pump= new physValue(Q_pump, "m^3/d");

      return calcEnergyConsumption(pQin, pQ_pump, g, density);
    }

    /// <summary>
    /// Calculate energy consumption needed to pump the amount min(Qin, Q_pump)
    /// </summary>
    /// <param name="Qin">Menge welche in Pumpe rein geht</param>
    /// <param name="Q_pump">
    /// Menge welche gepumpt werden soll
    /// aber nur gepumpt werden kann, wenn Q_pump kleiner gleich Qin
    /// </param>
    /// <param name="g">gravitational constant</param>
    /// <param name="density">density of material to be pumped</param>
    public physValue calcEnergyConsumption(physValue Qin, physValue Q_pump, 
      physValue g, physValue density)
    {
      // TODO, get density from density sensor
      // depending on _unit_start, which is either the substrate mix or
      // a fermenter, for both a density sensor should exist
      //
      //physValue density = new physValue("rho", 1000, "kg/m^3", "density");

      //

      Qin = Qin.convertUnit("m^3/d");
      Q_pump = Q_pump.convertUnit("m^3/d");
      g = g.convertUnit("m/s^2");
      density = density.convertUnit("kg/m^3");

      //

      // Q effluent - die ungepumpte Menge
      physValue Qeff = physValue.max(Qin - Q_pump, new physValue(0, "m^3/d"));

      // die gepumpte Menge
      // ist das nicht das gleiche wie:
      // Qeff_pumped= min(Qin, Q_pump)
      // ja ist das gleiche: 
      // Beweis: 
      // Qeff= max( Qin - Qpump, 0 )
      // Qeffpumped= Qin - Qeff
      //           = Qin - max( Qin - Qpump, 0 )    // argument und funktion VZ wechseln und max -> min
      //           = Qin + min( Qpump - Qin, 0 )    // Qin in min rein schieben
      //           = min( Qpump, Qin )
      physValue Qeff_pumped = Qin - Qeff;

      
      // $$P(t) [kWh/d]= u(t) \cdot \left( h_{lift} + h_{friction} \cdot \mu
      // \right) \cdot \rho \cdot g /
      // \eta \cdot \frac{1}{3600 \cdot 1000 \cdot 1000}$$
      //
      // $$\left[ \frac{kWh}{d} \right] = \left[ \frac{kW \cdot 3600 s}{d} \right]
      // = \left[ \frac{kNm \cdot 3600}{d} \right]
      // = \left[ \frac{k \cdot kg \cdot m^2 \cdot 3600}{d \cdot s^2} \right] =
      // \left[
      // \frac{m^3}{d} \cdot m \cdot \frac{g}{m^3} \cdot  
      // \frac{m}{s^2} \cdot \frac{k \cdot k}{1000 \cdot 1000} \right]$$
      //
      physValue P_kWh_d;

      // siehe auch Formeln in Ganzheitliche stoffliche und energetische Modellierung
      // S. 48. Formeln sind etwas anders, sprechen von
      // hydrostatischem Druck und Druckverlust in Leitung
      // erstere wird identisch wie hier berechnet, zweitere etwas anders

      // power needed to pump substrate in [Ws/d]
      // m³/d * m * kg/m^3 * [m/s^2] = kg/d * m/s^2 * m = N m/d = W s/d 
      physValue P_Ws_d = Qeff_pumped * //(
        h_lift //+ d_horizontal * mu) 
        * density * g *
                // N == kg * m/s^2, evtl. macht Doppelbruch Probleme
                new physValue(1, "N * s^2 / ( kg * m )") * 
                new physValue(1, "W * s / ( N * m )");

      //
      // TODO - parametrisierung
      // TS Gehalt und temperatur
      double DpL= calcPressureLoss(density.Value, 6, Qeff_pumped.Value, 15);

      // Pa = N/m^2 = Nm/m^3 = Ws/m^3
      // Ws/m^3 * m^3/d = Ws/d
      physValue Ppressloss = Qeff_pumped * new physValue( "DpL", DpL, "W * s/m^3" );

      // TODO - auskommentieren
      // Einheiten scheinen nicht überinzustimmen!!!
      P_Ws_d = P_Ws_d + Ppressloss;     // Ws/d

      // same power in [kWh/d]
      P_kWh_d = P_Ws_d * new physValue(1.0f/(3600.0f * 1000.0f), "kWh/(W * s)");

      if (eta == 0)
        throw new exception("eta == 0!");

      // power that the pump must have, due to losses (electrical degree of efficiency)
      P_kWh_d = P_kWh_d / eta;

      P_kWh_d.Symbol = "Pel";
      
      return P_kWh_d;
    }

    // ab hier OK

    /// <summary>
    /// calc pressure loss \Delta p_L [Pa]
    /// Darcy-Weisbach equation
    /// </summary>
    /// <param name="density">density of sludge or substrate [kg/m^3]</param>
    /// <param name="TSsludge_substrate">TS of sludge or substrate [% FM]</param>
    /// <param name="Qeff_pumped">
    /// volumetric flow rate of sludge or substrate [m^3/d]
    /// </param>
    /// <param name="T">substrate/sludge temperature in °C</param>
    /// <returns>pressure loss \Delta p_L [Pa]</returns>
    /// <exception cref="exception">_d_pipe == 0, division by zero</exception>
    /// <exception cref="exception">division by zero</exception>
    private double calcPressureLoss(double density, double TSsludge_substrate, 
      double Qeff_pumped, double T)
    {
      if (Qeff_pumped == 0) // wenn nichts gepumpt wird, sind auch Druckverluste 0
        return 0;           // schützt auch vor Div. durch 0, da Re_pipe 0 wird

      // calc pressure loss coefficient lamba_pipe [100 %]
      double lambda_pipe = 0;

      try
      {
        lambda_pipe = calc_lambda_pipe(density, TSsludge_substrate, Qeff_pumped, T);
      }
      catch (exception e)
      {
        Console.WriteLine(e.Message);
        throw new exception("division by zero!");
      }

      // velocity of the medium in the pipe v_p in m/d
      double v_pipe= calcPipeVelocity(Qeff_pumped);

      _d_horizontal = d_horizontal.convertUnit("m");

      // 1 * kg/m^3 * m^2/d^2 * m / m = kg / (m * d^2) = 1/(24*24*3600*3600) kg/(m*s^2)
      // 1 P a= 1 kg/(m * s^2)
      return ( lambda_pipe * density * Math.Pow(v_pipe, 2) * d_horizontal.Value ) /
             (2 * _d_pipe * (24 * 24) * (3600 * 3600) );
    }

    /// <summary>
    /// velocity of the medium in the pipe v_p in m/d
    /// </summary>
    /// <param name="Qeff_pumped">
    /// volumetric flow rate of sludge or substrate [m^3/d]
    /// </param>
    /// <returns>velocity of the medium in the pipe v_p in m/d</returns>
    /// <exception cref="exception">_d_pipe == 0, division by zero</exception>
    private double calcPipeVelocity(double Qeff_pumped)
    { 
      if (_d_pipe == 0)
        throw new exception("_d_pipe == 0!");

      // calc v_p
      // m^3/d / m^2 = m/d
      return ( 4 * Qeff_pumped ) / ( Math.PI * Math.Pow(_d_pipe, 2) );
    }

    /// <summary>
    /// calc pressure loss coefficient lamba_pipe [100 %]
    /// </summary>
    /// <param name="density">density of sludge or substrate [kg/m^3]</param>
    /// <param name="TSsludge_substrate">TS of sludge or substrate [% FM]</param>
    /// <param name="Qeff_pumped">
    /// volumetric flow rate of sludge or substrate [m^3/d]
    /// </param>
    /// <param name="T">substrate/sludge temperature in °C</param>
    /// <returns>pressure loss coefficient lamba_pipe [100 %]</returns>
    /// <exception cref="exception">_d_pipe == 0, division by zero</exception>
    /// <exception cref="exception">nflow == 0, division by zero</exception>
    /// <exception cref="exception">v_pipe == 0, division by zero</exception>
    /// <exception cref="exception">eta_eff_pipe == 0, division by zero</exception>
    /// <exception cref="exception">_k_pipe == 0 || Re_pipe == 0, division by zero</exception>
    private double calc_lambda_pipe(double density, double TSsludge_substrate,
                                double Qeff_pumped, double T)
    {
      // Reynolds number of pipe [100 %]
      double Re_pipe = calc_Re_pipe(density, TSsludge_substrate, Qeff_pumped, T);

      if ( (_k_pipe == 0) || (Re_pipe == 0) )
        throw new exception("_k_pipe == 0 || Re_pipe == 0!");

      // da eines in meter, das andere
      // in mm eingesetzt wird, ist hier alles richtig
      double d_k_ratio= _d_pipe / _k_pipe;

      if (Re_pipe < 2300)
        return 64 / Re_pipe;
      if ((Re_pipe >= 2300) && (Re_pipe <= Math.Pow(10, 6) * d_k_ratio))
        return 0.25 / Math.Pow(Math.Log10(15 / Re_pipe +
                                  0.2692 * Math.Pow(10, -3) * _k_pipe / _d_pipe), 2);
      else
        return 0.25 / Math.Pow( Math.Log10( 3715 * d_k_ratio ), 2 );
    }

    /// <summary>
    /// calc Reynolds number of pipe [100 %]
    /// </summary>
    /// <param name="density">density of sludge or substrate [kg/m^3]</param>
    /// <param name="TSsludge_substrate">TS of sludge or substrate [% FM]</param>
    /// <param name="Qeff_pumped">
    /// volumetric flow rate of sludge or substrate [m^3/d]
    /// </param>
    /// <param name="T">substrate/sludge temperature in °C</param>
    /// <returns>Reynolds number [100 %]</returns>
    /// <exception cref="exception">_d_pipe == 0, division by zero</exception>
    /// <exception cref="exception">nflow == 0, division by zero</exception>
    /// <exception cref="exception">v_pipe == 0, division by zero</exception>
    /// <exception cref="exception">eta_eff_pipe == 0, division by zero</exception>
    private double calc_Re_pipe(double density, double TSsludge_substrate,
                                double Qeff_pumped, double T)
    {
      // velocity of the medium in the pipe v_p in m/d
      double v_pipe = calcPipeVelocity(Qeff_pumped);

      // effective viscosity of water: eta_eff_pipe [Pa*s]
      double eta_eff_pipe = calc_eta_eff_pipe(TSsludge_substrate, Qeff_pumped, T);

      if (eta_eff_pipe == 0)
        throw new exception("eta_eff_pipe == 0!");

      // m/d * m * kg/m^3 / (Pa*s) = kg/(d * m * Pa * s) = 
      // kg * m^2/(d * m * N * s) = kg * m^2 * s^2/(d * m * kg * m * s) =
      // s/d = s/(24 * 3600 s) = 1/24*3600
      return (v_pipe * _d_pipe * density) / (eta_eff_pipe * 3600 * 24);
    }

    /// <summary>
    /// calc effective viscosity of sludge or substrate: eta_eff_pipe [Pa * s]
    /// </summary>
    /// <param name="TSsludge_substrate">
    /// total solids content of sludge or substrate [% FM]
    /// </param>
    /// <param name="Qeff_pumped">
    /// volumetric flow rate of sludge or substrate [m^3/d]
    /// </param>
    /// <param name="T">temperature of substrate/sludge in [°C]</param>
    /// <returns>effective viscosity [Pa*s]</returns>
    /// <exception cref="exception">_d_pipe == 0, division by zero</exception>
    /// <exception cref="exception">nflow == 0, division by zero</exception>
    /// <exception cref="exception">v_pipe == 0, division by zero</exception>
    private double calc_eta_eff_pipe(double TSsludge_substrate, double Qeff_pumped, 
      double T)
    {
      // viscosity of water [Pa * s]
      double eta_water = calc_eta_water(T);

      // consistency coefficient [Pa*s]
      double K = stirrer.calc_K(TSsludge_substrate);

      // flow index [100 %]
      double nflow = stirrer.calc_nflow(TSsludge_substrate);

      // shear rate [1/s]
      double gamma_dot = calc_shear_rate(TSsludge_substrate);

      // shear stress [Pa]
      double tau_pipe = calc_shear_stress(TSsludge_substrate);

      // velocity of medium in pipe [m/d]
      double v_pipe = calcPipeVelocity(Qeff_pumped);

      // TODO - substratabhängig
      double Cvisc= 0.75 * Math.Pow(10, -3);  // Pa * s

      // effective viscosity of substrate or sludge for case 1 [Pa * s]
      double case1 = eta_water + Cvisc * TSsludge_substrate;

      if (nflow == 0)
        throw new exception("nflow == 0!");

      // effective viscosity of substrate or sludge for case 2 [Pa*s]
      double case2 = K * Math.Pow( (3 * nflow + 1)/(4 * nflow), nflow ) * 
                         Math.Pow(gamma_dot, nflow - 1);

      if (v_pipe == 0)
        throw new exception("v_pipe == 0!");

      // effective viscosity of substrate or sludge for case 3 [Pa * s]
      // Pa * m / (m/d) + Pa*s*1    
      // damit letzte 1 wird, muss m/d in m/sec. umgerechnet werden, deshalb
      // m/d * 1/(24 * 3600) = m/s
      // von oben weiter:
      // Pa * d + Pa * s = Pa * 24 * 3600 s + Pa * s
      double case3= ( 24 * 3600 * tau_pipe * _d_pipe ) / ( 2 * Math.PI * v_pipe ) + 
        K * Math.Pow( 
          ( 2 * Math.PI * v_pipe ) / ( _d_pipe * 24 * 3600 ), 
            nflow - 1 );

      double eta_eff_pipe = 1;

      if (TSsludge_substrate < 3)     // < 3 % FM
        eta_eff_pipe = case1;         
      else if ((TSsludge_substrate >= 3) && (TSsludge_substrate <= 8))
        eta_eff_pipe = case2;         // >= 3 % FM and <= 8 % FM
      else                            // TS > 8 % FM
        eta_eff_pipe = case3;

      return eta_eff_pipe;
    }

    /// <summary>
    /// calc shear rate gamma_dot [1/s]
    /// </summary>
    /// <param name="Qeff_pumped">
    /// volumetric flow rate of substrate or sludge in [m^3/d]
    /// </param>
    /// <returns>shear rate [1/s]</returns>
    /// <exception cref="exception">_d_pipe == 0, division by zero</exception>
    private double calc_shear_rate(double Qeff_pumped)
    {
      // velocity of medium in pipe [m/d]
      double v_pipe = calcPipeVelocity(Qeff_pumped);

      // würde bei d_pipe == 0 den gleichen Fehler werfen
      // m/d/m = 1/d * h/3600 s * d/24h = 1/(24 * 3600 s)
      return 8 * v_pipe / _d_pipe * 1 / ( 24 * 3600 );
    }

    /// <summary>
    /// calc shear stress tau in pipe [Pa]
    /// </summary>
    /// <param name="TS_sludgesubstrate">
    /// total solids of sludge or substrate [% FM]
    /// </param>
    /// <returns>shear stress [Pa]</returns>
    private double calc_shear_stress(double TS_sludgesubstrate)
    {
      double Ctau1 = 0.01;    // [Pa] TODO - schwankt sehr stark zwischen substrate
      double Ctau2 = 0.5;     // TODO - schwankt sehr stark zwischen substrate

      return Ctau1 * Math.Exp(Ctau2 * TS_sludgesubstrate);
    }

    /// <summary>
    /// calculate viscosity of water eta_water [Pa*s]
    /// </summary>
    /// <param name="T">temperature [°C]</param>
    /// <returns>viscosity of water eta_water [Pa*s]</returns>
    private double calc_eta_water(double T)
    {
      double C1 =  2.6489 * Math.Pow(10, -11);       // Pa * s
      double C2 = -7.6244 * Math.Pow(10,  -9);       // Pa * s
      double C3 =  8.6862 * Math.Pow(10,  -7);       // Pa * s
      double C4 = -5.1689 * Math.Pow(10,  -5);       // Pa * s
      double C5 =  1.7475 * Math.Pow(10,  -3);       // Pa * s

      double eta_water = C1 * Math.Pow(T, 4) + C2 * Math.Pow(T, 3) +
                         C3 * Math.Pow(T, 2) + C4 * T + C5;
      
      return eta_water;
    }



  }



}


