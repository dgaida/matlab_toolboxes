/**
 * This file defines the properties of the fitness_params object.
 * 
 * TODOs:
 * - 
 * 
 * FINISHED!
 * 
 */

using System;
using System.Collections.Generic;
using System.Text;

/**
 * namespace for biogas plant optimization
 * 
 * Definition of:
 * - fitness_params
 * - objective function
 * - weights used inside objective function
 * 
 */
namespace biooptim
{
  /// <summary>
  /// definition of fitness parameters used in objective function
  /// </summary>
  public partial class fitness_params
  {

    // -------------------------------------------------------------------------------------
    //                            !!! PRIVATE FIELDS !!!
    // -------------------------------------------------------------------------------------
    
    /// <summary>
    /// minimal pH value inside each digester [-]
    /// </summary>
    private List<double> pH_min = new List<double>();

    /// <summary>
    /// maximal pH value inside each digester [-]
    /// </summary>
    private List<double> pH_max = new List<double>();

    /// <summary>
    /// optimal pH value inside each digester [-]
    /// </summary>
    private List<double> pH_optimum = new List<double>();

    /// <summary>
    /// maximal TS value inside each digester, measured in [% FM]
    /// </summary>
    private List<double> TS_max = new List<double>();

    /// <summary>
    /// minimal FOS/TAC value inside each digester [gHAcEq / gCaCO3]
    /// </summary>
    private List<double> VFA_TAC_min = new List<double>();

    /// <summary>
    /// maximal FOS/TAC value inside each digester [gHAcEq / gCaCO3]
    /// </summary>
    private List<double> VFA_TAC_max = new List<double>();

    /// <summary>
    /// minimal VFA value inside each digester [gHAcEq]
    /// </summary>
    private List<double> VFA_min = new List<double>();

    /// <summary>
    /// maximal VFA value inside each digester [gHAcEq]
    /// </summary>
    private List<double> VFA_max = new List<double>();

    /// <summary>
    /// minimal TAC value inside each digester [gCaCO3]
    /// 
    /// Grenzwerte, welche ich mal auf einer Konferenz (vermutlich VDI Tagung) aufgeschnappt habe
    /// 
    /// TAC &lt; 50 mmol/l              gefährlich
    /// 50 &lt; TAC &lt; 100 mmol/l     gering Warnung
    /// 100 &lt; TAC &lt; 250 mmol/l    OK
    /// </summary>
    private List<double> TAC_min = new List<double>();

    /// <summary>
    /// minimal hydraulic retention time (HRT) for each digester [d]
    /// </summary>
    private List<double> HRT_min = new List<double>();

    /// <summary>
    /// maximal hydraulic retention time (HRT) for each digester [d]
    /// </summary>
    private List<double> HRT_max = new List<double>();

    /// <summary>
    /// maximal organic loading rate for each digester, measured in [kgVS / (m^3 * d)]
    /// </summary>
    private List<double> OLR_max = new List<double>();
        
    /// <summary>
    /// maximum value of ammonium nitrogen in g/l, laut Leitfaden Biogas ist
    /// ab einem Wert von 3.0 bis 3.5 g/l mit einer Hemmwirkung zu rechnen, ab
    /// 3.5 auf jeden fall (S. 26-27).
    /// 
    /// Mir ist allerdings nicht klar, ob ammoniumstickstoff selbst hemmt
    /// oder ob es diese grenze nur gibt, da ammoniak über pH berechnet bei
    /// einem typischen pH wert dann eine konzentration hääte, welche zu einer
    /// hemmung führt. wenn nur ammoniak hemmt, ist NH4 max wert überflüssig
    /// es gibt den ja schon für NH3
    /// 
    /// der Wert wird in der Fitnessfunktion geprüft, da die inhibition
    /// funktionen für NH3 und NH4 die Chemie modellieren, allerdings dieser
    /// Wert hier dem Wunsch des Kunden entspricht keine höhere Konzentration
    /// zu fahren, obwohl es chemisch vielleicht noch keine Probleme macht.
    /// Allerdings entspricht das Modell auch nicht der Wirklichkeit, so dass
    /// es durchaus sinnvoll ist, diese zusätzliche boundary einzuführen
    /// </summary>
    private List<double> Snh4_max = new List<double>();

    /// <summary>
    /// nax. ammonia value inside each digester measured in [g/l]
    /// Hemmung im Bereich von 80 - 250 mg/l NH3 laut Leitfaden Biogas, S. 26
    /// </summary>
    private List<double> Snh3_max = new List<double>();

    /// <summary>
    /// min value of ratio acetic vs. propionic acid
    /// </summary>
    private List<double> AcVsPro_min = new List<double>();



    /// <summary>
    /// substrate feed Feststoffwolf, without manure [% FM]
    /// </summary>
    private double _TS_feed_max = 26;


    /// <summary>
    /// weights used inside fitness function
    /// </summary>
    private weights _myWeights = new weights();


    /// <summary>
    /// min. hydraulic retention time of the complete plant [d]
    /// TODO: not used yet
    /// 
    /// TODO: maybe rename to _SRT_min
    /// sludge retention time: volume of plant / total substrate feed
    /// ist die def. so richtig? müsste nicht auch berücksichtigt werden
    /// was aus der anlage raus geht? ist nicht mehr das was in die anlage
    /// rein geht. 
    /// in zukunft sollte man komplett selbst bestimmen können wie groß
    /// der auslauf aus einem fermenter sein soll
    /// </summary>
    private double _HRT_plant_min = 20;

    /// <summary>
    /// max. hydraulic retention time of the complete plant [d]
    /// TODO: not used yet
    /// </summary>
    private double _HRT_plant_max = 150;

    /// <summary>
    /// max. organic loading rate of the complete plant, measured in [kgVS / (m^3 * d)]
    /// TODO: not used yet
    /// </summary>
    private double _OLR_plant_max = 4;

    /// <summary>
    /// ob Güllebonus nach EEG 2009 möglich ist, wird temporär in dieser 
    /// variable gespeichert. ob man nach eeg 2009 wirklich gülle bonus
    /// erhält, wird in eeg2009 object definiert.
    /// TODO: kann man das auch besser lösen? benötigt man diesen parameter?
    /// 
    /// if true, then substrate feed satisfies restriction of manure bonus
    /// if false, not
    /// </summary>
    private bool _manurebonus = true;

    /// <summary>
    /// fitness function wird hier als string gespeichert, muss
    /// in matlab noch in function handle konvertiert werden
    /// </summary>
    private string _fitness_function= "@fitness_costs";

    /// <summary>
    /// number of objectives
    /// </summary>
    private int _nObjectives = 1;

    // TODO : setpoints???

    /// <summary>
    /// list of setpoints that have to be controlled
    /// </summary>
    private setpoints _mySetpoints= new setpoints();

    //fitness_params.setpoints= [];

    //% fitness_params.setpoints(1).location= 'chp'; % 'digester', 'substrate'
    //% fitness_params.setpoints(1).ref= 'reference_power_%s.mat';
    //% fitness_params.setpoints(1).sim= 'energyProduction_%s';
    //% fitness_params.setpoints(1).operator= @sum;  % @diff

    /// <summary>
    /// zählt in NMPC hoch, in jeder Iter um delta, genutzt in fitness_costs für
    /// setpoint regelung
    /// wird nicht mehr genutzt
    /// </summary>
    //private int _Ndelta = 0;



    // -------------------------------------------------------------------------------------
    //                              !!! PROPERTIES !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// substrate feed Feststoffwolf, without manure [% FM]
    /// TODO - macht der Sinn???
    /// </summary>
    public double TS_feed_max
    {
      get { return _TS_feed_max; }
      set { _TS_feed_max = value; }
    }


    /// <summary>
    /// weights used inside fitness function
    /// </summary>
    public weights myWeights
    {
      get { return _myWeights; }
    }


    /// <summary>
    /// min. hydraulic retention time of the complete plant [d]
    /// TODO: not used yet
    /// </summary>
    public double HRT_plant_min
    {
      get { return _HRT_plant_min; }
    }

    /// <summary>
    /// max. hydraulic retention time of the complete plant [d]
    /// TODO: not used yet
    /// </summary>
    public double HRT_plant_max
    {
      get { return _HRT_plant_max; }
    }

    /// <summary>
    /// max. organic loading rate of the complete plant, measured in [kgVS / (m^3 * d)]
    /// TODO: not used yet
    /// </summary>
    public double OLR_plant_max
    {
      get { return _OLR_plant_max; }
    }
    
    /// <summary>
    /// ob Güllebonus nach EEG 2009 möglich ist, wird temporär in dieser 
    /// variable gespeichert. ob man nach eeg 2009 wirklich gülle bonus
    /// erhält, wird in eeg2009 object definiert.
    /// TODO: kann man das auch besser lösen? benötigt man diesen parameter?
    /// 
    /// in plant.manure wird gespeichert ob güllebonus beantragt wurde
    /// hier wird gespeichert ob aktuelle substratzufuhr güllebonus fähig ist
    /// 
    /// muss auch in datei gespeichert werden, da in fitnessFindOptimalEquilibrium
    /// manurebonus evaluiert wird und in datei gespeichert, wird bei start von
    /// simulation wieder ausgelesen
    /// </summary>
    public bool manurebonus
    {
      get { return _manurebonus; }
      set { _manurebonus = value; }
    }

    /// <summary>
    /// fitness function wird hier als string gespeichert, muss
    /// in matlab noch in function handle konvertiert werden
    /// </summary>
    public string fitness_function
    {
      get { return _fitness_function; }
    }

    /// <summary>
    /// number of objectives
    /// </summary>
    public int nObjectives
    {
      get { return _nObjectives; }
    }

    /// <summary>
    /// list of setpoints that have to be controlled
    /// </summary>
    public setpoints mySetpoints
    {
      get { return _mySetpoints; }
    }



  }
}


