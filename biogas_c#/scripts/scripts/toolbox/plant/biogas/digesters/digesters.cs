/**
 * This file is part of the partial class digesters and defines
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
 * - Digesters
 * - Plant
 * - Substrates
 * - Chemistry used for biogas stuff
 * 
 */
namespace biogas
{
  /// <summary>
  /// list of digesters
  /// </summary>
  public partial class digesters : List<digester>
  {

    // -------------------------------------------------------------------------------------
    //                              !!! CONSTRUCTOR METHODS !!!
    // -------------------------------------------------------------------------------------

    

    // -------------------------------------------------------------------------------------
    //                              !!! PUBLIC METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// add the given digester to the list
    /// </summary>
    /// <param name="myDigester"></param>
    public void addDigester(digester myDigester)
    {
      this.Add(myDigester);
      this.ids.Add(myDigester.id);
    }

    /// <summary>
    /// Delete the specified digester from the lists.
    /// </summary>
    /// <param name="id">digester id</param>
    /// <exception cref="exception">Unknown digester id</exception>
    public void deleteDigester(string id)
    {
      digester myDigester= get(id);

      this.Remove(myDigester);
      this.ids.Remove(id);
    }
    /// <summary>
    /// Delete the specified digester from the lists. index is 1-based.
    /// </summary>
    /// <param name="index">digester index</param>
    /// <exception cref="exception">Invalid digester index</exception>
    public void deleteDigester(int index)
    {
      if (index <= 0 || index > getNumDigesters())
        throw new exception(String.Format(
          "digester index out of bounds: {0}! Must be between 1 ... {1}", index, getNumDigesters()));

      string id= this.ids[index - 1];

      deleteDigester(id);
    }



    ///// <summary>
    ///// Calculate thermal power needed to compensate heat loss due ot radiation
    ///// through the digesters surface. 
    ///// </summary>
    ///// <param name="digester_id"></param>
    ///// <param name="T_ambient"></param>
    ///// <param name="P_radiation_loss_kW"></param>
    ///// <param name="P_radiation_loss_kWh_d"></param>
    //public void compensateHeatLossDueToRadiation(string digester_id,
    //                                             physValue T_ambient, 
    //                                             out physValue P_radiation_loss_kW,
    //                                             out physValue P_radiation_loss_kWh_d)
    //{
    //  digester myDigester= get(digester_id);

    //  myDigester.compensateHeatLossDueToRadiation(T_ambient, out P_radiation_loss_kW,
    //                                                         out P_radiation_loss_kWh_d);
    //}

    /// <summary>
    /// Calculates costs for heating the digester. in case of a thermal heating
    /// costs are lost gain which we had if we sell the thermal energy. In case
    /// of an electrical heating it is the cost producing the electrical energy.
    /// </summary>
    /// <param name="digester_id">digester id</param>
    /// <param name="pP_loss">thermal power loss</param>
    /// <param name="sell_heat">€/kWh for selling thermal energy, this is a virtual price here
    /// missed gain, needed for a thermal heating</param>
    /// <param name="cost_elEnergy">costs for electricity in €/kWh, needed if we have a electrical
    /// heating</param>
    /// <returns>costs in €/d</returns>
    /// <exception cref="exception">Unknown digester id</exception>
    /// <exception cref="exception">efficiency is zero, division by zero</exception>
    public double calcCostsForHeating(string digester_id, physValue pP_loss, double sell_heat, 
      double cost_elEnergy)
    {
      digester myDigester = get(digester_id);

      return myDigester.calcCostsForHeating(pP_loss, sell_heat, cost_elEnergy);
    }

    /// <summary>
    /// Calculate thermal/electrical power needed by heating to compensate heat loss in digester. 
    /// </summary>
    /// <param name="digester_id">digester id</param>
    /// <param name="Q">substrate feed measured in m^3/d</param>
    /// <param name="mySubstrates"></param>
    /// <param name="T_ambient">ambient temperature</param>
    /// <param name="mySensors"></param>
    /// <returns>thermal/electrical energy needed by heating in kWh/d</returns>
    /// <exception cref="exception">Unknown digester id</exception>
    /// <exception cref="exception">Q.Length != mySubstrates.Count</exception>
    /// <exception cref="exception">efficiency is zero, division by zero</exception>
    public double calcHeatPower(string digester_id, double[] Q, substrates mySubstrates,
      physValue T_ambient, sensors mySensors)
    {
      digester myDigester = get(digester_id);

      return myDigester.calcHeatPower(Q, mySubstrates, T_ambient, mySensors);
    }

    /// <summary>
    /// Calculates the thermal energy balance of the digester. It compares 
    /// thermal sinks (negative) with thermal sources (positive) inside the digester
    /// thermal sinks are:
    /// - heat substrates
    /// - radiation
    /// thermal sources are:
    /// - microbiology
    /// - stirrer dissipation
    /// </summary>
    /// <param name="digester_id">digester id</param>
    /// <param name="Q">substrate feed measured in m^3/d</param>
    /// <param name="mySubstrates"></param>
    /// <param name="T_ambient">ambient temperature</param>
    /// <param name="mySensors"></param>
    /// <returns>thermal energy balance measured in kWh/d</returns>
    /// <exception cref="exception">Unknown digester id</exception>
    /// <exception cref="exception">Q.Length != mySubstrates.Count</exception>
    public double calcThermalEnergyBalance(string digester_id,
                                           double[] Q, substrates mySubstrates, physValue T_ambient,
      sensors mySensors)
    {
      digester myDigester = get(digester_id);

      return myDigester.calcThermalEnergyBalance(Q, mySubstrates, T_ambient, mySensors);
    }



    /// <summary>
    /// Read params from reader which reads a xml file.
    /// Reads all digesters out of the file, until end element digesters is found.
    /// Adds all digesters to digester list.
    /// </summary>
    /// <param name="reader"></param>
    public void getParamsFromXMLReader(ref XmlTextReader reader)
    {
      string xml_tag= "";
      string digester_id= "";

      bool do_while= true;

      while (reader.Read() && do_while)
      {
        switch (reader.NodeType)
        {

          case System.Xml.XmlNodeType.Element: // this knot is an element
            xml_tag= reader.Name;

            while (reader.MoveToNextAttribute())
            { // read the attributes, here only the attribute of digester
              // is of interest, all other attributes are ignored, 
              // actually there usally are no other attributes
              if (xml_tag == "digester" && reader.Name == "id")
              {
                // found a new digester
                digester_id= reader.Value;

                addDigester(new biogas.digester(ref reader, digester_id));

                break;
              }
            }
            break;

          case System.Xml.XmlNodeType.EndElement:
            if (reader.Name == "digesters")
              do_while= false;

            break;
        }
      }

    }

    /// <summary>
    /// Return the params as a xml string
    /// </summary>
    /// <returns></returns>
    public string getParamsAsXMLString()
    {
      StringBuilder sb= new StringBuilder();

      sb.Append("<digesters>\n");

      foreach (digester myDigester in this)
      {
        sb.Append(myDigester.getParamsAsXMLString());
      }

      sb.Append("</digesters>\n");

      return sb.ToString();
    }

    /// <summary>
    /// Print digesters to a string, to be displayed on a console
    /// </summary>
    /// <returns></returns>
    public string print()
    {
      StringBuilder sb= new StringBuilder();

      foreach (digester myDigester in this)
      {
        sb.Append(myDigester.print());
      }

      return sb.ToString();
    }

    /// <summary>
    /// Returns the by id specified digester object
    /// </summary>
    /// <param name="id">digester id</param>
    /// <returns></returns>
    /// <exception cref="exception">Unknown digester id</exception>
    public digester get(string id)
    {
      foreach (digester myDigester in this)
      {
        if (myDigester.id == id)
          return myDigester;
      }

      throw new exception(String.Format(
        "Cannot find the digester (id: {0}) in the list!", id));
    }
    /// <summary>
    /// Returns the by index specified digester object. index is 1-based.
    /// </summary>
    /// <param name="index">digester index</param>
    /// <returns></returns>
    /// <exception cref="exception">Invalid digester index</exception>
    public digester get(int index)
    {
      if (index <= 0 || index > getNumDigesters())
        throw new exception(String.Format(
          "digester index out of bounds: {0}! Must be between 1 ... {1}", index, getNumDigesters()));

      return this[index - 1];
    }

    /// <summary>
    /// Returns specified digester out of the given digester array
    /// </summary>
    /// <param name="digesters"></param>
    /// <param name="id">digester id</param>
    /// <returns></returns>
    /// <exception cref="exception">Unknown digester id</exception>
    public static digester get(biogas.digester[] digesters, string id)
    {
      foreach (digester myDigester in digesters)
      {
        if (myDigester.id == id)
          return myDigester;
      }

      throw new exception(String.Format(
        "Cannot find the digester (id: {0}) in the array!", id));
    }
    /// <summary>
    /// Returns the by id specified digester object
    /// </summary>
    /// <param name="id">digester id</param>
    /// <returns></returns>
    /// <exception cref="exception">Unknown digester id</exception>
    [Obsolete("Please use get(id) instead!")]
    public digester getByID(string id)
    {
      return get(id);
    }
    /// <summary>
    /// Returns the by id specified digester object and the index in the list.
    /// index is 1-based.
    /// </summary>
    /// <param name="id">digester id</param>
    /// <param name="index">corresponding digester index</param>
    /// <returns></returns>
    /// <exception cref="exception">Unknown digester id</exception>
    public digester getByID(string id, out int index)
    {
      int idigester= 0;

      foreach (digester myDigester in this)
      {
        if (myDigester.id == id)
        {
          index= idigester + 1;

          return myDigester;
        }

        idigester++;
      }

      throw new exception(String.Format(
        "Cannot find the digester (id: {0}) in the list!", id));
    }
    /// <summary>
    /// Returns the by id specified index of the digester in the list.
    /// index is 1-based.
    /// </summary>
    /// <param name="id">digester id</param>
    /// <returns>corresponding digester index</returns>
    /// <exception cref="exception">Unknown digester id</exception>
    public int getIndexByID(string id)
    {
      int index;

      getByID(id, out index);

      return index;
    }
    /// <summary>
    /// Returns the by index specified digester object. index is 1-based.
    /// </summary>
    /// <param name="index">digester index</param>
    /// <returns></returns>
    /// <exception cref="exception">Invalid digester index</exception>
    [Obsolete("Please use get(index) instead!")]
    public digester getByIndex(int index)
    {
      return get(index);
    }

    /// <summary>
    /// Returns index of the named digester.
    /// index is 1-based.
    /// </summary>
    /// <param name="name">digester name</param>
    /// <param name="index">corresponding digester index</param>
    /// <exception cref="exception">Unknown digester name</exception>
    public void getByName(string name, out int index)
    {
      string id;

      getByName(name, out id, out index);
    }
    /// <summary>
    /// Returns id and index of the named digester.
    /// index is 1-based.
    /// </summary>
    /// <param name="name">digester name</param>
    /// <param name="id">corresponding digester id</param>
    /// <param name="index">corresponding digester index</param>
    /// <exception cref="exception">Unknown digester name</exception>
    public void getByName(string name, out string id, out int index)
    {
      digester myDigester;

      getByName(name, out id, out index, out myDigester);
    }
    /// <summary>
    /// Returns id, index and digester object of the named digester.
    /// index is 1-based.
    /// </summary>
    /// <param name="name">digester name</param>
    /// <param name="id">corresponding digester id</param>
    /// <param name="index">corresponding digester index</param>
    /// <param name="myDigester"></param>
    /// <exception cref="exception">Unknown digester name</exception>
    public void getByName(string name, out string id, out int index,
                                       out digester myDigester)
    {
      int idigester= 0;

      foreach (digester dig in this)
      {
        if (dig.name == name)
        {
          id= dig.id;
          index= idigester + 1; // 1-based
          myDigester= dig;

          return;
        }

        idigester++;
      }

      throw new exception(String.Format(
        "Cannot find the digester (name: {0}) in the list!", name));
    }

    /// <summary>
    /// Returns true if id is inside this list
    /// </summary>
    /// <param name="id">digester id</param>
    /// <returns>true if this list contains id, else false</returns>
    public bool contains(string id)
    {
      return contains(this, id);
    }
    /// <summary>
    /// Returns true if myDigesters contains the given id
    /// </summary>
    /// <param name="myDigesters"></param>
    /// <param name="id">digester id</param>
    /// <returns>true if myDigesters contains id, else false</returns>
    public static bool contains(digesters myDigesters, string id)
    {
      foreach (digester myDigester in myDigesters)
      {
        if (myDigester.id == id)
          return true;
      }

      return false;
    }

    /// <summary>
    /// Returns number of Digesters
    /// </summary>
    /// <returns>number of digesters</returns>
    public int getNumDigesters()
    {
      return this.ids.Count;
    }
    /// <summary>
    /// Returns number of Digesters as double, only for MATLAB.
    /// </summary>
    /// <returns>number of digesters</returns>
    public double getNumDigestersD()
    {
      return (double)getNumDigesters();
    }



  }
}


