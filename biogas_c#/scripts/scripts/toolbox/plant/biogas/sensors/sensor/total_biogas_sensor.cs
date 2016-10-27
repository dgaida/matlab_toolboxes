/**
 * This file defines the class total_biogas_sensor.
 * 
 * TODOs:
 * - hängt stark von anzahl gemessenen gasen ab
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
  /// Sensor measuring the biogas produced by all digesters
  /// </summary>
  public class total_biogas_sensor : biogas.sensor
  {

    // -------------------------------------------------------------------------------------
    //                              !!! CONSTRUCTOR METHODS !!!
    // -------------------------------------------------------------------------------------
    
    /// <summary>
    /// Standard Constructor creating the sensor. Its id is total_biogas.
    /// id_suffix is here actually nothing
    /// </summary>
    /// <param name="id">TODO: what is that?</param>
    /// <param name="myPlant"></param>
    public total_biogas_sensor(string id, biogas.plant myPlant) :
      base( String.Format("{0}_{1}", _spec, id),
            String.Format("total biogas sensor {0}", id), id, 
            myPlant.getNumCHPs() * (int)BioGas.n_gases + 
                                   (int)BioGas.n_gases + 1 + 1)
    {
      // gas for each chp
      // total gas splitted in fractions [% and ppm]
      // total biogas [m³/d]
      // biogas excess [m³/d]
      //dimension

      // TODO
      // type= ?
      _type = 87;
    }
        
    /// <summary>
    /// Constructor called by the constructor of biogas.sensors while 
    /// reading the sensors out of a XML file. So reader must be at the correct position, 
    /// which is &lt;sensor&gt; was just read. 
    /// </summary>
    /// <param name="reader"></param>
    /// <param name="id">id of sensor</param>
    /// <param name="myPlant"></param>
    public total_biogas_sensor(ref XmlTextReader reader, string id, 
      biogas.plant myPlant) :
      base(ref reader, id, myPlant.getNumCHPs() * (int)BioGas.n_gases +
                                                  (int)BioGas.n_gases + 1 + 1)
    {
      // gas for each chp
      // total gas splitted in fractions [% and ppm]
      // total biogas [m³/d]
      // biogas excess [m³/d]
      //dimension

      // TODO
      // type= ?
      _type = 87;
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
    static public string _spec = "total_biogas";



    // -------------------------------------------------------------------------------------
    //                            !!! PROTECTED METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// not implemented
    /// </summary>
    /// <param name="u"></param>
    /// <param name="par"></param>
    /// <returns></returns>
    override protected physValue[] doMeasurement(double[] u, params double[] par)
    {
      throw new exception("Not implemented!");
    }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="myPlant"></param>
    /// <param name="u">contains (h2, ch4, co2)_digester_1, (h2, ch4, co2)_digester_2</param>
    /// <param name="gas2bhkwsplittype">fiftyfifty, one2one, threshold</param>
    /// <param name="par"></param>
    /// <returns></returns>
    override protected physValue[] doMeasurement(biogas.plant myPlant,
                                                 double[] u, string gas2bhkwsplittype, 
                                                 params double[] par)
    {
      // contains:
      // total biogas production [m³/d]
      // total biogas production splitted into components [m³d]
      // biogas for each chp splitted into components
      // biogas excess [m³/d]
      physValue[] values= new physValue[dimension];

      // TODO
      //Console.WriteLine(dimension);

      int n_digester= myPlant.getNumDigesters();
      int n_chp=      myPlant.getNumCHPs();
      int n_gases=    (int)BioGas.n_gases;

      // u contains (h2, ch4, co2)_digester_1, (h2, ch4, co2)_digester_2, ...
            
      // TODO - scheint mir ok zu sein, kann das nicht erkennen.
      // ch4 must be the second element due to implementation below
      //
      // ch4 is the second element
      int index_ch4= BioGas.pos_ch4 - 1;

      // total biogas in m^3/d (h2, ch4, co2)
      double[] biogas_total = BioGas.merge_streams(u, n_digester);

      // total biogas production in m³/d, sum of biogas_total
      double total_biogas_total;

      // percentual biogas prdocution on the plant (h2 %, ch4 %, co2 %)
      double[] biogas_total_perc = BioGas.calcRelContent(biogas_total, out total_biogas_total);

      //

      double[] gas_out= new double[n_gases * n_chp];

      //

      switch (gas2bhkwsplittype)
      {
        case "fiftyfifty":

          gas_out= math.repmat(math.rdivide(biogas_total, n_chp), n_chp);

          break;

        case "one2one":

          if (n_chp == n_digester)
            gas_out= u;
          else
            throw new exception(String.Format("n_chp != n_digester: {0} != {1}!",
                                               n_chp, n_digester));

          break;

        case "threshold":

          double gas_max;
              
          for (int ichp= 0; ichp < n_chp; ichp++)
          {
            if (biogas_total[index_ch4] > 0)
            {
              // in gas_max is the maximal amount of methane in m^3/d which
              // can be handled by the indexed bhkw
              myPlant.getCHP(ichp + 1).getMaxMethaneConsumption(out gas_max);

              // available methane content
              double methan= Math.Min(biogas_total[index_ch4], gas_max);

              for (int igas= 0; igas < n_gases; igas++)
              {
                // get the fraction out of the biogas
                gas_out[igas + ichp * n_gases]= 
                  methan / biogas_total[index_ch4] * biogas_total[igas];
              }

              // decrease biogas amount 
              for (int igas= 0; igas < n_gases; igas++)
              {
                biogas_total[igas] -= gas_out[igas + ichp * n_gases];
              }
            }
            else
              break;
          }

          //
            
          break;

        default:
          throw new exception(String.Format(
                              "Unknown gas2bhkwsplittype: {0}!", id_suffix));

      }

      // too much biogas produced [m^3/d], sum of the three parts   
      double gas_excess= Math.Max(total_biogas_total - math.sum(gas_out), 0);
            
      //

      values[0]= new physValue("biogas_t", total_biogas_total, "m^3/d", "total biogas");

      //

      physValue[] values_rel = BioGas.convert(biogas_total_perc);

      for (int igas= 0; igas < n_gases; igas++)
        values[igas + 1] = values_rel[igas];
 
      //

      for (int igas= 0; igas < n_gases; igas++)
      {
        for (int ichp= 0; ichp < n_chp; ichp++)
        {
          values[igas + ichp * n_gases + 1 + n_gases]=
                  new physValue(BioGas.symGases[igas] + "_" + myPlant.getCHPID(ichp + 1),
                                gas_out[igas + ichp * n_gases], "m^3/d",
                                BioGas.labelGases[igas]);
        }
      }

      values[ values.Length - 1 ]= new physValue("biogas_excess", gas_excess, "m^3/d", "excess biogas");

      //

      return values;
    }



  }
}


