/**
 * This file defines the class ADMintvars_sensor.
 * 
 * TODOs:
 * - is only suited for the ADM1xp, because it depends on size of ADM internal variables
 * 
 * Maybe not FINISHED!
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
  /// Sensor measuring the ADMintvars
  /// </summary>
  public class ADMintvars_sensor : biogas.sensor
  {

    // -------------------------------------------------------------------------------------
    //                              !!! CONSTRUCTOR METHODS !!!
    // -------------------------------------------------------------------------------------
    
    /// <summary>
    /// Standard Constructor creating the sensor. Its id is ADMintvars.
    /// id_suffix is here the digester ID in which the ADMintvars are measured
    /// </summary>
    /// <param name="id_suffix"></param>
    public ADMintvars_sensor(string id_suffix) :
      base( String.Format("{0}_{1}", _spec, id_suffix),
            String.Format("ADMintvars sensor {0}", id_suffix), id_suffix,
      64 + (int)BioGas.n_gases)
    {
      //dimension= 64 + (int)BioGas.n_gases;

      // TODO
      // type?
      //_type = ?;
      _type = 97;
    }

    /// <summary>
    /// Constructor called by the constructor of biogas.sensors while 
    /// reading the sensors out of a XML file. So reader must be at the correct position, 
    /// which is &lt;sensor&gt; was just read. 
    /// </summary>
    /// <param name="reader"></param>
    /// <param name="id">id of sensor</param>
    public ADMintvars_sensor(ref XmlTextReader reader, string id) :
      base(ref reader, id, 64 + (int)BioGas.n_gases)
    {
      //dimension = 64 + (int)BioGas.n_gases;

      // TODO
      // type?
      //_type = ?;
      _type = 97; 
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
    static public string _spec = "ADMintvars";

    

    // -------------------------------------------------------------------------------------
    //                            !!! PROTECTED METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// since x is not the state vector, this is not type 0!
    /// </summary>
    /// <param name="x">ADM1 internal variables vector</param>
    /// <param name="par">not used</param>
    /// <returns>measured ADM1 internal variables vector</returns>
    /// <exception cref="exception">x.Length != dimension</exception>
    override protected physValue[] doMeasurement(double[] x, params double[] par)
    { 
      physValue[] values= new physValue[dimension];

      if (x.Length != dimension)
      {
        throw new exception(String.Format(
                "x has not the correct dimension! is: {0}, must be: {1}!",
                x.Length, dimension));
      }

      for (int idim= 0; idim < dimension; idim++)
      {
        values[idim]= new physValue(String.Format("var_{0}", idim), x[idim], "");
      }

      return values;
    }



  }
}


