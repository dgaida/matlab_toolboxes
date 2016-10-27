/**
 * This file is part of the partial class physValue and defines
 * the operators.
 * 
 * TODOs:
 * - the ==, !=, <=, >= methods compare double values, which shouldn't be used
 * to compare double values
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
    //                              !!! OPERATOR METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// Returns v1 + v2. Throws an error if units are not the same
    /// </summary>
    /// <param name="v1">first physValue</param>
    /// <param name="v2">2nd physValue</param>
    /// <returns>v1 + v2</returns>
    /// <exception cref="exception">unit mismatch</exception>
    public static physValue operator+(physValue v1, physValue v2)
    {
      if (v1.Unit != v2.Unit)
      {
        throw new exception( String.Format( 
                  "Cannot add! The units of both summands ({0} and {1}) are not equal: {2} != {3}!", 
                  v1.Symbol, v2.Symbol, v1.Unit, v2.Unit ) );
      }

      return new physValue( v1.Symbol + " + " + v2.Symbol, 
                            v1.Value      +     v2.Value, 
                            v1.Unit, 
                            v1.Label  + " + " + v2.Label );
    }

    /// <summary>
    /// Returns v1 - v2. Throws an error if units are not the same.
    /// </summary>
    /// <param name="v1">1st physValue</param>
    /// <param name="v2">2nd physValue</param>
    /// <returns>v1 - v2</returns>
    /// <exception cref="exception">unit mismatch</exception>
    public static physValue operator-(physValue v1, physValue v2)
    {
      if (v1.Unit != v2.Unit)
      {
        throw new exception( String.Format(
              "Cannot substract! The units of both minuends are not equal: {0} != {1}!", 
              v1.Unit, v2.Unit) );
      }

      return new physValue( v1.Symbol + " - " + v2.Symbol,
                            v1.Value      -     v2.Value,
                            v1.Unit,
                            v1.Label  + " - " + v2.Label );
    }

    /// <summary>
    /// unary minus: Returns -v
    /// </summary>
    /// <param name="v">v</param>
    /// <returns>-v</returns>
    public static physValue operator-(physValue v)
    {
      physValue v_new= new physValue(v);

      v_new._value= -v.Value;
      
      return v_new;
    }

    /// <summary>
    /// Returns v1 * v2
    /// </summary>
    /// <param name="v1">1st</param>
    /// <param name="v2">2nd</param>
    /// <returns>v1 * v2</returns>
    public static physValue operator*(double v1, physValue v2)
    {
      return new physValue( String.Format("{0} * ", v1) + v2.Symbol,
                            v1 * v2.Value,
                            v2.Unit,
                            String.Format("{0} * ( {1} )", v1, v2.Label) );
    }
    /// <summary>
    /// Returns v1 * v2
    /// </summary>
    /// <param name="v2">v2</param>
    /// <param name="v1">v1</param>
    /// <returns>v1 * v2</returns>
    public static physValue operator*(physValue v2, double v1)
    {
      return v1 * v2;
    }

    /// <summary>
    /// Returns v1 * v2
    /// </summary>
    /// <param name="v1">1st</param>
    /// <param name="v2">2nd</param>
    /// <returns>v1 * v2</returns>
    public static physValue operator*(physValue v1, physValue v2)
    {
      // split the units in numerator and denominator
      string[] result_a= v1.Unit.Split('/');
      string[] result_b= v2.Unit.Split('/');

      // default unit is 1/1, e.g. if there is no denominator
      // 1st element for v1 and 2nd for v2
      string[] numerator= {"1", "1"};
      string[] denominator= {"1", "1"};

      // there is always a numerator
      numerator[0]= result_a[0];
      numerator[1]= result_b[0];

      if (result_a.Length > 1)
        denominator[0]= result_a[1];

      if (result_b.Length > 1)
        denominator[1]= result_b[1];

      // reduce the fraction
      string unit= reduceFraction(numerator, denominator);

      return new physValue( v1.Symbol + " * " + v2.Symbol,
                            v1.Value * v2.Value,
                            unit,
                            String.Format("( {0} ) * ( {1} )", 
                            v1.Label, v2.Label) );
    }

    /// <summary>
    /// Returns v1 / v2
    /// </summary>
    /// <param name="v1">numerator</param>
    /// <param name="v2">denominator</param>
    /// <returns>v1 / v2</returns>
    /// <exception cref="exception">division by zero</exception>
    public static physValue operator /(double v1, physValue v2)
    {
      if (v2.Value == 0)
        throw new exception("Division by zero");

      // split the units in numerator and denominator
      string[] result= v2.Unit.Split('/');

      string unit= "";

      if (result.Length > 1)
        unit= String.Format("{0} / {1}", result[1], result[0]);
      else
        unit= String.Format("1 / {0}", result[0]);

      return new physValue( String.Format("{0} / ", v1) + v2.Symbol,
                            v1 / v2.Value,
                            unit,
                            String.Format("( {0} ) / {1}", v1, v2.Label));
    }

    /// <summary>
    /// Returns v1 / v2
    /// </summary>
    /// <param name="v1">numerator</param>
    /// <param name="v2">denominator</param>
    /// <returns>v1 / v2</returns>
    /// <exception cref="exception">division by zero</exception>
    public static physValue operator/(physValue v1, double v2)
    {
      if (v2 == 0)
        throw new exception("Division by zero");

      return new physValue( v1.Symbol + String.Format( " / {0}", v2 ),
                            v1.Value      /     v2,
                            v1.Unit,
                            String.Format("( {0} ) / {1}", v1.Label, v2) );
    }

    /// <summary>
    /// Returns v1 / v2
    /// </summary>
    /// <param name="v1">numerator</param>
    /// <param name="v2">denominator</param>
    /// <returns>v1 / v2</returns>
    /// <exception cref="exception">division by zero</exception>
    public static physValue operator/(physValue v1, physValue v2)
    {
      if (v2.Value == 0)
        throw new exception("Division by zero");

      // split the units in numerator and denominator
      string[] result_a= v1.Unit.Split('/');
      string[] result_b= v2.Unit.Split('/');

      // default unit is 1/1, e.g. if there is no denominator
      string[] numerator= { "1", "1" };
      string[] denominator= { "1", "1" };

      numerator[0]= result_a[0];

      // the denominator of the 2nd physValue becomes the 2nd numerator
      if (result_b.Length > 1)
        numerator[1]= result_b[1];

      if (result_a.Length > 1)
        denominator[0]= result_a[1];

      // the numerator of the 2nd physValue becomes the 2nd denominator
      denominator[1]= result_b[0];

      // reduce the fraction
      string unit= reduceFraction(numerator, denominator);

      return new physValue( v1.Symbol + " / " + v2.Symbol,
                            v1.Value / v2.Value,
                            unit,
                            String.Format("( {0} ) / ( {1} )", 
                            v1.Label, v2.Label) );
    }

    /// <summary>
    /// Returns v1 == v2, the numerical values of v1 and v2 are compared
    /// Remark: You shouldn't compare double values with ==
    /// Throws an error if units are not the same. 
    /// </summary>
    /// <param name="v1">1st</param>
    /// <param name="v2">2nd</param>
    /// <returns>true, if values are equal</returns>
    /// <exception cref="exception">unit mismatch</exception>
    public static bool operator==(physValue v1, physValue v2)
    {
      if (v1.Unit != v2.Unit)
      {
        throw new exception( String.Format(
            "Cannot compare! The units of both physical values are not equal: {0} != {1}!",
            v1.Unit, v2.Unit) );
      }

      return v1.Value == v2.Value;
    }

    /// <summary>
    /// Returns v1 != v2, the numerical values of v1 and v2 are compared
    /// Remark: You shouldn't compare double values with !=
    /// Throws an error if units are not the same. 
    /// </summary>
    /// <param name="v1">1st</param>
    /// <param name="v2">2nd</param>
    /// <returns>true, if values are not equal</returns>
    /// <exception cref="exception">unit mismatch</exception>
    public static bool operator!=(physValue v1, physValue v2)
    {
      return !(v1 == v2);
    }

    /// <summary>
    /// Has to be implemented, when == is implemented
    /// </summary>
    /// <param name="v">some object</param>
    /// <returns>true if v is a physValue</returns>
    public override bool Equals(object v)
    {
      return this == (physValue)v;
    }

    /// <summary>
    /// Has to be implemented, when == is implemented
    /// </summary>
    /// <returns>?</returns>
    public override int GetHashCode()
    {
      return base.GetHashCode();
    }

    /// <summary>
    /// Returns v1 &gt; v2, the numerical values of v1 and v2 are compared
    /// Throws an error if units are not the same. 
    /// </summary>
    /// <param name="v1">1st</param>
    /// <param name="v2">2nd</param>
    /// <returns>v1 &gt; v2</returns>
    /// <exception cref="exception">unit mismatch</exception>
    public static bool operator>(physValue v1, physValue v2)
    {
      if (v1.Unit != v2.Unit)
      {
        throw new exception( String.Format(
              "Cannot compare! The units of both physical values are not equal: {0} != {1}!",
              v1.Unit, v2.Unit) );
      }

      return v1.Value > v2.Value;
    }

    /// <summary>
    /// Returns v1 &lt; v2, the numerical values of v1 and v2 are compared
    /// Throws an error if units are not the same. 
    /// </summary>
    /// <param name="v1">1st</param>
    /// <param name="v2">2nd</param>
    /// <returns>v1 &lt; v2</returns>
    /// <exception cref="exception">unit mismatch</exception>
    public static bool operator<(physValue v1, physValue v2)
    {
      if (v1.Unit != v2.Unit)
      {
        throw new exception( String.Format(
              "Cannot compare! The units of both physical values are not equal: {0} != {1}!",
              v1.Unit, v2.Unit) );
      }

      return v1.Value < v2.Value;
    }

    /// <summary>
    /// Returns v1 &lt;= v2, the numerical values of v1 and v2 are compared
    /// Remark: You shouldn't compare double values with ==
    /// </summary>
    /// <param name="v1">1st</param>
    /// <param name="v2">2nd</param>
    /// <returns>v1 &lt;= v2</returns>
    /// <exception cref="exception">unit mismatch</exception>
    public static bool operator<=(physValue v1, physValue v2)
    {
      return !(v1 > v2);
    }

    /// <summary>
    /// Returns v1 &gt;= v2, the numerical values of v1 and v2 are compared
    /// Remark: You shouldn't compare double values with ==
    /// </summary>
    /// <param name="v1">1st</param>
    /// <param name="v2">2nd</param>
    /// <returns>v1 &gt;= v2</returns>
    /// <exception cref="exception">unit mismatch</exception>
    public static bool operator>=(physValue v1, physValue v2)
    {
      return !(v1 < v2);
    }


    
  }
}


