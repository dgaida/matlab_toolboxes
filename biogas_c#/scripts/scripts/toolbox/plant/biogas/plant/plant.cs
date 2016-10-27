/**
 * This file is part of the partial class plant and defines
 * all methods not defined elsewhere.
 * 
 * TODOs:
 * - wenn fermenter nicht geheizt wird, dann habe ich wärmeverluste im fermenter, welche
 *   sich auf fermenter temperatur auswirkt, das wird bisher noch nicht berücksichtigt.
 * - genau so: wenn ich im fermenter mehr wärme produziere als ich verliere, dann wird
 *   nicht geheizt, trotzdem steigt die temperatur an.
 * 
 * Apart from that FINISHED!
 * 
 */

using System;
using System.Collections.Generic;
using System.Text;
using science;
using System.Xml;
using System.IO;
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
  /// Defines the biogas plant.
  /// It is defined by its id and has a name.
  /// A biogas plant contains digesters, chps and pumps.
  /// 
  /// </summary>
  public partial class plant
  {

    // -------------------------------------------------------------------------------------
    //                              !!! PUBLIC METHODS !!!
    // -------------------------------------------------------------------------------------

    ///// <summary>
    ///// Calculates power needed to compensate heat loss due to radiation through
    ///// the specified digester's surface.
    ///// </summary>
    ///// <param name="digester_id"></param>
    ///// <param name="P_radiation_loss_kW"></param>
    ///// <param name="P_radiation_loss_kWh_d"></param>
    //public void compensateHeatLossDueToRadiation(string digester_id,
    //                                             out physValue P_radiation_loss_kW,
    //                                             out physValue P_radiation_loss_kWh_d)
    //{
    //  myDigesters.compensateHeatLossDueToRadiation(digester_id, Tout, 
    //                                               out P_radiation_loss_kW,
    //                                               out P_radiation_loss_kWh_d);
    //}

    /// <summary>
    /// Calculates costs for heating the digester. in case of a thermal heating
    /// costs are lost gain which we had if we sell the thermal energy. In case
    /// of an electrical heating it is the cost producing the electrical energy.
    /// </summary>
    /// <param name="digester_id">digester id</param>
    /// <param name="pP_loss">thermal power loss</param>
    /// <param name="sell_heat">€/kWh for selling thermal energy, this is a virtual price here
    /// missed gain, needed for a thermal heating</param>
    /// <param name="cost_elEnergy">costs for electricity in €/kWh, needed if we have a electrical
    /// heating</param>
    /// <returns>costs in €</returns>
    /// <exception cref="exception">Unknown digester id</exception>
    /// <exception cref="exception">efficiency is zero, division by zero</exception>
    public double calcCostsForHeating(string digester_id, physValue pP_loss, double sell_heat,
      double cost_elEnergy)
    {
      return myDigesters.calcCostsForHeating(digester_id, pP_loss, sell_heat, cost_elEnergy);
    }

    /// <summary>
    /// Calculates costs for heating all digesters. in case of a thermal heating
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
    public double calcCostsForHeating_Total(physValue pP_loss, double sell_heat,
      double cost_elEnergy)
    {
      double costs= 0;

      foreach (digester myDigester in myDigesters)
      {
        costs += myDigester.calcCostsForHeating(pP_loss, sell_heat, cost_elEnergy);
      }

      return costs;
    }

    /// <summary>
    /// Calculate thermal/electrical power needed by heating to compensate heat loss in digester. 
    /// </summary>
    /// <param name="digester_id">digester id</param>
    /// <param name="Q">substrate feed measured in m^3/d</param>
    /// <param name="mySubstrates"></param>
    /// <param name="T_ambient">ambient temperature</param>
    /// <param name="mySensors"></param>
    /// <returns>thermal/electrical energy needed by heating in kWh/d</returns>
    /// <exception cref="exception">Unknown digester id</exception>
    /// <exception cref="exception">Q.Length != mySubstrates.Count</exception>
    /// <exception cref="exception">efficiency is zero, division by zero</exception>
    public double calcHeatPower(string digester_id, double[] Q, substrates mySubstrates,
      physValue T_ambient, sensors mySensors)
    {
      return myDigesters.calcHeatPower(digester_id, Q, mySubstrates, T_ambient, mySensors);
    }

    /// <summary>
    /// Calculates the thermal energy balance of the digester. It compares 
    /// thermal sinks (negative) with thermal sources (positive) inside the digester
    /// thermal sinks are:
    /// - heat substrates
    /// - radiation
    /// thermal sources are:
    /// - microbiology
    /// - stirrer dissipation
    /// </summary>
    /// <param name="digester_id">digester id</param>
    /// <param name="Q">substrate feed measured in m^3/d</param>
    /// <param name="mySubstrates"></param>
    /// <param name="mySensors"></param>
    /// <returns>thermal energy balance mesasured in kWh/d</returns>
    public double calcThermalEnergyBalance(string digester_id,
                                           double[] Q, substrates mySubstrates, sensors mySensors)
    {
      return myDigesters.calcThermalEnergyBalance(digester_id, Q, mySubstrates, Tout, mySensors);
    }

    /// <summary>
    /// Calculates verguetung for the given plant using EEG 2009/2012
    /// </summary>
    /// <param name="Pel">electrical power in kW</param>
    /// <param name="var">for EEG 2009 this indicates manure bonus</param>
    /// <returns>renumeration in €/kWh</returns>
    public double getVerguetung(double Pel, bool var)
    {
      return myFinances.getVerguetung(this, Pel, var);
    }



    /// <summary>
    /// Print the plant to a string, such that it can be displayed on a 
    /// console.
    /// </summary>
    /// <returns></returns>
    public string print()
    {
      StringBuilder sb= new StringBuilder();

      sb.Append("   ----------   PLANT:   " + name + "   ----------   \n");
      
      sb.Append("id: " + id + "\n");

      sb.Append("construction year: " + construct_year + "\n");

      sb.Append("g: " + g.printValue() + "\t\t\t");
      sb.Append("Tout: " + Tout.printValue() + "\r\n");

      //

      sb.Append( myDigesters.print() );

      sb.Append( myCHPs.print() );

      sb.Append(myTransportation.print());

      sb.Append( myFinances.print() );

      //

      sb.Append("   ----------     END PLANT     ----------   \n");

      return sb.ToString();
    }

    /// <summary>
    /// Write plant to a xml file
    /// </summary>
    /// <param name="XMLfile"></param>
    public void saveAsXML(string XMLfile)
    {
      //XmlWriterSettings settings = new XmlWriterSettings();
      //settings.OmitXmlDeclaration = true;
      //settings.ConformanceLevel = ConformanceLevel.Fragment;
      //settings.Encoding = Encoding.UTF8;

      StreamWriter writer = File.CreateText(XMLfile); //new System.IO.StreamWriter(XMLfile);//, Encoding.Default);
      //XmlWriter writer = XmlWriter.Create(XMLfile, settings);
      //File.CreateText(XMLfile);
      
      writer.Write/*Raw*/("<?xml version=\"1.0\" encoding=\"utf-8\"?>\n");

      writer.Write/*Raw*/(String.Format("<plant id= \"{0}\">\n", id));

      writer.Write/*Raw*/(xmlInterface.setXMLTag("name", name));
      writer.Write(xmlInterface.setXMLTag("construct_year", construct_year));
      writer.Write/*Raw*/(g.getParamsAsXMLString());
      writer.Write/*Raw*/(Tout.getParamsAsXMLString());

      writer.Write/*Raw*/(myDigesters.getParamsAsXMLString());

      writer.Write/*Raw*/(myCHPs.getParamsAsXMLString());

      writer.Write/*Raw*/(myTransportation.getParamsAsXMLString());

      writer.Write/*Raw*/(myFinances.getParamsAsXMLString());

      writer.Write/*Raw*/("</plant>\n");

      writer.Close();
    }


    
    // -------------------------------------------------------------------------------------
    //                              !!! PRIVATE METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// Creates and sets physValues of this class to default values, such that
    /// they are not null
    /// </summary>
    private void set_params_of()
    { 
      _g=    new physValue("g",    9.81, "m/s^2");
      
      _Tout= new physValue("Tout", 10,   "°C");

      _construct_year = 2009; // default value
    }



  }
}


