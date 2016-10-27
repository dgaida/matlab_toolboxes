/**
 * This file defines the gui gui_substrate.
 * 
 * TODOs:
 * - 
 * - 
 * 
 * http://stackoverflow.com/questions/1142802/how-to-use-localization-in-c-sharp
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
using System.Threading;  
using System.Globalization;  



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
    //                            !!! PUBLIC METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// standard constructor
    /// </summary>
    public gui_substrate()
    {
      InitializeComponent();

      initGUI();
    }



    // -------------------------------------------------------------------------------------
    //                            !!! PUBLIC METHODS !!!
    // -------------------------------------------------------------------------------------
    
    /// <summary>
    /// if substrate is modified (variable substrateIsModified), 
    /// then this method must be called
    /// 
    /// it changes the text of the guis headline
    /// </summary>
    /// <param name="flag">true, if changed, false if unchanged</param>
    public void substrateModified(bool flag)
    {
      substrateIsModified = flag;

      if (substrateIsModified)
      {
        if (curFileName.Length == 0)
          this.Text = "substrate GUI - *";
        else
          this.Text = String.Format("substrate GUI - {0} *", curFileName);
      }
      else
      {
        if (curFileName.Length == 0)
          this.Text = "substrate GUI";
        else
          this.Text = String.Format("substrate GUI - {0}", curFileName);
      }
    }

    /// <summary>
    /// sets lblHelp Text to given text
    /// </summary>
    /// <param name="text">some help text</param>
    public void setHelpText(String text)
    {
      lblHelp.Text = text;
    }

    /// <summary>
    /// sets lblHelp Text to default: helpText
    /// </summary>
    public void setHelpTextToDefault()
    {
      lblHelp.Text = helpText;
    }



    // -------------------------------------------------------------------------------------
    //                            !!! PROTECTED METHODS !!!
    // -------------------------------------------------------------------------------------



    // -------------------------------------------------------------------------------------
    //                            !!! PRIVATE METHODS !!!
    // -------------------------------------------------------------------------------------
    
    /// <summary>
    /// Sets status message to Bereit
    /// </summary>
    private void resetStatusMessage()
    {
      lblStatus.Text = "Bereit";
    }

    /// <summary>
    /// set message of status bar to given text
    /// </summary>
    /// <param name="message">some message</param>
    private void setStatusMessage(String message)
    {
      lblStatus.Text = message;
    }
    
    /// <summary>
    /// get selected substrate out of list of substrates
    /// </summary>
    /// <returns>selected substrate object</returns>
    private substrate get_sel_substrate()
    {
      int index = lstSubstrates.SelectedIndex;

      return get_substrate(index);
    }

    /// <summary>
    /// get substrate out of mySubstrates
    /// </summary>
    /// <param name="index">index of substrate: 0-based</param>
    /// <returns>substrate at given position</returns>
    private substrate get_substrate(int index)
    {
      substrate mySubstrate = new substrate();

      try
      {
        mySubstrate = mySubstrates.get(index + 1);
      }
      catch
      {
        MessageBox.Show(String.Format("Fehler beim Zugriff auf das Substrat {0}!", index),
          "Substrat Zugriffsfehler", MessageBoxButtons.OK, MessageBoxIcon.Error);
      }

      return mySubstrate;
    }

    /// <summary>
    /// set txtbox values to given substrate parameters
    /// </summary>
    /// <param name="mySubstrate">substrate</param>
    private void set_TxtBoxValues_to_substrate(substrate mySubstrate)
    {
      if (grpName == null)
        return;

      grpName.setSubstrate(mySubstrate);
      grpID.setSubstrate(mySubstrate);

      grpCost.setSubstrate(mySubstrate);

      grpRP.setSubstrate(mySubstrate);
      grpRL.setSubstrate(mySubstrate);
      grpNDF.setSubstrate(mySubstrate);
      grpADF.setSubstrate(mySubstrate);
      grpADL.setSubstrate(mySubstrate);

      grpTS.setSubstrate(mySubstrate);
      grpVS.setSubstrate(mySubstrate);
      grpD_VS.setSubstrate(mySubstrate);

      grpPH.setSubstrate(mySubstrate);
      grpNH4.setSubstrate(mySubstrate);
      grpTA.setSubstrate(mySubstrate);
      grpT.setSubstrate(mySubstrate);
      grpCSBfil.setSubstrate(mySubstrate);

      grpSva.setSubstrate(mySubstrate);
      grpSbu.setSubstrate(mySubstrate);
      grpSpro.setSubstrate(mySubstrate);
      grpSac.setSubstrate(mySubstrate);
      grpSI.setSubstrate(mySubstrate);

      grpkdis.setSubstrate(mySubstrate);
      grpkhydch.setSubstrate(mySubstrate);
      grpkhydpr.setSubstrate(mySubstrate);
      grpkhydli.setSubstrate(mySubstrate);

      grpkmc4.setSubstrate(mySubstrate);
      grpkmpro.setSubstrate(mySubstrate);
      grpkmac.setSubstrate(mySubstrate);
      grpkmh2.setSubstrate(mySubstrate);

      cmbSubstrateClass.SelectedItem = mySubstrate.get_param_of_s("substrate_class");
    }

    /// <summary>
    /// deletes all txtboxes from gui and sets them to null
    /// </summary>
    private void del_TxtBoxes_fromGUI()
    {
      if (grpName == null)
        return;

      grpGeneral.Controls.Remove(grpName);
      grpGeneral.Controls.Remove(grpID);
      grpGeneral.Controls.Remove(grpCost);

      grpWeender.Controls.Remove(grpRP);
      grpWeender.Controls.Remove(grpRL);
      grpWeender.Controls.Remove(grpNDF);
      grpWeender.Controls.Remove(grpADF);
      grpWeender.Controls.Remove(grpADL);

      grpPhys.Controls.Remove(grpTS);
      grpPhys.Controls.Remove(grpVS);
      grpPhys.Controls.Remove(grpD_VS);

      grpPhys.Controls.Remove(grpPH);
      grpPhys.Controls.Remove(grpNH4);
      grpPhys.Controls.Remove(grpTA);
      grpPhys.Controls.Remove(grpT);
      grpPhys.Controls.Remove(grpCSBfil);

      grpPhys.Controls.Remove(grpSva);
      grpPhys.Controls.Remove(grpSbu);
      grpPhys.Controls.Remove(grpSpro);
      grpPhys.Controls.Remove(grpSac);
      grpPhys.Controls.Remove(grpSI);

      grpModel.Controls.Remove(grpkdis);
      grpModel.Controls.Remove(grpkhydch);
      grpModel.Controls.Remove(grpkhydpr);
      grpModel.Controls.Remove(grpkhydli);

      grpModel.Controls.Remove(grpkmc4);
      grpModel.Controls.Remove(grpkmpro);
      grpModel.Controls.Remove(grpkmac);
      grpModel.Controls.Remove(grpkmh2);

      grpName = null;
      grpID = null;
      grpCost = null;

      grpRP = null;
      grpRL = null;
      grpNDF = null;
      grpADF = null;
      grpADL = null;

      grpTS = null;
      grpVS = null;
      grpD_VS = null;

      grpPH = null;
      grpNH4 = null;
      grpTA = null;
      grpT = null;
      grpCSBfil = null;

      grpSva = null;
      grpSbu = null;
      grpSpro = null;
      grpSac = null;
      grpSI = null;

      grpkdis = null;
      grpkhydch = null;
      grpkhydpr = null;
      grpkhydli = null;

      grpkmc4 = null;
      grpkmpro = null;
      grpkmac = null;
      grpkmh2 = null;

    }

    /// <summary>
    /// saves values in txt boxes in given substrate object
    /// only saves selected substrate class (EEG 2012), all others
    /// are saved directly after txtboxes are loosing focus, see
    /// grpboxtxt and phys
    /// </summary>
    /// <param name="mySubstrate">this substrate object is changed in this call
    /// </param>
    private void save_TxtBoxValues_in_substrate(substrate mySubstrate)
    {
      if (grpName == null)
        return;

      // wird mySubstrate so wirklich geändert?
      // oder muss ich mySubstrate auch wieder zurück geben?
      // das scheint so zu klappen

      //mySubstrate.set_params_of("name", grpName.getValue());
      //mySubstrate.set_params_of("id", grpID.getValue());

      //mySubstrate.set_params_of("cost", grpCost.getValueD());

      //mySubstrate.set_params_of("RP", grpRP.getValueD());
      //mySubstrate.set_params_of("RL", grpRL.getValueD());
      //mySubstrate.set_params_of("NDF", grpNDF.getValueD());
      //mySubstrate.set_params_of("ADF", grpADF.getValueD()); 
      //mySubstrate.set_params_of("ADL", grpADL.getValueD());

      //mySubstrate.set_params_of("TS", grpTS.getValueD());
      //mySubstrate.set_params_of("VS", grpVS.getValueD());
      //mySubstrate.set_params_of("D_VS", grpD_VS.getValueD());

      //mySubstrate.set_params_of("pH", grpPH.getValueD());
      //mySubstrate.set_params_of("Snh4", grpNH4.getValueD());
      //mySubstrate.set_params_of("TAC", grpTA.getValueD());
      //mySubstrate.set_params_of("T", grpT.getValueD());
      //mySubstrate.set_params_of("COD_S", grpCSBfil.getValueD());

      //mySubstrate.set_params_of("Sva",  grpSva.getValueD());
      //mySubstrate.set_params_of("Sbu",  grpSbu.getValueD());
      //mySubstrate.set_params_of("Spro", grpSpro.getValueD());
      //mySubstrate.set_params_of("Sac",  grpSac.getValueD());
      //mySubstrate.set_params_of("SIin", grpSI.getValueD());

      //mySubstrate.set_params_of("kdis", grpkdis.getValueD());
      //mySubstrate.set_params_of("khyd_ch", grpkhydch.getValueD());
      //mySubstrate.set_params_of("khyd_pr", grpkhydpr.getValueD());
      //mySubstrate.set_params_of("khyd_li", grpkhydli.getValueD());

      //mySubstrate.set_params_of("km_c4", grpkmc4.getValueD());
      //mySubstrate.set_params_of("km_pro", grpkmpro.getValueD());
      //mySubstrate.set_params_of("km_ac", grpkmac.getValueD());
      //mySubstrate.set_params_of("km_h2", grpkmh2.getValueD());

      mySubstrate.set_params_of("substrate_class", cmbSubstrateClass.SelectedItem.ToString());
    }

    /// <summary>
    /// first save current txtbox values in substrateOld
    /// then show values of substrateNew in txtboxes
    /// </summary>
    /// <param name="substrateNew">new substrate, new selected substrate</param>
    /// <param name="substrateOld">old (previously) selected substrate</param>
    private void change_substrates_inTxtBoxes(substrate substrateNew, substrate substrateOld)
    {
      // falls sich was geändert hat, dann felder in aktuell ausgewähltes Substrat speichern
      if (substrateIsModified)
      {
        // save parameters in current substrate object

        // ist dieses Objekt ein Verweis auf das Objekt in der Liste? JA!!!
        // oder muss ich dieses Objekt wieder in die Liste rein schreiben? NEIN!!!
        // scheint so zu funktionieren
        
        save_TxtBoxValues_in_substrate(substrateOld);
      }

      // neues substrat anzeigen
      set_TxtBoxValues_to_substrate(substrateNew);
      
      // enable buttons - usually they are already enabled

      cmdAdd.Enabled = true;
      cmdDel.Enabled = true;
      cmdPrint.Enabled = true;

      // reset flag
      // mach das nicht, da datei ja weiterhin geändert ist, muss also gespeichert werden
      //substrateModified(false);
    }

    
    
  }
}
