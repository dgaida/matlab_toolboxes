/**
 * This file defines the setpoints object.
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
  /// defines all that is needed to implement setpoint controls
  /// 
  /// </summary>
  public partial class setpoints : List<setpoint>
  {
    
    // -------------------------------------------------------------------------------------
    //                              !!! CONSTRUCTOR METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// standard constructor 
    /// </summary>
    public setpoints()
    {
      
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

            switch (xml_tag)
            {
              // 
              case "setpoint":
                Add(new setpoint(ref reader));

                break;
            }
            
            break;

          case System.Xml.XmlNodeType.Text: // text, thus value, of each element
                        
            break;

          case System.Xml.XmlNodeType.EndElement: // end of setpoint
            if (reader.Name == "setpoints")
              do_while = false;      // end while loop

            break;
        }
      }
    }

    /// <summary>
    /// Returns setpoints as XML string, such that they can be saved 
    /// in a XML file. 
    /// </summary>
    /// <returns></returns>
    public string getParamsAsXMLString()
    {
      StringBuilder sb = new StringBuilder();

      sb.Append("<setpoints>\n");

      foreach (setpoint mySetpoint in this)
        sb.Append(mySetpoint.getParamsAsXMLString());
      
      sb.Append("</setpoints>\n");

      return sb.ToString();
    }

    /// <summary>
    /// Prints the setpoints params to a string, such that the string
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

      sb.Append("   ----------   setpoints:   ----------   \r\n");

      foreach (setpoint mySetpoint in this)
        sb.Append(mySetpoint.print());

      sb.Append("   ---------- ---------- ---------- ----------   \n");

      return sb.ToString();
    }



    /// <summary>
    /// Returns the setpoint at the given position index.
    /// index is 0-based: 0,1,2,3,...
    /// </summary>
    /// <param name="index">index of setpoint</param>
    /// <returns>setpoint object</returns>
    /// <exception cref="exception">index invalid</exception>
    public setpoint get(int index)
    {
      if ((index < 0) || (index >= this.Count))
      {
        throw new exception(String.Format("index must be >= 0 and < {0}, but is: {1}!",
          this.Count, index));
      }

      return this[index];
    }


    /// <summary>
    /// Returns the number of setpoints in the list
    /// </summary>
    /// <returns>number of setpoints</returns>
    public int getNumSetpoints()
    {
      return this.Count;
    }
    /// <summary>
    /// Returns the number of setpoints in the list as double
    /// Only for MATLAB
    /// </summary>
    /// <returns>number of setpoints</returns>
    public double getNumSetpointsD()
    {
      return (double)getNumSetpoints();
    }



  }
}


