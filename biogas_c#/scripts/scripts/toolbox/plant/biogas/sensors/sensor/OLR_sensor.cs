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
* This file defines the class OLR_sensor.
* 
* TODOs:
* - improve documentation a bit
* - was für ein schwachsinn misst dieser Sensor? warum wird hier der zustandsvektor genutzt?
* 
* Except for that FINISHED!
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
  /// Sensor measuring the Organic Loading Rate 
  /// </summary>
  public class OLR_sensor : biogas.sensor
  {

    // -------------------------------------------------------------------------------------
    //                              !!! CONSTRUCTOR METHODS !!!
    // -------------------------------------------------------------------------------------
    
    /// <summary>
    /// Standard Constructor creating the sensor. Its id is OLR.
    /// id_suffix is here the digester ID in which the OLR is measured. 
    /// </summary>
    /// <param name="id_suffix"></param>
    public OLR_sensor(string id_suffix) :
      base( String.Format("{0}_{1}", _spec, id_suffix),
            String.Format("OLR sensor {0}", id_suffix), id_suffix)
    {
      // type
      _type = 7;
    }

    /// <summary>
    /// Constructor called by the constructor of biogas.sensors while 
    /// reading the sensors out of a XML file. So reader must be at the correct position, 
    /// which is &lt;sensor&gt; was just read. 
    /// </summary>
    /// <param name="reader"></param>
    /// <param name="id">id of sensor</param>
    public OLR_sensor(ref XmlTextReader reader, string id) : 
      base(ref reader, id)
    {
      // type
      _type = 7;
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
    static public string _spec = "OLR";



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
    /// Measure OLR of a digester
    /// 
    /// type 7
    /// 
    /// TODO: größtenteils identisch mit TS_sensor, man könnte was zusammen legen
    /// </summary>
    /// <param name="x">ADM state vector</param>
    /// <param name="myPlant"></param>
    /// <param name="mySubstrates">list of substrates</param>
    /// <param name="mySensors"></param>
    /// <param name="Q">
    /// substrate feed and recirculation sludge going into fermenter in m³/d
    /// first values are Q for substrates, then pumped sludge going into digester
    /// dimension: always number of substrates + number of digesters
    /// </param>
    /// <param name="par"></param>
    /// <returns></returns>
    override protected physValue[] doMeasurement(double[] x, biogas.plant myPlant,
                                                 biogas.substrates mySubstrates, biogas.sensors mySensors, 
                                                 double[] Q, params double[] par)
    {
      physValue[] values= new physValue[1];

      // TODO: so abändern, dass die aufgerufene methode calcOLR immer
      // feed und sludge übergeben werden. nicht oder

      // number of substrates
      int n_substrate= mySubstrates.getNumSubstrates();

      double Qsum= math.sum(Q);

      if (Q.Length < n_substrate)
        throw new exception( String.Format(
          "Q.Length < n_substrate: {0} < {1}!", Q.Length, n_substrate) );

      double[] Qsubstrates= new double[n_substrate];

      // volumeflow for substrates
      for (int isubstrate= 0; isubstrate < n_substrate; isubstrate++)
        Qsubstrates[isubstrate]= Q[isubstrate];

      //

      biogas.substrates substrates_or_sludge;

      //
      List<double> Q_s_or_s= new List<double>();

      // if no substrate is going into the fermenter we have to take the
      // TS from the digesters sludge going into this digester to calculate a
      // sludge. If there is substrate going into the digester we ignore
      // recirculation sludge, because the COD content inside the digester is
      // already influenced by the recirculated COD, so a high recirculation leads
      // to a reduction of the COD content inside the digester and then also to a
      // TS content reduction.
      if ( math.sum(Qsubstrates) == 0 )
      {
        substrates_or_sludge= new biogas.substrates();
        
        int ifermenter= 0;

        //

        for (int iflux= n_substrate; iflux < Q.Length; iflux++)
        {
          string digester_id= myPlant.getDigesterID(ifermenter + 1);

          double TS_digester, VS_digester= 0;

          try
          {
            mySensors.getCurrentMeasurementD("TS_" + digester_id + "_3", out TS_digester);
            mySensors.getCurrentMeasurementD("VS_" + digester_id + "_3", out VS_digester);

            // TODO - warum 4, wenn Fermenter abgestürzt ist, dann ist TS < 2
            // was zu doofen Fehlermeldungen führt mit calcNfE und boundNDF, wenn man
            // VS unten in biogas.sludge setzt. deshalb hier abfrage 
            if (TS_digester < 4 /*double.Epsilon*/)
              TS_digester= 11;
            // TODO - herausfinden warum 15
            if (VS_digester < 20 /*double.Epsilon*/)
              VS_digester = 85;   // 85 % TS
          }
          catch
          {
            TS_digester= 11;
            VS_digester = 85;
          }

          try
          {
            substrates_or_sludge.addSubstrate(
                      new biogas.sludge(mySubstrates, math.ones(n_substrate),
                        TS_digester, VS_digester));
          }
          catch (exception e)
          {
            LogError.Log_Err(String.Format("OLR_sensor.doMeasurement, VS: {0}, TS: {1}", 
              VS_digester, TS_digester), e);
            throw (e);
          }

          ifermenter= ifermenter + 1;
        }
        
        //

        for (int isubstrate= n_substrate; isubstrate < Q.Length; isubstrate++)
          Q_s_or_s.Add( Q[isubstrate] );

      }
      else
      {
        substrates_or_sludge= mySubstrates;

        for (int isubstrate= 0; isubstrate < Qsubstrates.Length; isubstrate++)
          Q_s_or_s.Add( Qsubstrates[isubstrate] );
      }

      //

      digester myDigester= myPlant.getDigesterByID(id_suffix);

      try
      {
        values[0] = myDigester.calcOLR(x, substrates_or_sludge, Q_s_or_s.ToArray(), Qsum);
      }
      catch (exception e)
      {
        LogError.Log_Err("OLR_sensor.doMeasurement2", e);
        throw (e);
      }

      //

      return values;
    }



  }
}


