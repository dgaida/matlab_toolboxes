/**
 * This file is part of the partial class plant and defines
 * all methods related to the digesters on the plant.
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
    /// Returns true if myDigesters contains the given digester_id
    /// </summary>
    /// <param name="digester_id">id of a digester</param>
    /// <returns>true if this list contains id, else false</returns>
    public bool containsDigester(string digester_id)
    {
      return myDigesters.contains(digester_id);
    }



    /// <summary>
    /// Returns number of digesters
    /// </summary>
    /// <returns>number of digesters</returns>
    public int getNumDigesters()
    {
      return this.myDigesters.getNumDigesters();
    }
    /// <summary>
    /// Returns number of digesters as double (only for MATLAB)
    /// </summary>
    /// <returns>number of digesters</returns>
    public double getNumDigestersD()
    {
      return (double)getNumDigesters();
    }

    /// <summary>
    /// Returns the digester ID of the by index specified digester. 
    /// index is 1-based.
    /// </summary>
    /// <param name="index">digester index</param>
    /// <returns></returns>
    /// <exception cref="exception">Invalid digester index</exception>
    public string getDigesterID(int index)
    {
      if (index <= 0 || index > getNumDigesters())
      {
        //return "";
        // bei der Initialisierung des Modells wird diese Methode sehr oft mit
        // index == 0 aufgerufen, weiß noch nicht genau warum, es scheint, dass die aufrufe
        // direkt von den blöcken selbst kommen (also deren parameterisierung), welche
        // dann die m-files aufrufen. evtl. ist da noch nicht der ausgewählte fermenter
        // ausgewählt.
        throw new exception(String.Format(
          "digester index out of bounds: {0}! Must be between 1 ... {1}", index, getNumDigesters()));
      }

      return myDigesters.ids[index - 1];
    }
    /// <summary>
    /// Returns the digester's index, specified by id. 1-based
    /// </summary>
    /// <param name="id">digester id</param>
    /// <returns></returns>
    /// <exception cref="exception">Unknown digester id</exception>
    public int getDigesterIndex(string id)
    {
      return myDigesters.getIndexByID(id);
    }
    /// <summary>
    /// Returns the digester's name, specified by id.
    /// </summary>
    /// <param name="id">digester id</param>
    /// <returns></returns>
    /// <exception cref="exception">Unknown digester id</exception>
    /// <exception cref="exception">Conversion to string not possible</exception>
    public string getDigesterName(string id)
    {
      return myDigesters.get_param_of_s(id, "name");
    }
    /// <summary>
    /// Returns the digester's name, specified by 1-based index.
    /// </summary>
    /// <param name="index">digester index</param>
    /// <returns></returns>
    /// <exception cref="exception">Invalid digester index</exception>
    /// <exception cref="exception">Conversion to string not possible</exception>
    public string getDigesterName(int index)
    {
      return myDigesters.get_param_of_s(index, "name");
    }
    /// <summary>
    /// Get the double Value of a physValue parameter of the digester 
    /// specified by 1-based index.
    /// </summary>
    /// <param name="index">digester index</param>
    /// <param name="param"></param>
    /// <returns></returns>
    /// <exception cref="exception">Invalid digester index</exception>
    /// <exception cref="exception">Unknown parameter</exception>
    /// <exception cref="exception">Conversion to double not possible</exception>
    public double getDigesterParam(int index, string param)
    {
      return myDigesters.get_param_of(index, param);
    }
    /// <summary>
    /// Get the double parameter of the digester 
    /// specified by 1-based index.
    /// </summary>
    /// <param name="index">digester index</param>
    /// <param name="param"></param>
    /// <returns></returns>
    /// <exception cref="exception">Invalid digester index</exception>
    /// <exception cref="exception">Unknown parameter</exception>
    /// <exception cref="exception">Conversion to double not possible</exception>
    public double getDigesterParamD(int index, string param)
    {
      return myDigesters.get_param_of_d(index, param);
    }
    /// <summary>
    /// Get the double Value of a physValue parameter of the digester 
    /// specified by id.
    /// </summary>
    /// <param name="id">digester id</param>
    /// <param name="param"></param>
    /// <returns></returns>
    /// <exception cref="exception">Unknown digester id</exception>
    /// <exception cref="exception">Unknown parameter</exception>
    /// <exception cref="exception">Conversion to double not possible</exception>
    public double getDigesterParam(string id, string param)
    {
      return myDigesters.get_param_of(id, param);
    }
    /// <summary>
    /// Get the double parameter of the by id specified digester.
    /// </summary>
    /// <param name="id">digester id</param>
    /// <param name="param"></param>
    /// <returns></returns>
    /// <exception cref="exception">Unknown digester id</exception>
    /// <exception cref="exception">Unknown parameter</exception>
    /// <exception cref="exception">Conversion to double not possible</exception>
    public double getDigesterParamD(string id, string param)
    {
      return myDigesters.get_param_of_d(id, param);
    }

    /// <summary>
    /// Set the double Value of the specified physValue parameter of the by
    /// 1-based index specified digester.
    /// </summary>
    /// <param name="index">digester index</param>
    /// <param name="symbol"></param>
    /// <param name="value"></param>
    /// <exception cref="exception">Invalid digester index</exception>
    /// <exception cref="exception">Unknown parameter</exception>
    public void setDigesterParam(int index, string symbol, physValue value)
    {
      myDigesters.set_params_of(index, symbol, value);
    }
    /// <summary>
    /// Set the specified double parameter of the by
    /// 1-based index specified digester.
    /// </summary>
    /// <param name="index">digester index</param>
    /// <param name="symbol"></param>
    /// <param name="value"></param>
    /// <exception cref="exception">Invalid digester index</exception>
    /// <exception cref="exception">Unknown parameter</exception>
    public void setDigesterParam(int index, string symbol, double value)
    {
      myDigesters.set_params_of(index, symbol, value);
    }
    /// <summary>
    /// Set the string parameter of the by id specified digester.
    /// </summary>
    /// <param name="id">digester id</param>
    /// <param name="symbol"></param>
    /// <param name="value"></param>
    /// <exception cref="exception">Unknown digester id</exception>
    /// <exception cref="exception">Unknown parameter</exception>
    public void setDigesterParam(string id, string symbol, string value)
    {
      myDigesters.set_params_of(id, symbol, value);
    }
    /// <summary>
    /// Set the double parameter of the by id specified digester.
    /// </summary>
    /// <param name="id">digester id</param>
    /// <param name="symbol"></param>
    /// <param name="value"></param>
    /// <exception cref="exception">Unknown digester id</exception>
    /// <exception cref="exception">Unknown parameter</exception>
    public void setDigesterParam(string id, string symbol, double value)
    {
      myDigesters.set_params_of(id, symbol, value);
    }

    /// <summary>
    /// Returns the by 1-based index specified digester.
    /// </summary>
    /// <param name="index">digester index</param>
    /// <returns></returns>
    /// <exception cref="exception">Invalid digester index</exception>
    public digester getDigester(int index)
    {
      return myDigesters.get(index);
    }
    /// <summary>
    /// Returns the by id specified digester.
    /// </summary>
    /// <param name="id">digester id</param>
    /// <returns></returns>
    /// <exception cref="exception">Unknown digester id</exception>
    public digester getDigesterByID(string id)
    {
      return myDigesters.get(id);
    }

    /// <summary>
    /// Returns id and index of the named digester.
    /// index is 1-based.
    /// </summary>
    /// <param name="name">digester name</param>
    /// <param name="id">corresponding digester id</param>
    /// <param name="index">corresponding digester index</param>
    /// <exception cref="exception">Unknown digester name</exception>
    public void getDigesterByName(string name, out string id, out int index)
    {
      myDigesters.getByName(name, out id, out index);
    }
    /// <summary>
    /// Returns index of the named digester.
    /// index is 1-based.
    /// </summary>
    /// <param name="name">digester name</param>
    /// <param name="index">corresponding digester index</param>
    /// <exception cref="exception">Unknown digester name</exception>
    public void getDigesterByName(string name, out int index)
    {
      myDigesters.getByName(name, out index);
    }

    /// <summary>
    /// Deletes the by 1-based index specified digester from the list.
    /// </summary>
    /// <param name="index">digester index</param>
    /// <exception cref="exception">Invalid digester index</exception>
    public void deleteDigester(int index)
    {
      digester myDigester = getDigester(index);

      myTransportation.deleteSubstrateTransport("substratemix_" + myDigester.id);

      myDigesters.deleteDigester(index);
    }

    /// <summary>
    /// Adds the digester myDigester to the list.
    /// </summary>
    /// <param name="myDigester"></param>
    public void addDigester(digester myDigester)
    {
      myDigesters.addDigester(myDigester);

      substrate_transport mySubstrateTransport = new substrate_transport("substratemix", myDigester.id);

      myTransportation.addSubstrateTransport(mySubstrateTransport);
    }


    /// <summary>
    /// Returns default values of ADM params vector, not dependent on substrate feed
    /// 
    /// if getADMparams method was called before (see below], then
    /// this method returns the last updated ADM params
    /// </summary>
    /// <param name="id">id of digester</param>
    /// <returns>ADM params</returns>
    /// <exception cref="exception">Unknown digester id</exception>
    public double[] getDefaultADMparams(string id)
    {
      // das sind die zuletzt upgedateten Parameter, nicht die default Werte
      // zumindest wenn getADMparams aufgerufen wurde, wird in ADM stoichiometry aufgerufen
      return myDigesters.getDefaultADMparams(id);
    }

    /// <summary>
    /// Returns default values of ADM params vector, not dependent on substrate feed
    /// 
    /// if getADMparams method was called before (see below], then
    /// this method returns the last updated ADM params
    /// </summary>
    /// <param name="index">index of digester</param>
    /// <returns>ADM params</returns>
    /// <exception cref="exception">Invalid digester index</exception>
    public double[] getDefaultADMparams(int index)
    {
      // das sind die zuletzt upgedateten Parameter, nicht die default Werte
      // zumindest wenn getADMparams aufgerufen wurde, wird in ADM stoichiometry aufgerufen
      return myDigesters.getDefaultADMparams(index);
    }


    /// <summary>
    /// Get ADM parameter at given position as given out value. pos is 1-based.
    /// </summary>
    /// <param name="id">id of digester</param>
    /// <param name="pos">from 1 to ADMparams.numParams</param>
    /// <param name="value">value of the ADM parameter</param>
    /// <exception cref="exception">Unknown digester id</exception>
    /// <exception cref="exception">Invalid pos</exception>
    public void getADMparameter(string id, int pos, out double value)
    {
      myDigesters.getADMparameter(id, pos, out value);
    }

    /// <summary>
    /// Get ADM parameter at given position as given out value. pos is 1-based.
    /// </summary>
    /// <param name="index">1-based index of digester</param>
    /// <param name="pos">from 1 to ADMparams.numParams</param>
    /// <param name="value">value of the ADM parameter</param>
    /// <exception cref="exception">Invalid digester index</exception>
    /// <exception cref="exception">Invalid pos</exception>
    public void getADMparameter(int index, int pos, out double value)
    {
      myDigesters.getADMparameter(index, pos, out value);
    }


    /// <summary>
    /// Set ADM parameter at given position to given value. pos is 1-based.
    /// </summary>
    /// <param name="id">id of digester</param>
    /// <param name="pos">from 1 to ADMparams.numParams</param>
    /// <param name="value">value of the ADM parameter</param>
    /// <exception cref="exception">Unknown digester id</exception>
    public void setADMparameter(string id, int pos, double value)
    {
      myDigesters.setADMparameter(id, pos, value);
    }

    /// <summary>
    /// Set ADM parameter at given position to given value. pos is 1-based.
    /// </summary>
    /// <param name="index">1-based index of digester</param>
    /// <param name="pos">from 1 to ADMparams.numParams</param>
    /// <param name="value">value of the ADM parameter</param>
    /// <exception cref="exception">Invalid digester index</exception>
    public void setADMparameter(int index, int pos, double value)
    {
      myDigesters.setADMparameter(index, pos, value);
    }

    /// <summary>
    /// Sets default values of ADM params vector, not dependent on substrate feed
    /// </summary>
    /// <param name="id">id of digester</param>
    /// <param name="ADM1params">the ADM1 parameter vector, must have the correct dimension
    /// </param>
    /// <exception cref="exception">Unknown digester id</exception>
    /// <exception cref="exception">vector has not correct dimension</exception>
    public void setDefaultADMparams(string id, double[] ADM1params)
    {
      myDigesters.setDefaultADMparams(id, ADM1params);
    }

    /// <summary>
    /// Sets default values of ADM params vector, not dependent on substrate feed
    /// </summary>
    /// <param name="index">1-based index of digester</param>
    /// <param name="ADM1params">the ADM1 parameter vector, must have the correct dimension
    /// </param>
    /// <exception cref="exception">Invalid digester index</exception>
    /// <exception cref="exception">vector has not correct dimension</exception>
    public void setDefaultADMparams(int index, double[] ADM1params)
    {
      myDigesters.setDefaultADMparams(index, ADM1params);
    }


    /// <summary>
    /// Returns handle of the gui belonging to the AD model block
    /// </summary>
    /// <param name="index">1-based index of digester</param>
    /// <returns>handle of MATLAB gui</returns>
    /// <exception cref="exception">Invalid digester index</exception>
    public double getDigester_gui_handle(int index)
    {
      return myDigesters.get_gui_handle(index);
    }

    /// <summary>
    /// Returns handle of the gui belonging to the AD model block
    /// </summary>
    /// <param name="name">name of digester</param>
    /// <returns>handle of MATLAB gui</returns>
    /// <exception cref="exception">Unknown digester name</exception>
    public double getDigester_gui_handle(String name)
    {
      int index;

      getDigesterByName(name, out index);

      return getDigester_gui_handle(index);
    }


    /// <summary>
    /// Sets handle of the gui belonging to the AD model block
    /// </summary>
    /// <param name="index">1-based index of digester</param>
    /// <param name="gui_handle">handle of MATLAB gui</param>
    /// <exception cref="exception">Invalid digester index</exception>
    public void setDigester_gui_handle(int index, double gui_handle)
    {
      myDigesters.set_gui_handle(index, gui_handle);
    }

    /// <summary>
    /// Sets handle of the gui belonging to the AD model block
    /// </summary>
    /// <param name="name">name of digester</param>
    /// <param name="gui_handle">handle of MATLAB gui</param>
    /// <exception cref="exception">Unknown digester name</exception>
    public void setDigester_gui_handle(String name, double gui_handle)
    {
      int index;

      getDigesterByName(name, out index);

      setDigester_gui_handle(index, gui_handle);
    }



  }
}


