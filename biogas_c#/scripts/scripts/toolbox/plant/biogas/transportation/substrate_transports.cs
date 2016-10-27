/**
 * This file is part of the partial class substrate_transports and defines
 * all methods not defined elsewhere.
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
  /// list of substrate_transports
  /// 
  /// contains all substrate_transports that are included inside the simulation model
  /// 
  /// next to substrate_transports there also could be other transportation objects
  /// inside the model, see the other class
  /// </summary>
  public partial class substrate_transports : List<substrate_transport>
  {

    // -------------------------------------------------------------------------------------
    //                              !!! CONSTRUCTOR METHODS !!!
    // -------------------------------------------------------------------------------------

    

    // -------------------------------------------------------------------------------------
    //                              !!! PUBLIC METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// add the given substrate_transport to the list
    /// </summary>
    /// <param name="mySubstrateTransport">substrate transport</param>
    public void addSubstrateTransport(substrate_transport mySubstrateTransport)
    {
      this.Add(mySubstrateTransport);
    }

    /// <summary>
    /// Delete the specified substrate_transport from the list.
    /// </summary>
    /// <param name="id">id of the substrate_transport</param>
    /// <exception cref="exception">Unknown id</exception>
    public void deleteSubstrateTransport(string id)
    {
      substrate_transport mySubstrateTransport= get(id);

      this.Remove(mySubstrateTransport);
    }
    /// <summary>
    /// Delete the specified substrate_transport from the list.
    /// </summary>
    /// <param name="mySubstrateTransport">substrate transport</param>
    public void deleteSubstrateTransport(substrate_transport mySubstrateTransport)
    {
      this.Remove(mySubstrateTransport);
    }
    /// <summary>
    /// Delete the specified substrate_transport from the lists. index is 1-based.
    /// </summary>
    /// <param name="index">index of the substrate_transport in the list: 1, 2, 3</param>
    /// <exception cref="exception">Invalid index</exception>
    public void deleteSubstrateTransport(int index)
    {
      if (index <= 0 || index > getNumSubstrateTransports())
        throw new exception(String.Format(
          "index out of bounds: {0}! Must be between 1 ... {1}", index, getNumSubstrateTransports()));

      substrate_transport mySubstrateTransport = this[index - 1];

      deleteSubstrateTransport(mySubstrateTransport);
    }



    /// <summary>
    /// Read params from reader which reads a xml file.
    /// reads until end elements of substrate_transports, adds all read substrate_transports to list
    /// </summary>
    /// <param name="reader">an open reader</param>
    public void getParamsFromXMLReader(ref XmlTextReader reader)
    {
      string xml_tag= "";
 
      bool do_while= true;

      while (reader.Read() && do_while)
      {
        switch (reader.NodeType)
        {

          case System.Xml.XmlNodeType.Element: // this knot is an element
            xml_tag= reader.Name;

            if (xml_tag == "substrate_transport")
            {
              // found a new substrate_transport
              addSubstrateTransport(new biogas.substrate_transport(ref reader));             
            }
            break;

          case System.Xml.XmlNodeType.EndElement:
            if (reader.Name == "substrate_transports")
              do_while= false;

            break;
        }
      }

    }

    /// <summary>
    /// Return the params of all substrate_transports as a xml string
    /// </summary>
    /// <returns>for xml file</returns>
    public string getParamsAsXMLString()
    {
      StringBuilder sb= new StringBuilder();

      sb.Append("<substrate_transports>\n");

      foreach (substrate_transport mySubstrateTransport in this)
      {
        sb.Append( mySubstrateTransport.getParamsAsXMLString() );
      }

      sb.Append("</substrate_transports>\n");

      return sb.ToString();
    }

    /// <summary>
    /// Print substrate_transports to a string, to be displayed on a console
    /// </summary>
    /// <returns>for console</returns>
    public string print()
    {
      StringBuilder sb= new StringBuilder();

      foreach (substrate_transport mySubstrateTransport in this)
      {
        sb.Append(mySubstrateTransport.print());
      }

      return sb.ToString();
    }

    /// <summary>
    /// Returns the by id specified substrate_transport object
    /// </summary>
    /// <param name="id">id of the substrate_transport</param>
    /// <returns>substrate transport object</returns>
    /// <exception cref="exception">Unknown id</exception>
    public substrate_transport get(string id)
    {
      foreach (substrate_transport mySubstrateTransport in this)
      {
        if (mySubstrateTransport.id == id)
          return mySubstrateTransport;
      }

      throw new exception(String.Format(
        "Cannot find the substrate_transport (id: {0}) in the list!", id));
    }
    /// <summary>
    /// Returns the by index specified substrate_transport object. index is 1-based.
    /// </summary>
    /// <param name="index">index of the substrate_transport in the list: 1, 2, 3, ...</param>
    /// <returns></returns>
    /// <exception cref="exception">Invalid index</exception>
    public substrate_transport get(int index)
    {
      if (index <= 0 || index > getNumSubstrateTransports())
        throw new exception(String.Format(
          "index out of bounds: {0}! Must be between 1 ... {1}", index, getNumSubstrateTransports()));

      return this[index - 1];
    }

    /// <summary>
    /// Returns the by id specified substrate_transport object and the index in the list.
    /// index is 1-based.
    /// </summary>
    /// <param name="id">id of the substrate_transport</param>
    /// <param name="index">index of the substrate_transport in the list: 1, 2, 3, ...</param>
    /// <returns></returns>
    /// <exception cref="exception">Unknown id</exception>
    public substrate_transport getByID(string id, out int index)
    {
      int isubstrate_transport= 0;

      foreach (substrate_transport mySubstrateTransport in this)
      {
        if (mySubstrateTransport.id == id)
        {
          index= isubstrate_transport + 1;

          return mySubstrateTransport;
        }

        isubstrate_transport++;
      }

      throw new exception(String.Format(
        "Cannot find the substrate_transport (id: {0}) in the list!", id));
    }
    /// <summary>
    /// Returns the by id specified index of the substrate_transport in the list.
    /// index is 1-based.
    /// </summary>
    /// <param name="id">id of the substrate_transport</param>
    /// <returns>index of the substrate_transport in the list: 1, 2, 3, ...</returns>
    /// <exception cref="exception">Unknown id</exception>
    public int getIndexByID(string id)
    {
      int index;

      getByID(id, out index);

      return index;
    }
    
    
    /// <summary>
    /// Returns true if id is inside this list
    /// </summary>
    /// <param name="id">id of the substrate_transport</param>
    /// <returns>true, if id inside list, else false</returns>
    public bool contains(string id)
    {
      return contains(this, id);
    }
    /// <summary>
    /// Returns true if mySubstrateTransports contains the given id
    /// </summary>
    /// <param name="mySubstrateTransports">list of substrate transport objects</param>
    /// <param name="id">id of the substrate_transport</param>
    /// <returns>true, if id inside list, else false</returns>
    public static bool contains(substrate_transports mySubstrateTransports, string id)
    {
      foreach (substrate_transport mySubstrateTransport in mySubstrateTransports)
      {
        if (mySubstrateTransport.id == id)
          return true;
      }

      return false;
    }

    /// <summary>
    /// Returns number of SubstrateTransports
    /// </summary>
    /// <returns>number of substrate_transports in the list</returns>
    public int getNumSubstrateTransports()
    {
      return this.Count;
    }
    /// <summary>
    /// Returns number of SubstrateTransports as double, only for MATLAB.
    /// </summary>
    /// <returns>number of substrate_transports in the list</returns>
    public double getNumSubstrateTransportsD()
    {
      return (double)getNumSubstrateTransports();
    }


    
  }
}


