/**
 * This file is part of the partial class substrates and defines
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
    //                              !!! CONSTRUCTOR METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// Constructor creating an empty substrate list
    /// </summary>
    public substrates()
    { 
    
    }

    /// <summary>
    /// Creating and returning a list with the given substrate only
    /// </summary>
    /// <param name="mySubstrate">a substrate</param>
    public substrates(substrate mySubstrate)
    {
      addSubstrate(mySubstrate);
    }

    /// <summary>
    /// Creates and returns a copy of the template
    /// </summary>
    /// <param name="template">template of substrates list</param>
    public substrates(substrates template)
    {
      foreach (substrate mySubstrate in template)
      {
        addSubstrate( mySubstrate.copy() );
      }

    }

    /// <summary>
    /// Reads the substrate list out of the xml file
    /// </summary>
    /// <param name="XMLfile">a xml file</param>
    public substrates(string XMLfile)
    {
      XmlTextReader reader= new System.Xml.XmlTextReader(XMLfile);

      string xml_tag= "";
      string substrate_id= "";

      // go through the file
      while (reader.Read())
      {
        switch (reader.NodeType)
        {

          case System.Xml.XmlNodeType.Element: // this knot is an element
            xml_tag= reader.Name;
            
            while (reader.MoveToNextAttribute())
            { // read the attributes, here only the attribute of digester
              // is of interest, all other attributes are ignored, 
              // actually there usally are no other attributes
              if (xml_tag == "substrate" && reader.Name == "id")
              {
                // found a new substrate
                substrate_id= reader.Value;

                addSubstrate(new biogas.substrate(ref reader, substrate_id));
                
                break;
              }
            }
            break;
    
        } // switch
      } // while

      //

      reader.Close();
    }



  }
}


