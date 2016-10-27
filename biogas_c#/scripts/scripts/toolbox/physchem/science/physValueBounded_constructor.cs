/**
 * This file is part of the partial class physValueBounded and defines
 * the constructors of the class.
 * 
 * TODOs:
 * 
 * FINISHED!
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
  /// Furthermore you can set lower and upper bounds for the value, which can be checked.
  /// 
  /// All methods in this class are const, as defined in C++, except stated otherwise
  /// 
  /// </remarks>
  public partial class physValueBounded : physValue
  {

    // -------------------------------------------------------------------------------------
    //                              !!! CONSTRUCTOR METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// constructor with all parameters
    /// </summary>
    /// <param name="symbol">
    /// symbol of the physical value, such as m for mass, T for temperature, ...
    /// </param>
    /// <param name="value">
    /// value of the physical value
    /// </param>
    /// <param name="unit">
    /// unit of the physical value, without rectangular brackets
    /// </param>
    /// <param name="label">
    /// label of the physical value, such as temperature, mass, ...
    /// </param>
    /// <param name="reference">
    /// reference for a physical value gotten out of literature, or from plants
    /// </param>
    /// <param name="lb">
    /// lower boundary of the physical value
    /// </param>
    /// <param name="ub">
    /// upper boundary of the physical value
    /// </param>
    public physValueBounded(string symbol, double value, string unit, string label,
                            string reference, physValue lb, physValue ub) :
                            base(symbol, value, unit, label, reference)
    {
      _lb= lb;
      _ub= ub;
    }
    /// <summary>
    /// constructor with no upper boundary
    /// </summary>
    /// <param name="symbol">
    /// symbol of the physical value, such as m for mass, T for temperature, ...
    /// </param>
    /// <param name="value">
    /// value of the physical value
    /// </param>
    /// <param name="unit">
    /// unit of the physical value, without rectangular brackets
    /// </param>
    /// <param name="label">
    /// label of the physical value, such as temperature, mass, ...
    /// </param>
    /// <param name="reference">
    /// reference for a physical value gotten out of literature, or from plants
    /// </param>
    /// <param name="lb">
    /// lower boundary of the physical value
    /// </param>
    public physValueBounded(string symbol, double value, string unit, string label,
                            string reference, physValue lb) :
      this(symbol, value, unit, label, reference, lb, 
           new physValue(double.PositiveInfinity, unit))
    {}
    /// <summary>
    /// Unbounded physical value, same as physValue
    /// </summary>
    /// <param name="symbol">
    /// symbol of the physical value, such as m for mass, T for temperature, ...
    /// </param>
    /// <param name="value">
    /// value of the physical value
    /// </param>
    /// <param name="unit">
    /// unit of the physical value, without rectangular brackets
    /// </param>
    /// <param name="label">
    /// label of the physical value, such as temperature, mass, ...
    /// </param>
    /// <param name="reference">
    /// reference for a physical value gotten out of literature, or from plants
    /// </param>
    public physValueBounded(string symbol, double value, string unit, string label,
                            string reference) :
      this(symbol, value, unit, label, reference, 
           new physValue(double.NegativeInfinity, unit), 
           new physValue(double.PositiveInfinity, unit))
    {}
    /// <summary>
    /// constructor with no reference
    /// </summary>
    /// <param name="symbol">
    /// symbol of the physical value, such as m for mass, T for temperature, ...
    /// </param>
    /// <param name="value">
    /// value of the physical value
    /// </param>
    /// <param name="unit">
    /// unit of the physical value, without rectangular brackets
    /// </param>
    /// <param name="label">
    /// label of the physical value, such as temperature, mass, ...
    /// </param>
    public physValueBounded(string symbol, double value, string unit, string label) : 
                            base(symbol, value, unit, label)
    {}
    /// <summary>
    /// constructor with no reference, label gotten via symbol
    /// </summary>
    /// <param name="symbol">
    /// symbol of the physical value, such as m for mass, T for temperature, ...
    /// </param>
    /// <param name="value">
    /// value of the physical value
    /// </param>
    /// <param name="unit">
    /// unit of the physical value, without rectangular brackets
    /// </param>
    public physValueBounded(string symbol, double value, string unit) : 
                            base(symbol, value, unit)
    {}
    /// <summary>
    /// constructor useful for temporary variables, only value and unit is defined
    /// </summary>
    /// <param name="value">
    /// value of the physical value
    /// </param>
    /// <param name="unit">
    /// unit of the physical value, without rectangular brackets
    /// </param>
    public physValueBounded(double value, string unit) : base(value, unit)
    {}
    /// <summary>
    /// constructor with no reference, label and unit gotten via symbol
    /// </summary>
    /// <param name="symbol">
    /// symbol of the physical value, such as m for mass, T for temperature, ...
    /// </param>
    /// <param name="value">
    /// value of the physical value
    /// </param>
    [Obsolete("Not save because you do not know in beforehand in which unit <value> is measured")]
    public physValueBounded(string symbol, double value) : base(symbol, value)
    {}
    /// <summary>
    /// constructor with no reference, label and unit gotten via symbol, value= 0
    /// </summary>
    /// <param name="symbol">
    /// symbol of the physical value, such as m for mass, T for temperature, ...
    /// </param>
    public physValueBounded(string symbol) : base(symbol)
    {}
    /// <summary>
    /// standard constructor, everything default
    /// </summary>
    public physValueBounded() : base()
    {}
    /// <summary>
    /// constructor used to copy physValueBoundeds, the returned physValueBounded 
    /// is identical to the template
    /// </summary>
    /// <param name="template">template</param>
    public physValueBounded(physValueBounded template) : base(template)
    {
      _lb=        template.LB;
      _ub=        template.UB;
    }
    /// <summary>
    /// constructor used to copy physValus, the returned physValueBounded 
    /// is identical to the template. Just adds boundaries at pos. and negative
    /// infinity.
    /// </summary>
    /// <param name="template">template</param>
    public physValueBounded(physValue template) : base(template)
    {
      _lb= new physValue(double.NegativeInfinity, Unit);
      _ub= new physValue(double.PositiveInfinity, Unit);
    }

    /// <summary>
    /// constructor used to copy physValus, the returned physValueBounded 
    /// is identical to the template. Just adds boundaries at lb and ub
    /// </summary>
    /// <param name="template">template</param>
    /// <param name="lb">lower boundary of the new physValueBounded</param>
    /// <param name="ub">upper boundary of the new physValueBounded</param>
    public physValueBounded(physValue template, double lb, double ub)
      : base(template)
    {
      _lb = new physValue(lb, Unit);
      _ub = new physValue(ub, Unit);
    }

  }
}


