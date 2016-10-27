/**
 * This file is part of the partial class substrate_transport and defines
 * all constructor methods.
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
using science;
using System.Xml;
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
  /// This class is used to transport the substrate feed.
  /// 
  /// a substrate_transport contains a pump and a transport for solid substrates
  /// </summary>
  public partial class substrate_transport
  {

    // -------------------------------------------------------------------------------------
    //                              !!! CONSTRUCTOR METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// Standard Constructor
    /// creates substrate_transport with default params, has no start and no destiny
    /// </summary>
    public substrate_transport()
    { 
    
    }

    ///// <summary>
    ///// Standard Constructor
    ///// creates pump with default params, has start= "substratemix" and destiny
    ///// 
    ///// TODO
    ///// verwirrung mit constructor unten string xmlfile
    ///// </summary>
    ///// <param name="unit_destiny">
    ///// unit to pump stuff to, unit can be a digester or "storagetank"
    ///// </param>
    //public substrate_transport(string unit_destiny) :
    //  base("substratemix", unit_destiny)
    //{

    //}

    /// <summary>
    /// Standard Constructor
    /// creates pump with default params, has start and destiny
    /// </summary>
    /// <param name="unit_start">
    /// unit to pump stuff from, unit can be "substratemix"
    /// </param>
    /// <param name="unit_destiny">
    /// unit to pump stuff to, unit can be a digester or "storagetank"
    /// </param>
    public substrate_transport(string unit_start, string unit_destiny) :
      base(unit_start, unit_destiny)
    {
      
    }

    /// <summary>
    /// Constructor called by the constructor of biogas.transportation while 
    /// reading the plant out of a XML file. So reader must be at the correct position, 
    /// which is &lt;substrate_transport&gt; was just read. 
    /// </summary>
    /// <param name="reader">an open reader</param>
    public substrate_transport(ref XmlTextReader reader)
    {
      getParamsFromXMLReader(ref reader);
    }

    /// <summary>
    /// Constructor used to read substrate_transport out of a XML file
    /// </summary>
    /// <param name="XMLfile">xml file</param>
    public substrate_transport(string XMLfile)
    {
      XmlTextReader reader = new System.Xml.XmlTextReader(XMLfile);

      getParamsFromXMLReader(ref reader);

      reader.Close();
    }



  }



}


