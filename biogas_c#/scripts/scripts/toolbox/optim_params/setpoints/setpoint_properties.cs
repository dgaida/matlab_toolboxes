/**
 * This file defines the properties of the setpoint object.
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

/**
 * namespace for biogas plant optimization
 * 
 * Definition of:
 * - fitness_params
 * - objective function
 * - weights used inside objective function
 * 
 */
namespace biooptim
{
  /// <summary>
  /// defines all that is needed to implement a setpoint control
  /// 
  /// </summary>
  public partial class setpoint
  {

    // -------------------------------------------------------------------------------------
    //                            !!! PRIVATE FIELDS !!!
    // -------------------------------------------------------------------------------------
    
    /// <summary>
    /// location is either an id of a chp, digester or substrate
    /// or it is 'chps', 'digesters', 'substrates', in the first case, operator
    /// must be empty, in the second case it must be something, see below
    /// </summary>
    private string _location= "chps";

    /// <summary>
    /// the ref file must always be named: 'ref_energyProduction_%s_%i.mat' where %s
    /// must be replaced by id of the chp, digester, substrate if operator is
    /// empty and %i replaced by index
    /// if operator is not empty, just name it 'ref_energyProduction_%i.mat' with
    /// %i replaced by index
    /// 
    /// just name it 'energyProduction' without underscore
    /// 
    /// TODO: nicht sensor_id nennen, sondern spec, weil das nicht die sensor_id ist
    /// sondern die specification, nein beides ist möglich
    /// bei sensoren für einen einzelnen sensor ist es die sensor_id
    /// bei summensensoren ist es nur die spec
    /// </summary>
    private string _sensor_id= "energyProduction";

    /// <summary>
    /// index inside the sensor: 0, 1, 2, ...
    /// </summary>
    private int _index= 0;

    /// <summary>
    /// char: 'sum', 'mean' or empty, if just one id is used above
    /// </summary>
    private string _s_operator= "sum";

    /// <summary>
    /// scaling factor, which is multiplied with the control error
    /// </summary>
    private double _scalefac = 0.1;

    

    // -------------------------------------------------------------------------------------
    //                              !!! PROPERTIES !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// location is either an id of a chp, digester or substrate
    /// or it is 'chps', 'digesters', 'substrates', in the first case, operator
    /// must be empty, in the second case it must be something, see below
    /// </summary>
    public string location
    {
      get { return _location; }
    }

    /// <summary>
    /// just name it 'energyProduction' without underscore
    /// </summary>
    public string sensor_id
    {
      get { return _sensor_id; }
    }

    /// <summary>
    /// index inside the sensor: 0, 1, 2, ...
    /// </summary>
    public int index
    {
      get { return _index; }
    }

    /// <summary>
    /// char: 'sum', 'mean' or empty, if just one id is used above
    /// </summary>
    public string s_operator
    {
      get { return _s_operator; }
    }

    /// <summary>
    /// scaling factor, which is multiplied with the control error
    /// </summary>
    public double scalefac
    {
      get { return _scalefac; }
    }


    
  }
}
