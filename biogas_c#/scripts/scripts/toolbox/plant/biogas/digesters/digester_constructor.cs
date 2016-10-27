/**
 * This file is part of the partial class digester and defines
 * the constructor methods of the class.
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
using toolbox;
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
  /// Defines a digester on a biogas plant. To each digester a heating belongs, which is
  /// either switched on or off.
  /// 
  /// Furthermore each digester is modelled by an anaerobic digestion model (ADM).
  /// This ADM object is accessible through this class.
  /// 
  /// </summary>
  public partial class digester
  {

    // -------------------------------------------------------------------------------------
    //                              !!! CONSTRUCTOR METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// Constructor called by the constructor of biogas.digesters while 
    /// reading the plant out of a XML file. So reader must be at the correct position, 
    /// which is &lt;digester id= "..."&gt; was just read. That for the id of
    /// the digester is given to this method.
    /// </summary>
    /// <param name="reader">open reader</param>
    /// <param name="id">id of digester</param>
    public digester(ref XmlTextReader reader, string id)
    {
      _id= id;

      getParamsFromXMLReader(ref reader);

      _AD_Model = new ADM(T);
    }

    /// <summary>
    /// Constructor used to read digester out of a XML file
    /// </summary>
    /// <param name="XMLfile">filename of xml file</param>
    public digester(string XMLfile)
    {
      XmlTextReader reader= new System.Xml.XmlTextReader(XMLfile);

      getParamsFromXMLReader(ref reader);

      reader.Close();

      _AD_Model = new ADM(T);
    }

    /// <summary>
    /// Creates an initialized digester with default params
    /// 
    /// They are:
    /// 
    /// Vtot: 3500 m³
    /// Vliq: 3000 m³
    /// Vliq_max: 3000 m³
    /// Vgas: 400 m³
    /// Vgas_max: 400 m³
    /// T: 40 °C
    /// diameter: 20 m
    /// k_wall: 0.4 W/(m² * K)
    /// k_roof: 0.25 W/(m² * K)
    /// k_ground: 1.9 W/(m² * K)
    /// heating efficiency: 0.4, heating always switched on as default
    /// </summary>
    /// <param name="id">id of digester</param>
    /// <param name="name">name of digester</param>
    public digester(string id, string name)
    {
      _id= id;
      _name= name;

      double[] values= {3500, 3000, 3000, 400, 400, 40, 20, 0.4, 0.25, 1.9, 0.4};

      try
      {
        set_params_of(values);
      }
      catch (exception e)
      {
        Console.WriteLine(e.Message);
        Console.WriteLine("Could not create digester!");
      }

      _AD_Model = new ADM(T);
    }

    /// <summary>
    /// creates an initialized digester with default params, 
    /// but with no name and no id
    /// </summary>
    public digester() : this("", "")
    {}



  }
}


