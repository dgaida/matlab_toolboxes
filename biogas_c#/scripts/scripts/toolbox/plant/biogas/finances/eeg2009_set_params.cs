/**
 * This file defines funding via the EEG 2009, public set_params methods.
 * 
 * TODOs:
 * - 
 * 
 * Should be FINISHED!
 * 
 */

using System;
using System.Collections.Generic;
using System.Text;
using System.Xml;
using science;
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
  /// funding structure of EEG 2009
  /// </summary>
  public partial class eeg2009 : funding
  {

    // -------------------------------------------------------------------------------------
    //                              !!! PUBLIC METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// Lets you set the different boni included in the EEG 2009
    /// </summary>
    /// <param name="symbols"></param>
    /// <exception cref="exception">Unknown parameter</exception>
    public override void set_params_of(params object[] symbols)
    {
      for (int iarg = 0; iarg < symbols.Length; iarg = iarg + 2)
      {
        switch ((string)symbols[iarg])
        {
          case "nawaro":                // 
            this.nawaro_b = (bool)symbols[iarg + 1];
            break;
          case "kwk":                   //
            this.kwk_b = (bool)symbols[iarg + 1];
            break;
          case "innovation":            //
            this.innovation_b = (bool)symbols[iarg + 1];
            break;
          case "immission":             //
            this.immission_b = (bool)symbols[iarg + 1];
            break;
          case "manure":                // Gülle-Bonus
            this.manure_b = (bool)symbols[iarg + 1];
            break;
          case "landschaft":            // Landschaftspflege-Bonus
            this.landschaft_b = (bool)symbols[iarg + 1];
            break;

          default:
            throw new exception(String.Format("Unknown parameter: {0}!",
                                              (string)symbols[iarg]));
        }
      }
    }

    /// <summary>
    /// Get params as an array of objects.
    /// </summary>
    /// <param name="variables">values</param>
    /// <param name="symbols"></param>
    /// <exception cref="exception">Unknown parameter</exception>
    /// <exception cref="exception">No input argument</exception>
    public override void get_params_of(out object[] variables, params string[] symbols)
    {
      int nargin = symbols.Length;

      if (nargin > 0)
      {
        variables = new object[nargin];

        for (int iarg = 0; iarg < nargin; iarg++)
        {
          switch (symbols[iarg])
          {
            case "nawaro":
              variables[iarg] = this.nawaro_b;
              break;
            case "kwk":                        // 
              variables[iarg] = this.kwk_b;
              break;
            case "innovation":                         // 
              variables[iarg] = this.innovation_b;
              break;
            case "immission":                      // 
              variables[iarg] = this.immission_b;
              break;
            case "manure":                      // 
              variables[iarg] = this.manure_b;
              break;
            case "landschaft":                   // 
              variables[iarg] = this.landschaft_b;
              break;

            default:
              throw new exception(String.Format("Unknown parameter: {0}!", symbols[iarg]));
          }
        }
      }
      else
        throw new exception("You did not give an argument!");
    }



  }
}
