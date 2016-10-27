/**
 * This file is part of the partial class heating and defines
 * all methods not defined elsewhere.
 * 
 * TODOs:
 * - heatSubstrate() and compensateHeatLossDueToRadiation() are basically the same
 *   both are calculating the electrical power needed for some specified thermal power, ok now
 * 
 * Apart from that FINISHED!
 * 
 */

using System;
using System.Collections.Generic;
using System.Text;
using toolbox;
using science;
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
  /// Defines a heating used to heat a digester
  /// </summary>
  public partial class heating
  {

    // -------------------------------------------------------------------------------------
    //                              !!! CONSTRUCTOR METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// Constructor setting the electrical degree of efficiency
    /// and the status of the heating, sets type to 1 (thermal)
    /// </summary>
    /// <param name="eta">electrical/thermal degree of efficiency</param>
    /// <param name="status">on/off</param>
    /// <param name="type">0 - electrical, 1 - thermal</param>
    public heating(double eta, bool status, int type)
    {
      this._eta = eta;
      this._status = status;
      this._type = type;  // thermal/electrical
    }

    /// <summary>
    /// Constructor setting the electrical degree of efficiency
    /// and the status of the heating, sets type to 1 (thermal)
    /// </summary>
    /// <param name="eta">electrical/thermal degree of efficiency</param>
    /// <param name="status">on/off</param>
    public heating(double eta, bool status) : this(eta, status, 1)
    {}

    /// <summary>
    /// Constructor setting the electrical (in this case thermal)  degree of efficiency.
    /// Per default the heating is on. default is a thermal heating
    /// </summary>
    /// <param name="eta"></param>
    public heating(double eta) : this(eta, true)
    { }

    /// <summary>
    /// Default constructor, sets the electrical (in this case thermal) 
    /// degree of efficiency to zero
    /// default is a thermal heating
    /// </summary>
    public heating() : this(0)
    {}



    // -------------------------------------------------------------------------------------
    //                              !!! PUBLIC METHODS !!!
    // -------------------------------------------------------------------------------------

    ///// <summary>
    ///// Calculates energy flow needed to heat the substrate flows Q
    ///// up to the temperature Tend. The volumeflows Q are assumed to
    ///// be measured in m^3/d
    ///// </summary>
    ///// <param name="Q">array of volumeflows of the substrates in [m³/d]</param>
    ///// <param name="mySubstrates"></param>
    ///// <param name="Tend"></param>
    ///// <param name="Pel_kWh_d">thermal or electrical energy per day</param>
    ///// <param name="Pel_kW">thermal or electrical power</param>
    ///// <exception cref="exception">Q.Length != mySubstrates.Count</exception>
    ///// <exception cref="exception">efficiency is zero, division by zero</exception>
    //public void heatSubstrates(double[] Q, substrates mySubstrates,
    //                           physValue Tend, out physValue Pel_kWh_d,
    //                                           out physValue Pel_kW)
    //{
    //  physValue[] pQ= new physValue[Q.Length];

    //  for (int iel= 0; iel < Q.Length; iel++)
    //    pQ[iel]= new physValue("Q", Q[iel], "m^3/d");

    //  heatSubstrates(pQ, mySubstrates, Tend, out Pel_kWh_d, out Pel_kW);
    //}
    ///// <summary>
    ///// Calculates energy flow needed to heat the substrate flows Q
    ///// up to the temperature Tend. The volumeflows Q are assumed to
    ///// be measured in m^3/d
    ///// </summary>
    ///// <param name="Q">array of volumeflows of the substrates in [m³/d]</param>
    ///// <param name="mySubstrates"></param>
    ///// <param name="Tend"></param>
    ///// <param name="Pel_kWh_d">thermal or electrical energy per day</param>
    ///// <exception cref="exception">Q.Length != mySubstrates.Count</exception>
    ///// <exception cref="exception">efficiency is zero, division by zero</exception>
    //public void heatSubstrates(double[] Q, substrates mySubstrates,
    //                           physValue Tend, out physValue Pel_kWh_d)
    //{
    //  physValue[] pQ = new physValue[Q.Length];

    //  for (int iel = 0; iel < Q.Length; iel++)
    //    pQ[iel] = new physValue("Q", Q[iel], "m^3/d");

    //  heatSubstrates(pQ, mySubstrates, Tend, out Pel_kWh_d);
    //}
    ///// <summary>
    ///// Calculates energy flow needed to heat the substrate flows Q
    ///// up to the temperature Tend.
    ///// </summary>
    ///// <param name="Q"></param>
    ///// <param name="mySubstrates"></param>
    ///// <param name="Tend"></param>
    ///// <param name="Pel_kWh_d">thermal or electrical energy per day</param>
    ///// <param name="Pel_kW">thermal or electrical power</param>
    ///// <exception cref="exception">Q.Length != mySubstrates.Count</exception>
    ///// <exception cref="exception">efficiency is zero, division by zero</exception>
    //public void heatSubstrates(physValue[] Q, substrates mySubstrates, 
    //                           physValue Tend, out physValue Pel_kWh_d,
    //                                           out physValue Pel_kW)
    //{
    //  physValue Qtherm_day= 
    //            mySubstrates.calcSumQuantityOfHeatPerDay(Q, Tend);

    //  heatSubstrate(Qtherm_day, out Pel_kWh_d, out Pel_kW);
    //}
    ///// <summary>
    ///// Calculates energy flow needed to heat the substrate flows Q
    ///// up to the temperature Tend.
    ///// </summary>
    ///// <param name="Q"></param>
    ///// <param name="mySubstrates"></param>
    ///// <param name="Tend"></param>
    ///// <param name="Pel_kWh_d">thermal or electrical energy per day</param>
    ///// <exception cref="exception">Q.Length != mySubstrates.Count</exception>
    ///// <exception cref="exception">efficiency is zero, division by zero</exception>
    //public void heatSubstrates(physValue[] Q, substrates mySubstrates,
    //                           physValue Tend, out physValue Pel_kWh_d)
    //{
    //  physValue Qtherm_day =
    //            mySubstrates.calcSumQuantityOfHeatPerDay(Q, Tend);

    //  heatSubstrate(Qtherm_day, out Pel_kWh_d);
    //}

    ///// <summary>
    ///// Calculates energy flow needed to get the thermal energy/day pQtherm_day 
    ///// from the heating.
    ///// </summary>
    ///// <param name="pQtherm_day"></param>
    ///// <param name="Pel_kWh_d">thermal or electrical energy per day</param>
    ///// <param name="Pel_kW">thermal or electrical power</param>
    ///// <exception cref="exception">efficiency is zero, division by zero</exception>
    //public void heatSubstrate(physValue pQtherm_day, out physValue Pel_kWh_d,
    //                                                 out physValue Pel_kW)
    //{
    //  heatSubstrate(pQtherm_day, out Pel_kWh_d);

    //  Pel_kW = Pel_kWh_d.convertUnit("kW");
    //}

    ///// <summary>
    ///// Calculates energy flow needed to get the thermal energy/day pQtherm_day 
    ///// from the heating.
    ///// </summary>
    ///// <param name="pQtherm_day"></param>
    ///// <param name="Pel_kWh_d">thermal or electrical energy per day</param>
    ///// <exception cref="exception">efficiency is zero, division by zero</exception>
    //public void heatSubstrate(physValue pQtherm_day, out physValue Pel_kWh_d)
    //{
    //  if (status)
    //  {
    //    physValue Qtherm_day= pQtherm_day.convertUnit("kWh/d");

    //    if (eta != 0)
    //    {
    //      Pel_kWh_d= Qtherm_day / eta;
    //      Pel_kWh_d.Symbol= "Pel_sub";
    //    }
    //    else
    //      throw new exception("electrical degree of efficiency of the heating: eta == 0");
    //  }
    //  else 
    //  {
    //    Pel_kWh_d= new physValue("Pel", 0, "kWh/d");
    //  } 
    //}

    ///// <summary>
    ///// Calculates energy flow needed to get the thermal power pP_radiation_loss 
    ///// from the heating.
    ///// </summary>
    ///// <param name="pP_radiation_loss"></param>
    ///// <param name="P_radiation_loss_kW">thermal or electrical power</param>
    ///// <param name="P_radiation_loss_kWh_d">thermal or electrical energy per day</param>
    ///// <exception cref="exception">efficiency is zero, division by zero</exception>
    //public void compensateHeatLossDueToRadiation(physValue pP_radiation_loss,
    //                                             out physValue P_radiation_loss_kW,
    //                                             out physValue P_radiation_loss_kWh_d)
    //{
    //  if (eta == 0)
    //    throw new exception("electrical degree of efficiency of the heating: eta == 0");

    //  if (status)
    //  {
    //    physValue P_radiation_loss= pP_radiation_loss / eta;

    //    P_radiation_loss.Symbol= "Pel_rad";

    //    P_radiation_loss_kW= P_radiation_loss.convertUnit("kW");
    //  }
    //  else
    //  {
    //    P_radiation_loss_kW= new physValue("Pel", 0, "kW");
    //  }

    //  P_radiation_loss_kWh_d= P_radiation_loss_kW.convertUnit("kWh/d");
    //}

    /// <summary>
    /// Calculates costs for heating the digester in €/d. in case of a thermal heating
    /// costs are lost gain which we had if we sell the thermal energy. In case
    /// of an electrical heating it is the cost producing the electrical energy.
    /// </summary>
    /// <param name="pP_loss">thermal power loss</param>
    /// <param name="sell_heat">€/kWh for selling thermal energy, this is a virtual price here
    /// missed gain, needed for a thermal heating</param>
    /// <param name="cost_elEnergy">costs for electricity in €/kWh, needed if we have a electrical
    /// heating</param>
    /// <param name="P_loss_kW">thermal or electrical power</param>
    /// <param name="P_loss_kWh_d">thermal or electrical energy per day</param>
    /// <returns>costs in €/d</returns>
    /// <exception cref="exception">efficiency is zero, division by zero</exception>
    public double calcCostsForHeating(physValue pP_loss, double sell_heat, double cost_elEnergy,
                                   out physValue P_loss_kW, out physValue P_loss_kWh_d)
    {
      compensateHeatLoss(pP_loss, out P_loss_kW, out P_loss_kWh_d);

      // falls im fermenter th. energie produziert wird, mehr als verbraucht, dann
      // sind kosten == 0, man kann diese thermische energie nicht verkaufen, also kein
      // gewinn machen
      if (pP_loss.Value < 0)
        return 0;

      switch (type)
      { 
        case 0: // electrical heating
          return P_loss_kWh_d.Value * cost_elEnergy;  // €
        case 1: // thermal heating
          return P_loss_kWh_d.Value * sell_heat;    // €
        default:
          throw new exception(String.Format("Unknown heating type: {0}", type));
      }

    }

    /// <summary>
    /// Calculates energy flow needed to get the thermal power pP_loss 
    /// from the heating.
    /// </summary>
    /// <param name="pP_loss">thermal power loss</param>
    /// <param name="P_loss_kW">thermal or electrical power</param>
    /// <param name="P_loss_kWh_d">thermal or electrical energy per day</param>
    /// <exception cref="exception">efficiency is zero, division by zero</exception>
    /// <exception cref="exception">heating failed</exception>
    public void compensateHeatLoss(physValue pP_loss,
                                   out physValue P_loss_kW, out physValue P_loss_kWh_d)
    {
      if (eta == 0)
        throw new exception("electrical/thermal degree of efficiency of the heating: eta == 0");

      try
      {
        if (status)
        {
          physValue P_loss = pP_loss / eta;

          P_loss.Symbol = "Ploss";

          P_loss_kW = P_loss.convertUnit("kW");
        }
        else
        {
          P_loss_kW = new physValue("Ploss", 0, "kW");
        }

        P_loss_kWh_d = P_loss_kW.convertUnit("kWh/d");
      }
      catch (exception e)
      {
        Console.WriteLine(e.Message);
        throw new exception("compensateHeatLoss: heating failed!");
      }
    }



    /// <summary>
    /// Read the parameters out of the xml reader.
    /// Reads one heating object until the end element of heating
    /// </summary>
    /// <param name="reader">an open reader</param>
    public void getParamsFromXMLReader(ref XmlTextReader reader)
    {
      string xml_tag= "";
      
      bool do_while= true;

      while (reader.Read() && do_while)
      {
        switch (reader.NodeType)
        {

          case System.Xml.XmlNodeType.Element: // this knot is an element
            xml_tag= reader.Name;
            break;

          case System.Xml.XmlNodeType.Text: // text, thus value, of each element

            switch (xml_tag)
            {
              case "eta":
                _eta = System.Xml.XmlConvert.ToDouble(reader.Value);
                break;
              case "status":
                _status= Convert.ToBoolean(Convert.ToInt32(reader.Value));
                break;
              case "type":
                _type = System.Xml.XmlConvert.ToInt32(reader.Value);
                break;
            }

            break;

          case System.Xml.XmlNodeType.EndElement:
            if (reader.Name == "heating")
              do_while= false;

            break;
        }
      }

    }

    /// <summary>
    /// Returns the parameters of the heating in a xml string.
    /// </summary>
    /// <returns></returns>
    public string getParamsAsXMLString()
    {
      StringBuilder sb= new StringBuilder();

      sb.Append("<heating>\n");

      sb.Append(xmlInterface.setXMLTag("eta", eta));
      sb.Append(xmlInterface.setXMLTag("status", status));
      sb.Append(xmlInterface.setXMLTag("type", type));
      
      sb.Append("</heating>\n");

      return sb.ToString();
    }

    /// <summary>
    /// print the params to a string to be displayed at the console.
    /// </summary>
    /// <returns></returns>
    public string print()
    {
      StringBuilder sb= new StringBuilder();

      sb.Append("   ----------   HEATING   ----------   \r\n");
      
      sb.Append("eta= "    + eta.ToString("0.00")    + " [100 %]\t\t\t");
      sb.Append("status= " + status.ToString() + "\t\t\t");
      sb.Append("type= " + type.ToString() + "\r\n");

      //
      //sb.Append("   ---------- ---------- ---------- ----------   \n");

      return sb.ToString();
    }



  }
}


