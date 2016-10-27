/**
 * This file is part of the partial class sensor_config and contains
 * the rest of the class, which is not located in separate files.
 * 
 * TODOs:
 * - 
 * 
 * Apart from that FINISHED!
 * 
 */

using System;
using toolbox;
using science;
using System.Text;
using System.Collections;
using System.Xml;

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
  /// <remarks>
  /// special class for real measurements. defines how a physValue by a sensor is measured with noise
  /// drift, calibration, etc.
  /// </remarks>
  public partial class sensor_config
  {

    // -------------------------------------------------------------------------------------
    //                              !!! PUBLIC METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// reset integrals to 0 and set is_in_calib to false
    /// </summary>
    public void reset()
    {
      // also set to 0, when time == 0, in addMeasurement
      int_memory = 0;     // set integrals of real sensor to 0
      int_drift = 0;
      is_in_calib = false;
    }



    // -------------------------------------------------------------------------------------
    //                              !!! GET METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// Returns the params of the object as XML string, such that it can be saved
    /// in a XML file
    /// </summary>
    /// <returns>a string with xml tags for physValue</returns>
    virtual public string getParamsAsXMLString() // const
    {
      StringBuilder sb= new StringBuilder();

      sb.Append(String.Format("<sensor_config index= \"{0}\">\n", index));

      sb.Append(xmlInterface.setXMLTag("apply_real_sensor", apply_real_sensor));
      sb.Append(xmlInterface.setXMLTag("noise_level", noise_level));
      sb.Append(xmlInterface.setXMLTag("y_min", y_min));
      sb.Append(xmlInterface.setXMLTag("y_max", y_max));
      sb.Append(xmlInterface.setXMLTag("drift", drift));
      sb.Append(xmlInterface.setXMLTag("dT_calib", dT_calib));
      sb.Append(xmlInterface.setXMLTag("t_calib", t_calib));

      sb.Append("</sensor_config>\n");

      return sb.ToString();
    }

    /// <summary>
    /// Read params using the given XML reader, which is reading a xml file.
    /// Reads one sensor, stops at end element of sensor.
    /// </summary>
    /// <param name="reader"></param>
    /// <param name="index">index of measurement in sensor: 0,1, ...</param>
    public virtual void getParamsFromXMLReader(ref XmlTextReader reader, int index)
    {
      string xml_tag = "";
      string param = "";

      this.index = index;

      bool do_while = true;

      while (reader.Read() && do_while)
      {
        switch (reader.NodeType)
        {
          case System.Xml.XmlNodeType.Element: // this knot is an element
            xml_tag = reader.Name;

            while (reader.MoveToNextAttribute())
            { // read the attributes, here only the attribute of digester
              // is of interest, all other attributes are ignored, 
              // actually there usally are no other attributes
              if (xml_tag == "physValue" && reader.Name == "symbol")
              {
                // found a new parameter
                param = reader.Value;

                //switch (param)
                //{
                //  case "h_lift":
                //    _h_lift.getParamsFromXMLReader(ref reader, param);
                //    break;
                //}

                break;
              }
            }

            break;

          case System.Xml.XmlNodeType.Text: // text, thus value, of each element

            switch (xml_tag)
            {
              case "apply_real_sensor":
                _apply_real_sensor = System.Xml.XmlConvert.ToBoolean(reader.Value);
                break;
              case "noise_level":
                noise_level = System.Xml.XmlConvert.ToDouble(reader.Value);
                break;
              case "y_min":
                y_min = System.Xml.XmlConvert.ToDouble(reader.Value);
                break;
              case "y_max":
                y_max = System.Xml.XmlConvert.ToDouble(reader.Value);
                break;
              case "drift":
                drift = System.Xml.XmlConvert.ToDouble(reader.Value);
                break;
              case "dT_calib":
                dT_calib = System.Xml.XmlConvert.ToDouble(reader.Value);
                break;
              case "t_calib":
                t_calib = System.Xml.XmlConvert.ToDouble(reader.Value);
                break;
            }

            break;

          case System.Xml.XmlNodeType.EndElement:
            if (reader.Name == "sensor_config")
              do_while = false;

            break;
        }
      }

    }

    /// <summary>
    /// Print
    /// </summary>
    /// <returns></returns>
    public string print() // const
    {
      StringBuilder sb = new StringBuilder();

      sb.Append("  index= " + index + "\t\t");
      sb.Append("apply_real_sensor= " + apply_real_sensor.ToString() + "\t\t");
      sb.Append("noise_level= " + noise_level.ToString("0.000") + " [100 %]\n");
      sb.Append("  y_min= " + y_min.ToString("0.0") + " [unit]\t\t");
      sb.Append("y_max= " + y_max.ToString("0.0") + " [unit]\t\t");
      sb.Append("drift= " + drift.ToString("0.0") + " [unit/d]\n");
      sb.Append("  dT_calib= " + dT_calib.ToString("0.0") + " [d]\t\t");
      sb.Append("t_calib= " + t_calib.ToString("0.0") + " [min]\r\n");

      return sb.ToString();
    }
    

    
    /// <summary>
    /// 
    /// </summary>
    /// <param name="t">current simulation time in days</param>
    /// <param name="last_t">time of last recorded measurement [days]</param>
    /// <param name="value"></param>
    /// <param name="last_signals"></param>
    /// <param name="myConfigs">real sensor configurations for measurements in sensor</param>
    /// <returns></returns>
    public static physValue[] getNoisyMeasurement(double t, double last_t,
      physValue[] value, physValue[] last_signals, sensor_config[] myConfigs)
    {
      if (value.Length != myConfigs.Length)
      {
        // ist der Fall für den fitness_sensor, dort dimension variabel
        //throw new exception(String.Format("value.Length != myConfigs.Length: {0} != {1}", 
        //  value.Length, myConfigs.Length));

        return value;
      }

      physValue[] value_noisy = new physValue[value.Length];

      // add noise and drift to each value in the array
      for (int isignal = 0; isignal < value.Length; isignal++)
      {
        sensor_config myConfig= myConfigs[isignal];

        // besetze mit nicht verauschten Werten
        value_noisy[isignal] = new physValue(value[isignal]);   // default Werte

        if (t <= 1)     // set integrals to 0
        {
          // setzt int_drift= 0, int_memory= 0 und is_in_calib= false  
          myConfig.reset();
        }

        if (myConfig.apply_real_sensor && t >= 1)    // add noise and drift
        {
          double signal = value[isignal].Value;

          double last_signal = signal;

          if (last_signals.Length > 0)
            last_signal = last_signals[isignal].Value;

          // add noise and drift to value
          double sensor_signal = myConfig.generate_sensor_signal(signal, last_signal, t, last_t);
          
          value_noisy[isignal].Value = sensor_signal;
        }
      }

      return value_noisy;
    }
    


    /// <summary>
    /// add noise and drift to signal
    /// 
    /// Vorlage: Rieger, Alex: Progress in sensor technology, WST, 2003
    /// </summary>
    /// <param name="signal">current raw measurement value</param>
    /// <param name="last_signal">
    /// measurement value of last time, needed to approximate derivation</param>
    /// <param name="t">current simulation time [days]</param>
    /// <param name="last_t">simulation time of last measurement [days]</param>
    /// <returns>signal added with noise and drift</returns>
    private double generate_sensor_signal(double signal, double last_signal,
      double t, double last_t)
    {
      // delta t for approximation of derivation [days]
      double delta_t = t - last_t;

      double udot = 0;
      double udotdot = 0;

      // derivation of raw sensor signal [unit/day]
      if (delta_t > 0)
        udot = (signal - last_signal) / delta_t;

      // 2nd derivation of raw sensor signal [unit/day^2]
      // für bessere Approximationen siehe methode der finiten differenzen
      // aber dann nicht kausal
      if (delta_t > 0)
        udotdot = (signal - last_signal) / (delta_t * delta_t);

      // filtered signal, 2nd order law pass [unit]
      double y = signal + 2 * T_fil / 60 / 24 * udot +
                          T_fil / 60 / 24 * T_fil / 60 / 24 * udotdot;

      // generate noise [unit], es ist sinnvoll deterministischen noise zu nutzen
      // für wiederholbarkeit von experimenten, deshalb auslesen eines arrays hier
      //
      // http://docs.nuget.org/docs/start-here/using-the-package-manager-console
      // http://numerics.mathdotnet.com/api/MathNet.Numerics.Distributions/index.htm
      // http://stackoverflow.com/questions/218060/random-gaussian-variables
      //
      // a new noise level twice a day, when dividing by 2
      double noise_val = noise_arr[((int)Math.Floor(t / 2)) % noise_arr.Length];

      double noise = noise_val * y_max * noise_level;

      // add noise to signal
      y += noise;

      // bound signal by measurement range
      y = Math.Min(Math.Max(y, y_min), y_max);

      // calculate drift

      // integrate drift signal, means multiplying with delta_t
      int_drift += drift * delta_t;   // drift integral

      // round towards infinity
      int Nt_calib = (int)Math.Ceiling(t / dT_calib);
      bool was_in_calib = is_in_calib;  // speichere aktuellen Zustand

      // zeitpunkt, wenn sensor gerade kalibriert wird
      // glaube, dass diese Detektion nicht funktioniert
      // wenn die simulation schnell abläuft, werden kalibrierungszeträume
      // einfach übersprungen, deshalb unten überprüfung über Nt_last_calib ergänzt
      if ((Nt_calib * dT_calib - t_calib / 60 / 24 <= t) && (t < dT_calib * Nt_calib))
        is_in_calib = true;
      else
        is_in_calib = false;

      int Nt_last_calib = (int)Math.Ceiling(last_t / dT_calib);

      // fallende Flanke, oder zeitraum zwischen letzter und dieser Messung
      // ist größer als wie kalibrierungszeitraum
      // abfrage ist etwas anders: Nt ist der zähler der kalibrierungspakete
      // wenn ich jetzt in einem andere paket (zeitabschnitt) bin wie
      // letztes mal, dann muss eine kalibrierung dazwischen gewesen sein
      if ((was_in_calib && !is_in_calib) || (Nt_calib > Nt_last_calib))   // fallende Flanke
        int_drift = 0;

      //

      // summe
      // unit - unit
      y += int_drift - int_memory;

      // switch
      if (is_in_calib)
        y = 0;

      // vermutlich müsste ich hier mit delta_t multiplizieren
      // dann müsste ich oben unter y += auch noch mal durch delta_t teilen
      // evtl. macht das der Simulink Block hinter der summe
      // in Rieger et al. 2003
      int_memory += y;    // TODO weiß nicht wie die reihenfolge hier sein soll?

      return int_memory;
    }



  }
}


