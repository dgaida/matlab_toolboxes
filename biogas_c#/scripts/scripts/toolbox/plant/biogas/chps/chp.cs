/**
 * This file is part of the partial class chp and defines
 * all methods not defined elsewhere.
 * 
 * TODOs:
 * - falls elektrischer Wirkungsgrad von BHKW unbekannt, gibt es aus AD profit calculator eine
 * formel: 
 * eta_el= c1 * Pmax^c2
 * mit c1= 0.19138
 * c2= 0.0868 und Pmax (max el. Leistung des BHKWs) gemessen in kW
 * 
 * 
 * FINISHED!
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
  /// Definition of a combined heat and power plant (cogeneration unit)
  /// </summary>
  public partial class chp
  {

    // -------------------------------------------------------------------------------------
    //                              !!! PUBLIC METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// Read params using the given XML reader, which is reading a xml file
    /// only one chp is read, stops at the end element of the chp
    /// </summary>
    /// <param name="reader">open reader</param>
    /// <returns>true on success, else false</returns>
    public bool getParamsFromXMLReader(ref XmlTextReader reader)
    {
      string xml_tag= "";
      string param= "";

      double[] values= { 250, 500, 0.4, 0.45 };

      // init physValue objects, such that they are not null
      try
      {
        set_params_of(values);
      }
      catch (exception e)
      {
        Console.WriteLine(e.Message);
        return false;
      }

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
                // found a new parameter
                param= reader.Value;

                switch (param)
                {
                  case "Pel":
                    Pel.getParamsFromXMLReader(ref reader, param);
                    break;
                  case "Ptherm":
                    Ptherm.getParamsFromXMLReader(ref reader, param);
                    break;
                }

                break;
              }
              else if (xml_tag == "chp" && reader.Name == "id")
              {
                _id= reader.Value;

                break;
              }
            }
            break;

          case System.Xml.XmlNodeType.Text: // text, thus value, of each element

            switch (xml_tag)
            {
              case "name":
                _name= reader.Value;
                break;
              case "eta_el":
                _eta_el = System.Xml.XmlConvert.ToDouble(reader.Value);//Convert.ToDouble(reader.Value);
                break;
              case "eta_therm":
                eta_therm = System.Xml.XmlConvert.ToDouble(reader.Value);//Convert.ToDouble(reader.Value);
                break;
            }

            break;

          case System.Xml.XmlNodeType.EndElement:
            if (reader.Name == "chp")
              do_while= false;

            break;
        }
      }

      return true;
    }

    /// <summary>
    /// Get params as an xml string, such that they can be written inside 
    /// a xml file.
    /// </summary>
    /// <returns>string with xml tags</returns>
    public string getParamsAsXMLString()
    {
      StringBuilder sb= new StringBuilder();

      sb.Append(String.Format("<chp id= \"{0}\">\n", id));

      sb.Append(xmlInterface.setXMLTag("name", name));

      sb.Append(Pel.getParamsAsXMLString());
      sb.Append(Ptherm.getParamsAsXMLString());
      sb.Append(xmlInterface.setXMLTag("eta_el", eta_el));
      sb.Append(xmlInterface.setXMLTag("eta_therm", eta_therm));
      
      sb.Append("</chp>\n");

      return sb.ToString();
    }

    /// <summary>
    /// Print the params of the chp to a string, to be displayed on a console
    /// </summary>
    /// <returns>string for console</returns>
    public string print()
    {
      StringBuilder sb= new StringBuilder();

      sb.Append("   ----------   CHP:   " + name + "   ----------   \r\n");
      sb.Append("id: " + id + "\r\n");

      sb.Append("  Pel= "     + Pel.printValue("0.0")      + "\t\t\t\t");
      sb.Append("Ptherm= "    + Ptherm.printValue("0.0")   + "\n");
      sb.Append("  eta_el= "  + eta_el.ToString("0.00")    + " [100 %]\t\t");
      sb.Append("eta_therm= " + eta_therm.ToString("0.00") + " [100 %]\r\n");
      
      //
      sb.Append("   ---------- ---------- ---------- ----------   \n");

      return sb.ToString();
    }
        
    /// <summary>
    /// Calculates the electrical and thermal energy, respectively power
    /// generated out of the gas stream u.
    /// ch4 and h2 is burned
    /// </summary>
    /// <param name="u">
    /// vector with as many elements as there are number of gases (BioGas.n_gases)
    /// the positions of the gases inside the vector are: 
    /// - biogas.BioGas.pos_ch4
    /// - biogas.BioGas.pos_co2
    /// - biogas.BioGas.pos_h2
    /// </param>
    /// <param name="P_el_kWh_d">electrical power in kWh/d</param>
    /// <param name="P_el_kW">electrical power in kW</param>
    /// <param name="P_therm_kWh_d">thermal power in kWh/d</param>
    /// <param name="P_therm_kW">thermal power in kW</param>
    public void burnBiogas(double[] u,
                           out physValue P_el_kWh_d, out physValue P_el_kW,
                           out physValue P_therm_kWh_d, out physValue P_therm_kW)
    {
      burnBiogas(u, out P_el_kWh_d, out P_therm_kWh_d);

      // power : kWh/d / (24 h/d) = kW
      //
      P_el_kW = P_el_kWh_d.convertUnit("kW");

      // power : kWh/d / (24 h/d) = kW
      //
      P_therm_kW = P_therm_kWh_d.convertUnit("kW");
    }

    /// <summary>
    /// Calculates the electrical and thermal energy, respectively power
    /// generated out of the gas stream u.
    /// ch4 and h2 is burned
    /// </summary>
    /// <param name="u">
    /// vector with as many elements as there are number of gases (BioGas.n_gases)
    /// the positions of the gases inside the vector are: 
    /// - biogas.BioGas.pos_ch4
    /// - biogas.BioGas.pos_co2
    /// - biogas.BioGas.pos_h2
    /// values measured in m^3/d
    /// </param>
    /// <param name="P_el_kWh_d">electrical energy per day</param>
    /// <param name="P_therm_kWh_d">thermal energy per day</param>
    /// <exception cref="exception">unit problem</exception>
    public void burnBiogas(double[] u, 
                           out physValue P_el_kWh_d, out physValue P_therm_kWh_d)
    {
      // energy per day in biogas measured in kWh/d
      physValue energy;

      try
      {
        energy = biogas.BioGas.burn(u);
      }
      catch (exception e)
      {
        Console.WriteLine(e.Message);
        energy = new physValue(0, "kWh/d");
      }

      // P(t) [kWh/d]= Q_{ch4}(t) * H_{ch4} * \eta_{el}
      //
      // [ kWh/d ]= [ m^3/d * kWh / ( Nm^3 ) ]
      //
      P_el_kWh_d= eta_el * energy;

      // bound power by maximal electrical power
      try
      {
        P_el_kWh_d = physValue.min(P_el_kWh_d, Pel.convertUnit("kWh/d"));
      }
      catch (exception e)
      {
        Console.WriteLine(e.Message);
        throw new exception("burnBiogas: unit problem!");
      }

      P_el_kWh_d.Symbol= "Pel";
      
            
      // P(t) [kWh/d]= Q_{ch4}(t) * H_{ch4} * \eta_{therm}
      //
      // [ kWh/d ]= [ m^3/d * kWh / ( Nm^3 ) ]
      //
      P_therm_kWh_d= eta_therm * energy;
       
      // bound power by maximal thermal power
      try
      {
        P_therm_kWh_d= physValue.min(P_therm_kWh_d, Ptherm.convertUnit("kWh/d"));
      }
      catch (exception e)
      {
        Console.WriteLine(e.Message);
        throw new exception("burnBiogas: unit problem 2!");
      }

      P_therm_kWh_d.Symbol= "Ptherm";
    }

    /// <summary>
    /// Calculates the maximal amount of methane (in m^3/d) which can be burned in a chp
    /// based on the electrical power. assuming that ch4 is the only
    /// gas in biogas which generates energy
    /// </summary>
    /// <param name="maxMethane">
    /// max. amount of methane which can be burned with chp in m^3/d
    /// </param>
    public void getMaxMethaneConsumption(out double maxMethane)
    {
      physValue p_maxMethane;

      getMaxMethaneConsumption(out p_maxMethane);

      maxMethane= p_maxMethane.Value;
    }
    /// <summary>
    /// Calculates the maximal amount of methane (in m^3/d) which can be burned in a chp
    /// based on the electrical power. assuming that ch4 is the only
    /// gas in biogas which generates energy
    /// </summary>
    /// <param name="maxMethane">
    /// max. amount of methane which can be burned with chp in m^3/d
    /// </param>
    public void getMaxMethaneConsumption(out physValue maxMethane)
    {
      physValue unit_converter= new physValue(1, "kWh / kW * h");

      maxMethane= Pel.convertUnit("kW") / eta_el / biogas.chemistry.Hch4 * unit_converter;

      maxMethane= maxMethane.convertUnit("m^3/d");
    }

    

  }
}


