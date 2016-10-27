/**
 * MATLAB Toolbox for Simulation, Control & Optimization of Biogas Plants
 * Copyright (C) 2014  Daniel Gaida
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
/**
* This file is part of the partial class sensors and defines
* the rest of the class.
* 
* TODOs:
* - evtl. weitere sensoren in create_sensor_network hinzufügen
* 
* Except for that FINISHED!
* 
*/

using System;
using System.Collections.Generic;
using System.Text;
using System.Xml;
using System.IO;
using science;
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
  /// List of sensors
  /// 
  /// is a list of sensors. The ids of the sensors inside this list
  /// are also saved inside the list ids. Next to sensors
  /// it also can contain sensor_arrays, which are an array of sensors.
  /// Sensors are grouped in different groups, dependent on the measure call syntax
  /// they have (those are the types: 0, 1, 2, ...).
  /// </summary>
  public partial class sensors : List<sensor>
  {

    // -------------------------------------------------------------------------------------
    //                              !!! CONSTRUCTOR METHODS !!!
    // -------------------------------------------------------------------------------------
    
    /// <summary>
    /// Create a sensor list with no sensors
    /// </summary>
    public sensors()
    {
      
    }

    /// <summary>
    /// Create a sensor list which contains one sensor: mySensor
    /// </summary>
    /// <param name="mySensor"></param>
    public sensors(sensor mySensor)
    {
      addSensor(mySensor);
    }
    
    /// <summary>
    /// Constructor creating the sensors by reading from the given xml file.
    /// </summary>
    /// <param name="XMLfile"></param>
    /// <param name="myPlant"></param>
    public sensors(string XMLfile, biogas.plant myPlant)
    {
      XmlTextReader reader= new System.Xml.XmlTextReader(XMLfile);

      getParamsFromXMLReader(ref reader, myPlant);
            
      reader.Close();
    }



    // -------------------------------------------------------------------------------------
    //                              !!! PUBLIC METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// Add the given sensor to the sensors and the ids list
    /// </summary>
    /// <param name="mySensor"></param>
    public void addSensor(sensor mySensor)
    {
      this.Add(mySensor);
      this._ids.Add(mySensor.id);

      // type of sensor, defines which doMeasurement is called
      // it is ok at the moment, no need to change something
      switch (mySensor.type)
      { 
        case 0:   // Sva_sensor, ...
          this.ids_type0.Add(mySensor.id); break;
        case 1:   // HRT_sensor
          this.ids_type1.Add(mySensor.id); break;
        // TODO - add more
        case 7:   // TS_sensor, OLR_sensor, stirrer, density
          this.ids_type7.Add(mySensor.id); break;
        case 8:   // fitness sensors
          this.ids_type8.Add(mySensor.id); break;
        default:
          // TODO - throw error
          break;
      }
    }

    /// <summary>
    /// Add the given sensor array to the sensors, but not the ids
    /// </summary>
    /// <param name="mySensorArray"></param>
    public void addSensorArray(sensor_array mySensorArray)
    {
      array.Add(mySensorArray);
      // TODO
      // noch zu ids hinzufügen??? nein, in ids befinden sich
      // nur sensors, keine sensor_arrays, sonst gibt es bei der
      // get(id, id_in_array) einen fehler

      // TODO
      // do we have to do something with type here as well???
      // at the moment no.
    }



    /// <summary>
    /// Create network of sensors, which are inside the simulation model
    /// </summary>
    /// <param name="myPlant"></param>
    /// <param name="mySubstrates"></param>
    /// <param name="plant_network"></param>
    /// <param name="plant_network_max"></param>
    /// <returns>
    /// sensors object containing all sensor and sensor_array objects inside the simulation model
    /// </returns>
    /// <exception cref="exception">Unknown sensor array id</exception>
    public static sensors create_sensor_network(plant myPlant, substrates mySubstrates,
                                                double[,] plant_network, double[,] plant_network_max)
    {
      sensors mySensors = new sensors();

      for (int idigester = 0; idigester < myPlant.getNumDigesters(); idigester++)
      { 
        string digester_id= myPlant.getDigesterID(idigester + 1);

        // 

        mySensors.addSensor(new biogas.VFA_TAC_sensor(digester_id + "_3"));

        mySensors.addSensor(new biogas.aceto_hydro_sensor(digester_id));

        mySensors.addSensor(new biogas.AcVsPro_sensor(digester_id + "_3"));

        mySensors.addSensor(new biogas.HRT_sensor(digester_id));

        mySensors.addSensor(new biogas.faecal_sensor(digester_id));

        mySensors.addSensor(new biogas.inhibition_sensor(digester_id));

        mySensors.addSensor(new biogas.energyProdMicro_sensor(digester_id));

        mySensors.addSensor(new biogas.biogas_sensor(digester_id));

        mySensors.addSensor(new biogas.VFA_sensor(digester_id + "_2") );
        mySensors.addSensor(new biogas.VFA_sensor(digester_id + "_3"));

        mySensors.addSensor(new biogas.VFAmatrix_sensor(digester_id + "_2"));
        mySensors.addSensor(new biogas.VFAmatrix_sensor(digester_id + "_3"));

        mySensors.addSensor(new biogas.Sva_sensor(digester_id + "_2"));
        mySensors.addSensor(new biogas.Sva_sensor(digester_id + "_3"));
        mySensors.addSensor(new biogas.Sbu_sensor(digester_id + "_2"));
        mySensors.addSensor(new biogas.Sbu_sensor(digester_id + "_3"));
        mySensors.addSensor(new biogas.Spro_sensor(digester_id + "_2"));
        mySensors.addSensor(new biogas.Spro_sensor(digester_id + "_3"));
        mySensors.addSensor(new biogas.Sac_sensor(digester_id + "_2"));
        mySensors.addSensor(new biogas.Sac_sensor(digester_id + "_3"));

        mySensors.addSensor(new biogas.VS_sensor(digester_id + "_2"));
        mySensors.addSensor(new biogas.VS_sensor(digester_id + "_3"));

        mySensors.addSensor(new biogas.Q_sensor(digester_id + "_2"));
        mySensors.addSensor(new biogas.Q_sensor(digester_id + "_3"));

        mySensors.addSensor(new biogas.NH3_sensor(digester_id + "_2"));
        mySensors.addSensor(new biogas.NH3_sensor(digester_id + "_3") );

        mySensors.addSensor(new biogas.NH4_sensor(digester_id + "_2"));
        mySensors.addSensor(new biogas.NH4_sensor(digester_id + "_3"));

        mySensors.addSensor(new biogas.Norg_sensor(digester_id + "_2"));
        mySensors.addSensor(new biogas.Norg_sensor(digester_id + "_3"));

        mySensors.addSensor(new biogas.TKN_sensor(digester_id + "_2"));
        mySensors.addSensor(new biogas.TKN_sensor(digester_id + "_3"));
        
        mySensors.addSensor(new biogas.Ntot_sensor(digester_id + "_2"));
        mySensors.addSensor(new biogas.Ntot_sensor(digester_id + "_3"));

        mySensors.addSensor(new biogas.pH_stream_sensor(digester_id + "_2"));
        mySensors.addSensor(new biogas.pH_sensor(digester_id + "_3") );

        mySensors.addSensor(new biogas.biomassAciAce_sensor(digester_id + "_3"));

        mySensors.addSensor(new biogas.biomassMeth_sensor(digester_id + "_3"));

        mySensors.addSensor(new biogas.TAC_sensor(digester_id + "_2"));
        mySensors.addSensor(new biogas.TAC_sensor(digester_id + "_3"));

        mySensors.addSensor(new biogas.SS_COD_sensor(digester_id + "_2"));
        mySensors.addSensor(new biogas.SS_COD_sensor(digester_id + "_3"));

        mySensors.addSensor(new biogas.VS_COD_sensor(digester_id + "_2"));
        mySensors.addSensor(new biogas.VS_COD_sensor(digester_id + "_3"));

        // heating
        mySensors.addSensor(new biogas.heatConsumption_sensor(digester_id));

        // stirrers - all stirrer in the digester
        mySensors.addSensor(new biogas.stirrer_sensor(digester_id));
        
        //

        mySensors.addSensor(new biogas.TS_sensor(digester_id + "_2"));  // TS messung des Fermenterinputs
        mySensors.addSensor(new biogas.TS_sensor(digester_id + "_3"));  // TS im fermenter

        mySensors.addSensor(new biogas.OLR_sensor(digester_id));

        // measures density of sludge inside the digester
        mySensors.addSensor(new biogas.density_sensor(digester_id));
        
        //

        mySensors.addSensor(new biogas.ADMstate_sensor(digester_id));

        mySensors.addSensor(new biogas.ADMstream_sensor(digester_id + "_2"));
        mySensors.addSensor(new biogas.ADMstream_sensor(digester_id + "_3"));
        
        //

        mySensors.addSensor(new biogas.ADMintvars_sensor(digester_id));

        mySensors.addSensor(new biogas.ADMparams_sensor(digester_id));

      }

      // 

      mySensors.addSensor( new biogas.SS_COD_sensor("finalstorage_2") );
      mySensors.addSensor( new biogas.VS_COD_sensor("finalstorage_2") );
      mySensors.addSensor( new biogas.Q_sensor(     "finalstorage_2") );

      mySensors.addSensor( new biogas.SS_COD_sensor("total_mix_2") );
      mySensors.addSensor( new biogas.VS_COD_sensor("total_mix_2") );
      mySensors.addSensor( new biogas.Q_sensor(     "total_mix_2") );
      mySensors.addSensor( new biogas.VS_sensor(    "total_mix_2") );

      mySensors.addSensor( new biogas.substrate_sensor("cost") );

      // fitness sensors

      mySensors.addSensor( new biogas.fitness_sensor() );

      mySensors.addSensor(new biogas.AcVsPro_fit_sensor());
      mySensors.addSensor(new biogas.VFA_fit_sensor());
      mySensors.addSensor(new biogas.VFA_TAC_fit_sensor());
      mySensors.addSensor(new biogas.TS_fit_sensor());
      mySensors.addSensor(new biogas.pH_fit_sensor());
      mySensors.addSensor(new biogas.OLR_fit_sensor());
      mySensors.addSensor(new biogas.TAC_fit_sensor());
      mySensors.addSensor(new biogas.HRT_fit_sensor());
      mySensors.addSensor(new biogas.N_fit_sensor());
      mySensors.addSensor(new biogas.CH4_fit_sensor());
      mySensors.addSensor(new biogas.SS_COD_fit_sensor());
      mySensors.addSensor(new biogas.VS_COD_fit_sensor());
      mySensors.addSensor(new biogas.gasexcess_fit_sensor());
      mySensors.addSensor(new biogas.setpoint_fit_sensor());
      mySensors.addSensor(new biogas.manurebonus_sensor());
      mySensors.addSensor(new biogas.udot_sensor());

      //

      mySensors.addSensor( new biogas.total_biogas_sensor("", myPlant) );

      //

      mySensors.addSensorArray( new biogas.sensor_array("Q") );

      for (int isubstrate = 0; isubstrate < mySubstrates.getNumSubstrates(); isubstrate++)
      {
        try
        {
          mySensors.getArray("Q").addSensor(new biogas.Q_sensor(mySubstrates.getID(isubstrate + 1)));
        }
        catch (exception e)
        {
          Console.WriteLine("Could not add Q_sensor to substrate array!");
          throw (e);
        }

        mySensors.addSensor(new biogas.substrateparams_sensor(mySubstrates.getID(isubstrate + 1)));
      }

      //

      
      // nº of Columms -> Inputs to the fermenter 
      for (int ifermenterIn= 0; ifermenterIn < myPlant.getNumDigesters() + 1; ifermenterIn++) 
      {
        // nº of Rows -> Outputs to the fermenter
        for (int ifermenterOut= 0; ifermenterOut < myPlant.getNumDigesters(); ifermenterOut++)    
        {
          // TODO - es gibt bestimmt auch eine funktion in matlab, welche diese schleife
          // schon implementiert hat als funktion
          // Connection condition within fermenters
          if ( ( plant_network[    ifermenterOut, ifermenterIn] > 0   ) && 
               ( plant_network_max[ifermenterOut, ifermenterIn] < Double.PositiveInfinity ) )
          {
            //
            // Fermenter Name for Input  
            String fermenter_id_in= myPlant.getDigesterID(ifermenterIn + 1);  
            // Fermenter Name for Output
            String fermenter_id_out= myPlant.getDigesterID(ifermenterOut + 1);  

            //

            mySensors.getArray("Q").addSensor( 
              new biogas.Q_sensor( fermenter_id_out + "_" + fermenter_id_in ) );
          }
        }
      }

      //

      for (int ibhkw= 0; ibhkw < myPlant.getNumCHPs(); ibhkw++)
      {
        String bhkw_id= myPlant.getCHPID(ibhkw + 1);
        
        mySensors.addSensor( new biogas.energyProduction_sensor(bhkw_id) );
      }

      //

      mySensors.addSensor(new biogas.energyProdSum_sensor());

      //

      // TODO - könnte man evtl. auch in transportation rein schieben

      for (int ipump = 0; ipump < myPlant.getNumPumps(); ipump++)
      {
        String pump_id = myPlant.getPumpID(ipump + 1);

        mySensors.addSensor(new biogas.pumpEnergy_sensor(pump_id));
      }

      // 

      for (int isubstrate_transport = 0; 
               isubstrate_transport < myPlant.getNumSubstrateTransports(); 
               isubstrate_transport++)
      {
        String substrate_transport_id = myPlant.getSubstrateTransportID(isubstrate_transport + 1);

        // for liquid substrates
        mySensors.addSensor(new biogas.pumpEnergy_sensor(substrate_transport_id));

        // for non-liquid substrates
        mySensors.addSensor(new biogas.transportEnergy_sensor(substrate_transport_id));
      }

      //



      // 

      return mySensors;
    }



    /// <summary>
    /// selects sensor constructor based on spec and calls add Sensor
    /// for appropriate sensor
    /// </summary>
    /// <param name="reader">an open xml reader</param>
    /// <param name="sensor_id">sensor id</param>
    /// <param name="spec">sensor specification</param>
    /// <param name="myPlant"></param>
    private void select_sensor_constructor(ref XmlTextReader reader,
      string sensor_id, string spec, biogas.plant myPlant)
    {
      if (spec == aceto_hydro_sensor._spec)
        addSensor(new biogas.aceto_hydro_sensor(ref reader, sensor_id));
      else if(spec == AcVsPro_sensor._spec)
        addSensor( new biogas.AcVsPro_sensor(ref reader, sensor_id) );
      else if(spec == ADMintvars_sensor._spec)
          addSensor(new biogas.ADMintvars_sensor(ref reader, sensor_id));
      else if (spec == ADMparams_sensor._spec)
        addSensor(new biogas.ADMparams_sensor(ref reader, sensor_id));
      else if(spec == ADMstate_sensor._spec)
          addSensor(new biogas.ADMstate_sensor(ref reader, sensor_id));
      else if (spec == ADMstream_sensor._spec)
        addSensor(new biogas.ADMstream_sensor(ref reader, sensor_id));
      else if(spec == biogas_sensor._spec)
          addSensor(new biogas.biogas_sensor(ref reader, sensor_id));
      else if(spec == biomassAciAce_sensor._spec)
          addSensor(new biogas.biomassAciAce_sensor(ref reader, sensor_id));
      else if(spec == density_sensor._spec)
          addSensor(new biogas.density_sensor(ref reader, sensor_id));
      else if (spec == energyProdMicro_sensor._spec)
        addSensor(new biogas.energyProdMicro_sensor(ref reader, sensor_id));
      else if (spec == energyProduction_sensor._spec)
        addSensor(new biogas.energyProduction_sensor(ref reader, sensor_id));
      else if (spec == energyProdSum_sensor._spec)
        addSensor(new biogas.energyProdSum_sensor(ref reader, sensor_id));
      else if (spec == faecal_sensor._spec)
        addSensor(new biogas.faecal_sensor(ref reader, sensor_id));
      else if (spec == fitness_sensor._spec)
        addSensor(new biogas.fitness_sensor(ref reader, sensor_id));
      else if (spec == AcVsPro_fit_sensor._spec)
        addSensor(new biogas.AcVsPro_fit_sensor(ref reader, sensor_id));
      else if (spec == VFA_fit_sensor._spec)
        addSensor(new biogas.VFA_fit_sensor(ref reader, sensor_id));
      else if (spec == VFA_TAC_fit_sensor._spec)
        addSensor(new biogas.VFA_TAC_fit_sensor(ref reader, sensor_id));
      else if (spec == TS_fit_sensor._spec)
        addSensor(new biogas.TS_fit_sensor(ref reader, sensor_id));
      else if (spec == pH_fit_sensor._spec)
        addSensor(new biogas.pH_fit_sensor(ref reader, sensor_id));
      else if (spec == OLR_fit_sensor._spec)
        addSensor(new biogas.OLR_fit_sensor(ref reader, sensor_id));
      else if (spec == TAC_fit_sensor._spec)
        addSensor(new biogas.TAC_fit_sensor(ref reader, sensor_id));
      else if (spec == HRT_fit_sensor._spec)
        addSensor(new biogas.HRT_fit_sensor(ref reader, sensor_id));
      else if (spec == N_fit_sensor._spec)
        addSensor(new biogas.N_fit_sensor(ref reader, sensor_id));
      else if (spec == CH4_fit_sensor._spec)
        addSensor(new biogas.CH4_fit_sensor(ref reader, sensor_id));
      else if (spec == SS_COD_fit_sensor._spec)
        addSensor(new biogas.SS_COD_fit_sensor(ref reader, sensor_id));
      else if (spec == VS_COD_fit_sensor._spec)
        addSensor(new biogas.VS_COD_fit_sensor(ref reader, sensor_id));
      else if (spec == gasexcess_fit_sensor._spec)
        addSensor(new biogas.gasexcess_fit_sensor(ref reader, sensor_id));
      else if (spec == setpoint_fit_sensor._spec)
        addSensor(new biogas.setpoint_fit_sensor(ref reader, sensor_id));
      else if (spec == manurebonus_sensor._spec)
        addSensor(new biogas.manurebonus_sensor(ref reader, sensor_id));
      else if (spec == udot_sensor._spec)
        addSensor(new biogas.udot_sensor(ref reader, sensor_id));
      // TODO - add more fitness sensors

      else if (spec == heatConsumption_sensor._spec)
        addSensor(new biogas.heatConsumption_sensor(ref reader, sensor_id));
      else if (spec == HRT_sensor._spec)
        addSensor(new biogas.HRT_sensor(ref reader, sensor_id));
      else if (spec == inhibition_sensor._spec)
        addSensor(new biogas.inhibition_sensor(ref reader, sensor_id));
      else if (spec == NH3_sensor._spec)
        addSensor(new biogas.NH3_sensor(ref reader, sensor_id));
      else if (spec == NH4_sensor._spec)
        addSensor(new biogas.NH4_sensor(ref reader, sensor_id));
      else if (spec == Norg_sensor._spec)
        addSensor(new biogas.Norg_sensor(ref reader, sensor_id));
      else if (spec == TKN_sensor._spec)
        addSensor(new biogas.TKN_sensor(ref reader, sensor_id));
      else if (spec == Ntot_sensor._spec)
        addSensor(new biogas.Ntot_sensor(ref reader, sensor_id));
      else if (spec == OLR_sensor._spec)
        addSensor(new biogas.OLR_sensor(ref reader, sensor_id));
      else if (spec == pH_sensor._spec)
        addSensor(new biogas.pH_sensor(ref reader, sensor_id));
      else if (spec == pH_stream_sensor._spec)
        addSensor(new biogas.pH_stream_sensor(ref reader, sensor_id));
      else if (spec == pumpEnergy_sensor._spec)
        addSensor(new biogas.pumpEnergy_sensor(ref reader, sensor_id));
      else if (spec == Q_sensor._spec)
        addSensor(new biogas.Q_sensor(ref reader, sensor_id));

      else if (spec == Sac_sensor._spec)
        addSensor(new biogas.Sac_sensor(ref reader, sensor_id));
      else if (spec == Sbu_sensor._spec)
        addSensor(new biogas.Sbu_sensor(ref reader, sensor_id));
      else if (spec == Spro_sensor._spec)
        addSensor(new biogas.Spro_sensor(ref reader, sensor_id));
      else if (spec == SS_COD_sensor._spec)
        addSensor(new biogas.SS_COD_sensor(ref reader, sensor_id));
      else if (spec == stirrer_sensor._spec)
        addSensor(new biogas.stirrer_sensor(ref reader, sensor_id));
      else if (spec == substrate_sensor._spec)
        addSensor(new biogas.substrate_sensor(ref reader, sensor_id));
      else if (spec == substrateparams_sensor._spec)
        addSensor(new biogas.substrateparams_sensor(ref reader, sensor_id));
      else if (spec == Sva_sensor._spec)
        addSensor(new biogas.Sva_sensor(ref reader, sensor_id));
      else if (spec == TAC_sensor._spec)
        addSensor(new biogas.TAC_sensor(ref reader, sensor_id));
      // myPlant muss noch hinzugefügt werden - OK
      else if (spec == total_biogas_sensor._spec)
        addSensor(new biogas.total_biogas_sensor(ref reader, sensor_id, myPlant));
      else if (spec == transportEnergy_sensor._spec)
        addSensor(new biogas.transportEnergy_sensor(ref reader, sensor_id));
      else if (spec == TS_sensor._spec)
        addSensor(new biogas.TS_sensor(ref reader, sensor_id));
      else if (spec == VFA_sensor._spec)
        addSensor(new biogas.VFA_sensor(ref reader, sensor_id));
      else if (spec == VFA_TAC_sensor._spec)
        addSensor(new biogas.VFA_TAC_sensor(ref reader, sensor_id));
      else if (spec == VFAmatrix_sensor._spec)
        addSensor(new biogas.VFAmatrix_sensor(ref reader, sensor_id));
      else if (spec == VS_COD_sensor._spec)
        addSensor(new biogas.VS_COD_sensor(ref reader, sensor_id));
      else if (spec == VS_sensor._spec)
        addSensor(new biogas.VS_sensor(ref reader, sensor_id));

      // TODO - add further, if needed
      // TODO - could also throw an error, if spec is unknown
    }



    /// <summary>
    /// Read params from reader which reads a xml file.
    /// reads until end elements of sensors, adds all read sensors to list
    /// </summary>
    /// <param name="reader"></param>
    /// <param name="myPlant"></param>
    public void getParamsFromXMLReader(ref XmlTextReader reader, biogas.plant myPlant)
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

                // hier habe ich sensor_id und spec, rufe methode aus
                // welche aus spec den richtigen constructor aufruft, übergeb
                // reader und sensor_id
                select_sensor_constructor(ref reader, sensor_id, spec, myPlant);
              }
              else if (xml_tag == "sensor_array" && reader.Name == "id")
              {
                // found a new sensor_array
                sensor_id = reader.Value;   // id von sensor_array ist identisch mit
                // specification, also bspw. "Q"

                addSensorArray( new biogas.sensor_array(sensor_id) );

                getArray(sensor_id).getParamsFromXMLReader(ref reader);
              }
            }

            break;

          case System.Xml.XmlNodeType.Text: // text, thus value, of each element

            if (xml_tag == "sampling_time")
            {
              _sampling_time = System.Xml.XmlConvert.ToDouble(reader.Value);
            }

            break;

          case System.Xml.XmlNodeType.EndElement:
            if (reader.Name == "sensors")
              do_while = false;

            break;
        }
      }

    }

    /// <summary>
    /// Return the params of all sensors as a xml string
    /// </summary>
    /// <returns></returns>
    public string getParamsAsXMLString()
    {
      StringBuilder sb = new StringBuilder();

      sb.Append("<sensors>\n");

      sb.Append(xmlInterface.setXMLTag("sampling_time", sampling_time));

      foreach (sensor mySensor in this)
      {
        sb.Append(mySensor.getParamsAsXMLString());
      }

      // for each sensor in sensor array
      foreach (sensor_array mySensorArray in array)
      {
        sb.Append(mySensorArray.getParamsAsXMLString());
      }
      
      sb.Append("</sensors>\n");

      return sb.ToString();
    }

    /// <summary>
    /// Print sensors to a string, to be displayed on a console
    /// </summary>
    /// <returns></returns>
    public string print()
    {
      StringBuilder sb = new StringBuilder();

      sb.Append("   ----------   SENSORS   ----------   \n");

      sb.Append(String.Format("sampling time= {0} \n", sampling_time));

      foreach (sensor mySensor in this)
      {
        sb.Append(mySensor.print());
      }

      // for each sensor in sensor array
      foreach (sensor_array mySensorArray in array)
      {
        foreach (sensor mySensor in mySensorArray)
        {
          sb.Append(mySensor.print());
        }
      }

      sb.Append("   ----------     END SENSORS     ----------   \n");

      return sb.ToString();
    }

    /// <summary>
    /// Write sensors to a xml file
    /// </summary>
    /// <param name="XMLfile"></param>
    public void saveAsXML(string XMLfile)
    {
      StreamWriter writer = File.CreateText(XMLfile); 
      
      writer.Write("<?xml version=\"1.0\" encoding=\"utf-8\"?>\n");

      writer.Write(getParamsAsXMLString());

      writer.Close();
    }



    /// <summary>
    /// Deletes all recorded data from the given sensor
    /// </summary>
    /// <param name="id">id of sensor or sensor_array</param>
    /// <param name="id_in_array">id of sensor in sensor_array</param>
    /// <exception cref="exception">Unknown sensor id</exception>
    public void deleteDataFromSensor(string id, string id_in_array)
    {
      sensor mySensor= get(id, id_in_array);

      mySensor.deleteData();
    }

    /// <summary>
    /// Deletes all recorded data from all sensors and sensor arrays in the sensor list
    /// </summary>
    public void deleteDataFromAllSensors()
    {
      // for each sensor
      foreach (sensor mySensor in this)
      {
        mySensor.deleteData();
      }

      // for each sensor in sensor array
      foreach (sensor_array mySensorArray in array)
      {
        foreach (sensor mySensor in mySensorArray)
        {
          mySensor.deleteData();
        }
      }

      if (!isEmpty())
      {
        throw new exception("sensors is not empty, although all data was deleted!", 
          "deleteDataFromAllSensors");
      }
    }



    /// <summary>
    /// Checks if sensor objects in sensors are empty or not. they are
    /// empty if they have not recorded anything. here we just check whether
    /// the first sensor is empty, because either all are empty or none
    /// 
    /// if no sensors are in list, then sensors is declared to be empty, so
    /// true is returned
    /// </summary>
    /// <returns>true, if empty or false if not empty</returns>
    public bool isEmpty()
    {
      // for each sensor
      foreach (sensor mySensor in this)
      {
        // the first sensor decides whether all sensors are empty
        // or not. this should be ok, because either all are empty
        // or none
        return mySensor.isEmpty();
      }

      // do not check this, because sensor array could be empty, even
      // if sensors are not. 
      // for each sensor in sensor array
      //foreach (sensor_array mySensorArray in array)
      //{
      //  foreach (sensor mySensor in mySensorArray)
      //  {
      //    mySensor.isEmpty();
      //  }
      //}

      return true;
    }



    /// <summary>
    /// Returns the sensor object with the given id
    /// </summary>
    /// <param name="id">id of sensor</param>
    /// <returns></returns>
    /// <exception cref="exception">Unknown sensor id</exception>
    public sensor get(string id)
    {
      return get(id, "");
    }

    /// <summary>
    /// Returns the sensor object with the given id
    /// </summary>
    /// <param name="id">id of sensor or sensor_array</param>
    /// <param name="id_in_array">id of sensor in sensor_array</param>
    /// <returns></returns>
    /// <exception cref="exception">Unknown sensor id</exception>
    public sensor get(string id, string id_in_array)
    {
      foreach (sensor mySensor in this)
      {
        if (mySensor.id == id)
          return mySensor;
      }

      foreach (sensor_array mySensorArray in array)
      {
        if (mySensorArray.id == id)
          return mySensorArray.get(id_in_array);
      }

      throw new exception(String.Format(
        "sensors:get: Cannot find the sensor (id: {0}) in the list!", id));
    }

    /// <summary>
    /// returns the given sensor_array
    /// </summary>
    /// <param name="id">id of sensor array</param>
    /// <returns></returns>
    /// <exception cref="exception">Unknown sensor array id</exception>
    public sensor_array getArray(string id)
    {
      foreach (sensor_array mySensorArray in array)
      {
        if (mySensorArray.id == id)
          return mySensorArray;
      }

      throw new exception(String.Format(
        "Cannot find the sensor array (id: {0}) in the array list!", id));
    }



    /// <summary>
    /// Returns ids of sensor_array with the given id
    /// </summary>
    /// <param name="id">id of sensor_array</param>
    /// <returns>ids of sensors inside given sensor array</returns>
    /// <exception cref="exception">Unknown sensor array id</exception>
    public string[] getIDsOfArray(string id)
    {
      foreach (sensor_array mySensorArray in array)
      {
        if (mySensorArray.id == id)
          return mySensorArray.getIDs();
      }

      throw new exception(String.Format(
        "Cannot find the sensor array (id: {0}) in the array list!", id));
    }


    /// <summary>
    /// Checks if given sensor id exists, then return true, else false
    /// </summary>
    /// <param name="id">id of sensor</param>
    /// <returns>true if sensor id exists in list, else false</returns>
    public bool exist(string id)
    {
      return exist(id, "");
    }
    /// <summary>
    /// Checks if given sensor id exists, then return true, else false
    /// </summary>
    /// <param name="id">id of sensor or sensor_array</param>
    /// <param name="id_in_array">id of sensor in sensor_array</param>
    /// <returns>true if sensor id exists in list, else false</returns>
    public bool exist(string id, string id_in_array)
    {
      foreach (sensor mySensor in this)
      {
        if (mySensor.id == id)
          return true;
      }

      foreach (sensor_array mySensorArray in array)
      {
        if (mySensorArray.id == id)
          return mySensorArray.exist(id_in_array);
      }

      return false;
    }

    /// <summary>
    /// Returns number of sensors
    /// </summary>
    /// <returns>number of sensors</returns>
    public int getNumSensors()
    {
      return this.ids.Count;
    }
    /// <summary>
    /// Returns number of sensors as double, only for MATLAB.
    /// </summary>
    /// <returns>number of sensors</returns>
    public double getNumSensorsD()
    {
      return (double)getNumSensors();
    }



  }
}


