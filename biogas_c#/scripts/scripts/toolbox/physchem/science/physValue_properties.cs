/**
 * This file is part of the partial class physValue and defines
 * the fields and properties of the class.
 * 
 * TODOs: 
 * - try to delete the public set access of Value
 * 
 * Apart from that FINISHED!
 * 
 */

using System;
using toolbox;
using System.Text;
using System.Collections;

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
    //                            !!! PRIVATE FIELDS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// symbol of the physical value, such as m for mass, T for temperature, ...
    /// protected, such that it can be changed from subclasses (physValueBounded)
    /// </summary>
    protected string _symbol= "";

    /// <summary>
    /// unit of the physical value, without rectangular brackets
    /// protected, such that it can be changed from subclasses (physValueBounded)
    /// </summary>
    protected string _unit= "";

    /// <summary>
    /// value of the physical value
    /// protected, such that it can be changed from subclasses (physValueBounded)
    /// </summary>
    protected double _value= 0;

    /// <summary>
    /// label of the physical value, such as temperature, mass, ...
    /// protected, such that it can be changed from subclasses (physValueBounded)
    /// </summary>
    protected string _label= "";

    /// <summary>
    /// reference for a physical value gotten out of literature, or from plants
    /// protected, such that it can be changed from subclasses (physValueBounded)
    /// </summary>
    protected string _reference= "";

    

    // -------------------------------------------------------------------------------------
    //                              !!! PROPERTIES !!!
    // -------------------------------------------------------------------------------------
        
    /// <summary>
    /// symbol of the physical value, such as m for mass, T for temperature, ...
    /// </summary>
    public string Symbol
    {
      get { return _symbol; }

      set 
      { 
        _symbol= value;

        string dummy;
        string label;

        // sets the label corresponding to the symbol, if the label could be found
        physValue.getLabelAndUnit(_symbol, out label, out dummy);

        if (label != "")
          _label= label;
      }
    }
        
    /// <summary>
    /// unit of the physical value, without rectangular brackets
    /// </summary>
    public string Unit
    {
      get { return _unit; }
    }

    // Versuch direkt mit chars in MATLAB zu arbeiten, funktioniert so nicht
    //public char[] cUnit
    //{
    //  get { return _unit.ToCharArray(); }
    //}

    /// <summary>
    /// value of the physical value
    /// </summary>
    public double Value
    {
      get { return _value; }
      // TODO: try to delete the public set access of Value
      //[Obsolete("Trying to delete this method")]
      set { _value= value; }
    }

    /// <summary>
    /// label of the physical value, such as temperature, mass, ...
    /// </summary>
    public string Label
    {
      get { return _label; }
      set { _label= value; }
    }

    /// <summary>
    /// reference for a physical value gotten out of literature, or from plants
    /// </summary>
    public string Reference
    {
      get { return _reference; }
    }

    

  }
}


