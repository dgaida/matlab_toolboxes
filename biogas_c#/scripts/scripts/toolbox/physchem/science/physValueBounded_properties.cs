/**
 * This file is part of the partial class physValueBounded and defines
 * the fields and properties.
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
    //                            !!! PRIVATE FIELDS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// lower bound of physical value, default -infinity
    /// </summary>
    private physValue _lb= new physValue(double.NegativeInfinity, "");

    /// <summary>
    /// upper bound of physical value, default +infinity
    /// </summary>
    private physValue _ub= new physValue(double.PositiveInfinity, "");



    // -------------------------------------------------------------------------------------
    //                              !!! PROPERTIES !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// lower bound of physical value, default -infinity
    /// </summary>
    public physValue LB
    {
      get { return _lb; }
      //set { _lb= value; }
    }

    /// <summary>
    /// upper bound of physical value, default +infinity
    /// </summary>
    public physValue UB
    {
      get { return _ub; }
      //set { _ub= value; }
    }



  }
}


