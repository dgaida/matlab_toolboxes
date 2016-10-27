/**
 * This file defines the setpoint object.
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
using toolbox;
using System.Xml;
using System.IO;

/**
 * namespace for biogas plant optimization
 * 
 * Definition of:
 * - fitness_params
 * - objective function
 * - weights used inside objective function
 * 
 */
namespace biooptim
{
  /// <summary>
  /// defines all that is needed to implement a setpoint control
  /// 
  /// </summary>
  public partial class setpoint
  {
    
    // -------------------------------------------------------------------------------------
    //                              !!! CONSTRUCTOR METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// standard constructor 
    /// </summary>
    public setpoint()
    {
      // default values are already set in setpoint_properties.cs

    }

    /// <summary>
    /// standard constructor 
    /// </summary>
    /// <param name="reader">an open reader, &lt;setpoint&gt; was just read</param>
    public setpoint(ref XmlTextReader reader)
    {
      getParamsFromXMLReader(ref reader);
    }



    // -------------------------------------------------------------------------------------
    //                              !!! PUBLIC METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// sets the setpoint params according to the values read out of an xml file
    /// 
    /// </summary>
    /// <param name="reader"></param>
    public void getParamsFromXMLReader(ref XmlTextReader reader)
    {
      string xml_tag = "";
      
      bool do_while = true;

      // go through the file
      while (reader.Read() && do_while)
      {
        switch (reader.NodeType)
        {

          case System.Xml.XmlNodeType.Element: // this knot is an element
            xml_tag = reader.Name;
            break;

          case System.Xml.XmlNodeType.Text: // text, thus value, of each element

            switch (xml_tag)
            {
              // 
              case "location":
                _location= reader.Value;
                break;
              case "sensor_id":
                _sensor_id= reader.Value;
                break;
              case "index":
                _index = System.Xml.XmlConvert.ToInt32(reader.Value);
                break;
              case "s_operator":
                _s_operator = reader.Value;
                break;
              case "scalefac":
                _scalefac = System.Xml.XmlConvert.ToDouble(reader.Value);
                break;
            }

            break;

          case System.Xml.XmlNodeType.EndElement: // end of setpoint
            if (reader.Name == "setpoint")
              do_while = false;      // end while loop

            break;
        }
      }
    }

    /// <summary>
    /// Returns setpoint as XML string, such that it can be saved 
    /// in a XML file. 
    /// </summary>
    /// <returns></returns>
    public string getParamsAsXMLString()
    {
      StringBuilder sb = new StringBuilder();

      sb.Append("<setpoint>\n");

      sb.Append(xmlInterface.setXMLTag("location", location));
      sb.Append(xmlInterface.setXMLTag("sensor_id", sensor_id));
      sb.Append(xmlInterface.setXMLTag("index", index));
      sb.Append(xmlInterface.setXMLTag("s_operator", s_operator));
      sb.Append(xmlInterface.setXMLTag("scalefac", scalefac));
      
      sb.Append("</setpoint>\n");

      return sb.ToString();
    }

    /// <summary>
    /// Prints the setpoint params to a string, such that the string
    /// can be written to a console.
    /// 
    /// For Custom Numeric Format Strings see:
    /// 
    /// http://msdn.microsoft.com/en-us/library/0c899ak8.aspx
    /// 
    /// </summary>
    /// <returns></returns>
    public string print()
    {
      StringBuilder sb = new StringBuilder();

      sb.Append("   ----------   setpoint:   ----------   \r\n");

      sb.Append(String.Format("  location: {0}\t\t\t", location));
      sb.Append(String.Format("sensor_id: {0}\n", sensor_id));
      sb.Append(String.Format("  index: {0}\t\t\t", index));
      sb.Append(String.Format("s_operator: {0}\t\t\t", s_operator));
      sb.Append(String.Format("scalefac: {0}\n", scalefac));

      sb.Append("   ---------- ---------- ---------- ----------   \n");

      return sb.ToString();
    }



  }
}


