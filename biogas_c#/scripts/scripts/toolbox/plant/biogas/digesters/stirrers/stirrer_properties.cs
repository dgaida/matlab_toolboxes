/**
 * This file is part of the partial class stirrer and defines
 * private fields and properties of the stirrer.
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
  /// Defines a stirrer used to stir the content in a digester
  /// </summary>
  public partial class stirrer
  {

    // -------------------------------------------------------------------------------------
    //                            !!! PRIVATE FIELDS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// id of the stirrer
    /// </summary>
    private string _id = "";

    /// <summary>
    /// electrical degree of efficiency of the stirrer, measured in 100 %
    /// </summary>
    private double _eta_mixer= 0;

    /// <summary>
    /// diameter of the stirrer in meter
    /// TODO: könnte man auch als physValue definieren
    /// </summary>
    private double _diameter = 0;

    /// <summary>
    /// rotation speed of the stirrer in 1/second
    /// TODO: könnte man auch als physValue definieren
    /// was bedeutet 1/second als einheit, ist nicht rad/s!
    /// http://en.wikipedia.org/wiki/Rotational_speed
    /// 1/min bedeutet: rpm: also 1 runde pro minute
    /// in rad/min, währen das also 2pi/min=2pi/60 1/s
    /// </summary>
    private double _rotspeed = 0;

    /// <summary>
    /// duration (Laufzeit = run time) of stirrer running per day measured in hours
    /// 24 h/d = 24
    /// TODO: könnte man auch als physValue definieren
    /// </summary>
    private double _runtime = 24;

    ///// <summary>
    ///// C_K,1 / [Pa * s], als Funktion implementieren
    ///// </summary>
    //private double _CK1 = 0;

    /// <summary>
    /// type of stirrer
    /// 0 - central mixer with Strömungsbrecher (0 und 1 sind "normal")
    /// 1 - submersible stirrer without Strömungsbrecher 
    /// 2 - central mixer without Strömungsbrecher
    /// 3 - submersible mixer with Strömungsbrecher
    /// </summary>
    private int _type = 0;

    /// <summary>
    /// if the fermenter is stirred, then true, else false
    /// </summary>
    private bool _stirred= true;



    // -------------------------------------------------------------------------------------
    //                              !!! PROPERTIES !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// id of the stirrer
    /// </summary>
    public string id
    {
      get { return _id; }
    }

    /// <summary>
    /// electrical degree of efficiency of the stirrer
    /// </summary>
    public double eta_mixer
    {
      get { return _eta_mixer; }
    }

    /// <summary>
    /// diameter of the stirrer in meter
    /// TODO: könnte man auch als physValue definieren
    /// </summary>
    public double diameter
    {
      get { return _diameter; }
    }

    /// <summary>
    /// rotation speed of the stirrer in 1/second
    /// TODO: könnte man auch als physValue definieren
    /// </summary>
    public double rotspeed
    {
      get { return _rotspeed; }
    }

    /// <summary>
    /// duration (Laufzeit = run time) of stirrer running per day measured in hours
    /// 24 h/d = 24
    /// TODO: könnte man auch als physValue definieren
    /// </summary>
    public double runtime
    {
      get { return _runtime; }
    }

    /// <summary>
    /// type of stirrer
    /// 0 - central mixer with Strömungsbrecher (0 und 1 sind "normal")
    /// 1 - submersible stirrer without Strömungsbrecher 
    /// 2 - central mixer without Strömungsbrecher
    /// 3 - submersible mixer with Strömungsbrecher
    /// </summary>
    public int type
    {
      get { return _type; }
    }

    /// <summary>
    /// if the fermenter is stirred, then true, else false
    /// </summary>
    public bool stirred
    {
      get { return _stirred; }
    }



  }
}


