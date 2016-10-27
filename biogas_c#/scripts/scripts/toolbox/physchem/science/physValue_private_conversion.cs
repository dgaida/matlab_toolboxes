/**
 * This file is part of the partial class physValue and defines
 * private methods used for conversion of units.
 * 
 * TODOs:
 * - it is not nice that the chemistry class is used here
 * 
 * Apart from that FINISHED!
 * 
 */

using System;
using toolbox;
using System.Text;
using System.Collections;

/// <summary>
/// The science namespace collects all classes which have to do with science in general.
/// </summary>
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
    //                          !!! PRIVATE CONVERSION METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// Does a unit conversion from mol/l to g/l 
    /// calculating the molar mass of the physValue
    /// </summary>
    /// <returns>returns physValue measured in g/l</returns>
    /// <seealso cref="biogas.chemistry.get_mol_mass_of(string)"/>
    private physValue convertFrom_mol_l_To_g_l() // const
    {
      physValue mol_mass;

      // molar mass of physical value in 'g/mol'
      mol_mass= biogas.chemistry.get_mol_mass_of(this.Symbol);

      // mol/l * g/mol = g / l
      return this * mol_mass;
    }

    /// <summary>
    /// Does a unit conversion from g/l to mol/l 
    /// calculating the molar mass of the physValue
    /// </summary>
    /// <returns>physValue measured in mol/l</returns>
    /// <seealso cref="biogas.chemistry.get_mol_mass_of(string)"/>
    private physValue convertFrom_g_l_To_mol_l() // const
    {
      physValue mol_mass;

      // molar mass of physical value in 'g/mol'
      // mol_mass is always > 0, if it is 0, then the method throws
      mol_mass= biogas.chemistry.get_mol_mass_of(this.Symbol);

      // g/l / (g/mol) = mol / l
      return this / mol_mass;
    }

    /// <summary>
    /// Does a unit conversion from mol/l to kgCOD/m^3 
    /// calculating the Chemical Oxygen Demand of the physValue
    /// </summary>
    /// <returns>physValue measured in gCOD/l</returns>
    /// <seealso cref="biogas.chemistry.get_COD_of(string)"/>
    private physValue convertFrom_mol_l_To_kgCODm3() // const
    {
      // Remark: 
      // The name of the method is a little misguiding, because
      // most of the time we are not converting from mol/l
      // to kgCOD/m^3 directly, instead from mol/l to gCOD/l,
      // as the example shows below
      // but as this method is also called to convert from
      // kmol/m^3 to kgCOD/m^3 the unit then does not come out
      // nicely, so we set the unit in the convertUnit() method manually
      // after conversion
      physValue COD;

      // COD of physical value in 'gCOD/mol'
      COD= biogas.chemistry.get_COD_of(this.Symbol);

      // mol/l * gCOD/mol = gCOD/l
      return this * COD;
    }

    /// <summary>
    /// Does a unit conversion from kgCOD/m^3 to mol/l 
    /// calculating the Chemical Oxygen Demand of the physValue
    /// </summary>
    /// <returns>physValue measured in mol/l</returns>
    /// <seealso cref="biogas.chemistry.get_COD_of(string)"/>
    private physValue convertFrom_kgCODm3_To_mol_l() // const
    {
      // Remark: 
      // The name of the method is a little misguiding, because
      // most of the time we are not converting from kgCOD/m^3
      // to mol/l directly, instead from gCOD/l to mol/l,
      // as the example shows below
      // but as this method is also called to convert from
      // kgCOD/m^3 to kmol/m^3 the unit then does not come out
      // nicely, so we set the unit in the convertUnit() method manually
      // after conversion
      physValue COD;

      // COD of physical value in 'gCOD/mol'
      // COD is always > 0, if COD for symbol cannot be calculated
      // the method throws
      COD= biogas.chemistry.get_COD_of(this.Symbol);

      // gCOD/l / (gCOD/mol) = gCOD/l * mol/gCOD = mol / l
      return this / COD;
    }

    
    
  }
}


