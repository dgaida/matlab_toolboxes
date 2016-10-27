/**
 * This file defines the class biogas_sensor.
 * 
 * TODOs:
 * - s. TODO in Datei
 * - hängt von Anzahl gemessener Gase ab
 * 
 * Therefore not yet FINISHED!
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
  /// Sensor measuring the biogas
  /// </summary>
  public class biogas_sensor : biogas.sensor
  {

    // -------------------------------------------------------------------------------------
    //                              !!! CONSTRUCTOR METHODS !!!
    // -------------------------------------------------------------------------------------
    
    /// <summary>
    /// Standard Constructor creating the sensor. Its id is biogas.
    /// id_suffix is here the digester ID in which the biogas is measured.
    /// </summary>
    /// <param name="id_suffix"></param>
    public biogas_sensor(string id_suffix) :
      base( String.Format("{0}_{1}", _spec, id_suffix),
            String.Format("biogas sensor {0}", id_suffix), id_suffix, 2 * (int)BioGas.n_gases)
    {
      //dimension= 2 * (int)BioGas.n_gases;

      // TODO
      // _type= ?
      _type = 99;
    }

    /// <summary>
    /// Constructor called by the constructor of biogas.sensors while 
    /// reading the sensors out of a XML file. So reader must be at the correct position, 
    /// which is &lt;sensor&gt; was just read. 
    /// </summary>
    /// <param name="reader"></param>
    /// <param name="id">id of sensor</param>
    public biogas_sensor(ref XmlTextReader reader, string id) :
      base(ref reader, id, 2 * (int)BioGas.n_gases)
    {
      //dimension= 2 * (int)BioGas.n_gases;

      // TODO
      // _type= ?
      _type = 99;
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
    static public string _spec = "biogas";



    /// <summary>
    /// Get current value of measured variable with the id: param
    /// </summary>
    /// <param name="param">
    /// id of the variable, the correct values of the
    /// ids are defined inside this function
    /// ids are: H2_%, CH4_%, CO2_%, and biogas_m3_d
    /// </param>
    /// <param name="value">current measurement value of given param</param>
    /// <exception cref="exception">Unknown param</exception>
    public void getCurrentMeasurement(string param, out double value)
    {
      getCurrentMeasurement(param, false, out value);
    }
    /// <summary>
    /// Get current value of measured variable with the id: param
    /// </summary>
    /// <param name="param">
    /// id of the variable, the correct values of the
    /// ids are defined inside this function
    /// ids are: H2_%, CH4_%, CO2_%, and biogas_m3_d
    /// </param>
    /// <param name="value">current measurement value of given param</param>
    /// <param name="noisy">if true, then noisy measurement values are returned. 
    /// they are only noisy if the parameter apply_real_sensor was true before and during
    /// the simulation</param>
    /// <exception cref="exception">Unknown param</exception>
    public void getCurrentMeasurement(string param, bool noisy, out double value)
    {
      value = getCurrentMeasurement(param, noisy).Value;
    }

    /// <summary>
    /// Get current value of measured variable with the id: param
    /// </summary>
    /// <param name="param">id of the variable, the correct values of the
    /// ids are defined inside this function
    /// ids are: H2_%, CH4_%, CO2_%, and biogas_m3_d</param>
    /// <param name="noisy">if true, then noisy measurement values are returned. 
    /// they are only noisy if the parameter apply_real_sensor was true before and during
    /// the simulation</param>
    /// <returns>current measurement value of given param</returns>
    /// <exception cref="exception">Unknown param</exception>
    override public physValue getCurrentMeasurement(string param, bool noisy)
    {
      physValue myValue;

      physValue[] values= getCurrentMeasurementVector(noisy);

      switch (param)
      { 
        // TODO : überarbeiten!!!
        case "H2_%":
          myValue= values[(int)BioGas.n_gases + BioGas.pos_h2  - 1];
          break;
        case "CH4_%":
          myValue= values[(int)BioGas.n_gases + BioGas.pos_ch4 - 1];
          break;
        case "CO2_%":
          myValue= values[(int)BioGas.n_gases + BioGas.pos_co2 - 1];
          break;

        case "biogas_m3_d":
          myValue= values[0];

          for (int igas= 0; igas < (int)BioGas.n_gases; igas++)
          {
            myValue= myValue + values[igas];
          }

          myValue.Symbol= "biogas";
          
          break;

        default:
          throw new exception(String.Format("biogas_sensor: Unknown param: {0}!", param));
      }
      
      return myValue;
    }


    /// <summary>
    /// Get values of measured variable with the id: param
    /// </summary>
    /// <param name="param">id of the variable, the correct values of the
    /// ids are defined inside this function
    /// ids are: H2_%, CH4_%, CO2_%, and biogas_m3_d</param>
    /// <param name="noisy">if true, then noisy measurement values are returned. 
    /// they are only noisy if the parameter apply_real_sensor was true before and during
    /// the simulation</param>
    /// <returns>measured values over time for given param</returns>
    /// <exception cref="exception">Unknown param</exception>
    override public physValue[] getMeasurementStream(string param, bool noisy)
    {

      switch (param)
      {
        // TODO : überarbeiten!!!
        case "H2_%":
          return getMeasurementStream((int)BioGas.n_gases + BioGas.pos_h2  - 1, noisy);
        case "CH4_%":
          return getMeasurementStream((int)BioGas.n_gases + BioGas.pos_ch4 - 1, noisy);
        case "CO2_%":
          return getMeasurementStream((int)BioGas.n_gases + BioGas.pos_co2 - 1, noisy);
        
        case "biogas_m3_d":
          physValue[] data = getMeasurementStream(0, noisy);

          for (int igas= 0; igas < (int)BioGas.n_gases; igas++)
          {
            for (int idata= 0; idata < data.Length; idata++)
              data[idata] += getMeasurementStream(igas, noisy)[idata];
          }

          return data;

        default:
          throw new exception(String.Format("biogas_sensor: Unknown param: {0}!", param));
      }

    }


    // diese überladung dürfte nicht benötigt werden, da in sensor dies überladung existiert
    // ruft die methode unten für noisy= false auf
    ///// <summary>
    ///// Get value at time t of measured variable with the id: param
    ///// </summary>
    ///// <param name="param">id of the variable, the correct values of the
    ///// ids are defined inside this function
    ///// ids are: H2_%, CH4_%, CO2_%, and biogas_m3_d</param>
    ///// <param name="t">some simulation time [days]</param>
    ///// <returns>measured values at time t for given param</returns>
    ///// <exception cref="exception">Unknown param</exception>
    //override public physValue getMeasurementAt(string param, double t)
    //{
    //  return getMeasurementAt(param, t, false);
    //}
    /// <summary>
    /// Get value at time t of measured variable with the id: param
    /// </summary>
    /// <param name="param">id of the variable, the correct values of the
    /// ids are defined inside this function
    /// ids are: H2_%, CH4_%, CO2_%, and biogas_m3_d</param>
    /// <param name="t">some simulation time [days]</param>
    /// <param name="noisy">if true, then noisy measurement values are returned. 
    /// they are only noisy if the parameter apply_real_sensor was true before and during
    /// the simulation</param>
    /// <returns>measured values at time t for given param</returns>
    /// <exception cref="exception">Unknown param</exception>
    override public physValue getMeasurementAt(string param, double t, bool noisy)
    {

      switch (param)
      {
        // TODO : überarbeiten!!!
        case "H2_%":
          return getMeasurementAt((int)BioGas.n_gases + BioGas.pos_h2  - 1, t, noisy);
        case "CH4_%":
          return getMeasurementAt((int)BioGas.n_gases + BioGas.pos_ch4 - 1, t, noisy);
        case "CO2_%":
          return getMeasurementAt((int)BioGas.n_gases + BioGas.pos_co2 - 1, t, noisy);

        case "biogas_m3_d":
          physValue[] values = getMeasurementVectorAt(t, noisy);

          physValue myValue= values[0];

          for (int igas= 0; igas < (int)BioGas.n_gases; igas++)
          {
            myValue= myValue + values[igas];
          }

          myValue.Symbol= "biogas";

          return myValue;

        default:
          throw new exception(String.Format("biogas_sensor: Unknown param: {0}!", param));
      }

    }



    // -------------------------------------------------------------------------------------
    //                            !!! PROTECTED METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// here it is defined what is measured in the sensor and in which position
    /// 
    /// not type 0
    /// </summary>
    /// <param name="u">biogas stream: dimension: BioGas.n_gases</param>
    /// <param name="par">not used</param>
    /// <returns>
    /// measured biogas values
    /// first n_gases values are biogas in m^3/d
    /// next n_gases values are biogas concentrations in %
    /// </returns>
    /// <exception cref="exception">u.Length &lt; _n_gases</exception>
    /// <exception cref="exception">u is empty</exception>
    override protected physValue[] doMeasurement(double[] u, params double[] par)
    { 
      physValue[] QgasP= new physValue[(int)BioGas.n_gases];

      // is already checked for in calcPercentualBiogasComposition
      //if (u.Length != (int)BioGas.n_gases)
      //  throw new exception(String.Format(
      //          "u is not of correct dimension: {0} != {1}!", 
      //          u.Length, (int)BioGas.n_gases)); 

      BioGas.calcPercentualBiogasComposition(u, out QgasP);

      physValue[] values= new physValue[dimension];

      for (int ivalue= 0; ivalue < values.Length; ivalue++)
      {
        if (ivalue < (int)BioGas.n_gases)
        {
          values[ivalue]= new physValue(BioGas.symGases[ivalue], u[ivalue], "m^3/d", 
                                        BioGas.labelGases[ivalue]);
        }
        else
          values[ivalue]= QgasP[ivalue - (int)BioGas.n_gases];
      }

      return values;
    }



  }
}


