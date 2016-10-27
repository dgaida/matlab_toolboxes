/**
 * This file is part of the partial class substrate and defines
 * all other methods.
 * 
 * TODOs:
 * - sensor sollte man zu digester, storage_tank und substrate source packen
 * und diese dann auch in xml datei speichern, mit parametern wie sensor drift,
 * messbereich etc., wird teilweise gemacht, allerdings eine separate xml datei
 * - 
 * 
 * Except for that FINISHED!
 * 
 */

using System;
using System.Collections.Generic;
using System.Text;
using science;
using toolbox;
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
  /// <summary>
  /// abstract class defining a sensor
  /// 
  /// A sensor can measure one or more physValues over time. To identify a 
  /// sensor it has an id and a id_suffix which indicates the location of the
  /// sensor. To measure a value use one of the measure methods. To get 
  /// a measured value at a given time use one of the getMeasurement methods. 
  /// </summary>
  public abstract partial class sensor
  {

    // -------------------------------------------------------------------------------------
    //                              !!! CONSTRUCTOR METHODS !!!
    // -------------------------------------------------------------------------------------
    
    /// <summary>
    /// Creates a sensor with an id, an id_suffix and a name
    /// </summary>
    /// <param name="id">
    /// identical identifier (id) of the sensor
    /// e.g.: HRT, Snh3, Snh4, ...
    /// </param>
    /// <param name="name">arbitrary descriptive name of the sensor</param>
    /// <param name="id_suffix">
    /// id_suffix of the sensor, usually the id of the digester 
    /// where the sensor is located, additionally in and out if necessary
    /// could also be: substratemix or storagetank
    /// </param>
    public sensor(string id, string name, string id_suffix) : this(id, name, id_suffix, 1)
    {}

    /// <summary>
    /// Creates a sensor with an id, an id_suffix and a name
    /// </summary>
    /// <param name="id">
    /// identical identifier (id) of the sensor
    /// e.g.: HRT, Snh3, Snh4, ...
    /// </param>
    /// <param name="name">arbitrary descriptive name of the sensor</param>
    /// <param name="id_suffix">
    /// id_suffix of the sensor, usually the id of the digester 
    /// where the sensor is located, additionally in and out if necessary
    /// could also be: substratemix or storagetank
    /// </param>
    /// <param name="dimension">dimension of the sensor, default= 1</param>
    public sensor(string id, string name, string id_suffix, int dimension)
    {
      _id = id;
      _name = name;
      _id_suffix = id_suffix;
      _dimension = dimension;

      // create configs
      myConfigs= new sensor_config[_dimension];

      for (int iel = 0; iel < myConfigs.Length; iel++)
        myConfigs[iel] = new sensor_config(iel);
    }

    /// <summary>
    /// Constructor called by the constructor of biogas.sensors while 
    /// reading the sensors out of a XML file. So reader must be at the correct position, 
    /// which is &lt;sensor&gt; was just read. 
    /// </summary>
    /// <param name="reader"></param>
    /// <param name="id">
    /// id of sensor
    /// </param>
    /// <param name="dimension">dimension of the sensor, default= 1</param>
    public sensor(ref XmlTextReader reader, string id, int dimension)
    {
      _id = id;
      _dimension = dimension;

      getParamsFromXMLReader(ref reader);
    }

    /// <summary>
    /// Constructor called by the constructor of biogas.sensors while 
    /// reading the sensors out of a XML file. So reader must be at the correct position, 
    /// which is &lt;sensor&gt; was just read. 
    /// </summary>
    /// <param name="reader"></param>
    /// <param name="id">
    /// id of sensor
    /// </param>
    public sensor(ref XmlTextReader reader, string id) : this(ref reader, id, 1)
    {}

    /// <summary>
    /// Constructor used to read sensor out of a XML file
    /// </summary>
    /// <param name="XMLfile">xml file</param>
    public sensor(string XMLfile)
    {
      XmlTextReader reader = new System.Xml.XmlTextReader(XMLfile);

      getParamsFromXMLReader(ref reader);

      reader.Close();
    }



    // -------------------------------------------------------------------------------------
    //                            !!! PUBLIC METHODS !!!
    // -------------------------------------------------------------------------------------

    // -------------------------------------------------------------------------------------
    //                              !!! GET METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// Read params using the given XML reader, which is reading a xml file.
    /// Reads one sensor, stops at end element of sensor.
    /// </summary>
    /// <param name="reader"></param>
    public virtual void getParamsFromXMLReader(ref XmlTextReader reader)
    {
      string xml_tag = "";
      int sensor_index = 0;

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
              if (xml_tag == "sensor_config" && reader.Name == "index")
              {
                // found a new sensor_config
                sensor_index = System.Xml.XmlConvert.ToInt32(reader.Value);

                if (sensor_index != -1)
                {
                  myConfigs[sensor_index] = new sensor_config(sensor_index);

                  myConfigs[sensor_index].getParamsFromXMLReader(ref reader, sensor_index);
                }
                else // zeichen dafür, dass alle Configs identisch sind, und es nur
                  // eine config für alle dimensionen gibt, gut für hochdimensionalen
                  // sensor wie ADMparams sensor
                {
                  myConfigs[0] = new sensor_config(0);

                  myConfigs[0].getParamsFromXMLReader(ref reader, 0);

                  for (int iindex = 1; iindex < dimension; iindex++)
                  {
                    myConfigs[iindex] = new sensor_config(myConfigs[0], iindex);
                  }
                }
              }
            }

            break;

          case System.Xml.XmlNodeType.Text: // text, thus value, of each element

            switch (xml_tag)
            {
              case "id_suffix":
                _id_suffix = reader.Value;
                break;
              case "name":
                _name = reader.Value;
                break;
              case "dimension":
                _dimension = System.Xml.XmlConvert.ToInt32(reader.Value);

                myConfigs= new sensor_config[dimension];

                break;              
            }

            break;

          case System.Xml.XmlNodeType.EndElement:
            if (reader.Name == "sensor")
              do_while = false;

            break;
        }
      }

    }

    /// <summary>
    /// Get params as an xml string, such that they can be written inside 
    /// a xml file.
    /// </summary>
    /// <returns></returns>
    public virtual string getParamsAsXMLString()
    {
      StringBuilder sb = new StringBuilder();

      sb.Append(String.Format("<sensor id= \"{0}\" spec= \"{1}\">\n", id, spec));

      // ist id von chp, digester, ...
      sb.Append(xmlInterface.setXMLTag("id_suffix", id_suffix));
      sb.Append(xmlInterface.setXMLTag("name", name));
      sb.Append(xmlInterface.setXMLTag("dimension", dimension));

      for (int iel = 0; iel < myConfigs.Length; iel++ )
        sb.Append(myConfigs[iel].getParamsAsXMLString());
      
      sb.Append("</sensor>\n");

      return sb.ToString();
    }

    /// <summary>
    /// Print the params of the sensor to a string, to be displayed on a console
    /// </summary>
    /// <returns></returns>
    public virtual string print()
    {
      StringBuilder sb = new StringBuilder();

      sb.Append("   ----------   Sensor   " + name + "   ----------   \r\n");
      // id_suffix steckt schon in id drin, deshalb hier nicht explizit noch mal 
      // anzuzeigen
      // id evtl. direkt in überschrift anzeigen, wie habe ich ddas bei chp gemacht?
      sb.Append("id: " + id + "\r\n");
      //sb.Append("name: " + name + "\r\n");

      for (int iel = 0; iel < myConfigs.Length; iel++ )
        sb.Append(myConfigs[iel].print());
      
      //
      sb.Append("   ---------- ---------- ---------- ----------   \n");

      return sb.ToString();
    }
    


    // -------------------------------------------------------------------------------------
    //                              !!! PUBLIC METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// Deletes all measured data from time and values lists
    /// </summary>
    public void deleteData()
    {
      // Clear does not reduce the capacity of the lists, just set the contents
      // null. I do not know when GC is operating.
      // as long as I do not run into outofmemory exceptions I guess that
      // memory usage shown by windows task manager is not correct. That means,
      // if the OS needs more memory the GC would start operating and getting 
      // not used memory from the matlab processes
      time.Clear();
      values.Clear();
      values_noise.Clear();

      // maybe this will free memory
      //values= new List<physValue[]>();

      for (int isignal = 0; isignal < myConfigs.Length; isignal++)
        myConfigs[isignal].reset();
    }

    /// <summary>
    /// If no data is inside values, then sensor isEmpty, else false.
    /// </summary>
    /// <returns>true if empty else false</returns>
    public bool isEmpty()
    {
      if (values.Count <= 0)
        return true;
      else
        return false;
    }



    // -------------------------------------------------------------------------------------
    //                              !!! PRIVATE METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// Adds a new measurement, taken at time t, to the lists.
    /// </summary>
    /// <param name="t">simulation time in days</param>
    /// <param name="value">an array of physical values measured at that time</param>
    private void addMeasurement(double t, physValue[] value)
    {   
      double last_t = 0;

      if (time.Count > 0)
        last_t = time[time.Count - 1];

      physValue[] last_signals;

      if (values.Count > 0)
        last_signals = values[values.Count - 1];
      else // init with 0 elements, needed below in if of getNoisyMeasurement
        last_signals = new physValue[0];

      values.Add(value);                          // just add value to list

      // add noisy value to list
      values_noise.Add(sensor_config.getNoisyMeasurement(t, last_t, value, last_signals, myConfigs));    
    
      time.Add(t);    // add current time to time vector
    }

    

  }



}


