/**
 * This file is part of the partial class digester and defines
 * private fields and properties.
 * 
 * TODOs:
 * - Anaerobic Digestion Model ADM not yet used
 * 
 * Except for that FINISHED!
 * 
 */

using System;
using System.Collections.Generic;
using System.Text;
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
  /// Defines a digester on a biogas plant. To each digester a heating belongs, which is
  /// either switched on or off.
  /// 
  /// Furthermore each digester is modelled by an anaerobic digestion model (ADM).
  /// This ADM object is accessible through this class.
  /// 
  /// </summary>
  public partial class digester
  {

    // -------------------------------------------------------------------------------------
    //                            !!! PRIVATE FIELDS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// id of the digester
    /// </summary>
    private string _id= "";

    /// <summary>
    /// name of the digester
    /// </summary>
    private string _name= "";

    /// <summary>
    /// maximal total volume of the digester [m^3]
    /// </summary>
    private physValue Vtot;

    /// <summary>
    /// current liquid volume of the digester [m^3]
    /// </summary>
    private physValue _Vliq;

    /// <summary>
    /// maximal liquid volume of the digester [m^3]
    /// </summary>
    private physValue Vliqmax;

    /// <summary>
    /// current volume of the gas space of the digester [m^3]
    /// </summary>
    private physValue _Vgas;

    /// <summary>
    /// maximal volume of the gas space of the digester [m^3]
    /// </summary>
    private physValue Vgasmax;

    /// <summary>
    /// current temperature inside the digester [°C]
    /// </summary>
    private physValue _T;

    /// <summary>
    /// diameter of the digester [m]
    /// a cylindrical digester is assumed
    /// </summary>
    private physValue _diam;

    ///// <summary>
    ///// height of the digester tank [m]
    // wird über Vliq und diam bestimmt
    ///// </summary>
    //private physValue _height;

    ///// <summary>
    ///// max. height of the digesters roof [m]
    // wird über Vgas und diam bestimmt
    ///// </summary>
    //private physValue _h_roof;

    /// <summary>
    /// heat transfer coefficient of the digester wall [W/(m^2 * K)]
    /// </summary>
    private physValue _k_wall;

    /// <summary>
    /// heat transfer coefficient of the digester roof [W/(m^2 * K)]
    /// </summary>
    private physValue _k_roof;

    /// <summary>
    /// heat transfer coefficient of the digester ground [W/(m^2 * K)]
    /// </summary>
    private physValue _k_ground;

    /// <summary>
    /// heating of the digester
    /// </summary>
    private heating _heating;

    /// <summary>
    /// stirrers of digester
    /// </summary>
    private stirrers _mixers= new stirrers();

    /// <summary>
    /// Anaerobic Digestion Model
    /// </summary>
    private ADM _AD_Model;

    /// <summary>
    /// TODO: not yet used
    /// accumulation of soluble solids: 0 &lt;= ... &lt;= 1
    /// 1 - no accumulation
    /// 0 - total accumulation (no effluent)
    /// </summary>
    private double _accum_s = 1;

    /// <summary>
    /// TODO: not yet used
    /// accumulation of particulate solids: 0 &lt;= ... &lt;= 1
    /// 1 - no accumulation
    /// 0 - total accumulation (no effluent)
    /// </summary>
    private double _accum_x = 1;

 

    // -------------------------------------------------------------------------------------
    //                              !!! PROPERTIES !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// id of the digester
    /// </summary>
    public string id
    {
      get { return _id; }
    }

    /// <summary>
    /// name of the digester
    /// </summary>
    public string name
    {
      get { return _name; }
    }

    /// <summary>
    /// current liquid volume of the digester [m^3]
    /// </summary>
    public physValue Vliq
    {
      get { return _Vliq; }
    }

    /// <summary>
    /// current volume of the gas space of the digester [m^3]
    /// </summary>
    public physValue Vgas
    {
      get { return _Vgas; }
    }

    /// <summary>
    /// current temperature inside the digester [°C]
    /// </summary>
    public physValue T
    {
      get { return _T; }
    }

    /// <summary>
    /// diameter of the digester [m]
    /// a cylindrical digester is assumed
    /// </summary>
    public physValue diam
    {
      get { return _diam; }
    }

    /// <summary>
    /// height of the digester tank [m]
    /// </summary>
    public physValue height
    {
      get 
      {
        physValue Vl = Vliq.convertUnit("m^3");
        physValue ddig = diam.convertUnit("m");

        if (ddig.Value != 0)
          return 4.0f * Vl / (ddig * ddig * Math.PI) * new physValue(1, "m*m*m/(m^3)");
        else
          return new physValue("h_dig", 0, "m");
      }
    }

    /// <summary>
    /// max. height of the digesters roof [m]
    /// </summary>
    public physValue h_roof
    {
      get 
      {
        physValue Vg = Vgas.convertUnit("m^3");
        physValue ddig = diam.convertUnit("m");

        if (ddig.Value != 0 || Vg.Value != 0)
        {
          double temp1 = Math.Pow(ddig.Value, 6) * Math.Pow(Math.PI, 2);
          //physValue temp1 = physValue.Pow(ddig, 6) * Math.Pow(Math.PI, 2) * new physValue(1, "m^6/((m)^6)");
          double temp2 = 576.0f * Math.Pow(Vg.Value, 2);
          //physValue temp2 = 576.0f * physValue.Pow(Vg, 2) * new physValue(1, "m^6/((m^3)^2)");
          double temp3 = Math.Sqrt(temp1 + temp2);
          //physValue temp3 = physValue.Sqrt( temp1 + temp2 ) * new physValue(1, "m^3/((m^6)^(1/2))");

          double temp4 = 24.0f * Vg.Value + temp3;
          //physValue temp4 = 24.0f * Vg + temp3;
          double numerator1 = -Math.Pow(temp4, 2.0f / 3.0f) * Math.Pow(Math.PI, (double)1.0f / 3.0);
          //physValue numerator1 = -physValue.Pow(temp4, 2, 3) * new physValue(1, "m^2/((m^3)^(2/3))") * 
          //                       Math.Pow(Math.PI, (double)1 / 3.0);

          double numerator = numerator1 + Math.Pow(ddig.Value, 2) * Math.PI;
          //physValue numerator = numerator1 + physValue.Pow(ddig, 2) * Math.PI;

          double denominator = Math.Pow(Math.PI, 2.0 / 3.0f) * Math.Pow(temp4, 1.0f / 3.0f);
          //physValue denominator = Math.Pow(Math.PI, 2.0 / 3.0f) * physValue.Pow(temp4, 1, 3) *
          //  new physValue(1, "m/((m^3)^(1/3))");

          return new physValue("h_roof", -1.0f / 2.0f * numerator / denominator, "m");
        }
        else
          return new physValue("h_roof", 0, "m");
      }
    }

    /// <summary>
    /// surface area of cylindrical wall [m^2]
    /// </summary>
    public physValue Awall
    {
      get 
      {
        return Math.PI * diam * height * new physValue(1, "m^2/(m*m)");
      }
    }

    /// <summary>
    /// surface area of roof 
    /// (Oberfläche (Mantelfläche) einer Kugelkalotte, Kugelkappe, Kugelhaube) 
    /// spherical cap
    /// Bronstein, S. 161
    /// [m^2]
    /// </summary>
    public physValue Aroof
    {
      get
      {
        //return Math.PI * (physValue.Pow(diam, 2) / 4 + physValue.Pow(h_roof, 2));
        return new physValue("Aroof", Math.PI * Math.Pow(diam.Value, 2) / 4.0f + 
                                                Math.Pow(h_roof.Value, 2), "m^2");
      }
    }

    /// <summary>
    /// surface area of cylindrical ground [m^2]
    /// </summary>
    public physValue Aground
    {
      get
      {
        return Math.PI * diam * diam / 4.0f * new physValue(1, "m^2/(m*m)");
      }
    }

    /// <summary>
    /// heat transfer coefficient of the digester wall [W/(m^2 * K)]
    /// deutsch: Wärmedurchgangskoeffizient
    /// In Ganzheitliche stoffliche und energetische Modellierung S. 52
    /// werden Werte genannt:
    /// * 0.57 W/(m² * K)
    /// * 0.3 bis 1 W/(m² * K)
    /// </summary>
    public physValue k_wall
    {
      get { return _k_wall; }
    }

    /// <summary>
    /// heat transfer coefficient of the digester roof [W/(m^2 * K)]
    /// </summary>
    public physValue k_roof
    {
      get { return _k_roof; }
    }

    /// <summary>
    /// heat transfer coefficient of the digester ground [W/(m^2 * K)]
    /// </summary>
    public physValue k_ground
    {
      get { return _k_ground; }
    }

    /// <summary>
    /// heating of the fermenter
    /// </summary>
    public heating heating
    {
      get { return _heating; }
    }

    /// <summary>
    /// stirrers of the fermenter
    /// </summary>
    public stirrers mixers
    {
      get { return _mixers; }
    }

    /// <summary>
    /// Anaerobic Digestion Model
    /// </summary>
    public ADM AD_Model
    {
      get { return _AD_Model; }
    }

    /// <summary>
    /// accumulation of soluble solids: 0 &lt;= ... &lt;= 1
    /// 1 - no accumulation
    /// 0 - total accumulation (no effluent)
    /// </summary>
    public double accum_s
    {
      get { return _accum_s; }
    }

    /// <summary>
    /// accumulation of particulate solids: 0 &lt;= ... &lt;= 1
    /// 1 - no accumulation
    /// 0 - total accumulation (no effluent)
    /// </summary>
    public double accum_x
    {
      get { return _accum_x; }
    }



    // -------------------------------------------------------------------------------------
    //                          !!! PUBLIC PROPERTIES !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// Proportionale Regelungskonstante für Gasausgleich [m^3/(m^3*d)]
    /// </summary>
    public static physValue kp= new physValue("kp", 10000, "m^3 / (m^3 * d)");

    

  }
}


