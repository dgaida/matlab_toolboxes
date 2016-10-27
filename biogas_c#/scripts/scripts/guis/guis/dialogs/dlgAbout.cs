/**
 * This file defines an about dialog
 * 
 * TODOs:
 * - 
 * - 
 * 
 * Not FINISHED!
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



namespace matlab_guis.dialogs
{
  /// <summary>
  /// an about dialog
  /// </summary>
  public partial class dlgAbout : Form
  {
    /// <summary>
    /// standard constructor
    /// </summary>
    public dlgAbout()
    {
      InitializeComponent();

      ToolTip tt_lbl_gecoc = new ToolTip();

      tt_lbl_gecoc.SetToolTip(lbl_gecoc, "http://www.gecoc.de/");
    }

    /// <summary>
    /// is called when clicked on the label gecoc
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    private void lbl_gecoc_LinkClicked(object sender, LinkLabelLinkClickedEventArgs e)
    {
      this.Cursor = Cursors.WaitCursor;

      System.Diagnostics.Process.Start("www.gecoc.de");

      // reset cursor
      this.Cursor = Cursors.Default;
    }
  }
}


