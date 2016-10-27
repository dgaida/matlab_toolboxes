/**
 * This file is part of the partial class substrates and defines
 * all other methods.
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
    //                              !!! PUBLIC METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// Add the given substrate to the substrate list and the ids list
    /// </summary>
    /// <param name="mySubstrate">a substrate</param>
    public void addSubstrate(substrate mySubstrate)
    {
      this.Add(mySubstrate);
      this._ids.Add(mySubstrate.id);
    }

    /// <summary>
    /// Delete the given substrate, defined by its id, from both lists
    /// </summary>
    /// <param name="id">the substrate id</param>
    /// <exception cref="exception">Unknown substrate id</exception>
    public void deleteSubstrate(string id)
    {
      substrate mySubstrate= get(id);

      this.Remove(mySubstrate);
      this._ids.Remove(id);
    }

    /// <summary>
    /// Delete the given substrate, defined by its index, from both lists.
    /// index is 1-based: 1,2,3,...
    /// </summary>
    /// <param name="index">index of substrate</param>
    /// <returns>true on success, else false</returns>
    public bool deleteSubstrate(int index)
    {
      if ((index < 1) || (index > this.Count))
      {
        Console.WriteLine(String.Format("index must be >= 1 and <= {0}, but is: {1}!",
          this.Count, index));
        return false;
      }

      string id= this.ids[index - 1];

      deleteSubstrate(id);

      return true;
    }

    /// <summary>
    /// Print all substrates in the list to a string, which can be plotted
    /// on a console
    /// </summary>
    /// <returns>string to be printed to console</returns>
    public string print()
    {
      StringBuilder sb= new StringBuilder();

      sb.Append("   ----------     SUBSTRATES     ----------   \n");

      foreach (substrate mySubstrate in this)
      {
        sb.Append(mySubstrate.print());
      }

      sb.Append("   ----------     END SUBSTRATES     ----------   \n");

      return sb.ToString();
    }

    /// <summary>
    /// Saves the substrate list in a xml file
    /// </summary>
    /// <param name="XMLfile">a xml file</param>
    public void saveAsXML(string XMLfile)
    {
      StreamWriter writer= File.CreateText(XMLfile);

      writer.Write("<?xml version=\"1.0\" encoding=\"utf-8\"?>\n");

      writer.Write("<substrates>\n");

      foreach (substrate mySubstrate in this)
      {
        writer.Write( mySubstrate.getParamsAsXMLString() );
      }

      writer.Write("</substrates>\n");

      writer.Close();
    }

    /// <summary>
    /// Returns the substrate object with the given id
    /// </summary>
    /// <param name="id">id of the substrate to find</param>
    /// <returns>substrate object</returns>
    /// <exception cref="exception">Unknown substrate id</exception>
    public substrate get(string id)
    {
      foreach (substrate mySubstrate in this)
      {
        if (mySubstrate.id == id)
          return mySubstrate;
      }

      throw new exception(String.Format(
        "Cannot find the substrate (id: {0}) in the list!", id));
    }

    /// <summary>
    /// Returns the substrate at the given position index.
    /// index is 1-based: 1,2,3,...
    /// </summary>
    /// <param name="index">index of substrate</param>
    /// <returns>substrate object</returns>
    /// <exception cref="exception">index invalid</exception>
    public substrate get(int index)
    {
      if ((index < 1) || (index > this.Count))
      {
        throw new exception(String.Format("index must be >= 1 and <= {0}, but is: {1}!",
          this.Count, index));
      }

      return this[index - 1];
    }

    /// <summary>
    /// Returns id and index corresponding to the given name.
    /// The returned index is 1-based
    /// just the first substrate with the given name is returned. if there
    /// are two substrates with the same name better do not use this function.
    /// </summary>
    /// <param name="name">name of substrate</param>
    /// <param name="id">id of substrate belonging to name</param>
    /// <param name="index">index of substrate belonging to name</param>
    /// <exception cref="exception">Unknown substrate name</exception>
    public void getByName(string name, out string id, out int index)
    {
      substrate mySubstrate;

      getByName(name, out id, out index, out mySubstrate);
    }
    /// <summary>
    /// Returns object, id and index corresponding to the given name.
    /// The returned index is 1-based
    /// just the first substrate with the given name is returned. if there
    /// are two substrates with the same name better do not use this function.
    /// </summary>
    /// <param name="name">name of substrate</param>
    /// <param name="id">id of substrate belonging to name</param>
    /// <param name="index">index of substrate belonging to name</param>
    /// <param name="mySubstrate">substrate belonging to name</param>
    /// <exception cref="exception">Unknown substrate name</exception>
    public void getByName(string name, out string id, out int index, 
                                       out substrate mySubstrate)
    {
      int isubstrate= 0;

      foreach (substrate sub in this)
      {
        if (sub.name == name)
        {
          id= sub.id;
          index= isubstrate + 1; // 1-based
          mySubstrate= sub;

          return;
        }

        isubstrate++;
      }

      throw new exception(String.Format(
        "Cannot find the substrate (name: {0}) in the list!", name), "substrates");
    }

    /// <summary>
    /// Returns the id of the substrate at the index'ed position.
    /// index is 1-based: 1,2,3,...
    /// </summary>
    /// <param name="index">index of substrate</param>
    /// <returns>id belonging to index</returns>
    /// <exception cref="exception">index invalid</exception>
    public string getID(int index)
    {
      if ((index < 1) || (index > this.Count))
      {
        throw new exception(String.Format("index must be >= 1 and <= {0}, but is: {1}!",
          this.Count, index));
      }

      return ids[index - 1];
    }
    /// <summary>
    /// Returns the name of the substrate at the index'ed position.
    /// index is 1-based: 1,2,3,...
    /// </summary>
    /// <param name="index">index of substrate</param>
    /// <returns>name belonging to index</returns>
    /// <exception cref="exception">index invalid</exception>
    public string getName(int index)
    {
      if ((index < 1) || (index > this.Count))
      {
        throw new exception(String.Format("index must be >= 1 and <= {0}, but is: {1}!",
          this.Count, index));
      }

      return this[index - 1].get_param_of_s("name");
    }

    /// <summary>
    /// Returns true if given list contains a substrate with the given 
    /// substrate_id 
    /// </summary>
    /// <param name="mySubstrates">list of substrates</param>
    /// <param name="substrate_id">substrate id</param>
    /// <returns>true, if id can be found in substrate list, else false</returns>
    public static bool contains(substrates mySubstrates, string substrate_id)
    {
      foreach (substrate mySubstrate in mySubstrates)
      {
        if (mySubstrate.id == substrate_id)
          return true;
      }

      return false;
    }

    /// <summary>
    /// Returns the number of substrates in the list
    /// </summary>
    /// <returns>number of substrates</returns>
    public int getNumSubstrates()
    {
      return this.ids.Count;
    }
    /// <summary>
    /// Returns the number of substrates in the list as double
    /// Only for MATLAB
    /// </summary>
    /// <returns>number of substrates</returns>
    public double getNumSubstratesD()
    {
      return (double)getNumSubstrates();
    }



  }
}


