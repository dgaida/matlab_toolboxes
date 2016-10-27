/**
 * This file is part of the partial class stirrer and defines
 * all constructor methods.
 * 
 * TODOs:
 * - 
 * 
 * Apart from that FINISHED!
 * 
 */

using System;
using System.Collections.Generic;
using System.Text;
using toolbox;
using science;
using System.Xml;

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
  /// Defines a stirrer used to stir the content in a digester
  /// </summary>
  public partial class stirrer
  {

    // -------------------------------------------------------------------------------------
    //                              !!! CONSTRUCTOR METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// Constructor called by the constructor of biogas.stirrers while 
    /// reading the plant out of a XML file. So reader must be at the correct position, 
    /// which is &lt;stirrer id= "..."&gt; was just read. That for the id of
    /// the stirrer is given to this method.
    /// </summary>
    /// <param name="reader">open reader</param>
    /// <param name="id">id of the stirrer</param>
    public stirrer(ref XmlTextReader reader, string id)
    {
      _id= id;

      getParamsFromXMLReader(ref reader);
    }

    /// <summary>
    /// Constructor used to read stirrer out of a XML file
    /// </summary>
    /// <param name="XMLfile">filename of the xml file</param>
    public stirrer(string XMLfile)
    {
      XmlTextReader reader= new System.Xml.XmlTextReader(XMLfile);

      getParamsFromXMLReader(ref reader);

      reader.Close();
    }

    /// <summary>
    /// Creates an initialized stirrer with default params
    /// </summary>
    /// <param name="id">id of stirrer</param>
    /// <param name="dummy">dummy</param>
    public stirrer(string id, int dummy)  // dummy um zu unterscheiden zu oberen constructor
    {
      _id= id;
      
      // set default parameter, könnten auch mit dem konstruktor übergeben werden

      _eta_mixer = 0.7;
      _diameter = 3.5;    // meter
      _rotspeed = 0.2;    // 1(umdrehungen) / second
    }

    /// <summary>
    /// Default constructor, 
    /// </summary>
    public stirrer() : this("", 0)
    {}



  }
}


