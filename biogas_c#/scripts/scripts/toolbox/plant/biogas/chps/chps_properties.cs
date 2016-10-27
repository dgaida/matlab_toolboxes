/**
 * This file is part of the partial class chps and defines
 * private fields and properties of the class.
 * 
 * TODOs:
 * - 
 * 
 * FINISHED!
 * 
 */

using System;
using System.Collections.Generic;
using System.Text;
using System.Xml;
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
  /// list of chp s
  /// </summary>
  public partial class chps : List<chp>
  {

    // -------------------------------------------------------------------------------------
    //                            !!! PRIVATE FIELDS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// ids of the chp
    /// </summary>
    private List<string> _ids= new List<string>();

    ///// <summary>
    ///// wird in einer statischen methode: run benötigt
    ///// kann nicht statisch sein, wenn man die variable ändern möchte
    ///// in plant definieren
    ///// how biogas is splitted:
    ///// threshold
    ///// fiftyfifty
    ///// one2one
    ///// </summary>
    //private static string gas2chpsplittype = "threshold";



    // -------------------------------------------------------------------------------------
    //                        !!! PUBLIC STATIC FIELDS !!!
    // -------------------------------------------------------------------------------------



    // -------------------------------------------------------------------------------------
    //                              !!! PROPERTIES !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// id of the chp
    /// </summary>
    public List<string> ids
    {
      get { return _ids; }
    }
    

    
  }
}


