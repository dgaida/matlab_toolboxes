/**
 * This file defines the class ADMparams_sensor.
 * 
 * TODOs:
 * - is only suited for the ADM1xp, because it depends on size of ADM internal params
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
  /// Sensor measuring the ADMparams
  /// </summary>
  public class ADMparams_sensor : biogas.sensor
  {

    // -------------------------------------------------------------------------------------
    //                              !!! CONSTRUCTOR METHODS !!!
    // -------------------------------------------------------------------------------------
    
    /// <summary>
    /// Standard Constructor creating the sensor. Its id is ADMparams.
    /// id_suffix is here the digester ID in which the ADMparams are measured
    /// </summary>
    /// <param name="id_suffix"></param>
    public ADMparams_sensor(string id_suffix) :
      base( String.Format("{0}_{1}", _spec, id_suffix),
            String.Format("ADMparams sensor {0}", id_suffix), id_suffix,
      ADMparams.numParams)
    {
      //dimension= 64 + (int)BioGas.n_gases;

      // TODO
      // type?
      //_type = ?;
      _type = 927;
    }

    /// <summary>
    /// Constructor called by the constructor of biogas.sensors while 
    /// reading the sensors out of a XML file. So reader must be at the correct position, 
    /// which is &lt;sensor&gt; was just read. 
    /// </summary>
    /// <param name="reader"></param>
    /// <param name="id">id of sensor</param>
    public ADMparams_sensor(ref XmlTextReader reader, string id) :
      base(ref reader, id, ADMparams.numParams)
    {
      //dimension = 64 + (int)BioGas.n_gases;

      // TODO
      // type?
      //_type = ?;
      _type = 927; 
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
    static public string _spec = "ADMparams";

    

    // -------------------------------------------------------------------------------------
    //                            !!! PROTECTED METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// since x is not the state vector, this is not type 0!
    /// </summary>
    /// <param name="x">ADM1 internal params vector</param>
    /// <param name="par">not used</param>
    /// <returns>measured ADM1 internal params vector</returns>
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
        values[idim]= new physValue(String.Format("par_{0}", idim), x[idim], "");
      }

      return values;
    }



  }
}


