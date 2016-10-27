/**
 * This file defines the class sensor_array.
 * 
 * TODOs:
 * - only Q sensors are possible for sensor_arrays
 * 
 * Should be FINISHED!
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
 * - Sensors
 * 
 */
namespace biogas
{
  /// <summary>
  /// an array of sensors
  /// </summary>
  public partial class sensor_array : List<biogas.sensor>
  {

    // -------------------------------------------------------------------------------------
    //                              !!! CONSTRUCTOR METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// Creates an empty sensor array with the given id
    /// </summary>
    /// <param name="id"></param>
    public sensor_array(string id)
    {
      _id= id;
    }



    // -------------------------------------------------------------------------------------
    //                            !!! PUBLIC METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// Adds the given sensor to the sensor array
    /// </summary>
    /// <param name="mySensor"></param>
    public void addSensor(sensor mySensor)
    {
      this.Add( mySensor );
    }



    /// <summary>
    /// Read params from reader which reads a xml file.
    /// reads until end elements of sensor_array, adds all read sensors to list
    /// </summary>
    /// <param name="reader"></param>
    public void getParamsFromXMLReader(ref XmlTextReader reader)
    {
      string xml_tag = "";
      string sensor_id = "";

      bool do_while = true;

      while (reader.Read() && do_while)
      {
        switch (reader.NodeType)
        {

          case System.Xml.XmlNodeType.Element: // this knot is an element
            xml_tag = reader.Name;

            while (reader.MoveToNextAttribute())
            { // read the attributes, here only the attribute of chp
              // is of interest, all other attributes are ignored, 
              // actually there usally are no other attributes
              if (xml_tag == "sensor" && reader.Name == "id")
              {
                // found a new sensor
                sensor_id = reader.Value;
              }
              else if (xml_tag == "sensor" && reader.Name == "spec")
              {
                string spec = reader.Value;

                // hier habe ich sensor_id und spec, rufe methode auf
                // welche aus spec den richtigen constructor aufruft, übergeb
                // reader und sensor_id
                //select_sensor_constructor(ref reader, sensor_id, spec);

                if (spec != "Q")
                { // aktuell darf das nur ein Q durchfluss sensor sein
                  // TODO - throw error
                  throw new exception("Only Q is implemented!");
                }

                addSensor(new biogas.Q_sensor(ref reader, sensor_id));
              }
            }

            break;

          case System.Xml.XmlNodeType.EndElement:
            if (reader.Name == "sensor_array")
              do_while = false;

            break;
        }
      }

    }

    /// <summary>
    /// Return the params of all sensors in sensor_array as a xml string
    /// </summary>
    /// <returns></returns>
    public string getParamsAsXMLString()
    {
      StringBuilder sb = new StringBuilder();

      sb.Append(String.Format("<sensor_array id= \"{0}\">\n", id));

      // for each sensor in sensor array
      foreach (sensor mySensor in this)
      {
        sb.Append(mySensor.getParamsAsXMLString());
      }

      sb.Append("</sensor_array>\n");
            
      return sb.ToString();
    }



    /// <summary>
    /// Returns the sensor object with the given id
    /// </summary>
    /// <param name="id">id of sensor</param>
    /// <returns></returns>
    /// <exception cref="exception">Unknown sensor id</exception>
    public sensor get(string id)
    {
      foreach (sensor mySensor in this)
      {
        if (mySensor.id == id)
          return mySensor;
      }

      throw new exception(String.Format(
        "Cannot find the sensor (id: {0}) in the array list!", id));
    }

    /// <summary>
    /// returns ids of the sensors in the array as string array
    /// </summary>
    /// <returns></returns>
    public string[] getIDs()
    {
      List<string> ids= new List<string>();

      foreach (sensor mySensor in this)
      {
        ids.Add(mySensor.id_suffix);
      }

      return ids.ToArray();
    }

    /// <summary>
    /// tests if given id is inside the array
    /// </summary>
    /// <param name="id">sensor id</param>
    /// <returns>true if id is in sensor_array, else false</returns>
    public bool exist(string id)
    {
      foreach (sensor mySensor in this)
      {
        if (mySensor.id == id)
          return true;
      }

      return false;
    }



    /// <summary>
    /// Returns mean or sum of measurements at a given time t for the sensor array
    /// only for substrates, pumps are in the same sensor_array Q, do not include them
    /// </summary>
    /// <param name="mySubstrates">list of substrates that are included in the sum, mean</param>
    /// <param name="s_operator">operator: mean, sum</param>
    /// <param name="t">simulation time in days</param>
    /// <param name="index">index inside sensor: 0, 1, 2, ...</param>
    /// <param name="noisy">if true, then noisy measurement values are returned. 
    /// they are only noisy if the parameter apply_real_sensor was true before and during
    /// the simulation</param>
    /// <returns></returns>
    /// <exception cref="exception">Invalid index</exception>
    public double getMeasurementDAt(substrates mySubstrates, string s_operator, double t, 
                                    int index, bool noisy)
    {
      List<double> data= new List<double>();
      
      foreach (sensor mySensor in this)
      {
        if (mySubstrates.ids.Contains(mySensor.id_suffix))
          data.Add( mySensor.getMeasurementDAt(index, t, noisy) );
      }

      if (s_operator == "sum")
        return math.sum(data);
      else if (s_operator == "mean")
        return math.mean(data);
      else
        // TODO - throw error
        return 0;
    }



    // -------------------------------------------------------------------------------------
    //                            !!! PROTECTED METHODS !!!
    // -------------------------------------------------------------------------------------

    



  }

}


