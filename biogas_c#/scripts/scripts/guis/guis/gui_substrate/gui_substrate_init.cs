/**
 * This file defines init methods of the gui gui_substrate.
 * 
 * TODOs:
 * - 
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

using guis.Resources;
using System.Text.RegularExpressions; // ressources file



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
    //                            !!! PRIVATE METHODS !!!
    // -------------------------------------------------------------------------------------
    
    /// <summary>
    /// init gui with substrate fields
    /// 
    /// creates the gui txtbox objects
    /// </summary>
    /// <param name="mySubstrates">list of substrates</param>
    /// <returns>true on success, else false</returns>
    private bool init_gui_with_substrate(substrates mySubstrates)
    { 
      // fill list

      if (mySubstrates.Count == 0)
      {
        MessageBox.Show("Es ist kein Substrat in der Liste!", "Substratliste ist leer!",
                        MessageBoxButtons.OK, MessageBoxIcon.Error);

        return false;
      }

      lstSubstrates.Items.Clear();

      foreach (substrate mySub in mySubstrates)
      {
        lstSubstrates.Items.Add(mySub.name);
      }

      //

      lstSubstrates.SelectedIndex = 0;

      // is also set in selectedIndexChanged event
      sel_substrate = 0;

      // 

      substrate mySubstrate = get_sel_substrate();

      // general parameters

      grpName = new GrpBoxTxt(this, mySubstrate, "name", del_grpName, 6, 19,  
                              strings.substrate_name, strings.substrate_name_tt);
      grpID = new GrpBoxTxt(this, mySubstrate, "id", del_grpID, 132, 19,
                            strings.substrate_id, strings.substrate_id_tt);

      grpCost = new GrpBoxPhys(this, mySubstrate, "cost", 258, 19);

      // weender analysis

      grpRP = new GrpBoxPhys(this, mySubstrate, "RP",    6, 19);
      grpRL = new GrpBoxPhys(this, mySubstrate, "RL",  132, 19);
      grpNDF= new GrpBoxPhys(this, mySubstrate, "NDF", 258, 19);
      grpADF= new GrpBoxPhys(this, mySubstrate, "ADF", 384, 19);
      grpADL= new GrpBoxPhys(this, mySubstrate, "ADL", 510, 19);

      // chemical and physical parameters

      grpTS  = new GrpBoxPhys(this, mySubstrate, "TS",     6, 19);
      grpVS  = new GrpBoxPhys(this, mySubstrate, "VS",   132, 19);
      grpD_VS= new GrpBoxPhys(this, mySubstrate, "D_VS", 258, 19);

      grpPH    = new GrpBoxPhys(this, mySubstrate, "pH",      6, 70);
      grpNH4   = new GrpBoxPhys(this, mySubstrate, "Snh4",  132, 70);
      grpTA    = new GrpBoxPhys(this, mySubstrate, "TAC",   258, 70);
      grpT     = new GrpBoxPhys(this, mySubstrate, "T",     384, 70);
      grpCSBfil= new GrpBoxPhys(this, mySubstrate, "COD_S", 510, 70);

      grpSva = new GrpBoxPhys(this, mySubstrate, "Sva",    6, 121);
      grpSbu = new GrpBoxPhys(this, mySubstrate, "Sbu",  132, 121);
      grpSpro= new GrpBoxPhys(this, mySubstrate, "Spro", 258, 121);
      grpSac = new GrpBoxPhys(this, mySubstrate, "Sac",  384, 121);
      grpSI  = new GrpBoxPhys(this, mySubstrate, "SIin", 510, 121);

      // model parameters

      grpkdis  = new GrpBoxPhys(this, mySubstrate, "kdis",      6, 19);
      grpkhydch= new GrpBoxPhys(this, mySubstrate, "khyd_ch", 132, 19);
      grpkhydpr= new GrpBoxPhys(this, mySubstrate, "khyd_pr", 258, 19);
      grpkhydli= new GrpBoxPhys(this, mySubstrate, "khyd_li", 384, 19);

      grpkmc4 = new GrpBoxPhys(this, mySubstrate, "km_c4",    6, 70);
      grpkmpro= new GrpBoxPhys(this, mySubstrate, "km_pro", 132, 70);
      grpkmac = new GrpBoxPhys(this, mySubstrate, "km_ac",  258, 70);
      grpkmh2 = new GrpBoxPhys(this, mySubstrate, "km_h2",  384, 70);

      //

      cmbSubstrateClass.SelectedItem = mySubstrate.get_param_of_s("substrate_class");

      // add grpboxes to surrounding groupboxes

      grpGeneral.Controls.Add(grpName);
      grpGeneral.Controls.Add(grpID);
      grpGeneral.Controls.Add(grpCost);

      grpWeender.Controls.Add(grpRP);
      grpWeender.Controls.Add(grpRL);
      grpWeender.Controls.Add(grpNDF);
      grpWeender.Controls.Add(grpADF);
      grpWeender.Controls.Add(grpADL);

      grpPhys.Controls.Add(grpTS);
      grpPhys.Controls.Add(grpVS);
      grpPhys.Controls.Add(grpD_VS);

      grpPhys.Controls.Add(grpPH);
      grpPhys.Controls.Add(grpNH4);
      grpPhys.Controls.Add(grpTA);
      grpPhys.Controls.Add(grpT);
      grpPhys.Controls.Add(grpCSBfil);

      grpPhys.Controls.Add(grpSva);
      grpPhys.Controls.Add(grpSbu);
      grpPhys.Controls.Add(grpSpro);
      grpPhys.Controls.Add(grpSac);
      grpPhys.Controls.Add(grpSI);

      grpModel.Controls.Add(grpkdis);
      grpModel.Controls.Add(grpkhydch);
      grpModel.Controls.Add(grpkhydpr);
      grpModel.Controls.Add(grpkhydli);

      grpModel.Controls.Add(grpkmc4);
      grpModel.Controls.Add(grpkmpro);
      grpModel.Controls.Add(grpkmac);
      grpModel.Controls.Add(grpkmh2);


      // enable command buttons

      cmdAdd.Enabled = true;
      cmdDel.Enabled = true;
      cmdPrint.Enabled = true;

      return true;
    }
    
    

  }
}


