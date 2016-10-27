/**
 * This file defines the objective object.
 * 
 * TODOs:
 * - 
 * 
 * 
 * inhibition Funktionen kann man auch direkt in fitness Funktion einbauen als
 * 
 * constraint= 1 - IpH        IpH ist eine bsp. inhibition Funktion
 * 
 * Ih2 wäre sehr sinnvoll einzufügen (wasserstoff bei absturz aktiv)
 * 
 * Unterschiede zu den constraints die ich jetzt nutze sind:
 * 
 * - meine constraints sind benutzerdefiniert einstellbar. d.h. es können auch grenzen
 *   eingegeben werden wo biologie noch nicht beeinflusst wird. aber es vom anlagenbetreiber 
 *   so gewünscht wird
 * - schwierig zu sagen ob modellierung der inhibition mit realität f.d. anlage übereinstimmt. 
 *   es liegen keine daten vor.
 * - constraints über inhibition werden dann aktiv wenn auf jeden fall probleme vorhanden sind
 *   (zumindest für eine default anlage). 
 *   wenn andere constraints nicht gesetzt werden, werden diese auf jeden fall aktiv. bspw. als backup oder
 *   default nutzbar
 * - constraints über inhibition sind biochemisch motiviert. skalieren also schon richtig.
 * 
 * 
 * ich könnte das umsetzen aber für phd alles mit 0 gewichten. da ich keine gewichte mehr ändern darf
 * in der experiment phase
 * 
 * 
 * Aus Mail an M.Z., 23.8.2013
 * 
 * 
 * Der Einfluss von Ammoniak auf die Produktivität der Methan produzierenden Bakterien ist im ADM1 enthalten. 
 * Man könnte also sagen, dass man die Ammoniakkonzentration gar nicht in der Fitnessfunktion berücksichtigen 
 * müsste. Aus folgenden Gründen mache ich das trotzdem:
 * 
 * 1)	Bei meinen Randbedingungen kann ich max. gewünschte Ammoniakkonz. vorgeben so wie es vom 
 *    Anlagenbetreiber gewünscht ist. Da Betreiber sicherheitsorientiert denken, wollen die nicht so 
 *    hohe Konzentrationen fahren wie es von der Biologie evtl. möglich wäre. 
 * 2)	ADM1 Modellierung und Parameter für Hemmung durch Ammoniak kann an der großen Anlage nicht durch 
 *    Daten validiert werden, da meist keine entsprechenden Daten vorhanden sind. Man arbeitet dann mit 
 *    Standardparametern, welche für die aktuelle Anlage sehr falsch sein könnten…
 *
 * 
 * 
 * Not FINISHED!
 * 
 */

using System;
using System.Collections.Generic;
using System.Text;
using science;
using toolbox;

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
  /// defines objective function
  /// </summary>
  public partial class objectives
  {

    // -------------------------------------------------------------------------------------
    //                              !!! PRIVATE METHODS !!!
    // -------------------------------------------------------------------------------------

    

  }
}


