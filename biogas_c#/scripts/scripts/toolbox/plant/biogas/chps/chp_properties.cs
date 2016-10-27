/**
 * This file is part of the partial class chp and defines
 * the private fields and properties of the chp.
 * 
 * TODOs:
 * - evtl. sollte man noch einen Parameter is_running hinzufügen um Stillzeiten 
 *   simulieren zu können. Die Idee soll sein, ein biogasspeicher in der größe der Gasphase
 *   der fermenter zu modellieren in dem das prod. biogas rein geht und aus dem die bhkws
 *   das biogas in der entsprechenden menge abgreifen. damit wird es möglich erst wenn gasphase
 *   voll ist, das überschüssige gas abzufackeln und die in realen daten immer wieder aufkommenden
 *   stillzeiten der bhkws sind damit besser modellierbar. 
 * 
 * Apart from that FINISHED!
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
  /// Definition of a combined heat and power plant (cogeneration unit)
  /// </summary>
  public partial class chp
  {

    // -------------------------------------------------------------------------------------
    //                            !!! PRIVATE FIELDS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// id of the combined heat and power plant
    /// </summary>
    private string _id= "";

    /// <summary>
    /// name of the combined heat and power plant
    /// </summary>
    private string _name= "";
      
    /// <summary>
    /// electrical power of the chp
    /// </summary>
    private physValue _Pel;

    /// <summary>
    /// thermal power of the chp
    /// </summary>
    private physValue _Ptherm;
    
    /// <summary>
    /// electrical degree of efficiency
    /// </summary>
    private double _eta_el;
    
    /// <summary>
    /// thermal degree of efficiency
    /// 
    /// in diesem Wert ist auch Wärmeverlust für Wärmetransport über Rohre 
    /// eingerechnet. 
    /// </summary>
    private double eta_therm;

    

    // -------------------------------------------------------------------------------------
    //                              !!! PROPERTIES !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// id of the combined heat and power plant
    /// </summary>
    public string id
    {
      get { return _id; }
    }

    /// <summary>
    /// name of the combined heat and power plant
    /// </summary>
    public string name
    {
      get { return _name; }
    }

    /// <summary>
    /// electrical power of the chp
    /// </summary>
    public physValue Pel
    {
      get { return _Pel; }
    }

    /// <summary>
    /// thermal power of the chp
    /// </summary>
    public physValue Ptherm
    {
      get { return _Ptherm; }
    }

    /// <summary>
    /// electrical degree of efficiency
    /// </summary>
    public double eta_el
    {
      get { return _eta_el; }
    }
  


  }
}


