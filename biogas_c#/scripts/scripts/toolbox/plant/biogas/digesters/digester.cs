/**
 * This file is part of the partial class digester and defines
 * all methods not defined elsewhere.
 * 
 * TODOs:
 * - 
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

    // -------------------------------------------------------------------------------------
    //                              !!! GET METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// Read params using the given XML reader, which is reading a xml file.
    /// Reads one digester, stops at end element of digester.
    /// </summary>
    /// <param name="reader">open reader</param>
    /// <returns>true on success, else false</returns>
    public bool getParamsFromXMLReader(ref XmlTextReader reader)
    {
      string xml_tag= "";
      string param= "";

      double[] values= { 3500, 3000, 3000, 400, 400, 40, 20, 0.4, 0.25, 1.9, 0.4 };

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
            { // read the attributes, here only the attribute of digester
              // is of interest, all other attributes are ignored, 
              // actually there usally are no other attributes
              if (xml_tag == "physValue" && reader.Name == "symbol")
              {
                // found a new parameter
                param= reader.Value;

                switch (param)
                { 
                  case "Vtot":
                    Vtot.getParamsFromXMLReader(ref reader, param);
                    break;
                  case "Vliq":
                    Vliq.getParamsFromXMLReader(ref reader, param);
                    break;
                  case "Vgas":
                    Vgas.getParamsFromXMLReader(ref reader, param);
                    break;
                  case "Vliqmax":
                    Vliqmax.getParamsFromXMLReader(ref reader, param);
                    break;
                  case "Vgasmax":
                    Vgasmax.getParamsFromXMLReader(ref reader, param);
                    break;
                  case "T":
                    T.getParamsFromXMLReader(ref reader, param);
                    break;
                  case "diam":
                    diam.getParamsFromXMLReader(ref reader, param);
                    break;
                  case "k_wall":
                    k_wall.getParamsFromXMLReader(ref reader, param);
                    break;
                  case "k_roof":
                    k_roof.getParamsFromXMLReader(ref reader, param);
                    break;
                  case "k_ground":
                    k_ground.getParamsFromXMLReader(ref reader, param);
                    break;
                }

                break;
              }
              else if (xml_tag == "digester" && reader.Name == "id")
              {
                _id= reader.Value;

                break;
              }
            }

            if (xml_tag == "heating")
            {
              heating.getParamsFromXMLReader(ref reader);
            }
            else if (xml_tag == "stirrers")
            {
              mixers.getParamsFromXMLReader(ref reader);
            }
            
            break;

          case System.Xml.XmlNodeType.Text: // text, thus value, of each element

            switch (xml_tag)
            {
              case "name":
                _name= reader.Value;
                break;
              case "accum_x":
                _accum_x = System.Xml.XmlConvert.ToDouble(reader.Value);
                break;
              case "accum_s":
                _accum_s = System.Xml.XmlConvert.ToDouble(reader.Value);
                break;
            }

            break;

          case System.Xml.XmlNodeType.EndElement:
            if (reader.Name == "digester")
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
    /// <returns>string containing xml tags</returns>
    public string getParamsAsXMLString()
    {
      StringBuilder sb= new StringBuilder();

      sb.Append(String.Format("<digester id= \"{0}\">\n", id));

      sb.Append(xmlInterface.setXMLTag("name", name));

      sb.Append(Vtot.getParamsAsXMLString());
      sb.Append(Vliq.getParamsAsXMLString());
      sb.Append(Vgas.getParamsAsXMLString());
      sb.Append(Vliqmax.getParamsAsXMLString());
      sb.Append(Vgasmax.getParamsAsXMLString());
      sb.Append(T.getParamsAsXMLString());
      sb.Append(diam.getParamsAsXMLString());
      sb.Append(k_wall.getParamsAsXMLString());
      sb.Append(k_roof.getParamsAsXMLString());
      sb.Append(k_ground.getParamsAsXMLString());

      sb.Append(xmlInterface.setXMLTag("accum_x", accum_x));
      sb.Append(xmlInterface.setXMLTag("accum_s", accum_s));

      sb.Append( heating.getParamsAsXMLString() );

      sb.Append(mixers.getParamsAsXMLString());

      //
      sb.Append("</digester>\n");

      return sb.ToString();
    }

    /// <summary>
    /// Print the params of the digester to a string, to be displayed on a console
    /// </summary>
    /// <returns>string for console</returns>
    public string print()
    {
      StringBuilder sb= new StringBuilder();

      sb.Append("   ----------   DIGESTER:   " + name + "   ----------   \r\n");
      sb.Append("id: " + id + "\r\n");

      sb.Append("  Vtot= "    + Vtot.printValue("0")     + "\t\t\t");
      sb.Append("Vliq= "      + Vliq.printValue("0")     + "\t\t\t");
      sb.Append("Vgas= "      + Vgas.Value.ToString("0") + "\n");
      sb.Append("  Vliqmax= " + Vliqmax.printValue("0")  + "\t\t\t");
      sb.Append("Vgasmax= "   + Vgasmax.printValue("0")  + "\t\t\t");
      sb.Append("T= "       + T.printValue("0.0")      + "\n");

      sb.Append("  diam= "      + diam.printValue("0.0")   + "\t\t\t");
      sb.Append("hwall= " + height.printValue("0.0") + "\t\t\t");
      sb.Append("hroof= " + h_roof.printValue("0.0") + "\n");
      sb.Append("  Awall= " + Awall.printValue("0.0") + "\t\t\t");
      sb.Append("Aroof= " + Aroof.printValue("0.0") + "\t\t\t");
      sb.Append("Aground= " + Aground.printValue("0.0") + "\n");
      
      sb.Append("  k_wall= " + k_wall.printValue("0.00") + "\t\t");
      sb.Append("k_roof= " + k_roof.printValue("0.00") + "\t\t");
      sb.Append("k_ground= " + k_ground.printValue("0.00") + "\r\n");

      sb.Append("  accum_x= " + accum_x.ToString("0.00") + "\t\t\t");
      sb.Append("accum_s= " + accum_s.ToString("0.00") + "\r\n");
      
      // heating
      sb.Append( heating.print() );

      sb.Append(mixers.print());       // stirrer

      //
      sb.Append("   ---------- ---------- ---------- ----------   \n");

      return sb.ToString();
    }



  }
}


