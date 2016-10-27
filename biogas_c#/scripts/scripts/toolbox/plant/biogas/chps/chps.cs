/**
 * This file is part of the partial class chps and defines
 * all methods not defined elsewhere.
 * 
 * TODOs:
 * - ausschließlich run methode und gas2chpsplittype klären
 * 
 * Apart from that FINISHED!
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
  /// list of chp s
  /// </summary>
  public partial class chps : List<chp>
  {

    // -------------------------------------------------------------------------------------
    //                              !!! CONSTRUCTOR METHODS !!!
    // -------------------------------------------------------------------------------------



    // -------------------------------------------------------------------------------------
    //                              !!! PUBLIC METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// simulates all chps of the plant
    /// </summary>
    /// <param name="t"></param>
    /// <param name="u">
    /// number of digesters times n_gases dimensional vector
    /// with the biogas streams for each digester measured in m^3/d</param>
    /// <param name="mySensors"></param>
    /// <param name="myPlant"></param>
    /// <returns>
    /// produced electrical power for each chp in kW and the biogas excess in m³/d
    /// dimension: number of digesters + 1
    /// </returns>
    public static double[] run(double t, double[] u, //double deltatime, 
      biogas.sensors mySensors, biogas.plant myPlant)
    {
      // TODO - Parameter aus plant bekommen
      string gas2chpsplittype = "threshold";

      return run(t, u, mySensors, myPlant, gas2chpsplittype);
    }

    /// <summary>
    /// simulates all chps of the plant
    /// </summary>
    /// <param name="t"></param>
    /// <param name="u">
    /// number of digesters times n_gases dimensional vector
    /// with the biogas streams for each digester measured in m^3/d</param>
    /// <param name="mySensors"></param>
    /// <param name="myPlant"></param>
    /// <param name="gas2chpsplittype">"threshold", "one2one", "fiftyfifty"</param>
    /// <returns>
    /// produced electrical power for each chp in kW and the biogas excess in m³/d
    /// dimension: number of chps + 1
    /// </returns>
    public static double[] run(double t, double[] u, //double deltatime, 
      biogas.sensors mySensors, biogas.plant myPlant, string gas2chpsplittype)
    {
      //
      // total biogas production [m³/d]
      // total biogas production splitted into components [m³d]
      // biogas for each chp splitted into components
      // biogas excess [m³/d]
      double[] biogas_vec;

      try
      {
        // split biogas upon available chps
        mySensors.measureVec(t, "total_biogas_",
               myPlant, u, gas2chpsplittype, out biogas_vec);
      }
      catch (exception e)
      {
        biogas_vec = math.zeros(11);
        //throw(e);
      }

      //
            
      int num_chps= myPlant.getNumCHPs();   // number of digesters

      // 2dim vector, 1st value, produced electrical energy / day
      // 2nd value: produced thermal energy / day
      double[] P_kWh_d;

      // returned vector by this method
      // produced electrical power for each chp in kW and the biogas excess in m³/d
      // dimension: number of chps + 1
      double[] outvec = new double[num_chps + 1];

      //

      double[] Psum_el_th= new double[2];
      Psum_el_th[0] = 0;
      Psum_el_th[1] = 0;

      //

      for (int ichp = 0; ichp < num_chps; ichp++)
      {
        // biogas which is burned by chp ichp
        double[] biogas_chp;

        try
        {
          // biogas which is burned by chp ichp
          biogas_chp = math.getrows(biogas_vec,
                                    1 + (1 + ichp) * (int)biogas.BioGas.n_gases,
                                    1 + (2 + ichp) * (int)biogas.BioGas.n_gases - 1);
        }
        catch (exception e)
        {
          biogas_chp = math.zeros(3);
          //throw (e);
        }

        try
        {
          // burn biogas in chp ichp
          mySensors.measureVec(t, "energyProduction_" + myPlant.getCHPID(ichp + 1),
                               myPlant, biogas_chp, out P_kWh_d);
        }
        catch (exception e)
        {
          P_kWh_d = math.zeros(2);
          //throw (e);
        }

        // electrical energy in kW
        outvec[ichp]= P_kWh_d[0] / 24;  // convert from kWh/d -> kW

        Psum_el_th[0] += P_kWh_d[0];
        Psum_el_th[1] += P_kWh_d[1];
      }

      // insert biogas excess in m^3/d
      outvec[num_chps] = biogas_vec[biogas_vec.Length - 1];

      try
      {
        //
        // measure total energy production of plant in kWh/d
        mySensors.measureVec(t, "energyProdSum", Psum_el_th);
      }
      catch (exception e)
      { 
        //throw(e);
      }

      //

      return outvec;
    }



    /// <summary>
    /// calculate electrical power in kWh/d out of given methane volume flow rate in m³/d
    /// but with upper boundary the max. producable electrical energy on plant
    /// </summary>
    /// <param name="volflowrateCH4">Qch4 in m^3/d</param>
    /// <param name="Pel_kWh_d">electrical power in kWh/d</param>
    public void getElPowerEquiv(double volflowrateCH4, out double Pel_kWh_d)
    {
      physValue Qch4 = new physValue("Qch4", volflowrateCH4, "m^3/d");

      // theoreticaly producable electrical power
      // m³/d * 1 * kWh/m³ = kWh/d
      physValue pPel = Qch4 * getMeanEtaEl() * biogas.chemistry.Hch4;

      // Pel is the max. possible producable energy of plant (all chps together)
      pPel = physValue.min(pPel.convertUnit("kWh/d"), getTotalPel().convertUnit("kWh/d"));

      // value is already in kWh/d
      Pel_kWh_d = pPel.Value;
    }


    /// <summary>
    /// Calculates sum of total producable electrical energy of all chps on the 
    /// biogas plant together
    /// </summary>
    /// <returns>sum of electrical energy in kW</returns>
    public physValue getTotalPel()
    { 
      physValue Pel= new physValue("Pel_sum", 0, "kW");

      foreach(chp myCHP in this)
      {
        Pel += myCHP.Pel.convertUnit("kW");
      }

      return Pel;
    }

    /// <summary>
    /// Calculates mean degree of electrical coefficiency of chps
    /// on plant
    /// </summary>
    /// <returns>mean degree of electrical coefficiency</returns>
    public double getMeanEtaEl()
    {
      double etael = 0;

      foreach (chp myCHP in this)
      {
        etael += myCHP.eta_el;
      }

      if (this.Count > 0)
        etael /= this.Count;

      return etael;
    }



    // -------------------------------------------------------------------------------------
    //                              !!! PUBLIC METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// add the given chp to the list
    /// </summary>
    /// <param name="myCHP">a chp</param>
    public void addCHP(chp myCHP)
    {
      this.Add(myCHP);
      this.ids.Add(myCHP.id);
    }

    /// <summary>
    /// Delete the specified chp from the lists.
    /// </summary>
    /// <param name="id">id of chp</param>
    /// <exception cref="exception">Unknown chp id</exception>
    public void deleteCHP(string id)
    {
      chp myCHP= get(id);

      this.Remove(myCHP);
      this.ids.Remove(id);
    }
    /// <summary>
    /// Delete the specified chp from the lists. index is 1-based.
    /// </summary>
    /// <param name="index">index of chp</param>
    /// <exception cref="exception">Invalid index</exception>
    public void deleteCHP(int index)
    {
      if (index <= 0 || index > getNumCHPs())
        throw new exception(String.Format(
          "chp index out of bounds: {0}! Must be between 1 ... {1}", index, getNumCHPs()));

      string id= this.ids[index - 1];

      deleteCHP(id);
    }



    /// <summary>
    /// Read params from reader which reads a xml file.
    /// reads until end elements of chps, adds all read chps to list
    /// 
    /// TODO: add parameter gas2chpsplittype
    /// </summary>
    /// <param name="reader">an open reader</param>
    public void getParamsFromXMLReader(ref XmlTextReader reader)
    {
      string xml_tag= "";
      string chp_id= "";

      bool do_while= true;

      while (reader.Read() && do_while)
      {
        switch (reader.NodeType)
        {

          case System.Xml.XmlNodeType.Element: // this knot is an element
            xml_tag= reader.Name;

            while (reader.MoveToNextAttribute())
            { // read the attributes, here only the attribute of chp
              // is of interest, all other attributes are ignored, 
              // actually there usally are no other attributes
              if (xml_tag == "chp" && reader.Name == "id")
              {
                // found a new chp
                chp_id= reader.Value;

                addCHP(new biogas.chp(ref reader, chp_id));

                break;
              }
            }
            break;

          case System.Xml.XmlNodeType.EndElement:
            if (reader.Name == "chps")
              do_while= false;

            break;
        }
      }

    }

    /// <summary>
    /// Return the params of all chps as a xml string
    /// </summary>
    /// <returns>atring with xml tags</returns>
    public string getParamsAsXMLString()
    {
      StringBuilder sb= new StringBuilder();

      sb.Append("<chps>\n");

      foreach (chp myCHP in this)
      {
        sb.Append( myCHP.getParamsAsXMLString() );
      }

      sb.Append("</chps>\n");

      return sb.ToString();
    }

    /// <summary>
    /// Print chps to a string, to be displayed on a console
    /// </summary>
    /// <returns>string for console</returns>
    public string print()
    {
      StringBuilder sb= new StringBuilder();

      foreach (chp myCHP in this)
      {
        sb.Append(myCHP.print());
      }

      return sb.ToString();
    }

    /// <summary>
    /// Returns the by id specified chp object
    /// </summary>
    /// <param name="id">id of chp</param>
    /// <returns>chp object</returns>
    /// <exception cref="exception">Unknown chp id</exception>
    public chp get(string id)
    {
      foreach (chp myCHP in this)
      {
        if (myCHP.id == id)
          return myCHP;
      }

      throw new exception(String.Format(
        "Cannot find the chp (id: {0}) in the list!", id));
    }
    /// <summary>
    /// Returns the by index specified chp object. index is 1-based.
    /// </summary>
    /// <param name="index">index of chp</param>
    /// <returns>chp object</returns>
    /// <exception cref="exception">Invalid index</exception>
    public chp get(int index)
    {
      if (index <= 0 || index > getNumCHPs())
        throw new exception(String.Format(
          "chp index out of bounds: {0}! Must be between 1 ... {1}", index, getNumCHPs()));

      return this[index - 1];
    }

    /// <summary>
    /// Returns the by id specified chp object
    /// </summary>
    /// <param name="id">id of chp</param>
    /// <returns>chp object</returns>
    /// <exception cref="exception">Unknown chp id</exception>
    [Obsolete("Please use get(id) instead!")]
    public chp getByID(string id)
    {
      return get(id);
    }
    /// <summary>
    /// Returns the by id specified chp object and the index in the list.
    /// index is 1-based.
    /// </summary>
    /// <param name="id">id of chp</param>
    /// <param name="index">index of chp</param>
    /// <returns>chp object</returns>
    /// <exception cref="exception">Unknown chp id</exception>
    public chp getByID(string id, out int index)
    {
      int ichp= 0;

      foreach (chp myCHP in this)
      {
        if (myCHP.id == id)
        {
          index= ichp + 1;

          return myCHP;
        }

        ichp++;
      }

      throw new exception(String.Format(
        "Cannot find the chp (id: {0}) in the list!", id));
    }
    /// <summary>
    /// Returns the by id specified index of the chp in the list.
    /// index is 1-based.
    /// </summary>
    /// <param name="id">id of chp</param>
    /// <returns>index of chp</returns>
    /// <exception cref="exception">Unknown chp id</exception>
    public int getIndexByID(string id)
    {
      int index;

      getByID(id, out index);

      return index;
    }
    /// <summary>
    /// Returns the by index specified chp object. index is 1-based.
    /// </summary>
    /// <param name="index">index of chp</param>
    /// <returns>chp object</returns>
    /// <exception cref="exception">Invalid index</exception>
    [Obsolete("Please use get(index) instead!")]
    public chp getByIndex(int index)
    {
      return get(index);
    }



    /// <summary>
    /// Returns true if id is inside this list
    /// </summary>
    /// <param name="id">id of chp</param>
    /// <returns>true if list contains chp id, else false</returns>
    public bool contains(string id)
    {
      return contains(this, id);
    }
    /// <summary>
    /// Returns true if myCHPs contains the given id
    /// </summary>
    /// <param name="myCHPs">list of chps</param>
    /// <param name="id">id of chp</param>
    /// <returns>true if list contains chp id, else false</returns>
    public static bool contains(chps myCHPs, string id)
    {
      foreach (chp myCHP in myCHPs)
      {
        if (myCHP.id == id)
          return true;
      }

      return false;
    }

    /// <summary>
    /// Returns number of CHPs
    /// </summary>
    /// <returns>number of chps in list</returns>
    public int getNumCHPs()
    {
      return this.ids.Count;
    }
    /// <summary>
    /// Returns number of CHPs as double, only for MATLAB.
    /// </summary>
    /// <returns>number of chps in list</returns>
    public double getNumCHPsD()
    {
      return (double)getNumCHPs();
    }


    
  }
}


