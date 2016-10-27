/**
 * MATLAB Toolbox for Simulation, Control & Optimization of Biogas Plants
 * Copyright (C) 2014  Daniel Gaida
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
/**
* Definition of a class useful for xml connections.
* 
* TODOs:
* - none
* 
* Apart from that FINISHED!
* 
*/

using System;
using System.Collections.Generic;
using System.Text;
using science;

/**
 * The toolbox namespace contains general classes used inside the toolbox.
 */
namespace toolbox
{
  /// <summary>
  /// This class contains methods, which create xml tags for different
  /// variable types
  /// 
  /// </summary>
  public class xmlInterface
  {
    
    /// <summary>
    /// Returns the given value as integer (0, 1) as xml string, named xmlTag
    /// </summary>
    /// <param name="xmlTag">string with the name of the xml tag</param>
    /// <param name="value">boolean, returned as 0 or 1</param>
    /// <returns>xml tag &lt;xmlTag>value.ToInt32&lt;/xmlTag></returns>
    public static string setXMLTag(string xmlTag, bool value)
    {
      return String.Format("<{0}>{1}</{0}>\n", xmlTag, Convert.ToInt32(value));
    }

    /// <summary>
    /// Returns the given value of the double as xml string, named xmlTag
    /// 
    /// dependent on the value different precisions are used
    /// </summary>
    /// <param name="xmlTag">string with the name of the xml tag</param>
    /// <param name="value">a double whose value is written inside the xml tag</param>
    /// <returns>xml tag <xmlTag>value.ToString</xmlTag></returns>
    public static string setXMLTag(string xmlTag, double value)
    {
      // TODO - OK
      // Aufteilung in verschiedene Wertebereiche macht momentan kein Sinn mehr
      // bzw. wird in der convert Funktion nicht mehr genutzt
      //if (value < 1)
      //  return String.Format("<{0}>{1}</{0}>\n", xmlTag, System.Xml.XmlConvert.ToString(value));// value.ToString("0.000"));
      //else if (value > 100)
      //  return String.Format("<{0}>{1}</{0}>\n", xmlTag, System.Xml.XmlConvert.ToString(value));// value.ToString("0.0"));
      //else if (value > 999)
      //  return String.Format("<{0}>{1}</{0}>\n", xmlTag, System.Xml.XmlConvert.ToString(value));// value.ToString("0"));
      //else
        return String.Format("<{0}>{1}</{0}>\n", xmlTag, System.Xml.XmlConvert.ToString(value));// .ToString("0.00"));
    }
    /// <summary>
    /// Returns the Value of the physValue as xml string, named xmlTag
    /// </summary>
    /// <param name="xmlTag">string with the name of the xml tag</param>
    /// <param name="value">a physValue</param>
    /// <returns>xml tag &lt;xmlTag>value.Value&lt;/xmlTag></returns>
    public static string setXMLTag(string xmlTag, physValue value)
    {
      return setXMLTag(xmlTag, value.Value);
    }
    /// <summary>
    /// Returns the string &lt;value&gt; as xml string, named xmlTag
    /// </summary>
    /// <param name="xmlTag">string with the name of the xml tag</param>
    /// <param name="value">string with the value</param>
    /// <returns>xml tag &lt;xmlTag>value&lt;/xmlTag></returns>
    public static string setXMLTag(string xmlTag, string value)
    {
      return String.Format("<{0}>{1}</{0}>\n", xmlTag, value);
    }
    /// <summary>
    /// Returns the string value of the given object as xml string, named xmlTag
    /// </summary>
    /// <param name="xmlTag">string with the name of the xml tag</param>
    /// <param name="value">an object which has a ToString method</param>
    /// <returns>xml tag &lt;xmlTag>value.ToString&lt;/xmlTag></returns>
    public static string setXMLTag(string xmlTag, object value)
    {
      return String.Format("<{0}>{1}</{0}>\n", xmlTag, value.ToString());
    }
    


  }
}


