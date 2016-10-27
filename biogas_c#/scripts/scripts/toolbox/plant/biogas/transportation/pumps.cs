/**
 * This file is part of the partial class pumps and defines
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
  /// list of pumps
  /// 
  /// contains all pumps that are included inside the simulation model
  /// 
  /// next to pumps there also could be other transportation objects
  /// inside the model, see the other class
  /// </summary>
  public partial class pumps : List<pump>
  {

    // -------------------------------------------------------------------------------------
    //                              !!! CONSTRUCTOR METHODS !!!
    // -------------------------------------------------------------------------------------

    

    // -------------------------------------------------------------------------------------
    //                              !!! PUBLIC METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// add the given pump to the list
    /// </summary>
    /// <param name="myPump">pump</param>
    public void addPump(pump myPump)
    {
      this.Add(myPump);
    }

    /// <summary>
    /// Delete the specified pump from the list.
    /// </summary>
    /// <param name="id">id of the pump</param>
    /// <exception cref="exception">Unknown pump id</exception>
    public void deletePump(string id)
    {
      pump myPump= get(id);

      this.Remove(myPump);
    }
    /// <summary>
    /// Delete the specified pump from the list.
    /// </summary>
    /// <param name="myPump">pump to be deleted</param>
    public void deletePump(pump myPump)
    {
      this.Remove(myPump);
    }
    /// <summary>
    /// Delete the specified pump from the lists. index is 1-based.
    /// </summary>
    /// <param name="index">index of the pump in the list: 1, 2, 3</param>
    /// <exception cref="exception">Invalid pump index</exception>
    public void deletePump(int index)
    {
      if (index <= 0 || index > getNumPumps())
        throw new exception(String.Format(
          "index out of bounds: {0}! Must be between 1 ... {1}", index, getNumPumps()));

      pump myPump= this[index - 1];

      deletePump(myPump);
    }



    /// <summary>
    /// Read params from reader which reads a xml file.
    /// reads until end elements of pumps, adds all read pumps to list
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

            if (xml_tag == "pump")
            {
              // found a new pump
              addPump(new biogas.pump(ref reader));             
            }
            break;

          case System.Xml.XmlNodeType.EndElement:
            if (reader.Name == "pumps")
              do_while= false;

            break;
        }
      }

    }

    /// <summary>
    /// Return the params of all pumps as a xml string
    /// </summary>
    /// <returns>for xml file</returns>
    public string getParamsAsXMLString()
    {
      StringBuilder sb= new StringBuilder();

      sb.Append("<pumps>\n");

      foreach (pump myPump in this)
      {
        sb.Append( myPump.getParamsAsXMLString() );
      }

      sb.Append("</pumps>\n");

      return sb.ToString();
    }

    /// <summary>
    /// Print pumps to a string, to be displayed on a console
    /// </summary>
    /// <returns>for console</returns>
    public string print()
    {
      StringBuilder sb= new StringBuilder();

      foreach (pump myPump in this)
      {
        sb.Append(myPump.print());
      }

      return sb.ToString();
    }

    /// <summary>
    /// Returns the by id specified pump object
    /// </summary>
    /// <param name="id">id of the pump</param>
    /// <returns>corresponding pump</returns>
    /// <exception cref="exception">Unknown pump id</exception>
    public pump get(string id)
    {
      foreach (pump myPump in this)
      {
        if (myPump.id == id)
          return myPump;
      }

      throw new exception(String.Format(
        "Cannot find the pump (id: {0}) in the list!", id));
    }
    /// <summary>
    /// Returns the by index specified pump object. index is 1-based.
    /// </summary>
    /// <param name="index">index of the pump in the list: 1, 2, 3, ...</param>
    /// <returns>pump</returns>
    /// <exception cref="exception">Invalid pump index</exception>
    public pump get(int index)
    {
      if (index <= 0 || index > getNumPumps())
        throw new exception(String.Format(
          "index out of bounds: {0}! Must be between 1 ... {1}", index, getNumPumps()));

      return this[index - 1];
    }

    /// <summary>
    /// Returns the by id specified pump object and the index in the list.
    /// index is 1-based.
    /// </summary>
    /// <param name="id">id of the pump</param>
    /// <param name="index">index of the pump in the list: 1, 2, 3, ...</param>
    /// <returns>pump</returns>
    /// <exception cref="exception">Unknown pump id</exception>
    public pump getByID(string id, out int index)
    {
      int ipump= 0;

      foreach (pump myPump in this)
      {
        if (myPump.id == id)
        {
          index= ipump + 1;

          return myPump;
        }

        ipump++;
      }

      throw new exception(String.Format(
        "Cannot find the pump (id: {0}) in the list!", id));
    }
    /// <summary>
    /// Returns the by id specified index of the pump in the list.
    /// index is 1-based.
    /// </summary>
    /// <param name="id">id of the pump</param>
    /// <returns>index of the pump in the list: 1, 2, 3, ...</returns>
    /// <exception cref="exception">Unknown pump id</exception>
    public int getIndexByID(string id)
    {
      int index;

      getByID(id, out index);

      return index;
    }
    
    
    /// <summary>
    /// Returns true if id is inside this list
    /// </summary>
    /// <param name="id">id of the pump</param>
    /// <returns>true, if id inside list, else false</returns>
    public bool contains(string id)
    {
      return contains(this, id);
    }
    /// <summary>
    /// Returns true if myPumps contains the given id
    /// </summary>
    /// <param name="myPumps">lsit of pumps</param>
    /// <param name="id">id of the pump</param>
    /// <returns>true, if id inside list, else false</returns>
    public static bool contains(pumps myPumps, string id)
    {
      foreach (pump myPump in myPumps)
      {
        if (myPump.id == id)
          return true;
      }

      return false;
    }

    /// <summary>
    /// Returns number of Pumps
    /// </summary>
    /// <returns>number of pumps in the list</returns>
    public int getNumPumps()
    {
      return this.Count;
    }
    /// <summary>
    /// Returns number of Pumps as double, only for MATLAB.
    /// </summary>
    /// <returns>number of pumps in the list</returns>
    public double getNumPumpsD()
    {
      return (double)getNumPumps();
    }


    
  }
}


