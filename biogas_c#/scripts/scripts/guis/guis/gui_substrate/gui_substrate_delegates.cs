/**
 * This file defines delegate methods for the gui gui_substrate.
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

using guis.Resources;     // ressources file
using System.Text.RegularExpressions; 



namespace matlab_guis
{
  /// <summary>
  /// Declare delegate -- defines required signature:
  /// is called in leave callback of a textbox, needed for GrpBoxTxt and Phys
  /// </summary>
  /// <param name="value">e.g. the value of a textbox</param>
  /// <param name="param">an id or symbol describing the value</param>
  /// <returns>true on success, else false</returns>
  public delegate bool LeaveDelegate(String value, String param);



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
    /// LeaveDelegate delegate method for inserted name
    /// changes the visualized name in the lstSubstrate accordingly
    /// </summary>
    /// <param name="value">the name</param>
    /// <param name="param">name, not used here</param>
    /// <returns>true on success, if name is empty, then false</returns>
    bool del_grpName(String value, String param)
    {
      // list index callback must return immediately
      call_event = false;

      if (value.Length == 0)
      {
        MessageBox.Show("Substrate name may not be empty!", "Substrate name error",
                      MessageBoxButtons.OK, MessageBoxIcon.Error);

        return false;
      }

      // is inserted before the selected item
      lstSubstrates.Items.Insert(lstSubstrates.SelectedIndex, value);

      // select the newly inserted item
      lstSubstrates.SelectedIndex = lstSubstrates.SelectedIndex - 1;

      // delete the old item below the new one
      lstSubstrates.Items.RemoveAt(lstSubstrates.SelectedIndex + 1);

      // enable callback for index changed again
      call_event = true;

      return true;
    }

    /// <summary>
    /// LeaveDelegate delegate method for inserted id
    /// checks whether the id is unique and whether it is alphanumeric
    /// </summary>
    /// <param name="value">the id</param>
    /// <param name="param">id</param>
    /// <returns>true if id is valid, else false</returns>
    bool del_grpID(String value, String param)
    {
      // may not be empty

      if (value.Length == 0)
      {
        MessageBox.Show("Substrate id may not be empty!", "Substrate id error",
                      MessageBoxButtons.OK, MessageBoxIcon.Error);

        return false;
      }

      // must be unique and may not contain special characters
      
      int s_index = 0;

      foreach (String id in mySubstrates.ids)
      {
        if ((id == value) && (s_index != lstSubstrates.SelectedIndex))
        {
          MessageBox.Show(String.Format("ID: {0} is not unique!", value), "ID error",
                      MessageBoxButtons.OK, MessageBoxIcon.Error);

          return false;
        }

        s_index++;
      }

      // ^ symbol is used for Specifying not condition
      Regex objAlphaNumericPattern = new Regex("[^a-z0-9_]");

      bool success = !objAlphaNumericPattern.IsMatch(value);

      if (!success)
      {
        MessageBox.Show(String.Format("ID: {0} may only be lowercase alphanumeric and may contain a '_'!",
          value), "ID error", MessageBoxButtons.OK, MessageBoxIcon.Error);
      }

      return success;
    }
    


  }
}


