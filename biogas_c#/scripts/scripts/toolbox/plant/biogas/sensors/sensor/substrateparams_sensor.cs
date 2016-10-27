/**
 * This file defines the class substrateparams_sensor.
 * 
 * TODOs:
 * - set_substrate_params_from_sensor muss noch stark verbessert werden
 * 
 * Not yet FINISHED!
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
  /// Sensor measuring the substrateparams, which are probes taken from the substrate feed.
  /// </summary>
  public class substrateparams_sensor : biogas.sensor
  {

    // -------------------------------------------------------------------------------------
    //                              !!! CONSTRUCTOR METHODS !!!
    // -------------------------------------------------------------------------------------
    
    /// <summary>
    /// Standard Constructor creating the sensor. Its id is substrateparams.
    /// id_suffix is here the substrate ID for which the substrateparams are measured
    /// </summary>
    /// <param name="id_suffix"></param>
    public substrateparams_sensor(string id_suffix) :
      base( String.Format("{0}_{1}", _spec, id_suffix),
            String.Format("substrateparams sensor {0}", id_suffix), id_suffix, 10)
    {
      //dimension= 10;

      // TODO
      // type= ?
      _type = 88;
    }

    /// <summary>
    /// Constructor called by the constructor of biogas.sensors while 
    /// reading the sensors out of a XML file. So reader must be at the correct position, 
    /// which is &lt;sensor&gt; was just read. 
    /// </summary>
    /// <param name="reader"></param>
    /// <param name="id">id of sensor</param>
    public substrateparams_sensor(ref XmlTextReader reader, string id) : 
      base(ref reader, id, 10)
    {
      //dimension = 10;

      // TODO
      // type= ?
      _type = 88;
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
    static public string _spec = "substrateparams";



    /// <summary>
    /// Get value at time t of measured variable with the id: param
    /// </summary>
    /// <param name="param">id of the variable, the correct values of the
    /// ids are defined inside this function
    /// ids are: 
    /// TS_%FM
    /// VS_%TS
    /// pH
    /// VFA_gl
    /// TAC_gl
    /// NH4N_gl
    /// RL_%TS
    /// RP_%TS
    /// RF_%TS
    /// COD_gl
    /// </param>
    /// <param name="t">simulation time in days</param>
    /// <returns></returns>
    override public physValue getMeasurementAt(string param, double t)
    {

      switch (param)
      {
        case "TS_%FM":
          return getMeasurementAt(0, t);
        case "VS_%TS":
          return getMeasurementAt(1, t);
        case "pH":
          return getMeasurementAt(2, t);
        case "VFA_gl":
          return getMeasurementAt(3, t);
        case "TAC_gl":
          return getMeasurementAt(4, t);
        case "NH4N_gl":
          return getMeasurementAt(5, t);
        case "RL_%TS":
          return getMeasurementAt(6, t);
        case "RP_%TS":
          return getMeasurementAt(7, t);
        case "RF_%TS":
          return getMeasurementAt(8, t);
        case "COD_gl":
          return getMeasurementAt(9, t);
        
        default:
          throw new exception(
                String.Format("substrateparams_sensor: Unknown param: {0}!", param));
      }

    }



    /// <summary>
    /// write measured variable at time t in given mySubstrate 
    /// (mySubstrates.get(substrate_id))
    /// </summary>
    /// <param name="t">current simulation time</param>
    /// <param name="mySensors"></param>
    /// <param name="mySubstrates">changed in this call</param>
    /// <param name="substrate_id">ID of substrate to be set</param>
    public static void set_substrate_params_from_sensor(double t, biogas.sensors mySensors,
                biogas.substrates mySubstrates, string substrate_id)
    {
      biogas.substrate mySubstrate = mySubstrates.get(substrate_id);

      set_substrate_params_from_sensor(t, mySensors, mySubstrate);
    }

    /// <summary>
    /// TODO - die ganze funktion ist noch nicht ausgegoren
    /// 
    /// write measured variable at time t in given mySubstrate
    /// 
    /// </summary>
    /// <param name="t">current simulation time</param>
    /// <param name="mySensors"></param>
    /// <param name="mySubstrate">changed in this call</param>
    public static void set_substrate_params_from_sensor(double t, biogas.sensors mySensors,
                       biogas.substrate mySubstrate)
    {
      string substrate_id = mySubstrate.id;

      substrateparams_sensor substrate_param_sensor = 
        (substrateparams_sensor)mySensors.get("substrateparams_" + substrate_id);

      if (!substrate_param_sensor.isEmpty())
      {
        physValue[] measVec= substrate_param_sensor.getMeasurementVectorAt(t);

        // hier werden nur TS und VS geändert
        mySubstrate.set_params_of("TS",  measVec[0], 
          // umrechung in % TS wird in c# bib gemacht (substrateparams_sensor)
          // s.unten in doMeasurement methode
          // this value measVec[1] is measured in % TS, this OK
                                  "VS",  measVec[1], 
                                  "pH",  measVec[2]//, 
                                  /*"Sac", measVec[3],
          // umrechnung von g/l in mmol/l
          // g/l / 50 g/mol * 1000 m = 1000 / 50 mmol/l
          // TODO convertTo nutzen
                                  "TAC", measVec[4] * 1000 / 50, */
                                  /*"Snh4", measVec[5]*/);
                                //'COD', measVec.Get(6));

        //mySubstrate.calc

        //if (mySubstrate.ismanure)
        //{
        //  mySubstrate.set_params_of("RF", measVec[6]);
          
        //  // TODO outcomment
        //  // measured in gCOD/l
        //  //mySubstrate.set_params_of("COD", measVec[7]);
        //  //mySubstrate.set_params_of("COD_S", 0.3 * measVec[7].Value);    
        //}
        //else
        //{
        //  // TODO - delete
        //  //if (substrate_id == "bullmanure")
        //  //  throw new exception("AAAAAAAAAAAA");

        //  mySubstrate.set_params_of("RL", measVec[6], "RP", measVec[7], 
        //                            "RF", measVec[8]);
                                                    
        //  // measured in kgCOD/m^3, same as gCOD/l
        //  //physValue COD_c= biogas.substrate.calcXc(mySubstrate);//.convertUnit("gCOD/l");

        //  //// TODO 
        //  //// 0.3

        //  //double COD_c2 = 0;

        //  //// TODO delete
        //  //if (substrate_id == "maize")    // für geiger kalibrierung
        //  //  COD_c2= COD_c.Value * 1.1;//5;
        //  //else
        //  //  COD_c2= COD_c.Value;
          
        //  //mySubstrate.set_params_of("COD", COD_c2);
        //  //mySubstrate.set_params_of("COD_S", 0.3 * COD_c2);                                            
           
        //}
        
      }

    }



    // -------------------------------------------------------------------------------------
    //                            !!! PROTECTED METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// save given x in sensor
    /// </summary>
    /// <param name="x">
    /// vector with the measurements of the 10 variables:
    /// TS [% FM]
    /// VS [% FM] (in sensor saved as [% TS])
    /// pH
    /// VFA [gHaceq/l]
    /// TAC [gCaCO3/l]
    /// NH4-N [g/l]
    /// RL [% TS]
    /// RP [% TS]
    /// RF [% TS]
    /// COD [gCOD/l]
    /// </param>
    /// <param name="par">not used</param>
    /// <returns>10 dim vector of substrate params</returns>
    override protected physValue[] doMeasurement(double[] x, params double[] par)
    { 
      physValue[] values= new physValue[dimension];

      if (x.Length != dimension)
      {
        throw new exception(String.Format(
                "x has not the correct dimension! is: {0}, must be: {1}!",
                x.Length, dimension));
      }

      values[0]= new physValue("TS",    x[0], "% FM");
      values[1]= new physValue("VS",    x[1]/x[0] * 100, "% TS");
      values[2]= new physValue("pH" ,   x[2], "-");
      values[3]= new physValue("VFA",   x[3], "gHAceq/l");
      values[4]= new physValue("TAC",   x[4], "gCaCO3/l");
      values[5]= new physValue("NH4-N", x[5], "g/l");
      values[6]= new physValue("RL",    x[6], "% TS");
      values[7]= new physValue("RP",    x[7], "% TS");
      values[8]= new physValue("RF",    x[8], "% TS");
      values[9]= new physValue("COD",   x[9], "gCOD/l");
      
      return values;
    }



  }
}


