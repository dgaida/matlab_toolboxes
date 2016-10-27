/**
 * This file is part of the partial class pump and defines
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
  /// Pumpen können zwischen
  /// 
  /// - (Substratzufuhr und Fermenter (substratemix -> digester_id) nicht mehr, s. substrate_transport)
  /// - verschiedenen Fermentern
  /// - Fermenter und Endlager (digester_id -> storagetank)
  /// 
  /// angebracht werden.
  /// 
  /// Pumps basically just calculate the energy needed to pump the stuff.
  /// 
  /// energy is needed for two reasons:
  /// - to pump over a distance -> friction
  /// - to liften stuff -> potential energy
  /// 
  /// A pump is only used to pump sludge, not to pump substrate (substrate_transport).
  /// Even if manure is fed the needed energy is calculated using (substrate_transport).
  /// </summary>
  public partial class pump
  {

    // -------------------------------------------------------------------------------------
    //                              !!! CONSTRUCTOR METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// Standard Constructor
    /// creates pump with default params, has no start and no destiny
    /// </summary>
    public pump()
    { 
    
    }

    /// <summary>
    /// Standard Constructor
    /// creates pump with default params, has start and destiny
    /// </summary>
    /// <param name="unit_start">
    /// unit to pump stuff from, unit can be "substratemix", a digester or "storagetank"
    /// </param>
    /// <param name="unit_destiny">
    /// unit to pump stuff to, unit can be a digester or "storagetank"
    /// </param>
    public pump(string unit_start, string unit_destiny)
    {
      _unit_start = unit_start;
      _unit_destiny = unit_destiny;
    }

    /// <summary>
    /// Constructor called by the constructor of biogas.transportation while 
    /// reading the plant out of a XML file. So reader must be at the correct position, 
    /// which is &lt;pump&gt; was just read. 
    /// </summary>
    /// <param name="reader">an open reader</param>
    public pump(ref XmlTextReader reader)
    {
      getParamsFromXMLReader(ref reader);
    }

    /// <summary>
    /// Constructor used to read pump out of a XML file
    /// </summary>
    /// <param name="XMLfile">a xml file</param>
    public pump(string XMLfile)
    {
      XmlTextReader reader = new System.Xml.XmlTextReader(XMLfile);

      getParamsFromXMLReader(ref reader);

      reader.Close();
    }



  }



}


