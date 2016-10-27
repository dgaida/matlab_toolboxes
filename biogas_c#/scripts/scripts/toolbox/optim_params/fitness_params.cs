/**
 * This file defines the fitness_params object.
 * 
 * TODOs:
 * - a few TODOs in the file but ok
 * 
 * FINISHED!
 * 
 */

using System;
using System.Collections.Generic;
using System.Text;
using System.Xml;
using System.IO;
using toolbox;

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
  /// definition of fitness parameters used in objective function
  /// </summary>
  public partial class fitness_params
  {

    // -------------------------------------------------------------------------------------
    //                              !!! CONSTRUCTOR METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// Standard Constructor creates the fitness_params object with default params
    /// </summary>
    /// <param name="numDigesters">number of digesters on plant</param>
    public fitness_params(int numDigesters/*biogas.plant myPlant*/)
    { 
      set_params_to_default(/*myPlant*/numDigesters);
    }

    /// <summary>
    /// Constructor used to read fitness_params out of a XML file
    /// </summary>
    /// <param name="XMLfile">name of the xml file</param>
    public fitness_params(string XMLfile)
    {
      XmlTextReader reader= new System.Xml.XmlTextReader(XMLfile);

      getParamsFromXMLReader(ref reader);

      reader.Close();
    }



    // -------------------------------------------------------------------------------------
    //                              !!! PUBLIC METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// set fitness params to values read out of a xml file
    /// </summary>
    /// <param name="reader"></param>
    public void getParamsFromXMLReader(ref XmlTextReader reader)
    {
      string xml_tag = "";
      int digester_index = 0;

      // do not set params, because plant is not known
      // TODO - macht probleme wenn ein neuer parameter hinzugefügt wird, da dann
      // dessen list leer bleibt
      // im grunde müsste man am ende der funktion die listen füllen, welche 
      // leer geblieben sind mit default werten
      
      bool do_while = true;

      // go through the file
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
              if (xml_tag == "digester" && reader.Name == "index")
              {
                // TODO
                // index of digester, not used at the moment
                digester_index = Convert.ToInt32(reader.Value);

                break;
              }
            }

            if (xml_tag == "weights")
            {
              myWeights.getParamsFromXMLReader(ref reader);
            }
            else if (xml_tag == "setpoints")
            {
              mySetpoints.getParamsFromXMLReader(ref reader);
            }

            break;

          case System.Xml.XmlNodeType.Text: // text, thus value, of each element

            switch (xml_tag)
            {
              // TODO - use digester_index here, compare with size of pH_min, ...
                // here we assume that params are given in the correct
                // order, thus first the first digester, then the 2nd digester, ...
              case "pH_min":
                pH_min.Add(System.Xml.XmlConvert.ToDouble(reader.Value));
                break;
              case "pH_max":
                pH_max.Add(System.Xml.XmlConvert.ToDouble(reader.Value));
                break;
              case "pH_optimum":
                pH_optimum.Add(System.Xml.XmlConvert.ToDouble(reader.Value));
                break;
              case "TS_max":
                TS_max.Add(System.Xml.XmlConvert.ToDouble(reader.Value));
                break;
              case "VFA_TAC_min":
                VFA_TAC_min.Add(System.Xml.XmlConvert.ToDouble(reader.Value));
                break;
              case "VFA_TAC_max":
                VFA_TAC_max.Add(System.Xml.XmlConvert.ToDouble(reader.Value));
                break;
              case "VFA_min":
                VFA_min.Add(System.Xml.XmlConvert.ToDouble(reader.Value));
                break;
              case "VFA_max":
                VFA_max.Add(System.Xml.XmlConvert.ToDouble(reader.Value));
                break;
              case "TAC_min":
                TAC_min.Add(System.Xml.XmlConvert.ToDouble(reader.Value));
                break;
              case "HRT_min":
                HRT_min.Add(System.Xml.XmlConvert.ToDouble(reader.Value));
                break;
              case "HRT_max":
                HRT_max.Add(System.Xml.XmlConvert.ToDouble(reader.Value));
                break;
              case "OLR_max":
                OLR_max.Add(System.Xml.XmlConvert.ToDouble(reader.Value));
                break;
              case "Snh4_max":
                Snh4_max.Add(System.Xml.XmlConvert.ToDouble(reader.Value));
                break;
              case "Snh3_max":
                Snh3_max.Add(System.Xml.XmlConvert.ToDouble(reader.Value));
                break;
              case "AcVsPro_min":
                AcVsPro_min.Add(System.Xml.XmlConvert.ToDouble(reader.Value));
                break;

              case "TS_feed_max":
                _TS_feed_max= System.Xml.XmlConvert.ToDouble(reader.Value);
                break;
              case "HRT_plant_min":
                _HRT_plant_min = System.Xml.XmlConvert.ToDouble(reader.Value);
                break;
              case "HRT_plant_max":
                _HRT_plant_max = System.Xml.XmlConvert.ToDouble(reader.Value);
                break;
              case "OLR_plant_max":
                _OLR_plant_max = System.Xml.XmlConvert.ToDouble(reader.Value);
                break;

              // read in manurebonus
              case "manurebonus":
                _manurebonus = System.Xml.XmlConvert.ToBoolean(reader.Value);
                break;

              case "fitness_function":
                _fitness_function = reader.Value;
                break;
              case "nObjectives":
                _nObjectives = System.Xml.XmlConvert.ToInt32(reader.Value);
                break;
              //case "Ndelta":
              //  _Ndelta = System.Xml.XmlConvert.ToInt32(reader.Value);
              //  break;

            }

            break;

          case System.Xml.XmlNodeType.EndElement: // end of fitness_params
            if (reader.Name == "fitness_params")
              do_while = false;      // end while loop

            break;
        }
      }



    }

    /// <summary>
    /// Returns fitness params as XML string, such that it can be saved 
    /// in a XML file
    /// </summary>
    /// <returns></returns>
    public string getParamsAsXMLString()
    {
      StringBuilder sb = new StringBuilder();

      sb.Append("<fitness_params>\n");

      for (int idigester = 0; idigester < pH_min.Count; idigester++)
      {
        sb.Append(String.Format("<digester index= \"{0}\">\n", idigester));

        sb.Append(xmlInterface.setXMLTag("pH_min", pH_min[idigester]));
        sb.Append(xmlInterface.setXMLTag("pH_max", pH_max[idigester]));
        sb.Append(xmlInterface.setXMLTag("pH_optimum", pH_optimum[idigester]));

        sb.Append(xmlInterface.setXMLTag("TS_max", TS_max[idigester]));

        sb.Append(xmlInterface.setXMLTag("VFA_TAC_min", VFA_TAC_min[idigester]));
        sb.Append(xmlInterface.setXMLTag("VFA_TAC_max", VFA_TAC_max[idigester]));

        sb.Append(xmlInterface.setXMLTag("VFA_min", VFA_min[idigester]));
        sb.Append(xmlInterface.setXMLTag("VFA_max", VFA_max[idigester]));

        sb.Append(xmlInterface.setXMLTag("TAC_min", TAC_min[idigester]));
        
        sb.Append(xmlInterface.setXMLTag("HRT_min", HRT_min[idigester]));
        sb.Append(xmlInterface.setXMLTag("HRT_max", HRT_max[idigester]));

        sb.Append(xmlInterface.setXMLTag("OLR_max", OLR_max[idigester]));

        sb.Append(xmlInterface.setXMLTag("Snh4_max", Snh4_max[idigester]));
        sb.Append(xmlInterface.setXMLTag("Snh3_max", Snh3_max[idigester]));

        sb.Append(xmlInterface.setXMLTag("AcVsPro_min", AcVsPro_min[idigester]));
        
        sb.Append("</digester>\n");
      }

      sb.Append(xmlInterface.setXMLTag("TS_feed_max", TS_feed_max));

      // add weights
      sb.Append(myWeights.getParamsAsXMLString());

      sb.Append(xmlInterface.setXMLTag("HRT_plant_min", HRT_plant_min));
      sb.Append(xmlInterface.setXMLTag("HRT_plant_max", HRT_plant_max));

      sb.Append(xmlInterface.setXMLTag("OLR_plant_max", OLR_plant_max));

      // write manurebonus inside file
      sb.Append(xmlInterface.setXMLTag("manurebonus", manurebonus));

      sb.Append(xmlInterface.setXMLTag("fitness_function", fitness_function));

      sb.Append(xmlInterface.setXMLTag("nObjectives", nObjectives));

      //sb.Append(xmlInterface.setXMLTag("Ndelta", _Ndelta));

      // add setpoints
      sb.Append(mySetpoints.getParamsAsXMLString());

      //
      sb.Append("</fitness_params>\n");

      return sb.ToString();
    }

    /// <summary>
    /// Saves the fitness_params in a xml file
    /// </summary>
    /// <param name="XMLfile">name of the xml file</param>
    public void saveAsXML(string XMLfile)
    {
      StreamWriter writer = File.CreateText(XMLfile);

      writer.Write("<?xml version=\"1.0\" encoding=\"utf-8\"?>\n");

      writer.Write(getParamsAsXMLString());

      writer.Close();
    }

    /// <summary>
    /// Prints the fitness params to a string, such that the string
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

      sb.Append("   ----------   fitness_params:   ----------   \r\n");

      for (int idigester = 0; idigester < pH_min.Count; idigester++)
      {
        sb.Append(String.Format("digester: {0}\n", idigester));

        sb.Append(String.Format("pH_min: {0}\t\t\t", pH_min[idigester]));
        sb.Append(String.Format("pH_max: {0}\t\t\t", pH_max[idigester]));
        sb.Append(String.Format("pH_optimum: {0}\n", pH_optimum[idigester]));

        sb.Append(String.Format("TS_max: {0}\t\t\t", TS_max[idigester]));
        sb.Append(String.Format("VFA_TAC_min: {0}\t\t\t", VFA_TAC_min[idigester]));
        sb.Append(String.Format("VFA_TAC_max: {0}\n", VFA_TAC_max[idigester]));
        sb.Append(String.Format("VFA_min: {0}\t\t\t", VFA_min[idigester]));
        sb.Append(String.Format("VFA_max: {0}\t\t\t", VFA_max[idigester]));
        sb.Append(String.Format("TAC_min: {0}\n", TAC_min[idigester]));
        sb.Append(String.Format("HRT_min: {0}\t\t\t", HRT_min[idigester]));
        sb.Append(String.Format("HRT_max: {0}\t\t\t", HRT_max[idigester]));
        sb.Append(String.Format("OLR_max: {0}\n", OLR_max[idigester]));
        sb.Append(String.Format("Snh4_max: {0}\t\t\t", Snh4_max[idigester]));
        sb.Append(String.Format("Snh3_max: {0}\t\t\t", Snh3_max[idigester]));

        sb.Append(String.Format("AcVsPro_min: {0}\r\n", AcVsPro_min[idigester]));
      }

      sb.Append(String.Format("TS_feed_max: {0}\r\n", TS_feed_max));

      // add weights
      sb.Append(myWeights.print());

      sb.Append(String.Format("\nHRT_plant_min: {0}\t\t\t", HRT_plant_min));
      sb.Append(String.Format("HRT_plant_max: {0}\t\t\t", HRT_plant_max));
      sb.Append(String.Format("OLR_plant_max: {0}\n", OLR_plant_max));

      sb.Append(String.Format("manurebonus: {0}\n", manurebonus));

      sb.Append(String.Format("fitness_function: {0}\t\t", fitness_function));
      sb.Append(String.Format("nObjectives: {0}\r\n", nObjectives));
      //sb.Append(String.Format("Ndelta: {0}\n", _Ndelta));

      // add setpoints
      sb.Append(mySetpoints.print());

      sb.Append("   ---------- ---------- ---------- ----------   \n");

      return sb.ToString();
    }



  }
}


