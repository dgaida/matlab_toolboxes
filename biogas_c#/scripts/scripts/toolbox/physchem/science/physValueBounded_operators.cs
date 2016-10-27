/**
 * This file is part of the partial class physValueBounded and defines
 * the operators of the class.
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
  /// Furthermore you can set lower and upper bounds for the value, which can be checked.
  /// 
  /// All methods in this class are const, as defined in C++, except stated otherwise
  /// 
  /// </remarks>
  public partial class physValueBounded : physValue
  {

    // -------------------------------------------------------------------------------------
    //                              !!! OPERATOR METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// Returns v1 + v2
    /// </summary>
    /// <param name="v1">1st</param>
    /// <param name="v2">2nd</param>
    /// <returns>v1 + v2</returns>
    /// <exception cref="exception">unit mismatch</exception>
    public static physValueBounded operator+(physValueBounded v1, physValueBounded v2)
    {
      return new physValueBounded((physValue)v1 + (physValue)v2);
    }
    /// <summary>
    /// Returns v1 + v2
    /// </summary>
    /// <param name="v1">1st</param>
    /// <param name="v2">2nd</param>
    /// <returns>v1 + v2</returns>
    /// <exception cref="exception">unit mismatch</exception>
    public static physValueBounded operator+(physValueBounded v1, physValue v2)
    {
      return new physValueBounded((physValue)v1 + v2);
    }
    /// <summary>
    /// Returns v1 + v2
    /// </summary>
    /// <param name="v1">1st</param>
    /// <param name="v2">2nd</param>
    /// <returns>v1 + v2</returns>
    /// <exception cref="exception">unit mismatch</exception>
    public static physValueBounded operator+(physValue v1, physValueBounded v2)
    {
      return new physValueBounded(v1 + (physValue)v2);
    }

    /// <summary>
    /// Returns v1 - v2
    /// </summary>
    /// <param name="v1">1st</param>
    /// <param name="v2">2nd</param>
    /// <returns>v1 - v2</returns>
    /// <exception cref="exception">unit mismatch</exception>
    public static physValueBounded operator-(physValueBounded v1, physValueBounded v2)
    {
      return new physValueBounded((physValue)v1 - (physValue)v2);
    }
    /// <summary>
    /// Returns v1 - v2
    /// </summary>
    /// <param name="v1">1st</param>
    /// <param name="v2">2nd</param>
    /// <returns>v1 - v2</returns>
    /// <exception cref="exception">unit mismatch</exception>
    public static physValueBounded operator-(physValueBounded v1, physValue v2)
    {
      return new physValueBounded((physValue)v1 - v2);
    }
    /// <summary>
    /// Returns v1 - v2
    /// </summary>
    /// <param name="v1">1st</param>
    /// <param name="v2">2nd</param>
    /// <returns>v1 - v2</returns>
    /// <exception cref="exception">unit mismatch</exception>
    public static physValueBounded operator-(physValue v1, physValueBounded v2)
    {
      return new physValueBounded(v1 - (physValue)v2);
    }

    /// <summary>
    /// unary minus: Returns -v
    /// </summary>
    /// <param name="v">v</param>
    /// <returns>-v</returns>
    public static physValueBounded operator-(physValueBounded v)
    {
      physValueBounded v_new= new physValueBounded(-(physValue)v);

      v_new._lb= -v.LB;
      v_new._ub= -v.UB;

      return v_new;
    }

    /// <summary>
    /// Returns v1 * v2
    /// </summary>
    /// <param name="v1">v1</param>
    /// <param name="v2">v2</param>
    /// <returns>v1 * v2</returns>
    public static physValueBounded operator*(double v1, physValueBounded v2)
    {
      return new physValueBounded(v1 * (physValue)v2);
    }
    /// <summary>
    /// Returns v1 * v2
    /// </summary>
    /// <param name="v2"></param>
    /// <param name="v1"></param>
    /// <returns>v1 * v2</returns>
    public static physValueBounded operator*(physValueBounded v2, double v1)
    {
      return v1 * v2;
    }

    /// <summary>
    /// Returns v1 * v2
    /// </summary>
    /// <param name="v1">v1</param>
    /// <param name="v2">v2</param>
    /// <returns>v1 * v2</returns>
    public static physValueBounded operator*(physValueBounded v1, physValueBounded v2)
    {
      return new physValueBounded((physValue)v1 * (physValue)v2);
    }
    /// <summary>
    /// Returns v1 * v2
    /// </summary>
    /// <param name="v1">v1</param>
    /// <param name="v2">v2</param>
    /// <returns>v1 * v2</returns>
    public static physValueBounded operator*(physValueBounded v1, physValue v2)
    {
      return new physValueBounded((physValue)v1 * v2);
    }
    /// <summary>
    /// Returns v1 * v2
    /// </summary>
    /// <param name="v1">v1</param>
    /// <param name="v2">v2</param>
    /// <returns>v1 * v2</returns>
    public static physValueBounded operator*(physValue v1, physValueBounded v2)
    {
      return new physValueBounded(v1 * (physValue)v2);
    }

    /// <summary>
    /// Returns v1 / v2
    /// </summary>
    /// <param name="v1">v1</param>
    /// <param name="v2">v2</param>
    /// <returns>v1 / v2</returns>
    /// <exception cref="exception">division by zero</exception>
    public static physValueBounded operator/(double v1, physValueBounded v2)
    {
      return new physValueBounded(v1 / (physValue)v2);
    }
    /// <summary>
    /// Returns v2 / v1
    /// </summary>
    /// <param name="v2">v2</param>
    /// <param name="v1">v1</param>
    /// <returns>v2 / v1</returns>
    /// <exception cref="exception">division by zero</exception>
    public static physValueBounded operator/(physValueBounded v2, double v1)
    {
      return new physValueBounded((physValue)v2 / v1);
    }

    /// <summary>
    /// Returns v1 / v2
    /// </summary>
    /// <param name="v1">v1</param>
    /// <param name="v2">v2</param>
    /// <returns>v1 / v2</returns>
    /// <exception cref="exception">division by zero</exception>
    public static physValueBounded operator/(physValueBounded v1, physValueBounded v2)
    {
      return new physValueBounded((physValue)v1 / (physValue)v2);
    }
    /// <summary>
    /// Returns v1 / v2
    /// </summary>
    /// <param name="v1">v1</param>
    /// <param name="v2">v2</param>
    /// <returns>v1 / v2</returns>
    /// <exception cref="exception">division by zero</exception>
    public static physValueBounded operator/(physValueBounded v1, physValue v2)
    {
      return new physValueBounded((physValue)v1 / v2);
    }
    /// <summary>
    /// Returns v1 / v2
    /// </summary>
    /// <param name="v1">v1</param>
    /// <param name="v2">v2</param>
    /// <returns>v1 / v2</returns>
    /// <exception cref="exception">division by zero</exception>
    public static physValueBounded operator/(physValue v1, physValueBounded v2)
    {
      return new physValueBounded(v1 / (physValue)v2);
    }

    /// <summary>
    /// Returns v1 == v2, the numerical values of v1 and v2 are compared
    /// Remark: You shouldn't compare double values with ==
    /// </summary>
    /// <param name="v1">v1</param>
    /// <param name="v2">v2</param>
    /// <returns>true, if numeric values are equal</returns>
    /// <exception cref="exception">unit mismatch</exception>
    public static bool operator==(physValueBounded v1, physValueBounded v2)
    {
      return (physValue)v1 == (physValue)v2;
    }
    /// <summary>
    /// Returns v1 == v2, the numerical values of v1 and v2 are compared
    /// Remark: You shouldn't compare double values with ==
    /// </summary>
    /// <param name="v1">v1</param>
    /// <param name="v2">v2</param>
    /// <returns>true, if numeric values are equal</returns>
    /// <exception cref="exception">unit mismatch</exception>
    public static bool operator==(physValueBounded v1, physValue v2)
    {
      return (physValue)v1 == v2;
    }
    /// <summary>
    /// Returns v1 == v2, the numerical values of v1 and v2 are compared
    /// Remark: You shouldn't compare double values with ==
    /// </summary>
    /// <param name="v1">v1</param>
    /// <param name="v2">v2</param>
    /// <returns>true, if numeric values are equal</returns>
    /// <exception cref="exception">unit mismatch</exception>
    public static bool operator==(physValue v1, physValueBounded v2)
    {
      return v1 == (physValue)v2;
    }

    /// <summary>
    /// Returns v1 != v2, the numerical values of v1 and v2 are compared
    /// Remark: You shouldn't compare double values with !=
    /// </summary>
    /// <param name="v1">v1</param>
    /// <param name="v2">v2</param>
    /// <returns>true, if numeric values are not equal</returns>
    /// <exception cref="exception">unit mismatch</exception>
    public static bool operator!=(physValueBounded v1, physValueBounded v2)
    {
      return !(v1 == v2);
    }
    /// <summary>
    /// Returns v1 != v2, the numerical values of v1 and v2 are compared
    /// Remark: You shouldn't compare double values with !=
    /// </summary>
    /// <param name="v1">v1</param>
    /// <param name="v2">v2</param>
    /// <returns>true, if numeric values are not equal</returns>
    /// <exception cref="exception">unit mismatch</exception>
    public static bool operator!=(physValueBounded v1, physValue v2)
    {
      return (physValue)v1 != v2;
    }
    /// <summary>
    /// Returns v1 != v2, the numerical values of v1 and v2 are compared
    /// Remark: You shouldn't compare double values with !=
    /// </summary>
    /// <param name="v1">v1</param>
    /// <param name="v2">v2</param>
    /// <returns>true, if numeric values are not equal</returns>
    /// <exception cref="exception">unit mismatch</exception>
    public static bool operator!=(physValue v1, physValueBounded v2)
    {
      return v1 != (physValue)v2;
    }

    /// <summary>
    /// Has to be implemented, when == is implemented
    /// </summary>
    /// <param name="v">a physValueBounded</param>
    /// <returns>true, if v is a physValueBounded</returns>
    public override bool Equals(object v)
    {
      return this == (physValueBounded)v;
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
    /// Returns v1 > v2, the numerical values of v1 and v2 are compared
    /// </summary>
    /// <param name="v1">v1</param>
    /// <param name="v2">v2</param>
    /// <returns>true, if v1 &gt; v2</returns>
    /// <exception cref="exception">unit mismatch</exception>
    public static bool operator>(physValueBounded v1, physValueBounded v2)
    {
      return (physValue)v1 > (physValue)v2;
    }
    /// <summary>
    /// Returns v1 > v2, the numerical values of v1 and v2 are compared
    /// </summary>
    /// <param name="v1">v1</param>
    /// <param name="v2">v2</param>
    /// <returns>v1 > v2</returns>
    /// <exception cref="exception">unit mismatch</exception>
    public static bool operator>(physValueBounded v1, physValue v2)
    {
      return (physValue)v1 > v2;
    }
    /// <summary>
    /// Returns v1 > v2, the numerical values of v1 and v2 are compared
    /// </summary>
    /// <param name="v1">v1</param>
    /// <param name="v2">v2</param>
    /// <returns>v1 > v2</returns>
    /// <exception cref="exception">unit mismatch</exception>
    public static bool operator>(physValue v1, physValueBounded v2)
    {
      return v1 > (physValue)v2;
    }

    /// <summary>
    /// Returns v1 &lt; v2, the numerical values of v1 and v2 are compared
    /// </summary>
    /// <param name="v1">v1</param>
    /// <param name="v2">v2</param>
    /// <returns>v1 &lt; v2</returns>
    /// <exception cref="exception">unit mismatch</exception>
    public static bool operator<(physValueBounded v1, physValueBounded v2)
    {
      return (physValue)v1 < (physValue)v2;
    }
    /// <summary>
    /// Returns v1 &lt; v2, the numerical values of v1 and v2 are compared
    /// </summary>
    /// <param name="v1">v1</param>
    /// <param name="v2">v2</param>
    /// <returns>v1 &lt; v2</returns>
    /// <exception cref="exception">unit mismatch</exception>
    public static bool operator<(physValueBounded v1, physValue v2)
    {
      return (physValue)v1 < v2;
    }
    /// <summary>
    /// Returns v1 &lt; v2, the numerical values of v1 and v2 are compared
    /// </summary>
    /// <param name="v1">v1</param>
    /// <param name="v2">v2</param>
    /// <returns>v1 &lt; v2</returns>
    /// <exception cref="exception">unit mismatch</exception>
    public static bool operator<(physValue v1, physValueBounded v2)
    {
      return v1 < (physValue)v2;
    }

    /// <summary>
    /// Returns v1 &lt;= v2, the numerical values of v1 and v2 are compared
    /// Remark: You shouldn't compare double values with ==
    /// </summary>
    /// <param name="v1">v1</param>
    /// <param name="v2">v2</param>
    /// <returns>v1 &lt;= v2</returns>
    /// <exception cref="exception">unit mismatch</exception>
    public static bool operator<=(physValueBounded v1, physValueBounded v2)
    {
      return !(v1 > v2);
    }
    /// <summary>
    /// Returns v1 &lt;= v2, the numerical values of v1 and v2 are compared
    /// Remark: You shouldn't compare double values with ==
    /// </summary>
    /// <param name="v1">v1</param>
    /// <param name="v2">v2</param>
    /// <returns>v1 &lt;= v2</returns>
    /// <exception cref="exception">unit mismatch</exception>
    public static bool operator<=(physValueBounded v1, physValue v2)
    {
      return (physValue)v1 <= v2;
    }
    /// <summary>
    /// Returns v1 &lt;= v2, the numerical values of v1 and v2 are compared
    /// Remark: You shouldn't compare double values with ==
    /// </summary>
    /// <param name="v1">v1</param>
    /// <param name="v2">v2</param>
    /// <returns>v1 &lt;= v2</returns>
    /// <exception cref="exception">unit mismatch</exception>
    public static bool operator<=(physValue v1, physValueBounded v2)
    {
      return v1 <= (physValue)v2;
    }

    /// <summary>
    /// Returns v1 &gt;= v2, the numerical values of v1 and v2 are compared
    /// Remark: You shouldn't compare double values with ==
    /// </summary>
    /// <param name="v1">v1</param>
    /// <param name="v2">v2</param>
    /// <returns>v1 &gt;= v2</returns>
    /// <exception cref="exception">unit mismatch</exception>
    public static bool operator>=(physValueBounded v1, physValueBounded v2)
    {
      return !(v1 < v2);
    }
    /// <summary>
    /// Returns v1 &gt;= v2, the numerical values of v1 and v2 are compared
    /// Remark: You shouldn't compare double values with ==
    /// </summary>
    /// <param name="v1">v1</param>
    /// <param name="v2">v2</param>
    /// <returns>v1 &gt;= v2</returns>
    /// <exception cref="exception">unit mismatch</exception>
    public static bool operator>=(physValueBounded v1, physValue v2)
    {
      return (physValue)v1 >= v2;
    }
    /// <summary>
    /// Returns v1 &gt;= v2, the numerical values of v1 and v2 are compared
    /// Remark: You shouldn't compare double values with ==
    /// </summary>
    /// <param name="v1">v1</param>
    /// <param name="v2">v2</param>
    /// <returns>v1 &gt;= v2</returns>
    /// <exception cref="exception">unit mismatch</exception>
    public static bool operator>=(physValue v1, physValueBounded v2)
    {
      return v1 >= (physValue)v2;
    }



  }
}


