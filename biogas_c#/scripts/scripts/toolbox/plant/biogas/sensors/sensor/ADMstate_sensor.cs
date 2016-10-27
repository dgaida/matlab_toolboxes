/**
 * This file defines the class ADMstate_sensor.
 * 
 * TODOs:
 * - hängt natürlich auch von implementiertem ADM1 Modell ab
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
  /// Sensor measuring the ADMstate
  /// </summary>
  public class ADMstate_sensor : biogas.sensor
  {

    // -------------------------------------------------------------------------------------
    //                              !!! CONSTRUCTOR METHODS !!!
    // -------------------------------------------------------------------------------------
    
    /// <summary>
    /// Standard Constructor creating the sensor. Its id is ADMstate.
    /// id_suffix is here the digester ID in which the ADMstate is measured
    /// </summary>
    /// <param name="id_suffix"></param>
    public ADMstate_sensor(string id_suffix) :
      base( String.Format("{0}_{1}", _spec, id_suffix),
            String.Format("ADMstate sensor {0}", id_suffix), id_suffix,
      (int)ADMstate.dim_state)
    {
      //dimension= (int)ADMstate.dim_state;

      // TODO
      // _type= ?;
      _type = 98;
    }

    /// <summary>
    /// Constructor called by the constructor of biogas.sensors while 
    /// reading the sensors out of a XML file. So reader must be at the correct position, 
    /// which is &lt;sensor&gt; was just read. 
    /// </summary>
    /// <param name="reader"></param>
    /// <param name="id">id of sensor</param>
    public ADMstate_sensor(ref XmlTextReader reader, string id) :
      base(ref reader, id, (int)ADMstate.dim_state)
    {
      //dimension = (int)ADMstate.dim_state;

      // TODO
      // _type= ?;
      _type = 98;
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
    static public string _spec = "ADMstate";



    // -------------------------------------------------------------------------------------
    //                            !!! PROTECTED METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// Measure ADM state vector in default units of the model
    /// 
    /// not type 0, because x is not the stream vector, but the 37 dim state vector
    /// </summary>
    /// <param name="x">37 dim state vector</param>
    /// <param name="par">not used</param>
    /// <returns>measured ADM state vector</returns>
    /// <exception cref="exception">x.Length != ADMstate.dim_state</exception>
    override protected physValue[] doMeasurement(double[] x, params double[] par)
    { 
      physValue[] values= new physValue[dimension];

      if (x.Length != ADMstate.dim_state)
      {
        throw new exception(String.Format(
                "x has not the correct dimension! is: {0}, must be: {1}!", 
                x.Length, ADMstate.dim_state));
      }

      for (int idim= 0; idim < dimension; idim++)
      {
        values[idim]= new physValue(ADMstate.symADMstate[idim], x[idim],
                                    ADMstate.getUnitOfADMstatevariable(idim + 1));
      }

      return values;
    }



  }
}


