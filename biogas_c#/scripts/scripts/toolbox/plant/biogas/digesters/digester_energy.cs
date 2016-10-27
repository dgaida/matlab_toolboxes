/**
 * This file is part of the partial class digester and defines
 * public methods for energy calculation.
 * 
 * TODOs:
 * - add thermal sources to calcThermalEnergyBalance(), OK
 * - berechnung der radiation loss verändern, OK
 * - 
 * 
 * Apart from that FINISHED!
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

    ///// <summary>
    ///// Calculate needed thermal power to heat the substrate flow Q
    ///// up to the temperature inside the digester. Q is measured in m³/d
    ///// </summary>
    ///// <param name="Q">volumetric flow rate of substrates in m^3/d</param>
    ///// <param name="mySubstrates"></param>
    ///// <param name="Pel_kWh_d">thermal or electrical energy per day</param>
    ///// <param name="Pel_kW">thermal or electrical power</param>
    ///// <exception cref="exception">Q.Length != mySubstrates.Count</exception>
    ///// <exception cref="exception">efficiency is zero, division by zero</exception>
    //public void heatInputSubstrates(double[] Q, substrates mySubstrates,
    //                                out physValue Pel_kWh_d,
    //                                out physValue Pel_kW)
    //{
    //  heating.heatSubstrates(Q, mySubstrates, T, out Pel_kWh_d, out Pel_kW);
    //}
    ///// <summary>
    ///// Calculate needed thermal power to heat the substrate flow Q
    ///// up to the temperature inside the digester. Q is measured in m³/d
    ///// </summary>
    ///// <param name="Q">volumetric flow rate of substrates in m^3/d</param>
    ///// <param name="mySubstrates"></param>
    ///// <param name="Pel_kWh_d">thermal or electrical energy per day</param>
    ///// <exception cref="exception">Q.Length != mySubstrates.Count</exception>
    ///// <exception cref="exception">efficiency is zero, division by zero</exception>
    //public void heatInputSubstrates(double[] Q, substrates mySubstrates,
    //                                out physValue Pel_kWh_d)
    //{
    //  heating.heatSubstrates(Q, mySubstrates, T, out Pel_kWh_d);
    //}

    /// <summary>
    /// Calculate thermal power get lost due to radiation through the
    /// digester surface.
    /// 
    /// TODO: at the moment power is always positive, would it be a problem if
    /// it is negative, where is it called? outside hotter than inside of digester, no 
    /// problem
    /// </summary>
    /// <param name="pT_ambient">ambient temperature</param>
    /// <returns>thermal power get lost in W</returns>
    public physValue calcHeatLossDueToRadiation(physValue pT_ambient)
    {
      physValue T_ambient= pT_ambient.convertUnit("°C");

      _T=    T.convertUnit("°C");
      _k_wall= k_wall.convertUnit("W/(m^2 * K)");
      physValue myAwall= Awall.convertUnit("m^2");

      // In Ganzheitliche stoffliche und energetische Modellierung S. 56
      // eine ausführliche Formel zur Berechnung des Wärmeübergangs bei
      // mehrschichtige wänden

      // P_{radiation,loss} [W]= Atot * h_{th} * ( T_{digester} - T_{ambient} )
      //
      // [ W ]= [ m^2 * W/(m^2 * K) * K ]$$
      //
      // Achtung: es ist total falsch eine temperaturdifferenz im nachhinein
      // in Kelvin zu konvertieren. vorher beide temperaturen in Kelvin
      // dann differenz bilden
      //
      physValue P_radiation_loss_wall = myAwall * _k_wall *
        /*physValue.max*/(_T.convertUnit("K") - T_ambient.convertUnit("K")/*,
                               new physValue(0, "°C")*/
                             );
      //

      _k_roof = k_roof.convertUnit("W/(m^2 * K)");
      physValue myAroof = Aroof.convertUnit("m^2");

      //
      // Achtung: es ist total falsch eine temperaturdifferenz im nachhinein
      // in Kelvin zu konvertieren. vorher beide temperaturen in Kelvin
      // dann differenz bilden
      //
      physValue P_radiation_loss_roof = myAroof * _k_roof *
        /*physValue.max*/(_T.convertUnit("K") - T_ambient.convertUnit("K")/*,
                               new physValue(0, "°C")*/
                             );

      //

      _k_ground = k_ground.convertUnit("W/(m^2 * K)");
      physValue myAground = Aground.convertUnit("m^2");

      // Achtung: es ist total falsch eine temperaturdifferenz im nachhinein
      // in Kelvin zu konvertieren. vorher beide temperaturen in Kelvin
      // dann differenz bilden
      physValue P_radiation_loss_ground = myAground * _k_ground *
        /*physValue.max*/(_T.convertUnit("K") - T_ambient.convertUnit("K")/*,
                               new physValue(0, "°C")*/
                             );

      //

      physValue P_radiation_sum= P_radiation_loss_wall + P_radiation_loss_roof + P_radiation_loss_ground;

      P_radiation_sum.Symbol = "P_rad_sum";

      return P_radiation_sum;
    }

    ///// <summary>
    ///// Calculate power needed to comepnsate thermal loss due to
    ///// radiation through the digesters surface.
    ///// </summary>
    ///// <param name="T_ambient">ambient temperature</param>
    ///// <param name="P_radiation_loss_kW">electrical or thermal power</param>
    ///// <param name="P_radiation_loss_kWh_d">electrical or thermal energy per day</param>
    ///// <exception cref="exception">efficiency is zero, division by zero</exception>
    //public void compensateHeatLossDueToRadiation(physValue T_ambient,
    //                                             out physValue P_radiation_loss_kW,
    //                                             out physValue P_radiation_loss_kWh_d)
    //{ 
    //  physValue P_radiation_loss= calcHeatLossDueToRadiation(T_ambient);

    //  heating.compensateHeatLossDueToRadiation(P_radiation_loss,
    //                                           out P_radiation_loss_kW,
    //                                           out P_radiation_loss_kWh_d);
    //}

    /// <summary>
    /// Calculates the thermal energy balance of the digester. It compares 
    /// thermal sinks (negative) with thermal sources (positive) inside the digester
    /// 
    /// At the moment the following processes are reflected:
    /// 
    /// thermal sinks are:
    /// 
    /// 1) heat energy needed to heat the substrates up to the digesters temperature
    /// (heat substrates)
    /// 2) heat energy loss due to radiation through the surface of the fermenter
    /// (radiation)
    /// 
    /// thermal sources are:
    /// 
    /// 1) microbiology
    /// 2) stirrer dissipation
    /// 
    /// For further effects see
    /// 
    /// 1) Lübken, M., Wichern, M., Schlattmann, M., Gronauer, A., and Horn, H.: 
    ///    Modelling the energy balance of an anaerobic digester fed with cattle manure
    ///    and renewable energy crops, Water Research 41, pp. 4085-4096, 2007
    /// 2) Lindorfer, H., Kirchmayr, R., Braun, R.: 
    ///    Self-heating of anaerobic digesters using energy crops, 2005
    /// 
    /// 
    /// </summary>
    /// <param name="Q">substrate feed measured in m^3/d</param>
    /// <param name="mySubstrates"></param>
    /// <param name="T_ambient">ambient temperature</param>
    /// <param name="mySensors"></param>
    /// <returns>thermal energy balance mesasured in kWh/d</returns>
    /// <exception cref="exception">Q.Length != mySubstrates.Count</exception>
    public double calcThermalEnergyBalance(double[] Q, substrates mySubstrates,
      physValue T_ambient, sensors mySensors)
    {
      physValue Psubsheat, Pradloss, Pmicros, Pstirdiss;

      return calcThermalEnergyBalance(Q, mySubstrates, T_ambient, mySensors, out Psubsheat,
        out Pradloss, out Pmicros, out Pstirdiss);
    }

    /// <summary>
    /// Calculates the thermal energy balance of the digester. It compares 
    /// thermal sinks (negative) with thermal sources (positive) inside the digester
    /// 
    /// At the moment the following processes are reflected:
    /// 
    /// thermal sinks are:
    /// 
    /// 1) heat energy needed to heat the substrates up to the digesters temperature
    /// (heat substrates)
    /// 2) heat energy loss due to radiation through the surface of the fermenter
    /// (radiation)
    /// 
    /// thermal sources are:
    /// 
    /// 1) microbiology
    /// 2) stirrer dissipation
    /// 
    /// For further effects see
    /// 
    /// 1) Lübken, M., Wichern, M., Schlattmann, M., Gronauer, A., and Horn, H.: 
    ///    Modelling the energy balance of an anaerobic digester fed with cattle manure
    ///    and renewable energy crops, Water Research 41, pp. 4085-4096, 2007
    /// 2) Lindorfer, H., Kirchmayr, R., Braun, R.: 
    ///    Self-heating of anaerobic digesters using energy crops, 2005
    /// 
    /// 
    /// </summary>
    /// <param name="Q">substrate feed measured in m^3/d</param>
    /// <param name="mySubstrates"></param>
    /// <param name="T_ambient">ambient temperature</param>
    /// <param name="mySensors"></param>
    /// <param name="Psubsheat">thermal energy needed to heat substrates in kWh/d</param>
    /// <param name="Pradloss">thermal energy loss due to radiation in kWh/d</param>
    /// <param name="Pmicros">Wärme produziert durch Bakterien in kWh/d</param>
    /// <param name="Pstirdiss">thermal energy created by stirrer in kWh/d</param>
    /// <returns>thermal energy balance mesasured in kWh/d</returns>
    /// <exception cref="exception">Q.Length &lt; mySubstrates.Count</exception>
    /// <exception cref="exception">energy calculations failed</exception>
    public double calcThermalEnergyBalance(double[] Q, substrates mySubstrates, 
      physValue T_ambient, sensors mySensors, out physValue Psubsheat, out physValue Pradloss, 
      out physValue Pmicros, out physValue Pstirdiss)
    { 
      //physValue Pel_kWh_d;
      //physValue Pel_kW;

      // thermal energy needed to heat substrates in kWh/d
      try
      {
        Psubsheat = mySubstrates.calcSumQuantityOfHeatPerDay(Q, T).convertUnit("kWh/d");
      }
      catch (exception e)
      {
        Console.WriteLine(e.Message);
        throw new exception("calcThermalEnergyBalance: heat substrates failed!");
      }

      //physValue P_radiation_loss_kW;
      //physValue P_radiation_loss_kWh_d;

      // energy needed to compensate loss due to radiation
      //compensateHeatLossDueToRadiation(T_ambient, out P_radiation_loss_kW, out P_radiation_loss_kWh_d);

      // thermal energy loss due to radiation in kWh/d
      try
      {
        Pradloss = calcHeatLossDueToRadiation(T_ambient).convertUnit("kWh/d");
      }
      catch (exception e)
      {
        Console.WriteLine(e.Message);
        throw new exception("calcThermalEnergyBalance: heat loss calculation failed!");
      }

      // Wärme produziert durch Bakterien
      // in kWh/d
      try
      {
        Pmicros = mySensors.getCurrentMeasurement("energyProdMicro_" + id);
        
        // wenn noch nichts aufgezeichnet wurde, dann ist der Wert 0
        if (Pmicros.Value != 0)
          Pmicros = Pmicros.convertUnit("kWh/d");
        else // setzte zu 0 kWh/d, da einheit sonst nicht stimmt
          Pmicros = new physValue(0, "kWh/d");
      }
      catch (exception e)
      {
        Console.WriteLine(e.Message);
        throw new exception("calcThermalEnergyBalance: microorganisms failed!");
      }

      // Wärme welche das Rühwerk erzeugt ist eine Wärmequelle, muss hier addiert werden
      // In Ganzheitliche stoffliche und energetische Modellierung S. 65
      // Dissipation Rührwerk - ist identisch mit der aufgebrachten Leistung des 
      // rührwerks. dafür muss erstmal rührwerksleistung berechnet werden, s. ebenfalls
      // In Ganzheitliche stoffliche und energetische Modellierung S. 45 ff.
      // für rührwerksleitung muss auch viskosität berechnet werden s. S. 81 für verschiedene
      // TS im fermenter

      // thermal energy created by stirrer in kWh/d
      try
      {
        Pstirdiss = calcStirrerDissipation(mySensors).convertUnit("kWh/d");
      }
      catch (exception e)
      {
        Console.WriteLine(e.Message);
        throw new exception("calcThermalEnergyBalance: stirrer dissipation failed!");
      }

      // sinks are negative, themal sources are positive
      physValue balance = - Psubsheat - Pradloss + 
                          Pstirdiss + Pmicros; // + produzierteWärme im Fermenter



      return balance.Value;
    }

    /// <summary>
    /// Calculates costs for heating the digester. in case of a thermal heating
    /// costs are lost gain which we had if we sell the thermal energy. In case
    /// of an electrical heating it is the cost producing the electrical energy.
    /// </summary>
    /// <param name="pP_loss">thermal power loss</param>
    /// <param name="sell_heat">€/kWh for selling thermal energy, this is a virtual price here
    /// missed gain, needed for a thermal heating</param>
    /// <param name="cost_elEnergy">costs for electricity in €/kWh, needed if we have a electrical
    /// heating</param>
    /// <returns>costs in €/d</returns>
    /// <exception cref="exception">efficiency is zero, division by zero</exception>
    public double calcCostsForHeating(physValue pP_loss, double sell_heat, double cost_elEnergy)
    {
      physValue P_loss_kW, P_loss_kWh_d;

      return heating.calcCostsForHeating(pP_loss, sell_heat, cost_elEnergy, 
        out P_loss_kW, out P_loss_kWh_d);
    }

    /// <summary>
    /// calc electrical or thermal power needed to heat the digester
    /// using the heating, in kWh/d
    /// </summary>
    /// <param name="Q">substrate feed measured in m^3/d</param>
    /// <param name="mySubstrates"></param>
    /// <param name="T_ambient">ambient temperature</param>
    /// <param name="mySensors"></param>
    /// <returns>thermal/electrical energy needed by heating in kWh/d</returns>
    /// <exception cref="exception">Q.Length != mySubstrates.Count</exception>
    /// <exception cref="exception">efficiency is zero, division by zero</exception>
    public double calcHeatPower(double[] Q, substrates mySubstrates,
      physValue T_ambient, sensors mySensors)
    {
      // thermal energy balance in kWh/d
      double balance = calcThermalEnergyBalance(Q, mySubstrates, T_ambient, mySensors);

      physValue P_loss_kW, P_loss_kWh_d;

      if (balance < 0)
      {
        heating.compensateHeatLoss(new physValue(-balance, "kWh/d"), out P_loss_kW, out P_loss_kWh_d);

        return P_loss_kWh_d.Value;
      }
      else
        return 0;
    }
    
    /// <summary>
    /// Calculate electrical power of stirrers inside digester
    /// </summary>
    /// <param name="mySensors"></param>
    /// <returns>electrical power of stirrers inside digester in kWh/d</returns>
    /// <exception cref="exception">calculation of stirrer power failed</exception>
    public physValue calcStirrerPower(sensors mySensors)
    {
      double Tdigester = T.convertUnit("°C").Value;
      double TSdigester;

      // get TS measurement inside this digester
      mySensors.getCurrentMeasurementD("TS_" + id + "_3", out TSdigester);

      // calc electrical power of all mixers in this digester, measure in kWh/d
      double Pel= mixers.calcPelectrical(Tdigester, TSdigester);

      return new physValue("Pel_mix", Pel, "kWh/d");
    }

    /// <summary>
    /// Calculate dissipated power of stirrers inside digester, dissipated to digester
    /// in kWh/d
    /// </summary>
    /// <param name="mySensors"></param>
    /// <returns>dissipated power of stirrers inside digester in kWh/d</returns>
    /// <exception cref="exception">calculation of stirrer power failed</exception>
    public physValue calcStirrerDissipation(sensors mySensors)
    {
      double Tdigester = T.convertUnit("°C").Value;
      double TSdigester;

      // get TS measurement inside this digester
      mySensors.getCurrentMeasurementD("TS_" + id + "_3", out TSdigester);

      // calc dissipated power of all mixers in this digester, measure in kWh/d
      double Pdiss = mixers.calcPdissipation(Tdigester, TSdigester);

      return new physValue("Pdiss_mix", Pdiss, "kWh/d");
    }



  }
}


