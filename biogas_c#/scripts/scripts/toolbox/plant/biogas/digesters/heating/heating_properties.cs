/**
 * This file is part of the partial class heating and defines
 * private fields and properties of the heating.
 * 
 * TODOs:
 * - 
 * 
 * Except for that FINISHED!
 * 
 */

using System;
using System.Collections.Generic;
using System.Text;
using toolbox;
using science;

/**
 * Mainly everything that has to do with biogas is defined in this namespace:
 * 
 * - Anaerobic Digestion Model
 * - CHPs
 * - Digesters
 * - Plant
 * - Substrates
 * - Chemistry used for biogas stuff
 * 
 */
namespace biogas
{
  /// <summary>
  /// Defines a heating used to heat a digester
  /// </summary>
  public partial class heating
  {

    // -------------------------------------------------------------------------------------
    //                            !!! PRIVATE FIELDS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// electrical degree of efficiency of the heating
    /// 
    /// wenn mit thermisch produzierter energie geheizt wird, dann könnte das auch
    /// heizverluste über rohrleitung bedeuten, also thermal degree of efficiency
    /// </summary>
    private double _eta= 0;

    /// <summary>
    /// if the fermenter is heated, then true, else false
    /// </summary>
    private bool _status= true;
    
    /// <summary>
    /// definiert ob heizung elektrisch, thermisch, oder was anderes
    /// ist
    /// 0 - electrical
    /// 1 - thermal
    /// 
    /// TODO: not used, is it needed?
    /// </summary>
    private int _type = 1;



    // -------------------------------------------------------------------------------------
    //                              !!! PROPERTIES !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// (type 0) electrical degree of efficiency of the heating
    /// if thermal (type 1), then: thermal degree of efficiency
    /// </summary>
    public double eta
    {
      get { return _eta; }
    }

    /// <summary>
    /// if the fermenter is heated, then true, else false
    /// </summary>
    public bool status
    {
      get { return _status; }
    }

    /// <summary>
    /// definiert ob heizung elektrisch, thermisch, oder was anderes
    /// ist
    /// 0 - electrical
    /// 1 - thermal
    /// 
    /// TODO: not used, is it needed?
    /// </summary>
    public int type
    {
      get { return _type; }
    }



  }
}


