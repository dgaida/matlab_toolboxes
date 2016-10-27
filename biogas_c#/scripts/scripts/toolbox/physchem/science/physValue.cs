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
* This file is part of the partial class physValue and contains
* the rest of the class, which is not located in seperate files.
* 
* TODOs:
* - Check why CaCO3 seems to have a molar mass of 50 gCaCO3/mol and not 100 gCaCO3/mol
*   molar mass of Ca is 40. converting from HCO3 to CaCO3 would be a factor of 40.
* 
* Apart from that FINISHED!
* 
*/

using System;
using toolbox;
using System.Text;
using System.Collections;
using System.Xml;

/**
 * The science namespace collects all classes which have to do with science in general.
 * 
 */
namespace science
{
  /// <remarks>
  /// Defines a physical value, which is a double number containing a unit and a symbol.
  /// Furthermore a label describes the physical value.
  /// There are operators implemented, such that you can add, substract, multiply, ...
  /// physical values.
  /// Working with physical values assures that you do not get wrong with units
  /// and always know in which unit the value is measured. This is realised by checking
  /// the unit while adding and substracting and reduce the fraction when multiplying
  /// and dividing physical values. Furthermore you can convert units.
  /// 
  /// You can define a reference for the physical value, e.g. when you save a number 
  /// which you have from literature or a database.
  /// 
  /// All methods in this class are const, as defined in C++, except stated otherwise
  /// 
  /// </remarks>
  public partial class physValue
  {

    // -------------------------------------------------------------------------------------
    //                              !!! PUBLIC METHODS !!!
    // -------------------------------------------------------------------------------------

    // -------------------------------------------------------------------------------------
    //                              !!! GET METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// Returns the unit of the physical value, either surrounded by square brackets or not
    /// </summary>
    /// <param name="addBrackets">
    /// If true, then surround unit with square brackets, else not
    /// </param>
    /// <param name="format_for_output">
    /// if true, then replace stuff in the unit, e.g.: ^3 -> ³, ^2 -> ², ...
    /// </param>
    /// <returns>
    /// The unit of the physical value, either surrounded by square brackets or not
    /// </returns>
    public string getUnit(bool addBrackets, bool format_for_output) // const
    {
      string unit= this.Unit;

      if (format_for_output)
      {
        unit= unit.Replace("^3", "³");
        unit= unit.Replace("^2", "²");
      }

      if (addBrackets)
        return "[" + unit + "]";
      else
        return unit;
    }
    /// <summary>
    /// Returns the unit of the physical value, either surrounded by square brackets or not
    /// </summary>
    /// <param name="addBrackets">
    /// If true, then surround unit with square brackets, else not
    /// </param>
    /// <returns>
    /// The unit of the physical value, either surrounded by square brackets or not
    /// </returns>
    public string getUnit(bool addBrackets) // const
    {
      return getUnit(addBrackets, false);
    }

    /// <summary>
    /// get unit without special characters such as ^, /, [], 
    /// </summary>
    /// <returns>unit without special characters</returns>
    public string getUnit_wo_sp_ch() // const
    {
      string unit= this.Unit;

      unit= unit.Replace("^", "");
      unit= unit.Replace("/", "_");
      unit= unit.Replace("%", "pph");
      unit= unit.Replace("-", "");
      unit= unit.Replace("(", "");
      unit= unit.Replace(")", "");
      unit = unit.Replace("[", "");
      unit = unit.Replace("]", "");
      unit = unit.Replace("€", "Euro");
      unit= unit.Replace("*", "");
      unit= unit.Replace("+", "_");
      unit= unit.Replace("-", "_");
      unit= unit.Replace(" ", "_");

      return unit;
    }

    /// <summary>
    /// get symbol without special characters such as ^, /, [], 
    /// </summary>
    /// <returns></returns>
    public string getSymbol_wo_sp_ch() // const
    {
      string symbol= this.Symbol;

      symbol= symbol.Replace("^", "");
      symbol= symbol.Replace("/", "_");
      symbol= symbol.Replace("%", "pph");
      symbol= symbol.Replace("-", "");
      symbol= symbol.Replace("(", "");
      symbol= symbol.Replace(")", "");
      symbol = symbol.Replace("[", "");
      symbol = symbol.Replace("]", "");
      symbol = symbol.Replace("€", "Euro");
      symbol= symbol.Replace("*", "");
      symbol= symbol.Replace("+", "");
      symbol= symbol.Replace("-", "");
      symbol= symbol.Replace(" ", "_");

      return symbol;
    }

    /// <summary>
    /// Returns the default unit of the given symbol, without square brackets
    /// </summary>
    /// <param name="symbol">symbol of a physValue</param>
    /// <returns>default unit of symbol</returns>
    public static string getDefaultUnit(string symbol) // const
    {
      return getDefaultUnit(symbol, false);
    }
    /// <summary>
    /// Returns the default unit of the given symbol
    /// </summary>
    /// <param name="symbol">symbol of a physValue</param>
    /// <param name="addBrackets">
    /// If true, then surround unit with square brackets, else not
    /// </param>
    /// <returns>default unit of symbol</returns>
    public static string getDefaultUnit(string symbol, bool addBrackets) // const
    {
      string dummy;
      string unit;

      physValue.getLabelAndUnit(symbol, out dummy, out unit);

      if (addBrackets)
        unit= "[" + unit + "]";

      return unit;
    }



    /// <summary>
    /// get values of a physValue array as double array
    /// </summary>
    /// <param name="inputs">array of physValues</param>
    /// <returns>double values of physValue array</returns>
    public static double[] getValues(physValue[] inputs) // const
    { 
      double[] values= new double[inputs.Length];

      for(int iel= 0; iel < inputs.Length; iel++)
      {
        values[iel]= inputs[iel].Value;
      }

      return values;
    }

   

    // -------------------------------------------------------------------------------------
    //                         !!! FURTHER PUBLIC METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// Creates a copy of the current object and returns the copy.
    /// </summary>
    /// <returns>
    /// The copy of the current object.
    /// </returns>
    public physValue copy() // const
    {
      return new physValue(this);
    }

    /// <summary>
    /// Converts this physValue to the given unit. const method
    /// 
    /// TODO: erweitern um KOnvertierung für d, h, min, ...
    /// </summary>
    /// <param name="unit">a unit to convert to, without square brackets</param>
    /// <returns>
    /// copy of this physValue where the value is measured in the given unit
    /// </returns>
    /// <exception cref="exception">Conversion error</exception>
    /// <exception cref="exception">Unknown unit</exception>
    public physValue convertUnit(string unit) // const
    {
      physValue myValue= new physValue(this);

      if (myValue.Unit == unit)
        return myValue;

      // used to reset the symbol and label at the end of the function
      string symbol= myValue.Symbol;
      string label = myValue.Label;

      switch (myValue.Unit)
      {
      
        case "gCOD/l":
        case "kgCOD/m^3":

          switch (unit)
          {
            case "gCOD/l":
            case "kgCOD/m^3":
              // do nothing
              break;

            case "mmol/l":
            case "mol/m^3":
              myValue= 1000 * myValue.convertUnit("mol/l");
              break;

            case "mol/l":
            case "kmol/m^3":
              myValue= myValue.convertFrom_kgCODm3_To_mol_l();
              break;

            case "g/l":
              myValue= myValue.convertUnit("mol/l");
              myValue= myValue.convertFrom_mol_l_To_g_l();
              break;

            case "mg/l":
              myValue= 1000 * myValue.convertUnit("g/l");
              break;

            case "µg/l":
              myValue= 1e6  * myValue.convertUnit("g/l");
              break;

            case "ng/l":
              myValue= 1e9  * myValue.convertUnit("g/l");
              break;

            default:
              throw new exception( String.Format("Cannot convert from {0} to {1}!", 
                                   myValue.Unit, unit) );
              
          }

          // we set the unit manually, assuming no error is done above
          // we could also do a conversion where the unit comes out nicely
          // but then we can not put "equal" units in one case as done above
          myValue._unit= unit;    
          
          break;

        case "mol/l":
        case "kmol/m^3":

          switch (unit)
          {
            case "mol/l":
            case "kmol/m^3":
              // do nothing
              break;

            case "mmol/l":
            case "mol/m^3":
              myValue= 1000 * myValue.convertUnit("mol/l");
              break;

            case "µmol/l":
            case "mmol/m^3":
              myValue = 1e6 * myValue.convertUnit("kmol/m^3");
              break;

            case "gCOD/l":
            case "kgCOD/m^3":
              myValue= myValue.convertFrom_mol_l_To_kgCODm3();
              break;
              
            case "g/l":
              myValue= myValue.convertFrom_mol_l_To_g_l();
              break;

            case "mg/l":
              myValue= 1000 * myValue.convertUnit("g/l");
              break;

            case "µg/l":
              myValue= 1e6  * myValue.convertUnit("g/l");
              break;

            case "ng/l":
              myValue= 1e9  * myValue.convertUnit("g/l");
              break;

            case "gCaCO3eq/l": // g CaCO3 equivalents / l
              // TODO: why 50 gCaCO3/mol, should be 100 gCaCO3/mol
              // 40 + 12 + 3 * 16 = 100 
              // CaCO3 has an equivalent weight of 50, see wikipedia for
              // equivalent weight, maybe this is the reason
              myValue= 50  * myValue; // 50 gCaCO3/mol
              break;
              
            case "mgCaCO3eq/l": // mg CaCO3 equivalents / l
              myValue= 1e3 * myValue.convertUnit("gCaCO3eq/l");
              break;
              
            case "gHAceq/l": // g HAc equivalents / l
              myValue= biogas.chemistry.get_mol_mass_of("Sac") * myValue; // 60 gHAceq/mol
              break;
              
            case "mgHAceq/l": // mg HAc equivalents / l
              myValue= 1e3 * myValue.convertUnit("gHAceq/l");
              break;
              
            default:
              throw new exception( String.Format("Cannot convert from {0} to {1}!", 
                                   myValue.Unit, unit) );
              
          }

          myValue._unit= unit;
          
          break;

        case "mmol/l":
        case "mol/m^3":

          switch (unit)
          {
            case "mmol/l":
            case "mol/m^3":
              // do nothing
              break;

            case "mol/l":
            case "kmol/m^3":
              myValue= 1e-3 * myValue.convertUnit("mmol/l");
              break;

            case "µmol/l":
              myValue = 1000 * myValue.convertUnit("mmol/l");
              break;

            default:
              throw new exception(String.Format("Cannot convert from {0} to {1}!",
                                   myValue.Unit, unit));

          }

          myValue._unit = unit;

          break;

        case "g/l":
        case "kg/m^3":

          switch (unit)
          {
            case "g/l":
            case "kg/m^3":
              // do nothing
              break;

            case "mg/l":
              myValue= 1000 * myValue.convertUnit("g/l");
              break;

            case "µg/l":
              myValue= 1e6  * myValue.convertUnit("g/l");
              break;

            case "ng/l":
              myValue= 1e9  * myValue.convertUnit("g/l");
              break;

            case "mol/l":
            case "kmol/m^3":
              myValue= myValue.convertFrom_g_l_To_mol_l();
              break;

            case "mmol/l":
              myValue= 1000 * myValue.convertUnit("mol/l");
              break;

            case "gCOD/l":
            case "kgCOD/m^3":
              myValue= myValue.convertUnit("mol/l");
              myValue= myValue.convertFrom_mol_l_To_kgCODm3();
              break;

            case "g/m^3":
              myValue= 1e3 * myValue.convertUnit("g/l");
              break;
                          
            default:
              throw new exception( String.Format("Cannot convert from {0} to {1}!", 
                                   myValue.Unit, unit) );
          }

          myValue._unit= unit;
          
          break;

        case "g/m^3":
        case "mg/l":

          switch (unit)
          {
            case "g/m^3":
            case "mg/l":
              // do nothing
              break;

            case "kg/m^3":
            case "g/l":
              myValue= 1e-3 * myValue.convertUnit("g/m^3");
              break;

            case "mol/l":
            case "kmol/m^3":
              myValue= myValue.convertUnit("g/l");
              myValue= myValue.convertFrom_g_l_To_mol_l();
              break;

            case "mmol/l":
              myValue= 1000 * myValue.convertUnit("mol/l");
              break;

            case "gCOD/l":
            case "kgCOD/m^3":
              myValue= myValue.convertUnit("mol/l");
              myValue= myValue.convertFrom_mol_l_To_kgCODm3();
              break;

            default:
              throw new exception(String.Format("Cannot convert from {0} to {1}!",
                                   myValue.Unit, unit));
          }

          myValue._unit= unit;
          
          break;

        case "ng/l":

          switch (unit)
          {
            case "mg/l":
              myValue= 1e-6 * myValue;
              break;

            default:
              myValue= myValue.convertUnit("mg/l");
              myValue= myValue.convertUnit(unit);
              break;
          }
                    
          myValue._unit= unit;

          break;

        case "m^3/h":

          switch (unit)
          {
            case "m^3/h":
              // do nothing
              break;

            case "m^3/d":
              myValue= 24 * myValue.convertUnit("m^3/h");
              break;

            default:
              throw new exception(String.Format("Cannot convert from {0} to {1}!",
                                   myValue.Unit, unit));
          }

          myValue._unit= unit;

          break;

        case "l/g":
        case "m^3/kg":    // e.g. m^3 gas / kg substrate

          switch (unit)
          {
            case "l/g":
            case "m^3/kg":
              // do nothing
              break;

            case "ml/g":
              myValue = 1e3 * myValue.convertUnit("l/g");
              break;

            case "m^3/g":
              myValue= 1e-3 * myValue.convertUnit("m^3/kg");
              break;

            default:
              throw new exception(String.Format("Cannot convert from {0} to {1}!",
                                   myValue.Unit, unit));
          }

          myValue._unit= unit;

          break;

        case "% TS":
        
          switch (unit)
          {
            case "% TS":
              // do nothing
              break;

            case "100 %":
              myValue= myValue / 100;
              break;

            default:
              throw new exception(String.Format("Cannot convert from {0} to {1}!",
                                   myValue.Unit, unit));
          }

          myValue._unit= unit;
          
          break;

        case "% FM":

          switch (unit)
          {
            case "% FM":
              // do nothing
              break;

            case "g/kg":
              myValue= 10 * myValue;
              break;
            case "100 %":
              myValue= myValue / 100;
              break;

            default:
              throw new exception(String.Format("Cannot convert from {0} to {1}!",
                                   myValue.Unit, unit));
          }

          myValue._unit= unit;

          break;

        case "kWh/d":

          switch (unit)
          { 
            case "kW":    // kWh/d * 1d/24 h= kW
              myValue= myValue / 24;
              break;

            case "W":
              myValue= 1000 * myValue.convertUnit("kW");
              break;

            default:
              throw new exception( String.Format("Cannot convert from {0} to {1}!", 
                                   myValue.Unit, unit));
          }

          myValue._unit= unit;
          
          break;

        case "W":

          switch (unit)
          {
            case "kWh/d":    // 24 h/d * kW = 24 kWh/d
              myValue= myValue.convertUnit("kW") * 24;
              break;

            case "kW":
              myValue= myValue / 1000;
              break;

            default:
              throw new exception(String.Format("Cannot convert from {0} to {1}!",
                                   myValue.Unit, unit));
          }

          myValue._unit= unit;
          
          break;

        case "kW":

          switch (unit)
          {
            case "kWh/d":    // 24 h/d * kW = 24 kWh/d
              myValue= myValue * 24;
              break;

            case "W":
              myValue= myValue * 1000;
              break;

            default:
              throw new exception(String.Format("Cannot convert from {0} to {1}!",
                                   myValue.Unit, unit));
          }

          myValue._unit= unit;

          break;

        case "MJ/m^3":
        case "MWs/m^3":

          switch (unit)
          {
            case "MJ/m^3":
            case "MWs/m^3":
              // do nothing
              break;

            case "MWh/m^3":
              myValue= myValue / 3600; // Ws * 1 h/3600 s
              break;

            case "kWh/m^3":
              myValue= myValue.convertUnit("kJ/m^3");
              myValue= myValue / 3600; // Ws * 1 h/3600 s
              break;

            case "kJ/m^3":
            case "kWs/m^3":
              myValue= 1000 * myValue;
              break;

            default:
              throw new exception( String.Format("Cannot convert from {0} to {1}!", 
                                   myValue.Unit, unit));
          }

          myValue._unit= unit; 
          
          break;

        case "100 %":

          switch (unit)
          { 
            case "%":
              myValue= 100 * myValue;
              break;

            // used by acetic vs propionic acid sensor, such that unit is set back to
            // mol/mol again
            case "mol/mol":
              break;

            case "% FM":
              myValue= 100 * myValue;
              break;

            case "% TS":
              myValue= 100 * myValue;
              break;

            default:
              throw new exception(String.Format("Cannot convert from {0} to {1}!", 
                                  myValue.Unit, unit));
          }

          myValue._unit= unit;
          
          break;

        case "°C":

          switch (unit)
          {
            case "K":
              myValue= myValue + new physValue(273.15, "°C");
              break;

            default:
              throw new exception(String.Format("Cannot convert from {0} to {1}!",
                                  myValue.Unit, unit));
          }

          myValue._unit= unit;
          
          break;

        case "K":

          switch (unit)
          {
            case "°C":
              myValue= myValue - new physValue(273.15, "K");
              break;

            default:
              throw new exception(String.Format("Cannot convert from {0} to {1}!",
                                  myValue.Unit, unit));
          }

          myValue._unit= unit;
          
          break;

        case "µbar":

          switch (unit)
          {
            case "mbar":
              myValue= 1e-3 * myValue;
              break;
            case "bar":
              myValue= 1e-6 * myValue;
              break;

            default:
              throw new exception(String.Format("Cannot convert from {0} to {1}!",
                                  myValue.Unit, unit));
          }

          myValue._unit= unit;

          break;

        case "mbar":

          switch (unit)
          {
            case "µbar":
              myValue= 1e3 * myValue;
              break;
            case "bar":
              myValue= 1e-3 * myValue;
              break;

            default:
              throw new exception(String.Format("Cannot convert from {0} to {1}!",
                                  myValue.Unit, unit));
          }

          myValue._unit= unit;

          break;

        case "bar":

          switch (unit)
          {
            case "µbar":
              myValue = 1e6 * myValue;
              break;
            case "mbar":
              myValue = 1e3 * myValue;
              break;

            default:
              throw new exception(String.Format("Cannot convert from {0} to {1}!",
                                  myValue.Unit, unit));
          }

          myValue._unit = unit;

          break;

        case "kJ/(m^3 * K)":
        case "kJ/(K * m^3)":
        case "kWs/(m^3 * K)":
        case "kWs/(K * m^3)":

          switch (unit)
          {
            case "kJ/(m^3 * K)":
            case "kJ/(K * m^3)":
            case "kWs/(m^3 * K)":
            case "kWs/(K * m^3)":
              // do nothing
              break;

            case "kWh/(m^3 * K)":    // kWs * 1h/3600 s= kWh / 3600
              myValue = myValue / 3600;
              break;

            default:
              throw new exception(String.Format("Cannot convert from {0} to {1}!",
                                   myValue.Unit, unit));
          }

          myValue._unit = unit;

          break;

        default:
          throw new exception(String.Format("Unknown unit of {0}: {1}! Tried to convert to: {2}.", 
                                            myValue.print(), myValue.Unit, unit));

      }

      myValue.Symbol= symbol;
      myValue.Label= label;
      
      return myValue;
    }

    /// <summary>
    /// Returns the params of the object as XML string, such that it can be saved
    /// in a XML file
    /// </summary>
    /// <returns>a string with xml tags for physValue</returns>
    virtual public string getParamsAsXMLString() // const
    {
      StringBuilder sb= new StringBuilder();

      sb.Append(String.Format("<physValue symbol= \"{0}\">\n", Symbol));

      sb.Append(xmlInterface.setXMLTag("value", Value));
      sb.Append(xmlInterface.setXMLTag("unit", Unit));
      sb.Append(xmlInterface.setXMLTag("label", Label));
      sb.Append(xmlInterface.setXMLTag("reference", Reference));
      
      sb.Append("</physValue>\n");

      return sb.ToString();
    }

    /// <summary>
    /// Reads the params out of the XmlTextReader and writes them in the object. 
    /// not const. Only reads one physValue then returns. the 2nd parameter symbol
    /// is not read out of the xml file but must be read before out of the xml file. 
    /// &lt;physValue symbol= "..."&gt;
    /// </summary>
    /// <param name="reader">an open xml textreader</param>
    /// <param name="symbol">symbol of the to be read physValue</param>
    /// <returns>true on success else false, false means, that physValue is empty
    /// </returns>
    virtual public bool getParamsFromXMLReader(ref XmlTextReader reader, string symbol)
    {
      string param= "";

      // if physValue is empty: "<physValue></physValue>", then false, else true
      bool notEmpty= false;

      Symbol= symbol;
      
      while (reader.Read())
      {
        switch (reader.NodeType)
        {
          case System.Xml.XmlNodeType.Element: // this knot is an element
            param= reader.Name; // e.g. value, unit, label, ...

            break;

          case System.Xml.XmlNodeType.Text: // text, thus value, of each element

            switch(param)
            {
              case "value":
                _value = System.Xml.XmlConvert.ToDouble(reader.Value);//Convert.ToDouble(reader.Value);
                notEmpty= true;
                break;
              case "unit":
                _unit= reader.Value;
                notEmpty= true;
                break;
              case "label":
                _label= reader.Value;
                notEmpty= true;
                break;
              case "reference":
                _reference= reader.Value;
                notEmpty= true;
                break;
            }
            break;

          case System.Xml.XmlNodeType.EndElement: // end of node </...>
            if (reader.Name == "physValue")
              return notEmpty;

            break;
        }
      }

      return notEmpty;
    }

    /// <summary>
    /// Print physValue to a string, which is returned. The value is printed with two digits.
    /// </summary>
    /// <returns>Label: Symbol= 0.60 unit</returns>
    public string print() // const
    {
      return print("0.00");
    }
    /// <summary>
    /// Print physValue to a string, which is returned
    /// </summary>
    /// <param name="delimiter">e.g. "0.00"</param>
    /// <returns>Label: Symbol= 0.6 unit</returns>
    public string print(string delimiter) // const
    {
      return String.Format("{0}: {1}= {2} {3}", Label, Symbol,
                           Value.ToString(delimiter), Unit);
    }
    /// <summary>
    /// Prints the value (2 digits accuracy) and unit of the physValue to a string
    /// </summary>
    /// <returns>0.60 unit</returns>
    public string printValue() // const
    {
      return printValue("0.00", false);
    }
    /// <summary>
    /// Prints the value and unit of the physValue to a string
    /// </summary>
    /// <param name="delimiter">
    /// e.g. "0.00", defines the accuracy of the returned value in the string
    /// </param>
    /// <returns>0.60 unit</returns>
    public string printValue(string delimiter) // const
    {
      return printValue(delimiter, false);
    }
    /// <summary>
    /// Prints the value (2 digits accuracy) and unit of the physValue to a string
    /// </summary>
    /// <param name="addBrackets">if true, then add brackets else not</param>
    /// <returns>0.60 unit</returns>
    public string printValue(bool addBrackets) // const
    {
      return printValue("0.00", addBrackets);
    }
    /// <summary>
    /// Prints the value and unit of the physValue to a string
    /// </summary>
    /// <param name="delimiter">
    /// e.g. "0.00", defines the accuracy of the returned value in the string
    /// </param>
    /// <param name="addBrackets">if true, then add brackets else not</param>
    /// <returns>0.60 unit</returns>
    public string printValue(string delimiter, bool addBrackets) // const
    {
      return String.Format("{0} {1}", Value.ToString(delimiter), 
                                      getUnit(addBrackets, true));
    }

    /// <summary>
    /// print symbol followed by a space and unit in brackets
    /// </summary>
    /// <returns>symbol [unit]</returns>
    public string printSymbolUnit() // const
    {
      return String.Format("{0} {1}", Symbol, getUnit(true, true));
    }

  }
}


