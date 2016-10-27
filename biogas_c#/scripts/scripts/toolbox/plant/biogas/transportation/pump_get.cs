/**
 * This file is part of the partial class pump and defines
 * all get methods and print method.
 * 
 * TODOs:
 * - 
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
    //                            !!! PUBLIC METHODS !!!
    // -------------------------------------------------------------------------------------
    
    // -------------------------------------------------------------------------------------
    //                              !!! GET METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// Read params using the given XML reader, which is reading a xml file.
    /// Reads one pump, stops at end element of pump.
    /// </summary>
    /// <param name="reader">an open reader</param>
    public virtual void getParamsFromXMLReader(ref XmlTextReader reader)
    {
      string xml_tag = "";
      string param = "";

      bool do_while = true;

      while (reader.Read() && do_while)
      {
        switch (reader.NodeType)
        {

          case System.Xml.XmlNodeType.Element: // this knot is an element
            xml_tag = reader.Name;

            while (reader.MoveToNextAttribute())
            { // read the attributes, here only the attribute of digester
              // is of interest, all other attributes are ignored, 
              // actually there usally are no other attributes
              if (xml_tag == "physValue" && reader.Name == "symbol")
              {
                // found a new parameter
                param = reader.Value;

                switch (param)
                {
                  case "h_lift":
                    _h_lift.getParamsFromXMLReader(ref reader, param);
                    break;
                  case "d_horizontal":
                    _d_horizontal.getParamsFromXMLReader(ref reader, param);
                    break;
                }

                break;
              }
            }

            break;

          case System.Xml.XmlNodeType.Text: // text, thus value, of each element

            switch (xml_tag)
            {
              case "unit_start":
                _unit_start = reader.Value;
                break;
              case "unit_destiny":
                _unit_destiny = reader.Value;
                break;
              case "eta":
                _eta = System.Xml.XmlConvert.ToDouble(reader.Value);
                break;
              //case "mu":
              //  _mu = System.Xml.XmlConvert.ToDouble(reader.Value);
              //  break;
              case "d_pipe":
                _d_pipe = System.Xml.XmlConvert.ToDouble(reader.Value);
                break;
              case "k_pipe":
                _k_pipe = System.Xml.XmlConvert.ToDouble(reader.Value);
                break;
            }

            break;

          case System.Xml.XmlNodeType.EndElement:
            if (reader.Name == "pump")
              do_while = false;

            break;
        }
      }

    }

    /// <summary>
    /// Get params as an xml string, such that they can be written inside 
    /// a xml file.
    /// </summary>
    /// <returns>string for xml</returns>
    public virtual string getParamsAsXMLString()
    {
      StringBuilder sb = new StringBuilder();

      sb.Append("<pump>\n");

      sb.Append(xmlInterface.setXMLTag("unit_start", unit_start));
      sb.Append(xmlInterface.setXMLTag("unit_destiny", unit_destiny));

      sb.Append(h_lift.getParamsAsXMLString());
      sb.Append(d_horizontal.getParamsAsXMLString());
      sb.Append(xmlInterface.setXMLTag("eta", eta));
      //sb.Append(xmlInterface.setXMLTag("mu", mu));
      sb.Append(xmlInterface.setXMLTag("d_pipe", _d_pipe));
      sb.Append(xmlInterface.setXMLTag("k_pipe", _k_pipe));

      sb.Append("</pump>\n");

      return sb.ToString();
    }

    /// <summary>
    /// Print the params of the pump to a string, to be displayed on a console
    /// </summary>
    /// <returns></returns>
    public virtual string print()
    {
      StringBuilder sb = new StringBuilder();

      sb.Append("   ----------   Pump   ----------   \r\n");
      sb.Append("id: " + id + "\r\n");

      sb.Append("  h_lift= " + h_lift.printValue("0.0") + "\t\t\t\t");
      sb.Append("d_horizontal= " + d_horizontal.printValue("0.0") + "\n");
      sb.Append("  eta= " + eta.ToString("0.00") + " [100 %]\t\t");
      //sb.Append("mu= " + mu.ToString("0.00") + " [100 %]\r\n");
      sb.Append("d_pipe= " + _d_pipe.ToString("0.00") + " [m]\t\t");
      sb.Append("k_pipe= " + _k_pipe.ToString("0.00") + " [mm]\r\n");

      //
      sb.Append("   ---------- ---------- ---------- ----------   \n");

      return sb.ToString();
    }



  }



}


