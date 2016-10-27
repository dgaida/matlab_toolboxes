/**
 * This file is part of the partial class substrates and defines
 * the private fields and properties of the class.
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
using science;
using System.Xml;
using System.IO;
using toolbox;

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
  /// List of substrates
  /// </summary>
  public partial class substrates : List<substrate>
  {

    // -------------------------------------------------------------------------------------
    //                            !!! PRIVATE FIELDS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// list with the substrate ids
    /// </summary>
    private List<string> _ids= new List<string>();



    // -------------------------------------------------------------------------------------
    //                        !!! PUBLIC STATIC FIELDS !!!
    // -------------------------------------------------------------------------------------

    


    // -------------------------------------------------------------------------------------
    //                              !!! PROPERTIES !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// id of the substrate
    /// </summary>
    public List<string> ids
    {
      get { return _ids; }
    }
    


  }
}


