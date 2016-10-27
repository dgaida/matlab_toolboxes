/**
 * This file defines the weights object.
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
  /// weights used in optimization
  /// 
  /// the multi-objective optimization problem is solved by weighting the 
  /// different objectives with weights and then sum them up
  /// 
  /// sum_i=1^N weight_i * objective_i
  /// 
  /// </summary>
  public partial class weights
  {
    
    // -------------------------------------------------------------------------------------
    //                              !!! CONSTRUCTOR METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// standard constructor creates a normalized weight vector
    /// </summary>
    public weights()
    {
      // default values are already set in weights_properties.cs

      normalize();
    }



    // -------------------------------------------------------------------------------------
    //                              !!! PUBLIC METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// normalizes given weights object, such that sum of all parameters is 1
    /// </summary>
    /// <param name="myWeights"></param>
    public static void normalize(weights myWeights)
    {
      myWeights.normalize();
    }
    /// <summary>
    /// normalizes this weights object, such that sum of all parameters is 1
    /// </summary>
    public void normalize()
    {
      double sum_weights;

      if (is_normal(out sum_weights))
        return;

      // each parameter is changed acoording to its number

      if (sum_weights > 0)
      {
        _w_CSB = _w_CSB / sum_weights;
        _w_CH4 = _w_CH4 / sum_weights;
        _w_money = _w_money / sum_weights;
        _w_energy = _w_energy / sum_weights;
        _w_pH = _w_pH / sum_weights;
        _w_TS = _w_TS / sum_weights;
        _w_VFA = _w_VFA / sum_weights;
        _w_HRT = _w_HRT / sum_weights;
        _w_TAC = _w_TAC / sum_weights;
        _w_OLR = _w_OLR / sum_weights;
        _w_N = _w_N / sum_weights;
        _w_gasexc = _w_gasexc / sum_weights;
        _w_FOS_TAC = _w_FOS_TAC / sum_weights;
        _w_faecal = _w_faecal / sum_weights;
        _w_AcVsPro = _w_AcVsPro / sum_weights;
        _w_setpoint = _w_setpoint / sum_weights;
        _w_udot = _w_udot / sum_weights;
      }
      else
      { 
        // throw error
        throw new exception(String.Format("sum_weights must be > 0! sum_weights= {0}", sum_weights));
      }
    }
    
    /// <summary>
    /// checks whether sum of weights is 1, if it is, then
    /// weights object is said to be normal, true is returned, else false
    /// </summary>
    /// <param name="myWeights"></param>
    /// <param name="sum_weigths">sum of all weights</param>
    /// <returns></returns>
    public static bool is_normal(weights myWeights, out double sum_weigths)
    {
      return myWeights.is_normal(out sum_weigths);
    }

    /// <summary>
    /// checks whether sum of weights is 1, if it is, then
    /// weights object is said to be normal, true is returned, else false
    /// </summary>
    /// <param name="sum_weigths">sum of all weights</param>
    /// <returns></returns>
    public bool is_normal(out double sum_weigths)
    { 
      sum_weigths = _w_CSB + _w_CH4 + _w_money + _w_energy + _w_pH + 
                    _w_TS + _w_VFA + _w_HRT + _w_TAC + _w_OLR + 
                    _w_N + _w_gasexc + _w_FOS_TAC + _w_faecal + _w_AcVsPro + 
                    _w_setpoint + _w_udot;

      if (Math.Abs(1 - sum_weigths) < 0.01)
        return true;

      return false;
    }



    /// <summary>
    /// sets the weigths according to the values read out of an xml file
    /// at the end normaizes the weights
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
              case "w_CSB":
                _w_CSB= System.Xml.XmlConvert.ToDouble(reader.Value);
                break;
              case "w_CH4":
                _w_CH4= System.Xml.XmlConvert.ToDouble(reader.Value);
                break;
              case "w_money":
                _w_money = System.Xml.XmlConvert.ToDouble(reader.Value);
                break;
              case "w_energy":
                _w_energy = System.Xml.XmlConvert.ToDouble(reader.Value);
                break;
              case "w_pH":
                _w_pH = System.Xml.XmlConvert.ToDouble(reader.Value);
                break;
              case "w_TS":
                _w_TS = System.Xml.XmlConvert.ToDouble(reader.Value);
                break;
              case "w_VFA":
                _w_VFA = System.Xml.XmlConvert.ToDouble(reader.Value);
                break;
              case "w_HRT":
                _w_HRT = System.Xml.XmlConvert.ToDouble(reader.Value);
                break;
              case "w_TAC":
                _w_TAC = System.Xml.XmlConvert.ToDouble(reader.Value);
                break;
              case "w_OLR":
                _w_OLR = System.Xml.XmlConvert.ToDouble(reader.Value);
                break;
              case "w_N":
                _w_N = System.Xml.XmlConvert.ToDouble(reader.Value);
                break;
              case "w_gasexc":
                _w_gasexc = System.Xml.XmlConvert.ToDouble(reader.Value);
                break;
              case "w_FOS_TAC":
                _w_FOS_TAC = System.Xml.XmlConvert.ToDouble(reader.Value);
                break;
              case "w_faecal":
                _w_faecal = System.Xml.XmlConvert.ToDouble(reader.Value);
                break;
              case "w_AcVsPro":
                _w_AcVsPro = System.Xml.XmlConvert.ToDouble(reader.Value);
                break;
              case "w_setpoint":
                _w_setpoint = System.Xml.XmlConvert.ToDouble(reader.Value);
                break;
              case "w_udot":
                _w_udot = System.Xml.XmlConvert.ToDouble(reader.Value);
                break;
            }

            break;

          case System.Xml.XmlNodeType.EndElement: // end of weights
            if (reader.Name == "weights")
              do_while = false;      // end while loop

            break;
        }
      }

      normalize();    // normalize weights
    }

    /// <summary>
    /// Returns weights as XML string, such that it can be saved 
    /// in a XML file. the weigths are in each case normalized
    /// </summary>
    /// <returns></returns>
    public string getParamsAsXMLString()
    {
      normalize();    // normalize weights before saving them

      StringBuilder sb = new StringBuilder();

      sb.Append("<weights>\n");

      sb.Append(xmlInterface.setXMLTag("w_CSB", Math.Round(w_CSB, 3)));
      sb.Append(xmlInterface.setXMLTag("w_CH4", Math.Round(w_CH4, 3)));
      sb.Append(xmlInterface.setXMLTag("w_money", Math.Round(w_money, 3)));
      sb.Append(xmlInterface.setXMLTag("w_energy", Math.Round(w_energy, 3)));
      sb.Append(xmlInterface.setXMLTag("w_pH", Math.Round(w_pH, 3)));
      sb.Append(xmlInterface.setXMLTag("w_TS", Math.Round(w_TS, 3)));
      sb.Append(xmlInterface.setXMLTag("w_VFA", Math.Round(w_VFA, 3)));
      sb.Append(xmlInterface.setXMLTag("w_HRT", Math.Round(w_HRT, 3)));
      sb.Append(xmlInterface.setXMLTag("w_TAC", Math.Round(w_TAC, 3)));
      sb.Append(xmlInterface.setXMLTag("w_OLR", Math.Round(w_OLR, 3)));
      sb.Append(xmlInterface.setXMLTag("w_N", Math.Round(w_N, 3)));
      sb.Append(xmlInterface.setXMLTag("w_gasexc", Math.Round(w_gasexc, 3)));
      sb.Append(xmlInterface.setXMLTag("w_FOS_TAC", Math.Round(w_FOS_TAC, 3)));
      sb.Append(xmlInterface.setXMLTag("w_faecal", Math.Round(w_faecal, 3)));
      sb.Append(xmlInterface.setXMLTag("w_AcVsPro", Math.Round(w_AcVsPro, 3)));
      sb.Append(xmlInterface.setXMLTag("w_setpoint", Math.Round(w_setpoint, 3)));
      sb.Append(xmlInterface.setXMLTag("w_udot", Math.Round(w_udot, 3)));

      sb.Append("</weights>\n");

      return sb.ToString();
    }

    /// <summary>
    /// Prints the weights to a string, such that the string
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

      sb.Append("   ----------   weights:   ----------   \r\n");

      sb.Append(String.Format("w_CSB: {0}\t\t\t", Math.Round(w_CSB, 3)));
      sb.Append(String.Format("w_CH4: {0}\t\t\t", Math.Round(w_CH4, 3)));
      sb.Append(String.Format("w_money: {0}\t\t\t", Math.Round(w_money, 3)));
      sb.Append(String.Format("w_energy: {0}\n", Math.Round(w_energy, 3)));

      sb.Append(String.Format("w_pH: {0}\t\t\t", Math.Round(w_pH, 3)));
      sb.Append(String.Format("w_TS: {0}\t\t\t", Math.Round(w_TS, 3)));
      sb.Append(String.Format("w_VFA: {0}\t\t\t", Math.Round(w_VFA, 3)));
      sb.Append(String.Format("w_HRT: {0}\n", Math.Round(w_HRT, 3)));

      sb.Append(String.Format("w_TAC: {0}\t\t\t", Math.Round(w_TAC, 3)));
      sb.Append(String.Format("w_OLR: {0}\t\t\t", Math.Round(w_OLR, 3)));
      sb.Append(String.Format("w_N: {0}\t\t\t", Math.Round(w_N, 3)));
      sb.Append(String.Format("w_gasexc: {0}\n", Math.Round(w_gasexc, 3)));

      sb.Append(String.Format("w_FOS_TAC: {0}\t\t\t", Math.Round(w_FOS_TAC, 3)));
      sb.Append(String.Format("w_faecal: {0}\t\t\t", Math.Round(w_faecal, 3)));
      sb.Append(String.Format("w_AcVsPro: {0}\t\t\t", Math.Round(w_AcVsPro, 3)));
      sb.Append(String.Format("w_setpoint: {0}\n", Math.Round(w_setpoint, 3)));
      
      sb.Append(String.Format("w_udot: {0}\n", Math.Round(w_udot, 3)));
      
      sb.Append("   ---------- ---------- ---------- ----------   \n");

      return sb.ToString();
    }



  }
}


