/**
 * This file is part of the partial class plant and defines
 * all constructor methods of the plant.
 * 
 * TODOs:
 * - 
 * 
 * Should be FINISHED!
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
  /// Defines the biogas plant.
  /// It is defined by its id and has a name.
  /// A biogas plant contains digesters, chps and pumps.
  /// 
  /// </summary>
  public partial class plant
  {

    // -------------------------------------------------------------------------------------
    //                              !!! CONSTRUCTOR METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// Standard constructor creating an empty plant, but with physValues set to default.
    /// </summary>
    public plant()
    {
      set_params_of();
    }

    /// <summary>
    /// Constructor creating the plant by reading from the given xml file.
    /// </summary>
    /// <param name="XMLfile"></param>
    public plant(string XMLfile)
    {
      XmlTextReader reader= new System.Xml.XmlTextReader(XMLfile);

      string xml_tag= "";
      string param= "";

      set_params_of();

      string plant_id= "";

      //bool finances_tag= false;      // true after finances xml tag was found <finances>

      while (reader.Read())
      {
        switch (reader.NodeType)
        {

          case System.Xml.XmlNodeType.Element: // this knot is an element
            xml_tag= reader.Name;

            while (reader.MoveToNextAttribute())
            { // read the attributes, here only the attribute of plant, digester and chp 
              // are of interest, all other attributes are ignored, 
              // actually there usally are no other attributes
              if (xml_tag == "plant" && reader.Name == "id")
              {
                _id= reader.Value;
                plant_id= _id;

                break;
              }
              else if (xml_tag == "physValue" && reader.Name == "symbol")
              {
                // found a new parameter
                param= reader.Value;

                switch (param)
                {
                  case "g":
                    g.getParamsFromXMLReader(ref reader, param);
                    break;
                  case "Tout":
                    Tout.getParamsFromXMLReader(ref reader, param);
                    break;
                }
                break;
              }
            }

            if (xml_tag == "digesters")
            {
              myDigesters.getParamsFromXMLReader(ref reader);
              plant_id= "";
            }
            else if (xml_tag == "chps")
            {
              myCHPs.getParamsFromXMLReader(ref reader);
              plant_id= "";
            }
            else if (xml_tag == "transportation")
            {
              myTransportation.getParamsFromXMLReader(ref reader);
              plant_id = "";
            }
            else if (xml_tag == "finances")// && !finances_tag)
            {
              myFinances.getParamsFromXMLReader(ref reader);
              plant_id= "";
              //finances_tag= true;
            }
            
            break;

          case System.Xml.XmlNodeType.Text: // text, thus value, of each element

            if (plant_id != "")             // ignore the text before the plant is found
            {
              switch (xml_tag)
              {
                case "name":
                  _name= reader.Value;
                  break;
                case "construct_year":      // construction year
                  _construct_year = System.Xml.XmlConvert.ToInt32(reader.Value);
                  break;
              }
            }
            // löschen
            //else if (finances_tag)
            //{
            //  double value = System.Xml.XmlConvert.ToDouble(reader.Value);//Convert.ToDouble(reader.Value);

            //  myFinances.set_params_of(xml_tag, value);
            //}
            break;

        } // switch
      } // while

      //

      reader.Close();

    }



  }
}


