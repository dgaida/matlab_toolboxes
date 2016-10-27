/**
 * This file defines the class sludge.
 * 
 * TODOs:
 * - 
 * 
 * So far finished...
 * 
 */

using System;
using System.Collections.Generic;
using System.Text;
using science;
using toolbox;
using System.Xml;
using System.IO;

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
  /// Defines sludge coming from a digester, which is a kind of substrate.
  /// </summary>
  public class sludge : biogas.substrate
  {

    // -------------------------------------------------------------------------------------
    //                              !!! CONSTRUCTOR METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// constructor
    /// 
    /// creates a new sludge object, which has parameters the same as the mean
    /// substrate feed (Rf, RP, RL, ADL, VS), the given TS content and
    /// a density of 1000 kg/m³
    /// 
    /// TS measured in % FM
    /// 
    /// sludge is created out of the weighted mean of the given substrates,
    /// which should be the substrates fed on the plant.
    /// 
    /// </summary>
    /// <param name="mySubstrates">list of substrates</param>
    /// <param name="Q">must be measured in m³/d</param>
    /// <param name="TS">must be measured in % FM</param>
    public sludge(substrates mySubstrates, double[] Q, double TS) : base()
    {
      
      physValue RF;
      physValue RP;
      physValue RL;
      physValue ADL;
      physValue VS;

      try
      {
        mySubstrates.get_weighted_mean_of(Q, "RF",  out RF);
        mySubstrates.get_weighted_mean_of(Q, "RP",  out RP);
        mySubstrates.get_weighted_mean_of(Q, "RL",  out RL);
        mySubstrates.get_weighted_mean_of(Q, "ADL", out ADL);
        mySubstrates.get_weighted_mean_of(Q, "VS",  out VS);

        set_params_of("RF", RF.Value, "RP", RP.Value, "RL", RL.Value,
                      "ADL", ADL.Value, "VS", VS.Value);

        set_params_of("TS", TS);
      }
      catch(exception e)
      {
        Console.WriteLine(e.Message);
        // TODO - maybe do something
        LogError.Log_Err("sludge constructor1", e);
      }

      // TODO: could calculate rho here instead of taking 1000 kg/m^3
      //set_params_of("rho", new physValue(1000, "kg/m^3"));



    }

    /// <summary>
    /// constructor
    /// 
    /// creates a new sludge object, which has parameters the same as the mean
    /// substrate feed (Rf, RP, RL, ADL), the given VS and TS content and
    /// a density of 1000 kg/m³
    /// 
    /// TS measured in % FM
    /// 
    /// sludge is created out of the weighted mean of the given substrates,
    /// which should be the substrates fed on the plant.
    /// 
    /// </summary>
    /// <param name="mySubstrates">list of substrates</param>
    /// <param name="Q">must be measured in m³/d</param>
    /// <param name="TS">must be measured in % FM</param>
    /// <param name="VS">must be measured in % TS</param>
    public sludge(substrates mySubstrates, double[] Q, double TS, double VS)
      : base()
    {

      physValue RF;
      physValue RP;
      physValue RL;
      physValue ADL;
      //physValue VS;

      try
      {
        mySubstrates.get_weighted_mean_of(Q, "RF", out RF);
        mySubstrates.get_weighted_mean_of(Q, "RP", out RP);
        mySubstrates.get_weighted_mean_of(Q, "RL", out RL);
        mySubstrates.get_weighted_mean_of(Q, "ADL", out ADL);
        //mySubstrates.get_weighted_mean_of(Q, "VS", out VS);

        set_params_of("RF", RF.Value, "RP", RP.Value, "RL", RL.Value,
                      "ADL", ADL.Value);//, "VS", VS.Value);
      }
      catch (exception e)
      {
        Console.WriteLine(e.Message);
        // TODO - maybe do something
        LogError.Log_Err("sludge constructor2a", e);
      }

      try
      {
        set_params_of("TS", TS);
        set_params_of("VS", VS);
      }
      catch (exception e)
      {
        Console.WriteLine(e.Message);
        // TODO - maybe do something
        LogError.Log_Err("sludge constructor2b", e);

        throw (e);
      }

      // TODO: could calculate rho here instead of taking 1000 kg/m^3
      //set_params_of("rho", new physValue(1000, "kg/m^3"));



    }



    // -------------------------------------------------------------------------------------
    //                              !!! PUBLIC METHODS !!!
    // -------------------------------------------------------------------------------------



  }
}


