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
    //                            !!! PRIVATE METHODS !!!
    // -------------------------------------------------------------------------------------
    
    /// <summary>
    /// make a new config, ask if current config should be saved
    /// </summary>
    /// <returns>true, if config was saved or doesn't have to be saved else false</returns>
    private bool newFile()
    {
      bool beSaved = maybeSave();

      // sonst wurde abbrechen gedrückt, dann nicht initGUI aufrufen
      if (beSaved)
      {
        // init GUI
        initGUI();
      }

      return beSaved;
    }

    /// <summary>
    /// Initializes gui
    /// </summary>
    private void initGUI()
    {
      // init variables

      curFileName = "";

      //

      substrateModified(false);

      // init something

      // set language and culture
      //Thread.CurrentThread.CurrentUICulture = CultureInfo.GetCultureInfo("de-DE");

      //Thread.CurrentThread.CurrentUICulture = CultureInfo.GetCultureInfo("en-US");

      //

      List<String> myClasses = substrate.classes;

      cmbSubstrateClass.Items.Clear();

      foreach (String myClass in myClasses)
      {
        cmbSubstrateClass.Items.Add(myClass);
      }

      cmbSubstrateClass.SelectedIndex = 0;


      // delete all gui elements

      del_TxtBoxes_fromGUI();

      // clear list
      // disable buttons

      lstSubstrates.Items.Clear();

      // reset global variables

      mySubstrates = null;
      sel_substrate = -1;
      call_event = true;
      curFileName = "";

      //

      cmdDel.Enabled = false;
      cmdPrint.Enabled = false;

      lblStatus.Text = "Bereit";

      // init methods change values, so set back to false again
      substrateModified(false);
      
    }

    /// <summary>
    /// Calls openFile with an empty string
    /// </summary>
    /// <returns></returns>
    private bool openFile()
    {
      return openFile("");
    }

    /// <summary>
    /// open a xml file
    /// </summary>
    /// <param name="fileName">opens the given filename, if empty then dlgOpenFile is opened</param>
    /// <returns>true, if config opened successfully, else false</returns>
    private bool openFile(String fileName)
    {
      bool success= false;

	    if ( maybeSave() ) 
	    {
        if (fileName.Length == 0)
        {
          DialogResult result = dlgOpenFile.ShowDialog();

          if (result == DialogResult.OK)
            fileName = dlgOpenFile.FileName;
        }

		    if (!(fileName.Length == 0))
		    {
          // prepare gui, cleaning up
			    newFile();

			    // open substrate
			    success= openSubstrateFile(fileName);

			    if (success)
			    {
				    curFileName= fileName;

            substrateModified(false);
			    }
		    }
	    }

	    return success;
    }

    /// <summary>
    /// Asks if the current configuration should be saved and saves it
    /// </summary>
    /// <returns>true, if config was saved or doesn't have to be saved, else false</returns>
    private bool maybeSave()
    {
      // true, stands for !scene->items().isEmpty(), see enam_membrane_simu
      // this means, that we assume here, that the config should be saved all the time if the 
      // config was modified
	    if( substrateIsModified && ( true || !( curFileName.Length == 0 ) ) )
	    {
		    DialogResult result;

        if(curFileName.Length == 0)
        {
          result= MessageBox.Show("Mindestens eines der Substrate wurde verändert." + Environment.NewLine +
                                  "Möchten Sie die Änderungen speichern?", "Speichern der Substrate Datei", 
                                  MessageBoxButtons.YesNoCancel, 
                                  MessageBoxIcon.Question, MessageBoxDefaultButton.Button1);
        }
        else
        {
          result = MessageBox.Show(String.Format("Mindestens eines der Substrate in {0} wurde verändert.", curFileName) + 
                                  Environment.NewLine +
                                  "Möchten Sie die Änderungen speichern?", "Speichern der Substrate Datei", 
                                  MessageBoxButtons.YesNoCancel, 
                                  MessageBoxIcon.Question, MessageBoxDefaultButton.Button1);
        }

        if (result == DialogResult.Yes)
          // on success, returns true
          return saveFile();
	      else if (result == DialogResult.No)
	      {
          substrateModified(false);

          return true;
	      }  
        else if (result == DialogResult.Cancel)
			    return false;
	    }

	    return true;
    }

    /// <summary>
    /// opens the file for reading
    /// </summary>
    /// <param name="fileName">name of xml file</param>
    /// <returns>true on success, else false</returns>
    private bool openSubstrateFile(String fileName)
    {
      // read config from xml file

      this.Cursor = Cursors.WaitCursor;

      setStatusMessage( String.Format("Laden der Datei {0}", fileName) );

      // create substrate object

      bool success;

      try
      {
        mySubstrates = new biogas.substrates(fileName);

        success = true;
      }
      catch
      {
        MessageBox.Show(String.Format("Kann Datei {0} nicht öffnen!", fileName),
                        "Fehler beim einlesen der Substratdatei", MessageBoxButtons.OK, MessageBoxIcon.Error);

        success = false;
      }

      // read out mySubstrates
      // before this method is called, new is called always, therefore 
      // the gui is empty at this point, correct to call init here

      success= success && init_gui_with_substrate(mySubstrates);

      //

      resetStatusMessage();

      this.Cursor = Cursors.Default;

      return success;
    }

    /// <summary>
    /// Call saveFile, before make a backup of current file and current config
    /// needed when saving the file failes to reset settings
    /// </summary>
    /// <returns>what saveFile() returns</returns>
    private bool saveFileWithBackup()
    {
      old_modified = substrateIsModified;    // used to reset, if saving failed
      old_curFile = curFileName;

      return saveFile();
    }

    /// <summary>
    /// save the config
    /// </summary>
    /// <returns>true on success else false</returns>
    private bool saveFile()
    {
      if ( curFileName.Length == 0 ) 
	    {
        // usually returns true, so substrateIsModified = false
		    substrateIsModified= !saveFileAs();
      } 
	    else 
	    {
        // usually returns true, so substrateIsModified = false
        substrateIsModified= !saveSubstrateFile(curFileName);
      }

      if (!substrateIsModified)
      {
        // TODO
        // maybe do something

      }
      else // saving failed
      {
        // old variables are set in saveFile and saveFileAs
        // because in this method and saveFileAs the filename
        // and the substratemodified state is changed
        
        substrateIsModified = old_modified;
        curFileName = old_curFile;
      }

      substrateModified(substrateIsModified);

	    return !substrateIsModified;
    }

    /// <summary>
    /// Saves configuration inside the xml file fileName
    /// </summary>
    /// <param name="fileName">xml file</param>
    /// <returns>true on success else false</returns>
    private bool saveSubstrateFile(String fileName)
    {
      // save config as xml

      this.Cursor = Cursors.WaitCursor;

      bool success = true;

      setStatusMessage( String.Format("Speichern der Datei {0}", fileName) );
      
      // ich muss sicherstellen, dass das gerade markierte textfeld den fokus verloren
      // hat

      this.Select();

      //

      try
      {
        // save substrate in xml file
        mySubstrates.saveAsXML(fileName);
      }
      catch
      {
        MessageBox.Show(String.Format("Kann die Datei {0} nicht speichern!", fileName), 
          "Fehler beim speichern der Substrate Datei", MessageBoxButtons.OK, MessageBoxIcon.Error);
      }

      resetStatusMessage();

      this.Cursor = Cursors.Default;

      return success;
    }

    /// <summary>
    /// Lets the user choose a file in which the config should be saved.
    /// Returns saveFile, except the case, when selected filename is empty, e.g. 
    /// happens when cancel is pressed
    /// </summary>
    /// <returns>what saveFile returns</returns>
    private bool saveFileAs()
    {
	    DialogResult result = dlgSaveFile.ShowDialog();

      String fileName;

      if (result == DialogResult.OK)
        fileName = dlgSaveFile.FileName;
      else
        fileName= "";

	    if (fileName.Length == 0)
		    return false;
	    else
		    curFileName= fileName;

	    return saveFile();
    }



    // -------------------------------------------------------------------------------------
    //                           !!! PUBLIC PROPERTIES !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// true, if config is modified and not saved yet, else false
    /// </summary>
    public bool isSubstrateModified
    {
      get { return substrateIsModified; }
    }



    // -------------------------------------------------------------------------------------
    //                           !!! PRIVATE FIELDS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// filename of current load substrates
    /// </summary>
    private String curFileName= "";

    /// <summary>
    /// true, if some substrate is modified and not saved yet, else false
    /// </summary>
    private bool substrateIsModified= false;



  }
}


