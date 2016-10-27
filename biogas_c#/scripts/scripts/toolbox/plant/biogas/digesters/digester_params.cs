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
* This file is part of the partial class digester and defines
* public methods calculating params such as HRT, VS, TS, OLR.
* 
* TODOs:
* - calcOLR verstehe ich nicht!!!!
* - dokumentation von methoden kann noch verbessert werden
* 
* therefore not FINISHED! (wg. 1)
* 
*/

using System;
using System.Collections.Generic;
using System.Text;
using science;
using toolbox;
using System.Xml;

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
  /// Defines a digester on a biogas plant. To each digester a heating belongs, which is
  /// either switched on or off.
  /// 
  /// Furthermore each digester is modelled by an anaerobic digestion model (ADM).
  /// This ADM object is accessible through this class.
  /// 
  /// </summary>
  public partial class digester
  {

    // -------------------------------------------------------------------------------------
    //                              !!! PUBLIC METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// Calculates TS content inside the digester. Therefore we calculate the COD 
    /// inside the digester using the state vector x. Furthermore we calculate out
    /// of the substrates going into the digester the ash and TS content. If
    /// no substrate is going into the digester we take the sludge and pass it to
    /// this method. But never mix substrates and sludge!!!
    /// 
    /// Basic formula is:
    /// 
    /// Xc,digester= rho_substrate * TS_digester [100 % FM] * 
    ///              VS_digester [% TS] / VS_substrate [% TS] * ( ... )
    ///     
    /// 
    /// !!!!!!!!!!!!!!!!!!!! ATTENTION !!!!!!!!!!!!!!!!!!!!!
    /// this function only calculates the total solids in steady state!!!
    /// because the ash content in the digester is not taken into account, just the ash of the substrate, which is only
    /// a small part of volume compared with ash in digester. in steady state we assume that ash content in digester is
    /// the same as the one of the substrate, but in dynamic simulation this is not true at all
    /// 
    /// As a reference see:
    /// 
    /// Koch, K., Lübken, M., Gehring, T., Wichern, M., and Horn, H.: 
    /// Biogas from grass silage – Measurements and modeling with ADM1, 
    /// Bioresource Technology 101, pp. 8158-8165, 2010.
    /// 
    /// </summary>
    /// <param name="x">digester state vector</param>
    /// <param name="mySubstrates">
    /// substrates or sludge but not both!!! Because TS content is calculated
    /// out of COD in digester. If there is a mixture of substrate and sludge going
    /// into the digester, then the COD is already decreased by the sludge, so no need
    /// to account for the lower TS of the sludge here.
    /// </param>
    /// <param name="Q">
    /// array of substrate mix stream or recirculations in m³/d
    /// wie soll das mit recirculations funktionieren?
    /// Q welches an get_weighted_mean_of übergeben wird, muss mindestens
    /// anzahl der substrate beinhalten. das funktioniert, weil
    /// mySubstrates einmal eine liste von schlamm ist, und einmal
    /// eine liste der substrate
    /// </param>
    /// <returns>TS in % FM</returns>
    /// <exception cref="exception">Q.Length &lt; mySubstrates.Count</exception>
    /// <exception cref="exception">TS value out of bounds</exception>
    public static physValue calcTS(double[] x, substrates mySubstrates, double[] Q)
    {
      physValue RF;
      physValue RP;
      physValue RL;
      physValue ADL;
      physValue VS;
      physValue rho;
      physValue ash;
      //physValue TS_substrate;

      mySubstrates.get_weighted_mean_of(Q, "RF",  out RF);
      mySubstrates.get_weighted_mean_of(Q, "RP",  out RP);
      mySubstrates.get_weighted_mean_of(Q, "RL",  out RL);
      mySubstrates.get_weighted_mean_of(Q, "ADL", out ADL);
      mySubstrates.get_weighted_mean_of(Q, "VS",  out VS);
      mySubstrates.get_weighted_mean_of(Q, "rho", out rho);

      mySubstrates.get_weighted_mean_of(Q, "Ash", out ash);
      //mySubstrates.get_weighted_mean_of(Q, "TS",  out TS_substrate);

      // particulate COD inside the digester
      physValue COD= biogas.ADMstate.calcVSOfADMstate(x, "kgCOD/m^3");

      VS= VS.convertUnit("% TS");
            
      ash= ash.convertUnit("% FM");   // ash of the substrates

      physValue TS;

      // we assume that the COD inside the digester is composed as is the substrate mix
      TS= biogas.substrate.calcTS(RF, RP, RL, ADL, 
                                  VS, COD, rho);//.convertUnit("100 %");

      //VS= biogas.substrate.convertFrom_TS_To_FM(VS, TS_substrate);
      VS= VS.convertUnit("100 %");    // VS of substrate mix, weiterhin gemessen in 100 % TS

      // TS_digester [% FM] * VS_substrates [100 % TS] + ash_substrate [% FM]
      // we know that the ash content of the substrates does not change inisde the digester
      // TODO: explain a bit better
      // wenn COD oben 0 wäre, dann wäre TS ebenfalls 0, durch die nächste Zeile
      // wird TS auf ash content angehoben. 
      TS= TS * VS + ash;

      TS.Symbol= "TS";

      return TS;
    }

    /// <summary>
    /// Calculates Volatile Solids inside the digester.
    /// We make the assumption, that the ash content inside the digester
    /// is equal to the ash content of the mean of the substrates going into it.
    /// 
    /// As the TS content is decreasing in a digester cascade, and the ash
    /// content keeps constant the VS content will decrease as well.
    /// </summary>
    /// <param name="x">digester state vector</param>
    /// <param name="mySubstrates">
    /// substrates or sludge but not both!!! Because TS content is calculated
    /// out of COD in digester. If there is a mixture of substrate and sludge going
    /// into the digester, then the COD is already decreased by the sludge, so no need
    /// to account for the lower TS of the sludge here.
    /// </param>
    /// <param name="Q">array of substrate mix stream or recirculations in m³/d</param>
    /// <param name="TS">returns TS content as well</param>
    /// <returns></returns>
    public static physValue calcVS(double[] x, substrates mySubstrates, double[] Q, 
                                   out physValue TS)
    {
      physValue ash;

      try
      {
        TS = calcTS(x, mySubstrates, Q);

        mySubstrates.get_weighted_mean_of(Q, "Ash", out ash);
      }
      catch (exception e)
      {
        Console.WriteLine(e.Message);
        TS = new physValue("TS", 0, "% FM");

        return new physValue("VS", 0, "% TS");
      }

      if (TS.Value == 0)
        return new physValue("VS", 0, "% TS");

      // ash [% FM] := ( 1 - VS [100 % TS] ) * TS [% FM]
      //
      // <=>
      //
      // VS [100 % TS] = 1 - ( ash [% FM] )/( TS [% FM] )
      //
      physValue VS= new physValue(1, "100 %") - ash / TS;

      VS= VS.convertUnit("% TS");
      VS.Symbol= "VS";

      return VS;
    }
    /// <summary>
    /// Calculates Volatile Solids inside the digester.
    /// We make the assumption, that the ash content inside the digester
    /// is equal to the ash content of the mean of the substrates going into it.
    /// 
    /// As the TS content is decreasing in a digester cascade, and the ash
    /// content keeps constant the VS content will decrease as well.
    /// </summary>
    /// <param name="x">digester state vector</param>
    /// <param name="mySubstrates">
    /// substrates or sludge but not both!!! Because TS content is calculated
    /// out of COD in digester. If there is a mixture of substrate and sludge going
    /// into the digester, then the COD is already decreased by the sludge, so no need
    /// to account for the lower TS of the sludge here.
    /// </param>
    /// <param name="Q">array of substrate mix stream or recirculations in m³/d</param>
    /// <returns></returns>
    public static physValue calcVS(double[] x, substrates mySubstrates, double[] Q)
    {
      physValue TS;

      return calcVS(x, mySubstrates, Q, out TS);
    }

    /// <summary>
    /// Calculates Ash content in digester
    /// </summary>
    /// <param name="x"></param>
    /// <param name="digester_id"></param>
    /// <param name="mySensors"></param>
    /// <param name="mySubstrates"></param>
    /// <param name="Q"></param>
    /// <param name="myPlant"></param>
    /// <returns></returns>
    public static physValue calcAsh(double[] x, string digester_id, biogas.sensors mySensors, substrates mySubstrates, double[] Q,
                                    plant myPlant)
    {
      physValue ash_digester, ash_substrate;

      try
      {
        ash_digester= mySensors.getCurrentMeasurement("Ash_" + digester_id + "_3");
      }
      catch (exception e)
      {
        Console.WriteLine(e.Message);
        ash_digester = new physValue("ash_digester", 11, "% TS");
      }

      try
      {
        mySubstrates.get_weighted_mean_of(Q, "Ash", out ash_substrate);
      }
      catch (exception e)
      {
        ash_substrate = new physValue("ash_substrate", 0, "% FM");

        return ash_digester;
      }

      double volume_substrate = math.sum(Q);    // m^3/d

      double volume_dig = myPlant.get_param_of_d("Vliq");   // m^3

      // TODO - achtung mit einheiten, mix von % TS und % FM
      ash_digester = ash_digester + volume_substrate / volume_dig * ash_substrate;

      ash_digester = ash_digester.convertUnit("% TS");
      ash_digester.Symbol = "Ash";

      return ash_digester;
    }

    /// <summary>
    /// Calculates the organic loading rate of the digester.
    /// Assumption that Q and Qsum is measured in m^3/d.
    /// 
    /// As a reference see:
    /// 
    /// Handreichung Biogasgewinnung und -nutzung: Grundlagen der anaeroben
    /// Fermentation, S. 29.
    /// 
    /// </summary>
    /// <param name="x">digester state vector</param>
    /// <param name="mySubstrates">
    /// substrates or sludge but not both!!! Because TS content is calculated
    /// out of COD in digester. If there is a mixture of substrate and sludge going
    /// into the digester, then the COD is aleardy decreased by the sludge, so no need
    /// to account for the lower TS of the sludge here.
    /// TODO: hier sollten es beide sein!
    /// </param>
    /// <param name="Q">
    /// Q of the substrates or sludge, but not both!
    /// TODO: hier sollten es beide sein!
    /// </param>
    /// <param name="Qsum">
    /// if there is sludge and substrate going into the digester, then Qsum will be
    /// bigger then math.sum(Q). Qsum is needed to account for full volumeflow
    /// going into the digester no matter if substrate or sludge.
    /// TODO: nach Änderung, dass Q alle feed enthält, ist Qsum= sum(Q)
    /// kann also als Parameter entfernt werden
    /// </param>
    /// <returns></returns>
    public physValue calcOLR(double[] x, substrates mySubstrates, double[] Q, double Qsum)
    {
      physValue Vliq= this.Vliq;

      physValue TS;

      // TODO
      // was mache ich hier!!!! ???????????????????
      // warum nehme ich nicht einfach VS aus den Substraten???
      physValue VS;//= calcVS(x, mySubstrates, Q, out TS);
      mySubstrates.get_weighted_mean_of(Q, "VS", out VS);
      mySubstrates.get_weighted_mean_of(Q, "TS", out TS);

      VS= biogas.substrate.convertFrom_TS_To_FM(VS, TS);
      VS= VS.convertUnit("100 %");

      physValue rho;

      mySubstrates.get_weighted_mean_of(Q, "rho", out rho);

      // hier wird die Annahme gemacht, dass rho von schlamm gleich ist
      // wie rho der substrate, aber egal (TODO)
      // evtl. wäre es besser gemessenes rho aus density_sensor zu nehmen
      // das ist dichte des inputs in den fermenter (Gemisch aus substrate und rezischlamm)
      physValue OLR= new physValue(Qsum, "m^3/d") * rho * VS / Vliq;

      OLR.Symbol= "OLR";

      return OLR;
    }

    /// <summary>
    /// calc methane yield [m^3 CH4 / kgVS]
    /// 
    /// http://www.bioconverter.com/technology/primer.htm#Methane%20Yield%20%28m3%20CH4%20/%20kg%20VS%20added%29
    /// 
    /// if methane yield is high, everything is ok, if it is too low
    /// maybe decrease substrate feed, digester could be overburdened
    /// 
    /// </summary>
    /// <param name="x">ADM state vector</param>
    /// <param name="pQ">Q   : m^3/d  : total feed into the digester</param>
    /// <param name="pVS">VS  : % TS   : volatile solids content of feed</param>
    /// <param name="pTS">TS  : % FM   : total solids content of feed</param>
    /// <param name="prho">rho : kg/m^3 : density of feed</param>
    /// <returns></returns>
    public physValue calcCH4Yield(double[] x, physValue pQ,  physValue pVS, 
                                              physValue pTS, physValue prho)
    {
      physValue Qgas_h2, Qgas_ch4;

      ADMstate.calcBiogasOfADMstate(x, Vliq, T, out Qgas_h2, out Qgas_ch4);

      physValue Q=   pQ.convertUnit("m^3/d");
      physValue VS=  pVS.convertUnit("% TS");
      physValue TS=  pTS.convertUnit("% FM");
      physValue rho= prho.convertUnit("kg/m^3");

      VS= substrate.convertFrom_TS_To_FM(VS, TS);

      // VS [% FM] * [100 % / % FM] * m^3/d * kg/m^3 = VS kg/d
      physValue VS_kg= VS.convertUnit("100 %") * Q * rho;

      if (VS_kg.Value == 0)
        return new physValue(0, "m^3/kg");

      // m^3/d / kgVS/d= m^3/kgVS
      // Einheit ist: m^3/kg
      physValue CH4Yield= Qgas_ch4 / VS_kg;

      return CH4Yield;
    }

    /// <summary>
    /// calc methane production rate [m^3/m^3/day]
    /// 
    /// http://www.bioconverter.com/technology/primer.htm#Methane%20Production%20Rate
    /// 
    /// http://www.bioconverter.com/technology/primer.htm#Methane%20Production%20Rate%20%28m3/m3-day%29
    /// 
    /// </summary>
    /// <param name="x">ADM state vector</param>
    /// <returns></returns>
    public physValue calcCH4ProductionRate(double[] x)
    {
      physValue Qgas_h2, Qgas_ch4;

      ADMstate.calcBiogasOfADMstate(x, Vliq, T, out Qgas_h2, out Qgas_ch4);

      Qgas_ch4= Qgas_ch4.convertUnit("m^3/d");
      _Vliq= Vliq.convertUnit("m^3");

      if (Vliq.Value == 0)
        return new physValue(0, "1/d");

      // m^3/d/m^3= 1/d
      physValue CH4ProductionRate= Qgas_ch4 / Vliq;

      return CH4ProductionRate;
    }

    /// <summary>
    /// Calculate the hydraulic retention time (HRT) for a
    /// digester with volume Vliq and input stream Q
    /// 
    /// Handreichung Biogasgewinnung und -nutzung: Grundlagen der anaeroben
    /// Fermentation, S. 29.
    /// </summary>
    /// <param name="Q">Q : vector of all input streams into the digester in [m^3/d]</param>
    /// <param name="Vliq">Vliq : liquid volume of the digester in [m^3]</param>
    /// <returns>hydraulic retention time in days [d]</returns>
    public static physValue calcHRT(double[] Q, physValue Vliq)
    {
      physValue[] pQ= new physValue[Q.Length];

      for (int iQ= 0; iQ < Q.Length; iQ++)
      {
        pQ[iQ]= new physValue("Q", Q[iQ], "m^3/d");
      }

      return calcHRT(pQ, Vliq);
    }
    /// <summary>
    /// Calculate hydraulic retention time
    /// </summary>
    /// <param name="Q"></param>
    /// <param name="Vliq"></param>
    /// <returns></returns>
    public static physValue calcHRT(physValue[] Q, physValue Vliq)
    {
      physValue Qsum= physValue.sum(Q);

      return calcHRT(Qsum, Vliq);
    }
    /// <summary>
    /// Calculate hydraulic retention time
    /// </summary>
    /// <param name="Q">must be measured in m³/d</param>
    /// <param name="Vliq"></param>
    /// <returns></returns>
    public static physValue calcHRT(double Q, physValue Vliq)
    {
      return calcHRT(new physValue("Q", Q, "m^3/d"), Vliq);
    }
    /// <summary>
    /// Calculate hydraulic retention time
    /// </summary>
    /// <param name="pQ"></param>
    /// <param name="pVliq"></param>
    /// <returns></returns>
    public static physValue calcHRT(physValue pQ, physValue pVliq)
    {
      physValue HRT;

      physValue Q=    pQ.convertUnit("m^3/d");
      physValue Vliq= pVliq.convertUnit("m^3");

      if (Q != new physValue(0, "m^3/d"))
      {
        HRT= Vliq / Q;

        HRT.Symbol= "HRT";
      }
      else
        HRT= new physValue("HRT", double.PositiveInfinity, "d");

      return HRT;
    }



  }
}


