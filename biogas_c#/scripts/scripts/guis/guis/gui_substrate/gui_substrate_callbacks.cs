/**
 * This file defines init methods of the gui gui_substrate.
 * 
 * TODOs:
 * - ändern der sprache funktioniert noch nicht
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

using guis.Resources; // ressources file

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
    //                            !!! PRIVATE METHODS !!!
    // -------------------------------------------------------------------------------------

    /*====================         CALLBACKS         ====================*/

    /*====================         Form CALLBACKS         ====================*/

    /// <summary>
    /// Is called when form is closing
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    private void gui_substrate_FormClosing(object sender, FormClosingEventArgs e)
    {
      // if something was changed ask if substrates should be saved
      if (!maybeSave())
        e.Cancel = true;

    }



    /*====================         Changed CALLBACKS         ====================*/

    /// <summary>
    /// index of lstSubstrates changed
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    private void lstSubstrates_SelectedIndexChanged(object sender, EventArgs e)
    {
      if (!call_event)
        return;

      // save whether substrate was modified or not
      bool substrateWasModified= substrateIsModified;

      // here sel_substrate is the previous index

      // this happens before the gui elements are initialized
      // the first selected substrate is selected in the init function and the gui elements
      // are set to the values of the first substrate, so nothing to do here
      // also happens when nothing is selected in the list anymore, happens if the selected
      // item gets deleted
      if (sel_substrate == -1 || lstSubstrates.SelectedIndex == -1)
      { 
        
      }
      else
      {
        change_substrates_inTxtBoxes(get_sel_substrate(), get_substrate(sel_substrate));
      }

      // set old index to new index
      sel_substrate = lstSubstrates.SelectedIndex;

      // reset modified status to previous one
      // when changing substrate, txtbox values are changed and grpboxtxt sets substrate
      // to modified, but it was not modified by user
      substrateModified(substrateWasModified);
    }


    private void radEnglish_CheckedChanged(object sender, EventArgs e)
    {
      if (radEnglish.Checked)
        Thread.CurrentThread.CurrentUICulture = CultureInfo.GetCultureInfo("en-US");
    }

    private void radGerman_CheckedChanged(object sender, EventArgs e)
    {
      if (radGerman.Checked)
        Thread.CurrentThread.CurrentUICulture = CultureInfo.GetCultureInfo("de-DE");
    }

    

    /*====================         Click CALLBACKS         ====================*/

    /// <summary>
    /// add a new substrate to the list
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    private void cmdAdd_Click(object sender, EventArgs e)
    {
      //

      // TODO - optionally show input dialog where you can add id and name
      // http://social.msdn.microsoft.com/Forums/windows/en-US/191ddf61-3ae5-4845-b852-56bb9b77238a/input-message-box-in-c


      //

      substrate mySubstrate = new substrate();

      if (mySubstrates == null)
      {
        mySubstrates = new substrates();
        lstSubstrates.Items.Clear();
      }

      mySubstrates.addSubstrate(mySubstrate);

      lstSubstrates.Items.Add(mySubstrate.name);

      // if no substrate was ever created
      if (grpName == null)
      {
        init_gui_with_substrate(mySubstrates);
      }
        // happens if list was empty, but before there was a substrate
      else if (sel_substrate == -1)
      {
        set_TxtBoxValues_to_substrate(mySubstrate);
      }

      // select the new entry which results in an event
      // if sel_substrate == -1 no event will occur, but correct substrate is 
      // already visualized by call of set_TxtBox... above
      lstSubstrates.SelectedIndex = lstSubstrates.Items.Count - 1;

      // so no need to call this
      // change_substrates_inTxtBoxes(mySubstrate, get_sel_substrate());

      // enable buttons

      cmdDel.Enabled = true;
      cmdPrint.Enabled = true;
    }

    /// <summary>
    /// delete selected substrate
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    private void cmdDel_Click(object sender, EventArgs e)
    {
      // may and can only be called when some substrate is selected

      mySubstrates.deleteSubstrate(lstSubstrates.SelectedIndex + 1);

      int prev_sel = lstSubstrates.SelectedIndex;

      // delete - calls the event index changed
      // will set sel_substrate to -1, but does nothing else
      lstSubstrates.Items.RemoveAt(lstSubstrates.SelectedIndex);

      if (lstSubstrates.Items.Count == 0)
      {
        del_TxtBoxes_fromGUI();

        cmdDel.Enabled = false;
        cmdPrint.Enabled = false;
        sel_substrate = -1;
      }
      else
      {
        // select first element or maybe better the element above
        // will set sel_substrate to this selected index, but does nothing else
        lstSubstrates.SelectedIndex = Math.Max(prev_sel - 1, 0);

        // so show new selected substrat manually
        set_TxtBoxValues_to_substrate(mySubstrates.get(lstSubstrates.SelectedIndex + 1));
      }
    }

    /// <summary>
    /// prints selected substrate parameters to console
    /// only works if exe is called form matlab, dll is not working
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    private void btnPrint_Click(object sender, EventArgs e)
    {
      substrate mySubstrate = get_sel_substrate();

      Console.WriteLine(mySubstrate.print());
    }



  }
}
