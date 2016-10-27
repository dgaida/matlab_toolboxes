/**
 * This file defines the partial class transportation and contains objects
 * needed for substrate or sludge transportation, such as pumps.
 * 
 * TODOs:
 * - in Ganzheitliche stoffliche und energetische Modellierung
 * S. 50, werden formeln für feststoffeinbringungen dargestellt. berechnung über 
 * eine spezifische energetische Kenngröße. verschiedene Kenngrößen sind
 * angegeben:
 * - Allgemeines Einbringsystem: 0.74 - 3.3 kWh/t
 * - Schubboden mit Eindrückschnecke: 0.92 kWh/t
 * - Schubboden: 0.38 kWh/t
 * - Vertikalmischer (Futtermischwagen): 1.1 kWh/t
 * - Trichterzulauf mit Dosierschnecke: 0.74 kWh/t
 * - Einpresssysteme: 1.07 - 3.3 kWh/t
 * 
 * - ein einbringsystem für feststoffe sollte man hier implementieren und in modell
 * nutzen, habe ich gemacht
 * 
 * Except for that FINISHED!
 * 
 */

using System;
using System.Collections.Generic;
using System.Text;
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
  /// transportation objects to pump/transport substrates or sludge
  /// 
  /// - pump
  /// - substrate_transport (includes a pump)
  /// 
  /// </summary>
  public partial class transportation
  {

    // -------------------------------------------------------------------------------------
    //                            !!! PRIVATE FIELDS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// Contains all pumps needed to pump sludge or pumpable substrates (low TS)
    /// </summary>
    private pumps myPumps= new pumps();

    /// <summary>
    /// Contains all substrate_transports needed to transport substrates (high TS)
    /// a substrate_transport also contains a pump for the liquid substrates
    /// </summary>
    private substrate_transports mySubstrateTransports = new substrate_transports();



    // -------------------------------------------------------------------------------------
    //                              !!! CONSTRUCTOR METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// does nothing
    /// </summary>
    public transportation()
    { 
    }

    /// <summary>
    /// Read all pumps out of the opened reader
    /// </summary>
    /// <param name="reader"></param>
    public transportation(ref XmlTextReader reader)
    { 
      // 
      getParamsFromXMLReader(ref reader);
    }

    /// <summary>
    /// Constructor creating the transportation object by reading from the 
    /// given xml file.
    /// </summary>
    /// <param name="XMLfile">xml file</param>
    public transportation(string XMLfile)
    {
      XmlTextReader reader = new System.Xml.XmlTextReader(XMLfile);

      getParamsFromXMLReader(ref reader);

      reader.Close();
    }



    // -------------------------------------------------------------------------------------
    //                              !!! GET METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// Read params from reader which reads a xml file.
    /// reads until end elements of transportation, adds all read pumps, etc. 
    /// to list
    /// </summary>
    /// <param name="reader"></param>
    public void getParamsFromXMLReader(ref XmlTextReader reader)
    {
      string xml_tag = "";

      bool do_while = true;

      while (reader.Read() && do_while)
      {
        switch (reader.NodeType)
        {

          case System.Xml.XmlNodeType.Element: // this knot is an element
            xml_tag = reader.Name;

            if (xml_tag == "pumps")
            {
              myPumps.getParamsFromXMLReader(ref reader);
            }
            else if (xml_tag == "substrate_transports")
            {
              mySubstrateTransports.getParamsFromXMLReader(ref reader);
            }
            break;

          case System.Xml.XmlNodeType.EndElement:
            if (reader.Name == "transportation")
              do_while = false;

            break;
        }
      }

    }

    /// <summary>
    /// Return the params of all transportation systems as a xml string
    /// </summary>
    /// <returns></returns>
    public string getParamsAsXMLString()
    {
      StringBuilder sb = new StringBuilder();

      sb.Append("<transportation>\n");

      // get pumps
      sb.Append(myPumps.getParamsAsXMLString());

      sb.Append(mySubstrateTransports.getParamsAsXMLString());

      // maybe get more if there are more transportation systems
      
      sb.Append("</transportation>\n");

      return sb.ToString();
    }

    /// <summary>
    /// Print transportation systems to a string, to be displayed on a console
    /// </summary>
    /// <returns></returns>
    public string print()
    {
      StringBuilder sb = new StringBuilder();

      sb.Append(myPumps.print());

      sb.Append(mySubstrateTransports.print());
      
      return sb.ToString();
    }

  }



}


