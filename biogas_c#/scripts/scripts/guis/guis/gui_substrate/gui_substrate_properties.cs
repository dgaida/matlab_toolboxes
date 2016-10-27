/**
 * This file defines properties and fields of the gui gui_substrate.
 * 
 * TODOs:
 * - maybe add further fields or properties
 * - 
 * 
 * Except for the TODOs FINISHED!
 * 
 */

using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

using biogas;   // for substrates
using science;  // for physValue



namespace matlab_guis
{
  /// <summary>
  /// gui to define substrate parameters and sve them
  /// in substrate_...xml
  /// for more information see biogas.substrates
  /// </summary>
  public partial class gui_substrate : Form
  {
    
    // -------------------------------------------------------------------------------------
    //                           !!! PRIVATE FIELDS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// If no item has a focus, then this text is shown in the Label lblHelp
    /// </summary>
    static private String helpText = "Klicken Sie in ein Textfeld um hier Hilfe für das Feld zu erhalten.";


    /// <summary>
    /// substrates object
    /// </summary>
    private substrates mySubstrates;


    //

    private GrpBoxTxt grpName;
    private GrpBoxTxt grpID;
    private GrpBoxPhys grpCost;

    private GrpBoxPhys grpTS;
    private GrpBoxPhys grpVS;
    private GrpBoxPhys grpD_VS;

    private GrpBoxPhys grpRP;
    private GrpBoxPhys grpRL;
    private GrpBoxPhys grpNDF;
    private GrpBoxPhys grpADF;
    private GrpBoxPhys grpADL;

    private GrpBoxPhys grpPH;
    private GrpBoxPhys grpNH4;
    private GrpBoxPhys grpTA;
    private GrpBoxPhys grpT;
    private GrpBoxPhys grpCSBfil;

    private GrpBoxPhys grpSva;
    private GrpBoxPhys grpSbu;
    private GrpBoxPhys grpSpro;
    private GrpBoxPhys grpSac;
    private GrpBoxPhys grpSI;

    private GrpBoxPhys grpkdis;
    private GrpBoxPhys grpkhydch;
    private GrpBoxPhys grpkhydpr;
    private GrpBoxPhys grpkhydli;

    private GrpBoxPhys grpkmc4;
    private GrpBoxPhys grpkmpro;
    private GrpBoxPhys grpkmac;
    private GrpBoxPhys grpkmh2;


    /// <summary>
    /// index of currently selected substrate
    /// in lstSubstrates_SelectedIndexChanged this is the last selected substrate
    /// because now it has changed
    /// -1 == no substrate selected
    /// </summary>
    private int sel_substrate = -1;

    /// <summary>
    /// only if true the list index changed event does something
    /// if false the event returns immediately
    /// </summary>
    private bool call_event = true;
    


  }
}


