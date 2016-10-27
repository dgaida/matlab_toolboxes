/**
 * This file defines funding via the EEG 2009.
 * 
 * TODOs:
 * - 
 * 
 * Should be FINISHED!
 * 
 */

using System;
using System.Collections.Generic;
using System.Text;
using System.Xml;
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
  /// funding structure of EEG 2009
  /// </summary>
  public partial class eeg2009 : funding
  {

    // -------------------------------------------------------------------------------------
    //                              !!! CONSTRUCTOR METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// Standard Constructor, sets parameter to default values
    /// </summary>
    public eeg2009()
    {
      bool[] values= { true, false, false, false, true, false };

      try
      {
        set_params_of(values);
      }
      catch (exception e)
      {
        Console.WriteLine(e.Message);
        Console.WriteLine("Could not create eeg2009!");
      }
    }



    // -------------------------------------------------------------------------------------
    //                              !!! PUBLIC METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// Check whether current substrate feed saved in sensors qualifies for the manure bonus
    /// 
    /// </summary>
    /// <param name="mySubstrates"></param>
    /// <param name="mySensors"></param>
    /// <returns></returns>
    public static bool check_manurebonus(biogas.substrates mySubstrates, biogas.sensors mySensors)
    {
      double t = mySensors.getCurrentTime();    // get current time

      // get recorded substrate feeds in m³/d
      physValue[] Q = mySensors.getMeasurementsAt("Q", "Q", t, mySubstrates);

      double[] Qdbl = physValue.getValues(Q);

      return check_manurebonus(mySubstrates, Qdbl);
    }

    /// <summary>
    /// Check whether given substrate feed Q qualifies for the manure bonus
    /// 
    /// Güllebonus wird ab jetzt immer während simulation geprüft, wird von manurebonus_sensor
    /// aufgezeichnet. eine überprüfung vor einer simulation wäre auch möglich, sollte aber
    /// nicht mehr durch geführt werden. zumindest sollte ein negatives ergebnis für den 
    /// güllebonus nicht daran hindern eine simulaion durchzuführen. 
    /// wenn sich substratzufuhr über prädiktionshorizont verändert, müsste aktuell diese
    /// methode für jeden neuen substratmix einzeln aufgerufen werden. d.h. Q enthält immer nur
    /// ein element je substrat und nicht mehrere elemente zu verschiedenen zeitpunkten
    /// </summary>
    /// <param name="mySubstrates"></param>
    /// <param name="Q">substrate feed on plant in m³/d</param>
    /// <param name="A">linear constraint vector of A * Q &lt;= b</param>
    /// <param name="b">right side of cosntraint</param>
    /// <param name="dist_bonus">distance of given feed Q to bonus, must be negative such that
    /// bonus is satisfied</param>
    /// <returns></returns>
    public static bool check_manurebonus(biogas.substrates mySubstrates, double[] Q, 
      out double[] A, out double b, out double dist_bonus)
    {
      //
      // linear inequality constraints for the substrate flow 
      // Gülle Bonus
      //
      // Erklärung zum Gülle Bonus:
      //
      // Für Strom aus Biogasanlagen kann nach den Vorschriften des "EEG
      // 2009" ein erhöhter NaWaRo Bonus gewährt werden, wenn der Anlage ein
      // Mindestanteil an Gülle zugeführt wird. Gemäß Anlage 2, Ziffer VI
      // des EEG 2009 besteht der Anspruch nur dann, wenn der Anteil von
      // Gülle (dazu zählt auch Festmist) JEDERZEIT (stimmt das WIRKLICH???) mindestens 30
      // Masseprozent beträgt. 
      //
      // Quelle: 
      //
      // http://www.dlr.rlp.de/internet/global/themen.nsf/ALL/26C1BE11D99FE329C12575270048A024?OpenDocument
      // 
      //
      // Summe über Gülle [kg/d] >= 0,3 * ( Summe aller Substrate [kg/d] )
      //
      // -0.7 * ( Summe über Gülle [kg/d] ) + 0.3 ( Summe restlicher
      // Substrate [kg/d] ) <= 0 
      //
      // -0.7 * ( Summe über Gülle [m³/d] * rho_gülle [kg/m³] ) + 0.3 (
      // Summe restlicher Substrate [m³/d] * rho_substrat [kg/m³] ) <= 0 
      //
      // In der Form Ax <= b
      //
      // b= 0;
      //
      // A= -0.7 * rho_gülle für alle Gülleformen und 0.3 * rho_substrat für
      // den Rest, hier ein liegender Vektor  
      //

      int n_substrates= mySubstrates.getNumSubstrates();

      // substrate_ineq= [A, b]
      double[] substrate_ineq = new double[n_substrates + 1];

      //

      for (int isubstrate = 0; isubstrate < n_substrates; isubstrate++)
      {
        substrate mySubstrate = mySubstrates.get(isubstrate + 1);

        double rho = mySubstrate.get_param_of("rho");    // get density of substrate in kg/m^3

        if (mySubstrate.ismanure)
        {
          substrate_ineq[isubstrate] = -0.7 * rho;
        }
        else
        {
          substrate_ineq[isubstrate] = 0.3 * rho;
        }
      }

      //

      bool is_manure_bonus = false;

      // linear constraint: A * Q <= b      A * Q - b <= 0
      A = math.getrows(substrate_ineq, 0, n_substrates - 1);
      b = substrate_ineq[n_substrates];

      // MATLAB syntax: if (substrate_ineq(1:end-1) * Q <= substrate_ineq(end))
      // this is the distance of the given feed Q to the manure bonus hyperplane
      dist_bonus = math.mtimes(A, Q) - b;

      // MATLAB syntax: if (substrate_ineq(1:end-1) * Q <= substrate_ineq(end))
      if (dist_bonus <= 0)
        is_manure_bonus = true;
      else
        is_manure_bonus = false;
      
      //

      return is_manure_bonus;
    }

    /// <summary>
    /// Check whether given substrate feed Q qualifies for the manure bonus
    /// </summary>
    /// <param name="mySubstrates"></param>
    /// <param name="Q">substrate feed on plant in m³/d</param>
    /// <returns></returns>
    public static bool check_manurebonus(biogas.substrates mySubstrates, double[] Q)
    {
      double[] A;
      double b, dist_bonus;

      return check_manurebonus(mySubstrates, Q, out A, out b, out dist_bonus);
    }



    /// <summary>
    /// Calculates verguetung for the given plant using EEG 2009
    /// in €/kWh
    /// </summary>
    /// <param name="myPlant"></param>
    /// <param name="Pel">
    /// current electrical power measured in kW
    /// es sollte eigentlich die im Jahresmittel eingespeiste Leistung sein,
    /// bei Annahme, dass Anlage das ganze Jahr mit dieser aktuellen Leistung
    /// durchfährt, dann stimmt die Rechnung
    /// </param>
    /// <param name="manure_b">
    /// true, then substrate feed satisfies manure bonus
    /// else false</param>
    /// <returns>renumeration in €/kWh</returns>
    override public double getVerguetung(biogas.plant myPlant, double Pel, bool manure_b)
    {
      // call getVerguetung
      // die Boni hängen nicht von der max. Leistung ab (bzw. Nennleistung)
      // sondern von der tatschlich im Jahr produzierten Leistung, im EEG 2012
      // Bemessungsleistung genannt
      //physValue maxPel= myPlant.getMaxElPower();
      // TODO man könnte Pel noch um einen Faktor verkleinern um Ausfallzeiten oder Zeiten
      // etwas niedriger el. Leistungsproduktion zu berücksichtigen

      int construct_year = myPlant.construct_year;

      // ct/kWh
      double money= getVerguetung(Pel, construct_year, manure_b);

      // divide by 100 to get €/kWh

      return money / 100;
    }


    
    /// <summary>
    /// Read params using the given XML reader, which is reading a xml file
    /// only one is read
    /// </summary>
    /// <param name="reader">an open reader</param>
    override public bool getParamsFromXMLReader(ref XmlTextReader reader)
    {
      string xml_tag = "";
      
      bool[] values = { true, false, false, false, true, false };

      // init physValue objects, such that they are not null
      try
      {
        set_params_of(values);
      }
      catch(exception e)
      {
        Console.WriteLine(e.Message);
        return false;
      }

      bool do_while = true;

      while (reader.Read() && do_while)
      {
        switch (reader.NodeType)
        {

          case System.Xml.XmlNodeType.Element: // this knot is an element
            xml_tag = reader.Name;

            break;

          case System.Xml.XmlNodeType.Text: // text, thus value, of each element

            switch (xml_tag)
            {
              case "nawaro":
                nawaro_b = System.Xml.XmlConvert.ToBoolean(reader.Value);
                break;
              case "kwk":
                kwk_b = System.Xml.XmlConvert.ToBoolean(reader.Value);
                break;
              case "innovation":
                innovation_b = System.Xml.XmlConvert.ToBoolean(reader.Value);
                break;
              case "immission":
                immission_b = System.Xml.XmlConvert.ToBoolean(reader.Value);
                break;
              case "manure":
                manure_b = System.Xml.XmlConvert.ToBoolean(reader.Value);
                break;
              case "landschaft":
                landschaft_b = System.Xml.XmlConvert.ToBoolean(reader.Value);
                break;
            }

            break;

          case System.Xml.XmlNodeType.EndElement:
            if (reader.Name == "EEG2009")
              do_while = false;

            break;
        }
      }

      return true;
    }

    /// <summary>
    /// get params as xml string
    /// </summary>
    /// <returns></returns>
    override public string getParamsAsXMLString()
    {
      StringBuilder sb = new StringBuilder();

      sb.Append("<EEG2009>\n");

      sb.Append(xmlInterface.setXMLTag("nawaro", nawaro_b));
      sb.Append(xmlInterface.setXMLTag("kwk", kwk_b));
      sb.Append(xmlInterface.setXMLTag("innovation", innovation_b));
      sb.Append(xmlInterface.setXMLTag("immission", immission_b));
      sb.Append(xmlInterface.setXMLTag("manure", manure_b));
      sb.Append(xmlInterface.setXMLTag("landschaft", landschaft_b));
      
      sb.Append("</EEG2009>\n");

      return sb.ToString();
    }

    /// <summary>
    /// print to console
    /// </summary>
    /// <returns></returns>
    override public string print()
    {
      StringBuilder sb = new StringBuilder();

      sb.Append("   ----------   EEG 2009   ----------   \r\n");

      // TODO
      // getVerguetung - wird schwer, da plant hier nicht bekannt ist

      sb.Append("nawaro= " + nawaro_b + " \t\t\t");
      sb.Append("kwk= " + kwk_b + " \t\t\t");
      sb.Append("innovation= " + innovation_b + " \n");
      sb.Append("immission= " + immission_b + " \t\t\t");
      sb.Append("manure= " + manure_b + " \t\t\t");
      sb.Append("landschaft= " + landschaft_b + " \r\n");
      
      //

      return sb.ToString();
    }



    // -------------------------------------------------------------------------------------
    //                              !!! PRIVATE METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// Liefert die Vergütung für eine Anlage zurück, gemessen in ct./kWh und abhängig
    /// von el. Leistung und Baujahr. geht alle Boni durch welche beantragt sind.
    /// 
    /// da gülle bonus direkt Substratabhängig ist, wird nur dieser Aufruf angeboten
    /// </summary>
    /// <param name="Pel">power of plant in kW</param>
    /// <param name="construct_year">construction year, must be >= 2009, otherwise no funding</param>
    /// <param name="manure_b_substrate">Gülle Bonus, wahr wenn substratmix erfüllt den
    /// Güllebonus, sonst false. sowie dieser wert als auch der gespeicherte Wert
    /// manre_b müssen wahr sein (= beantragt), damit es den güllebonus gibt</param>
    /// <returns>renumeration in ct/kWh</returns>
    private double getVerguetung(double Pel, int construct_year, bool manure_b_substrate)
    {
      //int pow_class = getPowerClass(Pel);

      //// no funding because power is too high
      //if (pow_class == -1)
      //  return 0;

      // TODO - ich nehme an, dass auch ältere Anlagen das EEG beantragen können.
      // prüfen welcher Satz dann zu nehmen ist. ich nehme hier einfach den 2009er Satz.
      // Für Altanlagen wird die Grundvergütung bis 150 kW einheitlich auf 11,67 Cent/kWh angehoben, 
      // über 150 kW wird die bisherige Grundvergütung auch zukünftig bezahlt. 
      // s. http://www.ormatic.de/de/eeg2012.html

      if (construct_year < 2009)
      {
        construct_year = 2009;
        // TODO - throw a warning
      }

      // Prozentsatz, welcher von jeder Vergütung abgezogen wird 
      double perc_val= (construct_year - 2009.0f) / 100.0f;
            
      // Grundvergütung nach el. Leistung in ct/kWh
      double verguetung = 0;

      double Pel_rest = Pel;    // noch nicht vergütete Leistung in kW
      double factor = 1.0;

      // Beispiel: Pel= 750 kW
      // grundverguetung: 150/750 * 11.67 ct/kWh + 500/750 * 9.18 ct/kWh + 100/750 * 8.25 ct/kWh
      // Beispiel: Pel= 600 kW
      // grundverguetung: 150/600 * 11.67 ct/kWh + 450/600 * 9.18 ct/kWh
      // Beispiel: Pel= 150 kW
      // grundverguetung: 150/150 * 11.67 ct/kWh


      for (int ischwelle = 0; ischwelle < schwellwerte.Length; ischwelle++)
      {
        if (Pel_rest <= 0)    // verhindert auch, dass durch 0 geteilt wird
          break;

        //try
        //{
        if (Pel_rest > schwellwerte[ischwelle])
        {
          factor = schwellwerte[ischwelle] / Pel;
          Pel_rest -= schwellwerte[ischwelle];
        }
        else
        {
          factor = Pel_rest / Pel;
          Pel_rest = 0;
        }
        //}
        //catch 
        //{
        //  break;
        //}

        //if (Pel_rest == Pel)
        //  throw new exception(String.Format("Pel_rest == Pel: {0}", Pel_rest));

        verguetung += factor * grundverguetung[ischwelle];

        // TODO - hängen wirklich alle Boni von der tatsächlichen Leistung ab
        // und nicht auch einer von der Nennleistung?
        // habe nicht gelesen, dass immissionsbonus anteilig ausgezahl wird, also
        // so wie die anderen. TODO - prüfen ob das so ist. das gleiche gilt für kwk und 
        // innovations/technologiebonus
        
        if (nawaro_b)       // NaWaRO-Bonus
          verguetung += factor * nawaro[ischwelle];
        if (kwk_b)          // KWK-Bonus
          verguetung += factor * kwk[ischwelle];
        if (innovation_b)   // Innovations-/Technologie-Bonus
          verguetung += factor * innovation[ischwelle];
        if (immission_b)    // Ludtreinhaltungs-/Immissions-Bonus
          verguetung += factor * immission[ischwelle];
        if (manure_b && manure_b_substrate && nawaro_b)       // Gülle-Bonus, gekoppelt an NaWaRo Bonus
          verguetung += factor * manure[ischwelle];
        if (landschaft_b && nawaro_b)   // Landschaftspflege-Bonus, gekoppelt an NaWaRo Bonus
          verguetung += factor * landschaft[ischwelle];
      }

      // aus Leitfaden Biogas, 2010, S. 150
      // zahlen der vergütung werden zuerst addiert und dann erst mit der 1% jährlichen
      // degression verrechnet, dann auf 2 NKS runden
      verguetung *= (1.0f - perc_val);

      verguetung = Math.Round(verguetung, 2);

      return verguetung;
    }

    ///// <summary>
    ///// Returns the class to which the given biogas plant's electrical power belongs
    ///// </summary>
    ///// <param name="Pel">power of plant in kW</param>
    ///// <returns>
    ///// 0: until 150 kW
    ///// 1: until 500 kW
    ///// 2: until 5 MW
    ///// 3: until 20 MW
    ///// </returns>
    //private int getPowerClass(double Pel)
    //{
    //  if (Pel <= 150)
    //    return 0;
    //  if (Pel <= 500)
    //    return 1;
    //  if (Pel <= 5000)
    //    return 2;
    //  if (Pel <= 20000)
    //    return 3;
    //  else
    //    return -1;
    //}

    /// <summary>
    /// set default values
    /// </summary>
    /// <param name="values">6dim vector</param>
    /// <exception cref="exception">values.Length != 6</exception>
    private void set_params_of(params bool[] values)
    {
      if (values.Length != 6)
        throw new exception(String.Format(
              "You may only call this method with 6 parameters and not with {0} parameters!",
              values.Length));

      this.nawaro_b = values[0];
      this.kwk_b= values[1];
      this.innovation_b= values[2];
      this.immission_b= values[3];
      this.manure_b= values[4];
      this.landschaft_b = values[5];
    }



  }
}
