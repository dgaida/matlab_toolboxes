/**
 * This file defines the class fitness_sensor.
 * 
 * TODOs:
 * - dimension ist variabel, hängt von anzahl objectives ab
 *   da dimension eines sensors eigentlich völlig egal ist, ist das ok so.
 *   ist nur wichtig für real sensor, und sensor_config, dieser sensor ist demnach immer ideal
 *   in sensor_config.getNoisyMeasurement wird einfach bei unstimmigkeit der dimensionen
 *   die ideale messung gemessen
 * 
 * Except for that FINISHED!
 * 
 */

using System;
using System.Collections.Generic;
using System.Text;
using System.Xml;
using science;
using biogas;
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
  /// Sensor measuring the fitness of optimization runs
  /// </summary>
  public class fitness_sensor : biogas.sensor
  {

    // -------------------------------------------------------------------------------------
    //                              !!! CONSTRUCTOR METHODS !!!
    // -------------------------------------------------------------------------------------
    
    /// <summary>
    /// Standard Constructor creating the sensor. Its id is fitness.
    /// 
    /// TODO: dimension müsste hier übergeben werden
    /// </summary>
    public fitness_sensor() :
      base( _spec, "fitness sensor", "")
    {
      // TODO - dimension ist variabel, hängt von anzahl objectives ab
      //dimension = 1;

      // TODO
      // type= ?
      _type = 94;
    }

    /// <summary>
    /// Constructor called by the constructor of biogas.sensors while 
    /// reading the sensors out of a XML file. So reader must be at the correct position, 
    /// which is &lt;sensor&gt; was just read. 
    /// </summary>
    /// <param name="reader"></param>
    /// <param name="id">id of sensor</param>
    public fitness_sensor(ref XmlTextReader reader, string id) : 
      base(ref reader, id)
    {
      // TODO - dimension ist variabel, hängt von anzahl objectives ab
      //dimension = 1;

      // TODO
      // type= ?
      _type = 94;
    }



    // -------------------------------------------------------------------------------------
    //                              !!! PROPERTIES !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// defines specification of sensor
    /// </summary>
    override public string spec { get { return _spec; } }

    /// <summary>
    /// defines specification of sensor
    /// </summary>
    static public string _spec = "fitness";



    // -------------------------------------------------------------------------------------
    //                            !!! PROTECTED METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// needed for multiobjective optimization, then x is the fitness vector
    /// </summary>
    /// <param name="x">fitness vector</param>
    /// <param name="par">not used</param>
    /// <returns></returns>
    override protected physValue[] doMeasurement(double[] x, params double[] par)
    {
      //throw new exception("Not implemented!");

      int nObj = x.Length;    // number of objectives

      physValue[] values = new physValue[nObj];

      for (int ival = 0; ival < nObj; ival++ )
        values[ival] = new physValue(String.Format("fitness {0}", ival), x[ival], "-");

      return values;
    }

    /// <summary>
    /// just saves the given fitness value
    /// 
    /// type 2
    /// </summary>
    /// <param name="param">the fitness value</param>
    /// <returns></returns>
    override protected physValue[] doMeasurement(double param)
    { 
      physValue[] values= new physValue[1];

      values[0]= new physValue("fitness", param, "-");

      return values;
    }



  }
}


