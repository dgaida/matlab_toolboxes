/**
 * This file contains all Callbacks of elements located in the menu 
 * of the gui gui_substrate.
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
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.Xml;

using matlab_guis.dialogs;         // for about dialog

using biogas;   // for substrates
using science;  // for physValue
using System.Threading;       // for language and localization
using System.Globalization;  



namespace matlab_guis
{
  /// <summary>
  /// GUI gui_substrate
  /// </summary>
  public partial class gui_substrate : Form
  {
    // -------------------------------------------------------------------------------------
    //                            !!! PUBLIC METHODS !!!
    // -------------------------------------------------------------------------------------



    // -------------------------------------------------------------------------------------
    //                            !!! PROTECTED METHODS !!!
    // -------------------------------------------------------------------------------------



    // -------------------------------------------------------------------------------------
    //                            !!! PRIVATE METHODS !!!
    // -------------------------------------------------------------------------------------
    
    /*====================         CALLBACKS         ====================*/

    /*====================         Click CALLBACKS         ====================*/

    /*====================         File Menu         ====================*/

    /// <summary>
    /// Make new configuration, click Callback of New menu
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    private void menuNew_Click(object sender, EventArgs e)
    {
      newFile();
    }

    /// <summary>
    /// Click callback of open menu
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    private void menuOpen_Click(object sender, EventArgs e)
    {
      openFile();
    }

    private bool old_modified= false;
    private String old_curFile= "";

    /// <summary>
    /// Click Callback of save menu
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    private void menuSave_Click(object sender, EventArgs e)
    {
      saveFileWithBackup();
    }

    /// <summary>
    /// Click Callback of save as menu
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    private void menuSaveAs_Click(object sender, EventArgs e)
    {
      old_modified = substrateIsModified;    // used to reset, if saving failed
      old_curFile = curFileName;

      saveFileAs();
    }
        
    /// <summary>
    /// Click Callback of Quit menu
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    private void menuQuit_Click(object sender, EventArgs e)
    {
      if (maybeSave())
        System.Windows.Forms.Application.Exit();
    }


    /*====================         Help Menu         ====================*/

    ///// <summary>
    ///// Click Callback of menu Handbuch
    ///// </summary>
    ///// <param name="sender"></param>
    ///// <param name="e"></param>
    //private void menuHandbuch_Click(object sender, EventArgs e)
    //{
    //  // open pdf document 'Bedienungsanleitung.pdf'
    //  // is in the path of the application

    //  System.Diagnostics.Process.Start(@"Bedienungsanleitung.pdf");
    //}
    
    /// <summary>
    /// Click Callback of menu Info/About
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    private void menuInfo_Click(object sender, EventArgs e)
    {
      dlgAbout myDialog = new dlgAbout();

      myDialog.ShowDialog();
    }

    

  }
}


