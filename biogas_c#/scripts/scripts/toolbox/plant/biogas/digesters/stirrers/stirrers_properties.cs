/**
 * This file is part of the partial class stirrers and defines
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
using toolbox;
using System.Xml;
using science;

/**
 * Mainly everything that has to do with biogas is defined in this namespace:
 * 
 * - Anaerobic Digestion Model
 * - CHPs
 * - Stirrers
 * - Plant
 * - Substrates
 * - Chemistry used for biogas stuff
 * 
 */
namespace biogas
{
  /// <summary>
  /// list of stirrers
  /// </summary>
  public partial class stirrers : List<stirrer>
  {

    // -------------------------------------------------------------------------------------
    //                            !!! PRIVATE FIELDS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// ids of the stirrer
    /// </summary>
    private List<string> _ids= new List<string>();



    // -------------------------------------------------------------------------------------
    //                        !!! PUBLIC STATIC FIELDS !!!
    // -------------------------------------------------------------------------------------

    

    // -------------------------------------------------------------------------------------
    //                              !!! PROPERTIES !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// id of the stirrer
    /// </summary>
    public List<string> ids
    {
      get { return _ids; }
    }
    


  }
}


