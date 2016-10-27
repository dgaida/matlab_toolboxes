/**
 * This file is part of the partial class substrates and defines
 * public get_params_of methods.
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
  /// list of substrates
  /// </summary>
  public partial class substrates : List<substrate>
  {

    // -------------------------------------------------------------------------------------
    //                              !!! PUBLIC METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// Get a string param of the by index specified substrate. index is 1-based.
    /// </summary>
    /// <param name="index">index of substrate</param>
    /// <param name="symbol">"name"</param>
    /// <returns>string</returns>
    /// <exception cref="exception">Unknown parameter</exception>
    /// <exception cref="exception">Conversion to string not possible</exception>
    public string get_param_of_s(int index, string symbol)
    {
      if ((index < 1) || (index > this.Count))
      {
        Console.WriteLine(String.Format("index must be >= 1 and <= {0}, but is: {1}!",
          this.Count, index));
        return "";
      }

      return this[index - 1].get_param_of_s(symbol);
    }
    /// <summary>
    /// Get a double param of the by index specified substrate. index is 1-based.
    /// </summary>
    /// <param name="index">index of substrate</param>
    /// <param name="symbol">"fCh_Xc"</param>
    /// <returns>double value</returns>
    /// <exception cref="exception">Unknown parameter</exception>
    /// <exception cref="exception">Conversion to double not possible</exception>
    public double get_param_of_d(int index, string symbol)
    {
      if ((index < 1) || (index > this.Count))
      {
        Console.WriteLine(String.Format("index must be >= 1 and <= {0}, but is: {1}!",
          this.Count, index));
        return 0;
      }

      return this[index - 1].get_param_of_d(symbol);
    }
    /// <summary>
    /// Get the Value of a physValue param of the by index specified substrate. 
    /// index is 1-based.
    /// </summary>
    /// <param name="index">index of substrate</param>
    /// <param name="symbol">"RF"</param>
    /// <returns>double value</returns>
    /// <exception cref="exception">Unknown parameter</exception>
    /// <exception cref="exception">Conversion to physValue not possible</exception>
    public double get_param_of(int index, string symbol)
    {
      if ((index < 1) || (index > this.Count))
      {
        Console.WriteLine(String.Format("index must be >= 1 and <= {0}, but is: {1}!", 
          this.Count, index));
        return 0;
      }

      return this[index - 1].get_param_of(symbol);
    }

    /// <summary>
    /// Get a string param of the by id specified substrate.
    /// </summary>
    /// <param name="id">id of substrate</param>
    /// <param name="symbol">"name"</param>
    /// <returns>string</returns>
    /// <exception cref="exception">Unknown substrate id</exception>
    /// <exception cref="exception">Unknown parameter</exception>
    /// <exception cref="exception">Conversion to string not possible</exception>
    public string get_param_of_s(string id, string symbol)
    {
      return get(id).get_param_of_s(symbol);
    }
    /// <summary>
    /// Get a double param of the by id specified substrate.
    /// </summary>
    /// <param name="id">id of substrate</param>
    /// <param name="symbol">"fCh_Xc"</param>
    /// <returns>double</returns>
    /// <exception cref="exception">Unknown substrate id</exception>
    /// <exception cref="exception">Unknown parameter</exception>
    /// <exception cref="exception">Conversion to double not possible</exception>
    public double get_param_of_d(string id, string symbol)
    {
      return get(id).get_param_of_d(symbol);
    }
    /// <summary>
    /// Get the Value of a physValue param of the by id specified substrate.
    /// </summary>
    /// <param name="id">id of substrate</param>
    /// <param name="symbol">"RF"</param>
    /// <returns>double value</returns>
    /// <exception cref="exception">Unknown substrate id</exception>
    /// <exception cref="exception">Unknown parameter</exception>
    /// <exception cref="exception">Conversion to physValue not possible</exception>
    public double get_param_of(string id, string symbol)
    {
      return get(id).get_param_of(symbol);
    }



  }
}


