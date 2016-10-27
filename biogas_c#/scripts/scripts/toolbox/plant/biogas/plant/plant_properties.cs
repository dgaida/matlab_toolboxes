/**
 * This file is part of the partial class plant and defines
 * private fields and properties of the plant.
 * 
 * TODOs:
 * - add Tground and use it in calculation of radiation loss
 * 
 * Apart from that FINISHED!
 * 
 */

using System;
using System.Collections.Generic;
using System.Text;
using science;
using System.Xml;
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
    //                            !!! PRIVATE FIELDS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// id of the plant
    /// </summary>
    private string _id= "";

    /// <summary>
    /// name of the plant
    /// </summary>
    private string _name;

    /// <summary>
    /// ambient temperature of the plant (outside)
    /// </summary>
    private physValue _Tout;

    // TODO
    // add Tground and use it in calculation of radiation loss

    /// <summary>
    /// gravitational acceleration [m/s^2]
    /// </summary>
    private physValue _g;

    /// <summary>
    /// construction year of plant. e.g. 2009, 2010, ...
    /// </summary>
    private int _construct_year;

    /// <summary>
    /// list of digesters on the plant
    /// </summary>
    public digesters myDigesters= new digesters();

    /// <summary>
    /// list of combined heat and power plants on the plant
    /// </summary>
    public chps myCHPs= new chps();

    /// <summary>
    /// list of pumps and other transport utilities on the plant
    /// </summary>
    public transportation myTransportation= new transportation();

    /// <summary>
    /// finances
    /// </summary>
    public finances myFinances= new finances();



    // -------------------------------------------------------------------------------------
    //                              !!! PROPERTIES !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// id of the plant
    /// </summary>
    public string id
    {
      get { return _id; }
    }

    /// <summary>
    /// name of the plant
    /// </summary>
    public string name
    {
      get { return _name; }
    }

    /// <summary>
    /// gravitational acceleration [m/s^2]
    /// </summary>
    public physValue g
    {
      get { return _g; }
    }

    /// <summary>
    /// ambient temperature of the plant (outside)
    /// </summary>
    public physValue Tout
    {
      get { return _Tout; }
    }

    /// <summary>
    /// construction year of plant. e.g. 2009, 2010, ...
    /// </summary>
    public int construct_year
    {
      get { return _construct_year; }
    }



  }
}


