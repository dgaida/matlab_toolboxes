/**
 * This file is part of the partial class plant and defines
 * all methods related to the chps on the plant.
 * 
 * TODOs:
 * - Die Idee soll sein, ein biogasspeicher in der größe der Gasphase
 *   der fermenter zu modellieren in dem das prod. biogas rein geht und aus dem die bhkws
 *   das biogas in der entsprechenden menge abgreifen. damit wird es möglich erst wenn gasphase
 *   voll ist, das überschüssige gas abzufackeln und die in realen daten immer wieder aufkommenden
 *   stillzeiten der bhkws sind damit besser modellierbar. 
 * 
 * FINISHED!
 * 
 */

using System;
using System.Collections.Generic;
using System.Text;
using science;
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
    //                              !!! PUBLIC METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// Returns true if myCHPs contains the given chp_id
    /// </summary>
    /// <param name="chp_id">id of a chp</param>
    /// <returns>true if list contains chp id, else false</returns>
    public bool containsCHP(string chp_id)
    {
      return myCHPs.contains(chp_id);
    }



    /// <summary>
    /// Returns number of chps
    /// </summary>
    /// <returns>number of chps in list</returns>
    public int getNumCHPs()
    {
      return this.myCHPs.getNumCHPs();
    }
    /// <summary>
    /// Returns number of chps as double (only for MATLAB)
    /// </summary>
    /// <returns>number of chps in list</returns>
    public double getNumCHPsD()
    {
      return (double)getNumCHPs();
    }

    /// <summary>
    /// Returns the chp ID of the by index specified chp. 
    /// index is 1-based.
    /// </summary>
    /// <param name="index">chp index</param>
    /// <returns></returns>
    /// <exception cref="exception">Invalid chp index</exception>
    public string getCHPID(int index)
    {
      if (index <= 0 || index > getNumCHPs())
        throw new exception(String.Format(
          "index out of bounds: {0}! Must be between 1 ... {1}", index, getNumCHPs()));

      return myCHPs.ids[index - 1];
    }
    /// <summary>
    /// Returns the chp's index, specified by id.
    /// </summary>
    /// <param name="id">chp id</param>
    /// <returns>corresponding chp index</returns>
    /// <exception cref="exception">Unknown chp id</exception>
    public int getCHPIndex(string id)
    {
      return myCHPs.getIndexByID(id);
    }
    /// <summary>
    /// Returns the chp's name, specified by id.
    /// </summary>
    /// <param name="id">chp id</param>
    /// <returns>corresponding chp name</returns>
    /// <exception cref="exception">Unknown chp id</exception>
    public string getCHPName(string id)
    {
      return myCHPs.get_param_of_s(id, "name");
    }
    /// <summary>
    /// Returns the chp's name, specified by 1-based index.
    /// </summary>
    /// <param name="index">chp index</param>
    /// <returns>corresponding chp name</returns>
    /// <exception cref="exception">Invalid chp index</exception>
    public string getCHPName(int index)
    {
      return myCHPs.get_param_of_s(index, "name");
    }
    /// <summary>
    /// Get the double Value of a physValue parameter of the chp 
    /// specified by 1-based index.
    /// </summary>
    /// <param name="index">chp index</param>
    /// <param name="param"></param>
    /// <returns></returns>
    /// <exception cref="exception">Invalid chp index</exception>
    /// <exception cref="exception">Unknown parameter</exception>
    public double getCHPParam(int index, string param)
    {
      return myCHPs.get_param_of(index, param);
    }
    /// <summary>
    /// Get the double Value of a physValue parameter of the chp 
    /// specified by id.
    /// </summary>
    /// <param name="id">chp id</param>
    /// <param name="param"></param>
    /// <returns></returns>
    /// <exception cref="exception">Unknown chp id</exception>
    /// <exception cref="exception">Unknown parameter</exception>
    public double getCHPParam(string id, string param)
    {
      return myCHPs.get_param_of(id, param);
    }
    /// <summary>
    /// Get the double parameter of the by id specified chp.
    /// </summary>
    /// <param name="id">chp id</param>
    /// <param name="param"></param>
    /// <returns></returns>
    /// <exception cref="exception">Unknown chp id</exception>
    /// <exception cref="exception">Unknown parameter</exception>
    /// <exception cref="exception">Conversion to double not possible</exception>
    public double getCHPParamD(string id, string param)
    {
      return myCHPs.get_param_of_d(id, param);
    }
    /// <summary>
    /// Set the double Value of the specified physValue parameter of the by
    /// 1-based index specified chp.
    /// </summary>
    /// <param name="index">chp index</param>
    /// <param name="symbol"></param>
    /// <param name="value"></param>
    /// <exception cref="exception">Invalid chp index</exception>
    /// <exception cref="exception">Unknown parameter</exception>
    public void setCHPParam(int index, string symbol, physValue value)
    {
      myCHPs.set_params_of(index, symbol, value);
    }
    /// <summary>
    /// Set the specified double parameter of the by
    /// 1-based index specified chp.
    /// </summary>
    /// <param name="index">chp index</param>
    /// <param name="symbol"></param>
    /// <param name="value"></param>
    /// <exception cref="exception">Invalid chp index</exception>
    /// <exception cref="exception">Unknown parameter</exception>
    public void setCHPParam(int index, string symbol, double value)
    {
      myCHPs.set_params_of(index, symbol, value);
    }
    /// <summary>
    /// Set the string parameter of the by id specified chp.
    /// </summary>
    /// <param name="id">chp id</param>
    /// <param name="symbol"></param>
    /// <param name="value"></param>
    /// <exception cref="exception">Unknown chp id</exception>
    /// <exception cref="exception">Unknown parameter</exception>
    public void setCHPParam(string id, string symbol, string value)
    {
      myCHPs.set_params_of(id, symbol, value);
    }
    /// <summary>
    /// Set the double parameter of the by id specified chp.
    /// </summary>
    /// <param name="id">chp id</param>
    /// <param name="symbol"></param>
    /// <param name="value"></param>
    /// <exception cref="exception">Unknown chp id</exception>
    /// <exception cref="exception">Unknown parameter</exception>
    public void setCHPParam(string id, string symbol, double value)
    {
      myCHPs.set_params_of(id, symbol, value);
    }

    /// <summary>
    /// Returns the by 1-based index specified chp.
    /// </summary>
    /// <param name="index">chp index</param>
    /// <returns></returns>
    /// <exception cref="exception">Invalid chp index</exception>
    public chp getCHP(int index)
    {
      return myCHPs.get(index);
    }
    /// <summary>
    /// Returns the by id specified chp.
    /// </summary>
    /// <param name="id">chp id</param>
    /// <returns></returns>
    /// <exception cref="exception">Unknown chp id</exception>
    public chp getCHPByID(string id)
    {
      return myCHPs.get(id);
    }

    /// <summary>
    /// Deletes the by 1-based index specified chp from the list.
    /// </summary>
    /// <param name="index">chp index</param>
    /// <exception cref="exception">Invalid chp index</exception>
    public void deleteCHP(int index)
    {
      myCHPs.deleteCHP(index);
    }

    /// <summary>
    /// Adds the chp myCHP to the list.
    /// </summary>
    /// <param name="myCHP"></param>
    public void addCHP(chp myCHP)
    {
      myCHPs.addCHP(myCHP);
    }



    /// <summary>
    /// Calculates the electrical and thermal energy, respectively power
    /// generated out of the gas stream u.
    /// ch4 and h2 is burned
    /// </summary>
    /// <param name="chp_id">ID of the chp used for burning</param>
    /// <param name="u">
    /// vector with as many elements as there are number of gases (BioGas.n_gases)
    /// the positions of the gases inside the vector are: 
    /// - biogas.BioGas.pos_ch4
    /// - biogas.BioGas.pos_co2
    /// - biogas.BioGas.pos_h2
    /// </param>
    /// <param name="P_el_kWh_d"></param>
    /// <param name="P_therm_kWh_d"></param>
    /// <exception cref="exception">Unknown chp id</exception>
    public void burnBiogas(string chp_id, double[] u, 
                           out physValue P_el_kWh_d, out physValue P_therm_kWh_d)
    {
      // throws an exception when chp_id does not exist
      chp myCHP = this.getCHPByID(chp_id);

      //

      myCHP.burnBiogas(u, out P_el_kWh_d, out P_therm_kWh_d);
    }

    /// <summary>
    /// Calculates the electrical and thermal energy, respectively power
    /// generated out of the gas stream u.
    /// ch4 and h2 is burned
    /// </summary>
    /// <param name="chp_id">ID of the chp used for burning</param>
    /// <param name="u">
    /// vector with as many elements as there are number of gases (BioGas.n_gases)
    /// the positions of the gases inside the vector are: 
    /// - biogas.BioGas.pos_ch4
    /// - biogas.BioGas.pos_co2
    /// - biogas.BioGas.pos_h2
    /// </param>
    /// <param name="P_el_kWh_d"></param>
    /// <param name="P_therm_kWh_d"></param>
    /// <exception cref="exception">Unknown chp id</exception>
    public void burnBiogas(string chp_id, double[] u,
                           out double P_el_kWh_d, out double P_therm_kWh_d)
    {
      physValue pP_el_kWh_d;
      physValue pP_therm_kWh_d;

      //

      burnBiogas(chp_id, u, out pP_el_kWh_d, out pP_therm_kWh_d);

      //

      P_el_kWh_d = pP_el_kWh_d.Value;
      P_therm_kWh_d = pP_therm_kWh_d.Value;
    }

    /// <summary>
    /// Returns max. electrical power of plant, sum of el. 
    /// power of all chps. in kW
    /// </summary>
    /// <returns>el. power in kW</returns>
    public physValue getMaxElPower()
    {
      // TODO
      // man könnte auch myCHPs.getTotalPel() aufrufen anstatt

      double PelMax= 0;

      for (int ibhkw= 0; ibhkw < getNumCHPs(); ibhkw++)
      {
        PelMax= PelMax + getCHPParam(ibhkw + 1, "Pel");
      }

      return new physValue("PelMax", PelMax, "kW", "Max. Pel");
    }

    /// <summary>
    /// Returns max. electrical energy of plant, sum of el. 
    /// energy of all chps. in kWh/d
    /// </summary>
    /// <returns>max el. energy in kWh/d</returns>
    /// <exception cref="exception">Calculation failed</exception>
    public physValue getMaxElEnergy()
    {
      physValue maxenergy;

      try
      {
        maxenergy = getMaxElPower().convertUnit("kWh/d");
      }
      catch (exception e)
      {
        Console.WriteLine(e.Message);
        throw new exception("getMaxElEnergy: calculation failed!");
      }

      return maxenergy;
    }


    /// <summary>
    /// calculate electrical power in kWh/d out of given methane volume flow rate in m³/d
    /// but with upper boundary the max. producable electrical energy on plant
    /// </summary>
    /// <param name="volflowrateCH4">Qch4 in m^3/d</param>
    /// <param name="Pel_kWh_d">electrical power in kWh/d</param>
    public void getElPowerEquiv(double volflowrateCH4, out double Pel_kWh_d)
    {
      myCHPs.getElPowerEquiv(volflowrateCH4, out Pel_kWh_d);
    }



  }
}


