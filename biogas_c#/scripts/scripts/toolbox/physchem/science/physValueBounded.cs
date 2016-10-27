/**
 * This file is part of the partial class physValueBounded and contains
 * the rest of the class, which is not located in seperate files.
 * 
 * TODOs:
 * - TODOs with XML file
 * 
 * Except for that FINISHED!
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
  /// Furthermore you can set lower and upper bounds for the value, which can be checked.
  /// 
  /// All methods in this class are const, as defined in C++, except stated otherwise
  /// 
  /// </remarks>
  public partial class physValueBounded : physValue
  {
    // -------------------------------------------------------------------------------------
    //                         !!! FURTHER PUBLIC METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// Creates a copy of the current <typeparamref name="physValueBounded"/> object and returns the copy.
    /// </summary>
    /// <returns>
    /// The copy of the current object.
    /// </returns>
    public new physValueBounded copy() // const
    {
      return new physValueBounded(this);
    }

    /// <summary>
    /// Converts this physValueBounded to the given <paramref name="unit"/>. const method
    /// </summary>
    /// <param name="unit">unit to which is converted</param>
    /// <returns>new physValueBounded measured in given unit</returns>
    public new physValueBounded convertUnit(string unit) // const
    {
      return new physValueBounded(base.convertUnit(unit));
    }

    /// <summary>
    /// Returns the params of the object as XML string, such that it can be saved
    /// in a XML file
    /// 
    /// TODO: why not call it physValueBounded ???
    /// 
    /// <seealso cref="physValueBounded.getParamsFromXMLReader(ref XmlTextReader, string)"/>
    /// </summary>
    /// <returns>xml tags for physValueBounded</returns>
    override public string getParamsAsXMLString()
    {
      StringBuilder sb= new StringBuilder();

      sb.Append(String.Format("<physValue symbol= \"{0}\">\n", Symbol));

      sb.Append(xmlInterface.setXMLTag("value", Value));
      sb.Append(xmlInterface.setXMLTag("unit", Unit));
      sb.Append(xmlInterface.setXMLTag("label", Label));
      sb.Append(xmlInterface.setXMLTag("reference", Reference));
      sb.Append(xmlInterface.setXMLTag("LB", LB));
      sb.Append(xmlInterface.setXMLTag("UB", UB));

      sb.Append("</physValue>\n");

      return sb.ToString();
    }

    /// <summary>
    /// Reads the params out of the XmlTextReader and writes them in the object. 
    /// not const. Only reads one physValueBounded then returns. the 2nd parameter symbol
    /// is not read out of the xml file but must be read before out of the xml file. 
    /// 
    /// TODO: why not call it physValueBounded ???
    /// &lt;physValue symbol= "..."&gt;
    /// </summary>
    /// <param name="reader">an open xml textreader</param>
    /// <param name="symbol">symbol of the to be read physValueBounded</param>
    /// <returns>true, if physValue not empty</returns>
    override public bool getParamsFromXMLReader(ref XmlTextReader reader, string symbol)
    {
      string param= "";

      // if physValue is empty: "<physValue></physValue>", then false, else true
      bool notEmpty= false;

      _symbol= symbol;

      while (reader.Read())
      {
        switch (reader.NodeType)
        {
          case System.Xml.XmlNodeType.Element: // this knot is an element
            param= reader.Name;

            break;

          case System.Xml.XmlNodeType.Text: // text, thus value, of each element

            switch (param)
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
              case "LB":
                _lb = new physValue(System.Xml.XmlConvert.ToDouble(reader.Value), Unit);
                notEmpty= true;
                break;
              case "UB":
                _ub = new physValue(System.Xml.XmlConvert.ToDouble(reader.Value), Unit);
                notEmpty= true;
                break;
            }
            break;

          case System.Xml.XmlNodeType.EndElement:
            if (reader.Name == "physValue")
              return notEmpty;

            break;
        }
      }

      return notEmpty;
    }

    /// <summary>
    /// Sets upper bound to max and LB to -infinity.
    /// The unit is the one the object currently has.
    /// </summary>
    /// <param name="max">max value</param>
    public void setUB(double max)
    {
      _lb= new physValue(double.NegativeInfinity, Unit);
      _ub= new physValue(max, Unit);
    }
    /// <summary>
    /// Sets lower bound to min and UB to infinity. 
    /// The unit is the one the object currently has.
    /// </summary>
    /// <param name="min">min value</param>
    public void setLB(double min)
    {
      _lb= new physValue(min, Unit);
      _ub= new physValue(double.PositiveInfinity, Unit);
    }
    /// <summary>
    /// Sets boundaries of physValueBounded to min and max.
    /// The unit is the one the object currently has.
    /// </summary>
    /// <param name="min">min value</param>
    /// <param name="max">max value</param>
    public void setBounds(double min, double max)
    {
      _lb= new physValue(min, Unit);
      _ub= new physValue(max, Unit);
    }

    /// <summary>
    /// Checks if value is out of bounds
    /// </summary>
    /// <returns>true, if value is out of bounds</returns>
    public bool isOutOfBounds()
    {
      if (this < _lb || this > _ub)
        return true;
      else
        return false;
    }

    /// <summary>
    /// Throws an exception if value is out of bounds
    /// </summary>
    /// <exception cref="exception">value out of bounds</exception>
    public void printIsOutOfBounds()
    {
      if (isOutOfBounds())
      {
        throw new exception(String.Format(
                            "The value of {0} is out of bounds [{1}, {2}]: {3}= {4} {5}!",
                            Label, LB.Value, UB.Value, Symbol, Value, Unit));
      }
    }
    


  }
}


