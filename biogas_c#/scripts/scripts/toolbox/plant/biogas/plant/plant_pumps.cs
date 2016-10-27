/**
 * This file is part of the partial class plant and defines
 * all methods related to the transportation units (pumps, ...) on the plant.
 * 
 * TODOs:
 * - maybe add further methods
 * 
 * Except for that FINISHED!
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
    /// Returns true if myTransportation contains the given pump_id
    /// </summary>
    /// <param name="pump_id">id of a pump</param>
    /// <returns>true if pump is inside the list, else false</returns>
    public bool containsPump(string pump_id)
    {
      return myTransportation.containsPump(pump_id);
    }



    /// <summary>
    /// Returns number of pumps
    /// </summary>
    /// <returns>number of pumps</returns>
    public int getNumPumps()
    {
      return this.myTransportation.getNumPumps();
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
    /// <param name="index">pump index</param>
    /// <returns></returns>
    /// <exception cref="exception">Invalid pump index</exception>
    public string getPumpID(int index)
    {
      return myTransportation.getPumpID(index);
    }
    /// <summary>
    /// Returns the pump's index, specified by id.
    /// </summary>
    /// <param name="id">pump id</param>
    /// <returns></returns>
    /// <exception cref="exception">Unknown pump id</exception>
    public int getPumpIndex(string id)
    {
      return myTransportation.getPumpIndex(id);
    }
    
    
    
    /// <summary>
    /// Returns the by 1-based index specified pump.
    /// </summary>
    /// <param name="index">pump index</param>
    /// <returns></returns>
    /// <exception cref="exception">Invalid pump index</exception>
    public pump getPump(int index)
    {
      return myTransportation.getPump(index);
    }
    /// <summary>
    /// Returns the by id specified pump.
    /// </summary>
    /// <param name="id">pump id</param>
    /// <returns></returns>
    /// <exception cref="exception">Unknown pump id</exception>
    public pump getPumpByID(string id)
    {
      return myTransportation.getPumpByID(id);
    }

    /// <summary>
    /// Delete the specified pump from the list.
    /// </summary>
    /// <param name="id">pump id</param>
    /// <exception cref="exception">Unknown pump id</exception>
    public void deletePump(string id)
    {
      myTransportation.deletePump(id);
    }
    /// <summary>
    /// Deletes the by 1-based index specified pump from the list.
    /// </summary>
    /// <param name="index">pump index</param>
    /// <exception cref="exception">Invalid pump index</exception>
    public void deletePump(int index)
    {
      myTransportation.deletePump(index);
    }

    /// <summary>
    /// Adds the pump myPump to the list.
    /// </summary>
    /// <param name="myPump"></param>
    public void addPump(pump myPump)
    {
      myTransportation.addPump(myPump);
    }



    /// <summary>
    /// Get the double Value of a physValue parameter of the pump 
    /// specified by 1-based index.
    /// </summary>
    /// <param name="index">pump index</param>
    /// <param name="param"></param>
    /// <returns></returns>
    /// <exception cref="exception">Invalid pump index</exception>
    /// <exception cref="exception">Unknown parameter</exception>
    /// <exception cref="exception">Conversion to double not possible</exception>
    public double getPumpParam(int index, string param)
    {
      return myTransportation.getPumpParam(index, param);
    }
    /// <summary>
    /// Get the double Value of a physValue parameter of the pump 
    /// specified by id.
    /// </summary>
    /// <param name="id">pump id</param>
    /// <param name="param"></param>
    /// <returns></returns>
    /// <exception cref="exception">Unknown pump id</exception>
    /// <exception cref="exception">Unknown parameter</exception>
    /// <exception cref="exception">Conversion to double not possible</exception>
    public double getPumpParam(string id, string param)
    {
      return myTransportation.getPumpParam(id, param);
    }
    /// <summary>
    /// Get the double parameter of the by id specified pump.
    /// </summary>
    /// <param name="id">pump id</param>
    /// <param name="param"></param>
    /// <returns></returns>
    /// <exception cref="exception">Unknown pump id</exception>
    /// <exception cref="exception">Unknown parameter</exception>
    /// <exception cref="exception">Conversion to double not possible</exception>
    public double getPumpParamD(string id, string param)
    {
      return myTransportation.getPumpParamD(id, param);
    }
    /// <summary>
    /// Set the double Value of the specified physValue parameter of the by
    /// 1-based index specified pump.
    /// </summary>
    /// <param name="index">pump index</param>
    /// <param name="symbol"></param>
    /// <param name="value"></param>
    /// <exception cref="exception">Invalid pump index</exception>
    /// <exception cref="exception">Unknown parameter</exception>
    public void setPumpParam(int index, string symbol, physValue value)
    {
      myTransportation.setPumpParam(index, symbol, value);
    }
    /// <summary>
    /// Set the specified double parameter of the by
    /// 1-based index specified pump.
    /// </summary>
    /// <param name="index">pump index</param>
    /// <param name="symbol"></param>
    /// <param name="value"></param>
    /// <exception cref="exception">Invalid pump index</exception>
    /// <exception cref="exception">Unknown parameter</exception>
    public void setPumpParam(int index, string symbol, double value)
    {
      myTransportation.setPumpParam(index, symbol, value);
    }
    /// <summary>
    /// Set the string parameter of the by id specified pump.
    /// </summary>
    /// <param name="id">pump id</param>
    /// <param name="symbol"></param>
    /// <param name="value"></param>
    /// <exception cref="exception">Unknown pump id</exception>
    /// <exception cref="exception">Unknown parameter</exception>
    public void setPumpParam(string id, string symbol, string value)
    {
      myTransportation.setPumpParam(id, symbol, value);
    }
    /// <summary>
    /// Set the double parameter of the by id specified pump.
    /// </summary>
    /// <param name="id">pump id</param>
    /// <param name="symbol"></param>
    /// <param name="value"></param>
    /// <exception cref="exception">Unknown pump id</exception>
    /// <exception cref="exception">Unknown parameter</exception>
    public void setPumpParam(string id, string symbol, double value)
    {
      myTransportation.setPumpParam(id, symbol, value);
    }



  }
}


