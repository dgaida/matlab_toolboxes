/**
 * This file is part of the partial class chp and defines
 * the constructor methods.
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
  /// Definition of a combined heat and power plant (cogeneration unit)
  /// </summary>
  public partial class chp
  {

    // -------------------------------------------------------------------------------------
    //                              !!! CONSTRUCTOR METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// Constructor called by the constructor of biogas.chps while 
    /// reading the plant out of a XML file. So reader must be at the correct position, 
    /// which is &lt;chp id= "..."&gt; was just read. That for the id of
    /// the chp is given to this method.
    /// </summary>
    /// <param name="reader">an open reader</param>
    /// <param name="id">id of chp</param>
    public chp(ref XmlTextReader reader, string id)
    {
      _id= id;

      getParamsFromXMLReader(ref reader);
    }

    /// <summary>
    /// Constructor used to read chp out of a XML file
    /// </summary>
    /// <param name="XMLfile">filename of the xml file</param>
    public chp(string XMLfile)
    {
      XmlTextReader reader= new System.Xml.XmlTextReader(XMLfile);

      getParamsFromXMLReader(ref reader);

      reader.Close();
    }

    /// <summary>
    /// Creates an initialized chp with default params
    /// 
    /// they are:
    /// P electrical: 250 kW
    /// P thermal: 500 kW
    /// eta electrical: 0.4
    /// eta thermal: 0.45
    /// </summary>
    /// <param name="id">id of chp</param>
    /// <param name="name">name of chp</param>
    public chp(string id, string name)
    {
      _id= id;
      _name= name;

      double[] values= { 250, 500, 0.4, 0.45 };

      try
      {
        set_params_of(values);
      }
      catch (exception e)
      {
        Console.WriteLine(e.Message);
        Console.WriteLine("Failed to create chp object!");
      }
    }

    /// <summary>
    /// creates an initialized chp with default params, 
    /// but with no name and no id
    /// </summary>
    public chp() : this("", "")
    {}



  }
}


