/**
 * This file is part of the partial class substrate_transport and defines
 * all methods not defined elsewhere.
 * 
 * TODOs:
 * - improve documentation
 * - Da zu jedem Fermenter auch eine substrate_transport gehört, kann
 *   an eigentlich auch bei erstellung eines digesters auch gleich
 *   ein substrate_transport erstellen. bin noch niht sicher wie man
 *   das am besten macht..., mache ich jetzt so in plant_digester.cs
 * - run methoden prüfen
 *   
 * 
 * in gui_plant sollte bei jedem fermenter direkt ein Feld geben wo man die 
 * Art der Feststoffzubringung angeben kann und dazu die spez. energyverbrauch.
 * 
 * 
 * 
 * Should be FINISHED!
 * 
 */

using System;
using System.Collections.Generic;
using System.Text;
using System.Xml;
using science;
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
  /// This class is used to transport the substrate feed.
  /// 
  /// a substrate_transport contains a pump and a transport for solid substrates
  /// </summary>
  public partial class substrate_transport : pump
  {

    // -------------------------------------------------------------------------------------
    //                              !!! PUBLIC METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// Get params as an array of objects.
    /// </summary>
    /// <param name="variables"></param>
    /// <param name="symbols"></param>
    /// <exception cref="exception">Unknown parameter</exception>
    /// <exception cref="exception">No input argument</exception>
    public override void get_params_of(out object[] variables, params string[] symbols)
    {
      int nargin= symbols.Length;

      if (nargin > 0)
      {
        variables = new object[nargin];

        for (int iarg = 0; iarg < nargin; iarg++)
        {
          switch (symbols[iarg])
          {
            case "name_solids":
              variables[iarg] = this.name_solids;
              break;
            case "energy_per_ton":
              variables[iarg] = this.energy_per_ton;
              break;
            default:  // call method of base class
              base.get_params_of(out variables, symbols);
              break;
          }
        }
      }
      else
        throw new exception("You did not give an argument!");
    }
    
    /// <summary>
    /// Set params of pump. Syntax: set_params_of( "h_lift", 2, "eta", 0.4, ... ).
    /// Used to set the value of physValues as well, so make sure that
    /// the value you want to set is measured in the unit in which the
    /// physValue is saved in the object. 
    /// Therefore see: set_params_of(params double[] values)
    /// </summary>
    /// <param name="symbols"></param>
    /// <exception cref="exception">Unknown parameter</exception>
    public override void set_params_of(params object[] symbols)
    {
      for (int iarg = 0; iarg < symbols.Length; iarg = iarg + 2)
      {
        switch ((string)symbols[iarg])
        {
          case "name_solids":
            this._name_solids = (string)symbols[iarg + 1];
            break;
          case "energy_per_ton":
            this._energy_per_ton = (double)symbols[iarg + 1];
            break;

          default:
            base.set_params_of(symbols);
            break;
        }
      }
    }



    // -------------------------------------------------------------------------------------
    //                              !!! GET METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// Read params using the given XML reader, which is reading a xml file.
    /// Reads one substrate_transport, stops at end element of substrate_transport.
    /// </summary>
    /// <param name="reader">an open reader</param>
    public override void getParamsFromXMLReader(ref XmlTextReader reader)
    {
      string xml_tag = "";
      
      bool do_while = true;

      while (reader.Read() && do_while)
      {
        switch (reader.NodeType)
        {

          case System.Xml.XmlNodeType.Element: // this knot is an element
            xml_tag = reader.Name;

            if (xml_tag == "pump")
              base.getParamsFromXMLReader(ref reader);              

            break;

          case System.Xml.XmlNodeType.Text: // text, thus value, of each element

            switch (xml_tag)
            {
              case "name_solids":
                _name_solids = reader.Value;
                break;
              case "energy_per_ton":
                _energy_per_ton = System.Xml.XmlConvert.ToDouble(reader.Value);
                break;
            }

            break;

          case System.Xml.XmlNodeType.EndElement:
            if (reader.Name == "substrate_transport")
              do_while = false;

            break;
        }
      }

    }

    /// <summary>
    /// Get params as an xml string, such that they can be written inside 
    /// a xml file.
    /// </summary>
    /// <returns></returns>
    public override string getParamsAsXMLString()
    {
      StringBuilder sb = new StringBuilder();

      sb.Append("<substrate_transport>\n");

      sb.Append(xmlInterface.setXMLTag("name_solids", name_solids));
      sb.Append(xmlInterface.setXMLTag("energy_per_ton", energy_per_ton));

      sb.Append(base.getParamsAsXMLString());

      sb.Append("</substrate_transport>\n");

      return sb.ToString();
    }

    /// <summary>
    /// Print the params of the pump to a string, to be displayed on a console
    /// </summary>
    /// <returns></returns>
    public override string print()
    {
      StringBuilder sb = new StringBuilder();

      sb.Append("   ----------   Substrate Transport   ----------   \r\n");
      sb.Append("name_solids: " + name_solids + "\r\n");

      sb.Append("energy_per_ton= " + energy_per_ton.ToString("0.00") + " [kWh/t]\r\n");

      sb.Append(base.print());

      //
      sb.Append("   ---------- ---------- ---------- ----------   \n");

      return sb.ToString();
    }



    // -------------------------------------------------------------------------------------
    //                              !!! PUBLIC METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// TODO
    /// </summary>
    /// <param name="t">current simulation time in days</param>
    /// <param name="mySensors"></param>
    /// <param name="unit_start"></param>
    /// <param name="unit_destiny"></param>
    /// <param name="myPlant"></param>
    /// <param name="mySubstrates"></param>
    /// <param name="substrate_network"></param>
    /// <returns></returns>
    public static double run(double t, //double deltatime,
      biogas.sensors mySensors,
      string unit_start, string unit_destiny,
      biogas.plant myPlant, biogas.substrates mySubstrates,
      double[,] substrate_network)
    {
      double Q_pump, Q_solids;

      return run(t, mySensors, unit_start, unit_destiny, 
        myPlant, mySubstrates, substrate_network, out Q_pump, out Q_solids);
    }

    /// <summary>
    /// TODO
    /// </summary>
    /// <param name="t">current simulation time in days</param>
    /// <param name="mySensors"></param>
    /// <param name="unit_start"></param>
    /// <param name="unit_destiny"></param>
    /// <param name="myPlant"></param>
    /// <param name="mySubstrates"></param>
    /// <param name="substrate_network"></param>
    /// <param name="Q_pump">to be pumped amount in m^3/d</param>
    /// <param name="Q_solids">
    /// amount that can not be pumped because TS content is too high
    /// </param>
    /// <returns></returns>
    public static double run(double t, //double deltatime,
      biogas.sensors mySensors, 
      string unit_start, string unit_destiny,
      biogas.plant myPlant, biogas.substrates mySubstrates,
      double[,] substrate_network, out double Q_pump, out double Q_solids)
    {
      string substrate_transport_id = getid(unit_start, unit_destiny);

      // determine rho - default value for digester or storagetank
      physValue density_liq = new physValue("rho", 1000, "kg/m^3", "density");
      physValue density_sol = new physValue("rho", 1000, "kg/m^3", "density");

      Q_pump = 0;
      Q_solids = 0;

      //

      if (unit_start == "substratemix")
      {
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
        physValue[] Q_digester =
          sensors.getSubstrateMixFlowForFermenter(t, mySubstrates, myPlant,
                                  mySensors, substrate_network, unit_destiny);

        // values are Q for all substrates
        double[] Q = physValue.getValues(Q_digester);

        // an dieser Stelle muss man heraus finden, welche Elemente
        // von Q flüssig und welche fest sind, an Hand TS Gehalt bestimmen < 11 % FM

        biogas.substrates mySubsSol = new biogas.substrates();
        biogas.substrates mySubsLiq = new biogas.substrates();

        List<double> Q_liq_subs= new List<double>();
        List<double> Q_sol_subs = new List<double>();

        //

        for (int iel = 0; iel < Q.Length; iel++)
        {
          double TS= mySubstrates.get_param_of(iel + 1, "TS");

          if (TS < 11)    // liquid substrate (pumpable)
          { 
            mySubsLiq.addSubstrate(mySubstrates.get(iel + 1));
            Q_liq_subs.Add(Q[iel]);
          }
          else
          {
            mySubsSol.addSubstrate(mySubstrates.get(iel + 1));
            Q_sol_subs.Add(Q[iel]);
          }
        }

        if (Q_liq_subs.Count > 0)
        {
          double[] Q_liq_s_a = Q_liq_subs.ToArray();

          Q_pump = math.sum(Q_liq_s_a);

          // 
          mySubsLiq.get_weighted_mean_of(Q_liq_s_a, "rho", out density_liq);
        }
        
        if (Q_sol_subs.Count > 0)
        {
          double[] Q_sol_s_a = Q_sol_subs.ToArray();

          Q_solids = math.sum(Q_sol_s_a);

          // 
          mySubsSol.get_weighted_mean_of(Q_sol_s_a, "rho", out density_sol);
        }
        
      }
      else
      {
        throw new exception("substrate_transport may only pump the substratemix");
      }


      // measure energy needed to pump stuff 

      // dann als summe raus geben (solids + liquids)
      double P_kWh_d;

      // its important that we pass two arguments here
      // is used in energyPump_sensor to ditinguish between this call
      // the one from pump.cs
      double[] parvec = { Q_pump, density_liq.Value };

      mySensors.measure(t, "pumpEnergy_" + substrate_transport_id,
        myPlant, Q_pump, parvec, out P_kWh_d);

      //

      double[] parv = { density_sol.Value };
      double P_solids;

      mySensors.measure(t, "transportEnergy_" + substrate_transport_id,
        myPlant, Q_solids, parv, out P_solids);

      P_kWh_d += P_solids;

      // TODO - DEFINE WHAT SHOULD be returned
      //double[] retvals = { P_kWh_d, Q_pump };

      return P_kWh_d;// retvals;
    }



  }
}


