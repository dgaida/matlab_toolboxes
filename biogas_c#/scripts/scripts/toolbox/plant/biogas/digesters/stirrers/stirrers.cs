/**
 * This file is part of the partial class stirrers and defines
 * all methods not defined elsewhere.
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
using toolbox;
using System.Xml;
using science;

/**
 * Mainly everything that has to do with biogas is defined in this namespace:
 * 
 * - Anaerobic Digestion Model
 * - CHPs
 * - Stirrers
 * - Plant
 * - Substrates
 * - Chemistry used for biogas stuff
 * 
 */
namespace biogas
{
  /// <summary>
  /// list of stirrers
  /// </summary>
  public partial class stirrers : List<stirrer>
  {

    // -------------------------------------------------------------------------------------
    //                              !!! CONSTRUCTOR METHODS !!!
    // -------------------------------------------------------------------------------------

    

    // -------------------------------------------------------------------------------------
    //                              !!! PUBLIC METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// add the given stirrer to the list
    /// </summary>
    /// <param name="myStirrer">to be added stirrer</param>
    public void addStirrer(stirrer myStirrer)
    {
      this.Add(myStirrer);
      this.ids.Add(myStirrer.id);
    }

    /// <summary>
    /// Delete the specified stirrer from the lists.
    /// </summary>
    /// <param name="id">id of stirrer</param>
    /// <returns>true if successfull, else false</returns>
    public bool deleteStirrer(string id)
    {
      stirrer myStirrer;

      try
      {
        myStirrer = get(id);
      }
      catch (exception e)
      {
        Console.WriteLine(e.Message);
        return false;
      }

      this.Remove(myStirrer);
      return this.ids.Remove(id);
    }
    /// <summary>
    /// Delete the specified stirrer from the lists. index is 1-based.
    /// </summary>
    /// <param name="index">stirrer index</param>
    /// <exception cref="exception">Invalid stirrer index</exception>
    public void deleteStirrer(int index)
    {
      if (index <= 0 || index > getNumStirrers())
        throw new exception(String.Format(
          "index out of bounds: {0}! Must be between 1 ... {1}", index, getNumStirrers()));

      string id= this.ids[index - 1];

      deleteStirrer(id);
    }



    /// <summary>
    /// calculate mechanical power [kWh/d]
    /// </summary>
    /// <param name="Tdigester">temperature inside digester in [°C]</param>
    /// <param name="TSdigester">TS content inside digester in [% FM]</param>
    /// <returns>power [kWh/d]</returns>
    /// <exception cref="exception">calculation of stirrer power failed</exception>
    public double calcPelectrical(double Tdigester, double TSdigester)
    {
      double Pel_tot = 0;   // kWh/d

      foreach (stirrer myStirrer in this)
      {
        try
        {
          Pel_tot += myStirrer.calcPelectrical(Tdigester, TSdigester);
        }
        catch (exception e)
        { 
          Console.WriteLine(e.Message);
          throw new exception(String.Format("Calculation of stirrer power for stirrer {0} failed!", 
            myStirrer.id));
        }
      }

      return Pel_tot;
    }

    /// <summary>
    /// calculate dissipated power [kWh/d]
    /// </summary>
    /// <param name="Tdigester">temperature inside digester in [°C]</param>
    /// <param name="TSdigester">TS content inside digester in [% FM]</param>
    /// <returns>power [kWh/d]</returns>
    /// <exception cref="exception">calculation of stirrer power failed</exception>
    public double calcPdissipation(double Tdigester, double TSdigester)
    {
      double Pdiss_tot = 0;   // kWh/d

      foreach (stirrer myStirrer in this)
      {
        try
        {
          Pdiss_tot += myStirrer.calcPdissipation(Tdigester, TSdigester);
        }
        catch (exception e)
        {
          Console.WriteLine(e.Message);
          throw new exception(String.Format("Calculation of stirrer power for stirrer {0} failed!",
            myStirrer.id));
        }
      }

      return Pdiss_tot;
    }



    /// <summary>
    /// Read params from reader which reads a xml file.
    /// Reads all stirrers out of the file, until end element stirrers is found.
    /// Adds all stirrers to stirrer list.
    /// </summary>
    /// <param name="reader">open xml reader</param>
    public void getParamsFromXMLReader(ref XmlTextReader reader)
    {
      string xml_tag= "";
      string stirrer_id= "";

      bool do_while= true;

      while (reader.Read() && do_while)
      {
        switch (reader.NodeType)
        {

          case System.Xml.XmlNodeType.Element: // this knot is an element
            xml_tag= reader.Name;

            while (reader.MoveToNextAttribute())
            { // read the attributes, here only the attribute of stirrer
              // is of interest, all other attributes are ignored, 
              // actually there usally are no other attributes
              if (xml_tag == "stirrer" && reader.Name == "id")
              {
                // found a new stirrer
                stirrer_id= reader.Value;

                addStirrer(new biogas.stirrer(ref reader, stirrer_id));

                break;
              }
            }
            break;

          case System.Xml.XmlNodeType.EndElement:
            if (reader.Name == "stirrers")
              do_while= false;

            break;
        }
      }

    }

    /// <summary>
    /// Return the params as a xml string
    /// </summary>
    /// <returns>string with xml tags</returns>
    public string getParamsAsXMLString()
    {
      StringBuilder sb= new StringBuilder();

      sb.Append("<stirrers>\n");

      foreach (stirrer myStirrer in this)
      {
        sb.Append(myStirrer.getParamsAsXMLString());
      }

      sb.Append("</stirrers>\n");

      return sb.ToString();
    }

    /// <summary>
    /// Print stirrers to a string, to be displayed on a console
    /// </summary>
    /// <returns>string for console</returns>
    public string print()
    {
      StringBuilder sb= new StringBuilder();

      foreach (stirrer myStirrer in this)
      {
        sb.Append(myStirrer.print());
      }

      return sb.ToString();
    }

    /// <summary>
    /// Returns the by id specified stirrer object
    /// </summary>
    /// <param name="id">id of stirrer</param>
    /// <returns>stirrer object</returns>
    /// <exception cref="exception">Unknown stirrer id</exception>
    public stirrer get(string id)
    {
      foreach (stirrer myStirrer in this)
      {
        if (myStirrer.id == id)
          return myStirrer;
      }

      throw new exception(String.Format(
        "Cannot find the stirrer (id: {0}) in the list!", id));
    }
    /// <summary>
    /// Returns the by index specified stirrer object. index is 1-based.
    /// </summary>
    /// <param name="index">index of stirrer</param>
    /// <returns>stirrer object</returns>
    /// <exception cref="exception">Invalid stirrer index</exception>
    public stirrer get(int index)
    {
      if (index <= 0 || index > getNumStirrers())
        throw new exception(String.Format(
          "index out of bounds: {0}! Must be between 1 ... {1}", index, getNumStirrers()));

      return this[index - 1];
    }

    /// <summary>
    /// Returns specified stirrer out of the given stirrer array
    /// </summary>
    /// <param name="stirrers">list of stirrers</param>
    /// <param name="id">stirrer id</param>
    /// <returns>stirrer object</returns>
    /// <exception cref="exception">Unknown stirrer id</exception>
    public static stirrer get(biogas.stirrer[] stirrers, string id)
    {
      foreach (stirrer myStirrer in stirrers)
      {
        if (myStirrer.id == id)
          return myStirrer;
      }

      throw new exception(String.Format(
        "Cannot find the stirrer (id: {0}) in the array!", id));
    }
    /// <summary>
    /// Returns the by id specified stirrer object
    /// </summary>
    /// <param name="id">stirrer id</param>
    /// <returns>stirrer</returns>
    /// <exception cref="exception">Unknown stirrer id</exception>
    [Obsolete("Please use get(id) instead!")]
    public stirrer getByID(string id)
    {
      return get(id);
    }
    /// <summary>
    /// Returns the by id specified stirrer object and the index in the list.
    /// index is 1-based.
    /// </summary>
    /// <param name="id">stirrer id</param>
    /// <param name="index">index of specified stirrer</param>
    /// <returns>stirrer object</returns>
    /// <exception cref="exception">Unknown stirrer id</exception>
    public stirrer getByID(string id, out int index)
    {
      int istirrer= 0;

      foreach (stirrer myStirrer in this)
      {
        if (myStirrer.id == id)
        {
          index= istirrer + 1;

          return myStirrer;
        }

        istirrer++;
      }

      throw new exception(String.Format(
        "Cannot find the stirrer (id: {0}) in the list!", id));
    }
    /// <summary>
    /// Returns the by id specified index of the stirrer in the list.
    /// index is 1-based.
    /// </summary>
    /// <param name="id">stirrer id</param>
    /// <returns>index of specified stirrer</returns>
    /// <exception cref="exception">Unknown stirrer id</exception>
    public int getIndexByID(string id)
    {
      int index;

      getByID(id, out index);

      return index;
    }
    /// <summary>
    /// Returns the by index specified stirrer object. index is 1-based.
    /// </summary>
    /// <param name="index">index of stirrer</param>
    /// <returns>stirrer object</returns>
    /// <exception cref="exception">Invalid stirrer index</exception>
    [Obsolete("Please use get(index) instead!")]
    public stirrer getByIndex(int index)
    {
      return get(index);
    }



    /// <summary>
    /// Returns true if id is inside this list
    /// </summary>
    /// <param name="id">stirrer id</param>
    /// <returns>true if id is in this list, else false</returns>
    public bool contains(string id)
    {
      return contains(this, id);
    }
    /// <summary>
    /// Returns true if myStirrers contains the given id
    /// </summary>
    /// <param name="myStirrers">list of stirrers</param>
    /// <param name="id">id of stirrer</param>
    /// <returns>true if id is in list, else false</returns>
    public static bool contains(stirrers myStirrers, string id)
    {
      foreach (stirrer myStirrer in myStirrers)
      {
        if (myStirrer.id == id)
          return true;
      }

      return false;
    }

    /// <summary>
    /// Returns number of Stirrers
    /// </summary>
    /// <returns>number of stirrers in this list</returns>
    public int getNumStirrers()
    {
      return this.ids.Count;
    }
    /// <summary>
    /// Returns number of Stirrers as double, only for MATLAB.
    /// </summary>
    /// <returns>number of stirrers in this list</returns>
    public double getNumStirrersD()
    {
      return (double)getNumStirrers();
    }



  }
}


