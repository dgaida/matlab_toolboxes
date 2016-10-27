/**
 * This file defines method of the partial class transportation 
 * for pumps.
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
  /// transportation objects to pump/transport substrates or sludge
  /// 
  /// - pump
  /// 
  /// </summary>
  public partial class transportation
  {

    // -------------------------------------------------------------------------------------
    //                              !!! PUBLIC METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// Add given pump to list
    /// </summary>
    /// <param name="myPump"></param>
    public void addPump(pump myPump)
    {
      myPumps.addPump(myPump);    
    }

    /// <summary>
    /// Delete the specified pump from the list.
    /// </summary>
    /// <param name="id">id of the pump</param>
    /// <exception cref="exception">Unknown pump id</exception>
    public void deletePump(string id)
    {
      myPumps.deletePump(id);
    }
    /// <summary>
    /// Delete the specified pump from the lists. index is 1-based.
    /// </summary>
    /// <param name="index">index of the pump in the list</param>
    /// <exception cref="exception">Invalid pump index</exception>
    public void deletePump(int index)
    {
      myPumps.deletePump(index);
    }



    /// <summary>
    /// Returns true if myPumps contains the given pump_id
    /// </summary>
    /// <param name="pump_id">id of a pump</param>
    /// <returns>true if pump is inside the list, else false</returns>
    public bool containsPump(string pump_id)
    {
      return myPumps.contains(pump_id);    
    }



    /// <summary>
    /// Returns number of pumps
    /// </summary>
    /// <returns>number of pumps</returns>
    public int getNumPumps()
    {
      return this.myPumps.Count;
    }

    /// <summary>
    /// Returns number of pumps as double (only for MATLAB)
    /// </summary>
    /// <returns>number of pumps</returns>
    public double getNumPumpsD()
    {
      return (double)getNumPumps();
    }


    /// <summary>
    /// Returns the pump ID of the by index specified pump. 
    /// index is 1-based.
    /// </summary>
    /// <param name="index"></param>
    /// <returns></returns>
    /// <exception cref="exception">Invalid pump index</exception>
    public string getPumpID(int index)
    {
      if (index <= 0 || index > getNumPumps())
        throw new exception(String.Format(
          "index out of bounds: {0}! Must be between 1 ... {1}", index, getNumPumps()));

      return myPumps[index - 1].id;
    }
    /// <summary>
    /// Returns the pump's index, specified by id.
    /// </summary>
    /// <param name="id">id of the pump</param>
    /// <returns></returns>
    /// <exception cref="exception">Unknown pump id</exception>
    public int getPumpIndex(string id)
    {
      return myPumps.getIndexByID(id);
    }

    /// <summary>
    /// Returns the by id specified pump.
    /// </summary>
    /// <param name="id">id of the pump</param>
    /// <returns></returns>
    /// <exception cref="exception">Unknown pump id</exception>
    public pump getPumpByID(string id)
    {
      return myPumps.get(id);
    }
    /// <summary>
    /// Returns the by index specified pump object. index is 1-based.
    /// </summary>
    /// <param name="index">index of the pump</param>
    /// <returns></returns>
    /// <exception cref="exception">Invalid pump index</exception>
    public pump getPump(int index)
    {
      return myPumps.get(index);
    }

    /// <summary>
    /// Returns the by id specified pump object and the index in the list.
    /// index is 1-based.
    /// </summary>
    /// <param name="id">id of the pump</param>
    /// <param name="index">index of the pump</param>
    /// <returns></returns>
    /// <exception cref="exception">Unknown pump id</exception>
    public pump getPumpByID(string id, out int index)
    {
      return myPumps.getByID(id, out index);
    }
    /// <summary>
    /// Returns the by id specified index of the pump in the list.
    /// index is 1-based.
    /// </summary>
    /// <param name="id">id of the pump</param>
    /// <returns></returns>
    [Obsolete("Use getPumpIndex(string) instead!")]
    public int getPumpIndexByID(string id)
    {
      return myPumps.getIndexByID(id);
    }



    /// <summary>
    /// Get the double Value of a physValue parameter of the pump 
    /// specified by 1-based index.
    /// </summary>
    /// <param name="index">pump index</param>
    /// <param name="param">parameter</param>
    /// <returns></returns>
    /// <exception cref="exception">Invalid pump index</exception>
    /// <exception cref="exception">Unknown parameter</exception>
    /// <exception cref="exception">Conversion to double not possible</exception>
    public double getPumpParam(int index, string param)
    {
      return myPumps.get_param_of(index, param);
    }
    /// <summary>
    /// Get the double Value of a physValue parameter of the pump 
    /// specified by id.
    /// </summary>
    /// <param name="id">pump id</param>
    /// <param name="param">parameter</param>
    /// <returns></returns>
    /// <exception cref="exception">Unknown pump id</exception>
    /// <exception cref="exception">Unknown parameter</exception>
    /// <exception cref="exception">Conversion to double not possible</exception>
    public double getPumpParam(string id, string param)
    {
      return myPumps.get_param_of(id, param);
    }
    /// <summary>
    /// Get the double parameter of the by id specified pump.
    /// </summary>
    /// <param name="id">pump id</param>
    /// <param name="param">parameter</param>
    /// <returns></returns>
    /// <exception cref="exception">Unknown pump id</exception>
    /// <exception cref="exception">Unknown parameter</exception>
    /// <exception cref="exception">Conversion to double not possible</exception>
    public double getPumpParamD(string id, string param)
    {
      return myPumps.get_param_of_d(id, param);
    }
    /// <summary>
    /// Set the double Value of the specified physValue parameter of the by
    /// 1-based index specified pump.
    /// </summary>
    /// <param name="index">pump index</param>
    /// <param name="symbol">parameter</param>
    /// <param name="value"></param>
    /// <exception cref="exception">Invalid pump index</exception>
    /// <exception cref="exception">Unknown parameter</exception>
    public void setPumpParam(int index, string symbol, physValue value)
    {
      myPumps.set_params_of(index, symbol, value);
    }
    /// <summary>
    /// Set the specified double parameter of the by
    /// 1-based index specified pump.
    /// </summary>
    /// <param name="index">pump index</param>
    /// <param name="symbol">parameter</param>
    /// <param name="value"></param>
    /// <exception cref="exception">Invalid pump index</exception>
    /// <exception cref="exception">Unknown parameter</exception>
    public void setPumpParam(int index, string symbol, double value)
    {
      myPumps.set_params_of(index, symbol, value);
    }
    /// <summary>
    /// Set the string parameter of the by id specified pump.
    /// </summary>
    /// <param name="id">pump id</param>
    /// <param name="symbol">parameter</param>
    /// <param name="value"></param>
    /// <exception cref="exception">Unknown pump id</exception>
    /// <exception cref="exception">Unknown parameter</exception>
    public void setPumpParam(string id, string symbol, string value)
    {
      myPumps.set_params_of(id, symbol, value);
    }
    /// <summary>
    /// Set the double parameter of the by id specified pump.
    /// </summary>
    /// <param name="id">pump id</param>
    /// <param name="symbol">parameter</param>
    /// <param name="value"></param>
    /// <exception cref="exception">Unknown pump id</exception>
    /// <exception cref="exception">Unknown parameter</exception>
    public void setPumpParam(string id, string symbol, double value)
    {
      myPumps.set_params_of(id, symbol, value);
    }



  }



}


