/**
 * This file is part of the partial class stirrer and defines
 * all methods not defined elsewhere.
 * 
 * TODOs:
 * - methoden substratabhängig machen: K, nflow, alpha_T
 * - 
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
  /// Defines a stirrer used to stir the content in a digester
  /// </summary>
  public partial class stirrer
  {

    // -------------------------------------------------------------------------------------
    //                              !!! PUBLIC METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// calculate electrical power [kWh/d]
    /// </summary>
    /// <param name="Tdigester">temperature inside digester in [°C]</param>
    /// <param name="TSdigester">TS content inside digester in [% FM]</param>
    /// <returns>power [kWh/d]</returns>
    /// <exception cref="exception">eta_mixer == 0</exception>
    /// <exception cref="exception">newton number error</exception>
    public double calcPelectrical(double Tdigester, double TSdigester)
    {
      // run time = 0 h/d, then power = 0
      if (!stirred || (runtime == 0))   // if digester is not stirred at all, then return 0 kWh/d
        return 0;

      if (eta_mixer == 0)
      { 
        // throw error
        throw new exception(String.Format("eta_mixer == 0: {0}!", eta_mixer));
      }

      return calcPmechanical(Tdigester, TSdigester) / eta_mixer * runtime / 1000;
    }

    /// <summary>
    /// calculate dissipated power (same as mechanical power) [kWh/d]
    /// </summary>
    /// <param name="Tdigester">temperature inside digester in [°C]</param>
    /// <param name="TSdigester">TS content inside digester in [% FM]</param>
    /// <returns>power [kWh/d]</returns>
    /// <exception cref="exception">newton number error</exception>
    public double calcPdissipation(double Tdigester, double TSdigester)
    {
      // run time = 0 h/d, then power = 0
      if (!stirred || (runtime == 0))   // if digester is not stirred at all, then return 0 kWh/d
        return 0;

      return calcPmechanical(Tdigester, TSdigester) * runtime / 1000;
    }



    // -------------------------------------------------------------------------------------
    //                              !!! PRIVATE METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// calculate mechanical power [W]
    /// </summary>
    /// <param name="Tdigester">temperature inside digester in [°C]</param>
    /// <param name="TSdigester">TS content inside digester in [% FM]</param>
    /// <returns>power [W]</returns>
    /// <exception cref="exception">newton number error</exception>
    private double calcPmechanical(double Tdigester, double TSdigester)
    {
      double Np = 0;

      try
      {
        Np = calcNewtonNumber(Tdigester, TSdigester);   // dimensionless [100 %]
      }
      catch (exception e)
      {
        Console.WriteLine(e.Message);
        throw new exception("Could not calculate newton number!");
      }

      double rho_digester = 1000;   // kg/m^3

      // 1 * kg * m^5/(m^3 * s^3) = kg * m^2/s^3= N * m/s = W
      // in Watt
      return Np * rho_digester * Math.Pow(rotspeed, 3) * Math.Pow(diameter, 5);
    }

    /// <summary>
    /// calculate Newton (power) number Np [100 %]
    /// </summary>
    /// <param name="Tdigester">temperature inside digester in [°C]</param>
    /// <param name="TSdigester">TS content inside digester in [% FM]</param>
    /// <returns>Np [100 %]</returns>
    /// <exception cref="exception">type must be between 0 and 3</exception>
    /// <exception cref="exception">eta_eff == 0</exception>
    private double calcNewtonNumber(double Tdigester, double TSdigester)
    {
      double Re = calcReynoldsNumber(Tdigester, TSdigester);

      switch (type)
      {
          // literatur geprüft, handbuch der kältetechnik
          // stimmt so, gerber stimmt nicht
        case 0:     // central mixer with Strömungsbrecher
          if (Re > 40)
            return 2;
          else
            return 80 / Re;
        case 1:     // submersible mixer without Strömungsbrecher
          if (Re > 3.1)
            return 4 / Math.Pow(Math.Log10(Re), 2);
          else
            return 50 / Re;
        case 2:     // central mixer without Strömungsbrecher
          if (Re > 3.1 && Re < 553)
            return 4 / Math.Pow(Math.Log10(Re), 2);
          else if (Re <= 3.1)
            return 50 / Re;
          else // > 553
            return 1 / Math.Pow(Re, 0.1);
        case 3:     // submersible mixer with Strömungsbrecher
          if (Re > 3.1 && Re < 635)
            return 4 / Math.Pow(Math.Log10(Re), 2);
          else if (Re <= 3.1)
            return 50 / Re;
          else // > 635
            return 0.8 * Math.Pow(Re, -0.07);
      }

      // throw error
      throw new exception(String.Format("type must be between 0 and 3: {0}!", type));

      //return 0;
    }

    /// <summary>
    /// calculate Reynolds number Re [100 %]
    /// </summary>
    /// <param name="Tdigester">temperature inside digester in [°C]</param>
    /// <param name="TSdigester">TS content inside digester in [% FM]</param>
    /// <returns>Re [100 %]</returns>
    /// <exception cref="exception">eta_eff == 0</exception>
    private double calcReynoldsNumber(double Tdigester, double TSdigester)
    {
      double rho_digester = 1000;   // kg/m^3

      double eta_eff= 0;

      try
      {
        eta_eff = calc_eta_eff(Tdigester, TSdigester);
      }
      catch (exception e)
      {
        Console.WriteLine(e.Message);
      }

      // kg/m^3*1/sec*m^2/(Pa*s)= kg/(m*s^2*Pa) * Pa / (N/m^2) = kg*m/s^2 / N = 1
      if (eta_eff != 0)
        return rho_digester * rotspeed * Math.Pow(diameter, 2) / eta_eff;
      else
        // throw error
        throw new exception(String.Format("eta_eff == {0}!", eta_eff));
    }

    /// <summary>
    /// calculate effective viscosity eta_eff [Pa*s]
    /// </summary>
    /// <param name="Tdigester">temperature inside digester in [°C]</param>
    /// <param name="TSdigester">TS content inside digester in [% FM]</param>
    /// <returns>eta_eff [Pa*s]</returns>
    /// <exception cref="exception">nflow == 0</exception>
    private double calc_eta_eff(double Tdigester, double TSdigester)
    {
      double alpha_T = calc_alpha_T(Tdigester);

      double K = calc_K(TSdigester);

      double nflow = calc_nflow(TSdigester);

      if (nflow == 0)
      {
        // throw error
        throw new exception(String.Format("nflow == {0}!", nflow));
      }

      return alpha_T * K * Math.Pow(11 / (2 * Math.PI) * rotspeed, nflow - 1) * 
                           Math.Pow((3 * nflow + 1) / (4 * nflow), nflow);
    }



    /// <summary>
    /// calculates temperature correction alpha_T [100 %]
    /// </summary>
    /// <param name="Tdigester">Temperature inside digester [°C]</param>
    /// <returns>alpha_T</returns>
    private double calc_alpha_T(double Tdigester)
    {
      // TODO: evtl. variabel machen
      double CT1 = 1.3;   // Gerber: 1.3952 und 1.2759
      double CT2 = 0.014; // Gerber: 0.01650 und 0.01187

      return CT1 * Math.Exp( -CT2 * Tdigester );
    }

    /// <summary>
    /// calculate consistency coefficient in Pa*s
    /// 
    /// also called from pump
    /// </summary>
    /// <param name="TSdigester">TS content in digester in % FM</param>
    /// <returns>K in Pa*s</returns>
    public static double calc_K(double TSdigester)
    {
      // TODO - variabel machen: schwein, kuh, chicken
      double CK1 = 0.05; // [Pa*s]   // Gerber: 0.0091 - 0.0791
      // TODO - variabel machen: schwein, kuh, chicken
      double CK2 = 0.45;    // Gerber: 0.38 - 0.58

      return CK1 * Math.Exp(CK2 * TSdigester);
    }

    /// <summary>
    /// calculate flow index n_flow [100 %]
    /// 
    /// also called from pump
    /// </summary>
    /// <param name="TSdigester">TS content in digester in % FM</param>
    /// <returns>nflow [100 %]</returns>
    public static double calc_nflow(double TSdigester)
    {
      // TODO - variabel machen: schwein, kuh, chicken
      double Cnflow1 = 0.67;    // Gerber: 0.62 - 0.77
      // TODO - variabel machen: schwein, kuh, chicken
      double Cnflow2 = 0.07;    // Gerber: 0.04 - 0.07

      return Cnflow1 * Math.Exp( - Cnflow2 * TSdigester );
    }



    // -------------------------------------------------------------------------------------
    //                              !!! PUBLIC METHODS !!!
    // -------------------------------------------------------------------------------------
        
    /// <summary>
    /// Read the parameters out of the xml reader.
    /// Reads one stirrer object until the end element of stirrer
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

            while (reader.MoveToNextAttribute())
            { // read the attributes, here only the attribute of physValue
              // is of interest, all other attributes are ignored, 
              // actually there usally are no other attributes
              if (xml_tag == "physValue" && reader.Name == "symbol")
              {
                // do something if needed, at the moment there are no physValues

                break;
              }
              else if (xml_tag == "stirrer" && reader.Name == "id")
              {
                _id = reader.Value;

                break;
              }
            }
            break;

          case System.Xml.XmlNodeType.Text: // text, thus value, of each element

            switch (xml_tag)
            {
              case "eta_mixer":
                _eta_mixer = System.Xml.XmlConvert.ToDouble(reader.Value);
                break;
              case "diameter":
                _diameter = System.Xml.XmlConvert.ToDouble(reader.Value);
                break;
              case "rotspeed":
                _rotspeed = System.Xml.XmlConvert.ToDouble(reader.Value);
                break;
              case "runtime":
                _runtime = System.Xml.XmlConvert.ToDouble(reader.Value);
                break;
              case "type":
                _type = System.Xml.XmlConvert.ToInt32(reader.Value);
                break;
              case "stirred": // TODO - warum nutze ich nicht System.Xml.XmlConvert.ToBoolean?
                // da ich bool als int32 speicher, s. xmlInterface, eigentlich nicht so sinnvoll
                _stirred= Convert.ToBoolean(Convert.ToInt32(reader.Value));
                break;
            }

            break;

          case System.Xml.XmlNodeType.EndElement:
            if (reader.Name == "stirrer")
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

      sb.Append(String.Format("<stirrer id= \"{0}\">\n", id));

      sb.Append(xmlInterface.setXMLTag("eta_mixer", eta_mixer));
      sb.Append(xmlInterface.setXMLTag("diameter", diameter));
      sb.Append(xmlInterface.setXMLTag("rotspeed", rotspeed));
      sb.Append(xmlInterface.setXMLTag("runtime", runtime));
      sb.Append(xmlInterface.setXMLTag("type", type));
      sb.Append(xmlInterface.setXMLTag("stirred", stirred));
      
      sb.Append("</stirrer>\n");

      return sb.ToString();
    }

    /// <summary>
    /// print the params to a string to be displayed at the console.
    /// </summary>
    /// <returns></returns>
    public string print()
    {
      StringBuilder sb= new StringBuilder();

      sb.Append("   ----------   STIRRER   ----------   \r\n");
      sb.Append("id: " + id + "\r\n");

      sb.Append("  eta_mixer= "    + eta_mixer.ToString("0.00")    + " [100 %]\t\t\t");
      sb.Append("diameter= " + diameter.ToString("0.00") + " [m]\t\t\t");
      sb.Append("rotspeed= " + rotspeed.ToString("0.00") + " [1/s]\n");
      sb.Append("  runtime= " + runtime.ToString("0.00") + " [h/d]\t\t\t");
      sb.Append("type= " + type.ToString() + "\t\t\t");
      sb.Append("stirred= " + stirred.ToString() + "\r\n");

      //
      //sb.Append("   ---------- ---------- ---------- ----------   \n");

      return sb.ToString();
    }



  }
}


