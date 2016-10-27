/**
 * This file defines the finances of the biogas plant. 
 * 
 * TODOs:
 * - Könnte sicherlich noch um weitere terme erweitert werden
 * - methode welche EEG ändert fehlt wohl noch
 * 
 * Looks pretty good!
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
  /// finances of a biogas plant
  ///
  /// includes EEG 2009 and EEG 2012
  /// </summary>
  public partial class finances
  {
   
    // -------------------------------------------------------------------------------------
    //                              !!! CONSTRUCTOR METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// Standard Constructor sets parameters to default values
    /// </summary>
    public finances()
    {
      double[] values= { /*0.214,*/ 0.015, 0.0, /*0.04,*/ 0.18 };

      try
      {
        set_params_of(values);

        // init some EEG
        myEEG = new eeg2009();
      }
      catch (exception e)
      {
        Console.WriteLine(e.Message);
        Console.WriteLine("Could not create finances object!");
      }
    }


    
    // -------------------------------------------------------------------------------------
    //                              !!! PUBLIC METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// Calculates verguetung for the given plant using EEG 2009/2012
    /// </summary>
    /// <param name="myPlant"></param>
    /// <param name="Pel">electrical power in kW</param>
    /// <param name="var">for EEG 2009 this indicates manure bonus</param>
    /// <returns>renumeration in €/kWh</returns>
    public double getVerguetung(biogas.plant myPlant, double Pel, bool var)
    {
      return myEEG.getVerguetung(myPlant, Pel, var);
    }

    // TODO - Methode mit mySubstrates auch hinzufügen, wird für EEG 2012 benötigt



    /// <summary>
    /// Read params from reader which reads a xml file.
    /// reads until end elements of finances
    /// </summary>
    /// <param name="reader">an open reader</param>
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

            if (xml_tag == "EEG2009")   // plant has EEG 2009
            {
              myEEG = new eeg2009();

              myEEG.getParamsFromXMLReader(ref reader);
            }
            else if (xml_tag == "EEG2012")    // plant has EEG 2012
            {
              myEEG = new eeg2012();

              myEEG.getParamsFromXMLReader(ref reader);
            }
            break;

          case System.Xml.XmlNodeType.EndElement:
            if (reader.Name == "finances")
              do_while = false;

            break;
        }
      }

    }

    /// <summary>
    /// get params as xml string
    /// </summary>
    /// <returns></returns>
    public string getParamsAsXMLString()
    {
      StringBuilder sb= new StringBuilder();

      sb.Append("<finances>\n");

      sb.Append( myEEG.getParamsAsXMLString() );

      //sb.Append(xmlInterface.setXMLTag("revEl", revenueEl));
      sb.Append(xmlInterface.setXMLTag("revTherm", revenueTherm));
      sb.Append(xmlInterface.setXMLTag("revGas", revenueGas));
      //sb.Append(xmlInterface.setXMLTag("revManureBonus", revenueManureBonus));
      sb.Append(xmlInterface.setXMLTag("priceEl", priceElEnergy));

      sb.Append("</finances>\n");

      return sb.ToString();
    }

    /// <summary>
    /// print to console
    /// </summary>
    /// <returns></returns>
    public string print()
    {
      StringBuilder sb= new StringBuilder();

      sb.Append("   ----------   FINANCES   ----------   \r\n");

      sb.Append( myEEG.print() );

      //sb.Append("  revEl=   "  + revenueEl.Value.ToString("0.00") + " " 
      //                         + revenueEl.Unit + "\t\t\t");
      sb.Append("revTherm= "   + revenueTherm.Value.ToString("0.00") + " " 
                               + revenueTherm.Unit + "\t\t\t");
      sb.Append("revGas= "     + revenueGas.Value.ToString("0.00") + " " 
                               + revenueGas.Unit + "\n");
      //sb.Append("  revManureBonus= " + revenueManureBonus.Value.ToString("0.00") + " " 
      //                         + revenueManureBonus.Unit + "\n");
      sb.Append("  priceEl= "  + priceElEnergy.Value.ToString("0.00") + " " 
                               + priceElEnergy.Unit + "\r\n");

      //
      
      return sb.ToString();
    }

    

    // -------------------------------------------------------------------------------------
    //                              !!! PRIVATE METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// This method defines what the units are in which the values of the params 
    /// are saved in the digester object.
    /// </summary>
    /// <param name="values"></param>
    /// <exception cref="exception">values.Length != 3</exception>
    private void set_params_of(params double[] values)
    {
      if (values.Length != 3)
        throw new exception(String.Format(
              "You may only call this method with 3 parameters and not with {0} parameters!",
              values.Length));

      //this._revenueEl=     new physValue("revEl",    values[0], "€/kWh", 
      //                     "revenue from selling produced electrical energy");
      this._revenueTherm=  new physValue("revTherm", values[0], "€/kWh", 
                           "revenue from selling produced thermal energy");
      this._revenueGas=    new physValue("revGas",   values[1], "€/m^3",
                           "revenue from selling produced biogas");
      //this._revenueManureBonus= new physValue("revManureBonus", values[3], "€/m^3",
      //                     "revenue of Manure Bonus (EEG 2009)");
      this._priceElEnergy= new physValue("priceEl",  values[2], "€/kWh", 
                           "price for buying electrical energy");
    }



  }
}


