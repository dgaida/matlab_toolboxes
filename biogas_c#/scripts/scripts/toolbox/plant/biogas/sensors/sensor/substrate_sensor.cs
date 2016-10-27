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
 * This file defines the class substrate_sensor.
 * 
 * TODOs:
 * - das Q, welches hier übergeben wird, wird in der regel aus volumeflow_files
 * gelesen. wenn anlage geregelt wird, dann stimmen diese Qs nicht mit realen auf anlage
 * angewendeten Qs überein. Damit stimmen die gemessenen sensor werte auch nicht mehr
 * das gilt bspw. für den sensor substrate_cost
 * 
 * FINISHED!
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
  /// Sensor measuring substrate parameters
  /// 
  /// substrate parameter must be defined in mySubstrates
  /// </summary>
  public class substrate_sensor : biogas.sensor
  {

    // -------------------------------------------------------------------------------------
    //                              !!! CONSTRUCTOR METHODS !!!
    // -------------------------------------------------------------------------------------
    
    /// <summary>
    /// Standard Constructor creating the sensor. Its id is substrate.
    /// parameter is here the parameter of the substrate to be measured
    /// 
    /// can be used to measure cost of substrate: substrate_cost
    /// 
    /// substrate_sensor('cost')
    /// </summary>
    /// <param name="parameter"></param>
    public substrate_sensor(string parameter) :
      base(String.Format("{0}_{1}", _spec, parameter),
           String.Format("substrate sensor {0}", parameter), parameter)
    {
      // TODO
      // type= ?
      _type = 89;
    }

    /// <summary>
    /// Constructor called by the constructor of biogas.sensors while 
    /// reading the sensors out of a XML file. So reader must be at the correct position, 
    /// which is &lt;sensor&gt; was just read. 
    /// </summary>
    /// <param name="reader"></param>
    /// <param name="id">id of sensor</param>
    public substrate_sensor(ref XmlTextReader reader, string id) : 
      base(ref reader, id)
    {
      // TODO
      // type= ?
      _type = 89;
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
    static public string _spec = "substrate";



    // -------------------------------------------------------------------------------------
    //                            !!! PROTECTED METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// not implemented
    /// </summary>
    /// <param name="x"></param>
    /// <param name="par"></param>
    /// <returns></returns>
    override protected physValue[] doMeasurement(double[] x, params double[] par)
    {
      throw new exception("Not implemented!");
    }

    /// <summary>
    /// measures mean value of given parameter in mySubstrates depending on Q
    /// 
    /// type 3
    /// </summary>
    /// <param name="x">not used</param>
    /// <param name="mySubstrates"></param>
    /// <param name="Q">
    /// substrate feed in m^3/d
    /// doesn't matter if this is substrate mix for plant or
    /// substrate mix to digester, depends on what we want to have</param>
    /// <param name="par">not used</param>
    /// <returns>mean value of given parameter</returns>
    override protected physValue[] doMeasurement(double[] x, biogas.substrates mySubstrates,
                                                 double[] Q, params double[] par)
    {
      physValue[] values= new physValue[1];

      // id_suffix is here the parameter to be measured, see above
      mySubstrates.get_weighted_sum_of(Q, id_suffix, out values[0]);

      values[0].Symbol= id_suffix;

      return values;
    }



  }
}


