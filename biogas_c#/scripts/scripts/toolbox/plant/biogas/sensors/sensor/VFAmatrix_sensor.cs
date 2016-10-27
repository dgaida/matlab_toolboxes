/**
 * This file defines the class VFAmatrix_sensor.
 * 
 * TODOs:
 * - why do we need this sensor additionally to the already existing sensors
 * Sva_sensor, Spro_sensor, ...?
 * 
 * Because of that not FINISHED!
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
  /// Sensor measuring the VFA matrix (Sva, Sbu, Spro, Sac) in g/l
  /// </summary>
  public class VFAmatrix_sensor : biogas.sensor
  {

    // -------------------------------------------------------------------------------------
    //                              !!! CONSTRUCTOR METHODS !!!
    // -------------------------------------------------------------------------------------
    
    /// <summary>
    /// Standard Constructor creating the sensor. Its id is VFAmatrix.
    /// id_suffix is here the digester ID in which the VFA matrix is measured, followed by 2 or 3,
    /// defining in respectively out.
    /// </summary>
    /// <param name="id_suffix"></param>
      public VFAmatrix_sensor(string id_suffix) :
          base(String.Format("{0}_{1}", _spec, id_suffix),
            String.Format("VFA matrix sensor {0}", id_suffix), id_suffix, 4)
    {

      // number of volatile fatty acids 
      // Sva, Sbu, Spro, Sac
      //dimension= 4;

    }

    /// <summary>
    /// Constructor called by the constructor of biogas.sensors while 
    /// reading the sensors out of a XML file. So reader must be at the correct position, 
    /// which is &lt;sensor&gt; was just read. 
    /// </summary>
    /// <param name="reader"></param>
    /// <param name="id">id of sensor</param>
      public VFAmatrix_sensor(ref XmlTextReader reader, string id) : 
      base(ref reader, id, 4)
    {
      // number of volatile fatty acids 
      // Sva, Sbu, Spro, Sac
      //dimension= 4;
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
    static public string _spec = "VFAmatrix";



    /// <summary>
    /// Get current value of measured variable with the id: param
    /// </summary>
    /// <param name="param">id of the variable, the correct values of the
    /// ids are defined inside this function
    /// ids are: Sva, Sbu, Spro and Sac</param>
    /// <param name="noisy">if true, then noisy measurement values are returned. 
    /// they are only noisy if the parameter apply_real_sensor was true before and during
    /// the simulation</param>
    /// <returns></returns>
    override public physValue getCurrentMeasurement(string param, bool noisy)
    {
      physValue myValue;

      physValue[] values= getCurrentMeasurementVector(noisy);

      switch (param)
      {
        case "Sva":
          myValue= values[0];
          break;
        case "Sbu":
          myValue= values[1];
          break;
        case "Spro":
          myValue= values[2];
          break;
        case "Sac":
          myValue= values[3];
          break;

        default:
          throw new exception(String.Format("VFAmatrix_sensor: Unknown param: {0}!", param));
      }

      return myValue;
    }


    /// <summary>
    /// Get values of measured variable with the id: param
    /// </summary>
    /// <param name="param">id of the variable, the correct values of the
    /// ids are defined inside this function
    /// ids are: Sva, Sbu, Spro and Sac</param>
    /// <param name="noisy">if true, then noisy measurement values are returned. 
    /// they are only noisy if the parameter apply_real_sensor was true before and during
    /// the simulation</param>
    /// <returns></returns>
    override public physValue[] getMeasurementStream(string param, bool noisy)
    {

      switch (param)
      {
        case "Sva":
          return getMeasurementStream(0, noisy);
        case "Sbu":
          return getMeasurementStream(1, noisy);
        case "Spro":
          return getMeasurementStream(2, noisy);
        case "Sac":
          return getMeasurementStream(3, noisy);

        default:
          throw new exception(String.Format("VFAmatrix_sensor: Unknown param: {0}!", param));
      }

    }


    /// <summary>
    /// Get value at time t of measured variable with the id: param
    /// </summary>
    /// <param name="param">id of the variable, the correct values of the
    /// ids are defined inside this function
    /// ids are: Sva, Sbu, Spro and Sac</param>
    /// <param name="t">simulation time in days</param>
    /// <param name="noisy">if true, then noisy measurement values are returned. 
    /// they are only noisy if the parameter apply_real_sensor was true before and during
    /// the simulation</param>
    /// <returns>measured param at given time t</returns>
    override public physValue getMeasurementAt(string param, double t, bool noisy)
    {

      switch (param)
      {
        case "Sva":
          return getMeasurementAt(0, t, noisy);
        case "Sbu":
          return getMeasurementAt(1, t, noisy);
        case "Spro":
          return getMeasurementAt(2, t, noisy);
        case "Sac":
          return getMeasurementAt(3, t, noisy);

        default:
          throw new exception(String.Format("VFAmatrix_sensor: Unknown param: {0}!", param));
      }

    }



    // -------------------------------------------------------------------------------------
    //                            !!! PROTECTED METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// Measures acid concentration in g/l
    /// 
    /// type 0
    /// </summary>
    /// <param name="x">ADM state vector</param>
    /// <param name="par">not used</param>
    /// <returns>four measured acids: Sva, Sbu, Spro, Sac</returns>
    override protected physValue[] doMeasurement(double[] x, params double[] par)
    { 
      physValue[] values= new physValue[dimension];
         
      values[0]= biogas.ADMstate.calcFromADMstate(x, "Sva",  "g/l");
      values[1]= biogas.ADMstate.calcFromADMstate(x, "Sbu",  "g/l");
      values[2]= biogas.ADMstate.calcFromADMstate(x, "Spro", "g/l");
      values[3]= biogas.ADMstate.calcFromADMstate(x, "Sac",  "g/l");
      
      return values;
    }



  }
}


