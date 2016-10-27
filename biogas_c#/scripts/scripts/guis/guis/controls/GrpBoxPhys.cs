/**
 * This class defines a groupbox containing a text field and a combobox 
 * to specify some value and its unit. designed for a physValue
 * 
 * TODOs:
 * - see TODOs below
 * - bisher kann nur eine einheit angegeben werden
 * - überprüfung der einheit erfolgt noch nicht
 * 
 * Except for the TODOs FINISHED!
 * 
 */

using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Drawing;
using System.Data;
using System.Linq;
using System.Text;
using System.Windows.Forms;

using science;      // for physValue
using biogas;       // for substrate



namespace matlab_guis
{
  /// <summary>
  /// This class defines a groupbox containing a text field and a combobox 
  /// to specify some value and its unit. designed for a physValue
  /// 
  /// </summary>
  public partial class GrpBoxPhys : UserControl
  {
    // -------------------------------------------------------------------------------------
    //                            !!! PUBLIC METHODS !!!
    // -------------------------------------------------------------------------------------

    // -------------------------------------------------------------------------------------
    //                            !!! CONSTRUCTOR METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// Standard Constructor creating the control
    /// </summary>
    public GrpBoxPhys()
    {
      InitializeComponent();
    }

    /// <summary>
    /// Standard constructor initializing the groupbox
    /// </summary>
    /// <param name="parentFrame">gui this GroupBox exists in</param>
    /// <param name="mySubstrate">substrate object which is represented by this grpboxtxt</param>
    /// <param name="param">substrate parameter which is represented by this grpboxtxt, 
    /// must be referring to a physValue</param>
    /// <param name="xPos">x-coordinate of position of GroupBox</param>
    /// <param name="yPos">y-coordinate of position of GroupBox</param>
    public GrpBoxPhys(gui_substrate parentFrame, substrate mySubstrate, String param,
                      int xPos, int yPos)
      : this(parentFrame, mySubstrate, param, checkIfDouble, xPos, yPos, "")
    {
    }

    /// <summary>
    /// Standard constructor initializing the groupbox
    /// </summary>
    /// <param name="parentFrame">gui this GroupBox exists in</param>
    /// <param name="mySubstrate">substrate object which is represented by this grpboxtxt</param>
    /// <param name="param">substrate parameter which is represented by this grpboxtxt, 
    /// must be referring to a physValue</param>
    /// <param name="mydelegate">function that is called when txtbox looses focus. can
    /// check the value on validity</param>
    /// <param name="xPos">x-coordinate of position of GroupBox</param>
    /// <param name="yPos">y-coordinate of position of GroupBox</param>
    public GrpBoxPhys(gui_substrate parentFrame, substrate mySubstrate, String param,
                      LeaveDelegate mydelegate, int xPos, int yPos)
      : this(parentFrame, mySubstrate, param, mydelegate, xPos, yPos, "")
    {
    }

    /// <summary>
    /// Standard constructor initializing the groupbox
    /// </summary>
    /// <param name="parentFrame">gui this GroupBox exists in</param>
    /// <param name="mySubstrate">substrate object which is represented by this grpboxtxt</param>
    /// <param name="param">substrate parameter which is represented by this grpboxtxt, 
    /// must be referring to a physValue</param>
    /// <param name="mydelegate">function that is called when txtbox looses focus. can
    /// check the value on validity</param>
    /// <param name="xPos">x-coordinate of position of GroupBox</param>
    /// <param name="yPos">y-coordinate of position of GroupBox</param>
    /// <param name="helpText">text visualized as help while txtbox has focus</param>
    public GrpBoxPhys(gui_substrate parentFrame, substrate mySubstrate, String param,
                      LeaveDelegate mydelegate, int xPos, int yPos, String helpText)
      : this(parentFrame, mySubstrate, param, mydelegate, xPos, yPos, helpText, 120)
    {
    }

    /// <summary>
    /// Standard constructor initializing the groupbox
    /// </summary>
    /// <param name="parentFrame">gui this GroupBox exists in</param>
    /// <param name="mySubstrate">substrate object which is represented by this grpboxtxt</param>
    /// <param name="param">substrate parameter which is represented by this grpboxtxt, 
    /// must be referring to a physValue</param>
    /// <param name="mydelegate">function that is called when txtbox looses focus. can
    /// check the value on validity</param>
    /// <param name="xPos">x-coordinate of position of GroupBox</param>
    /// <param name="yPos">y-coordinate of position of GroupBox</param>
    /// <param name="helpText">text visualized as help while txtbox has focus</param>
    /// <param name="width">width of the GroupBox</param>
    public GrpBoxPhys(gui_substrate parentFrame, substrate mySubstrate, String param,
                      LeaveDelegate mydelegate, int xPos, int yPos, String helpText, int width)
      : this(parentFrame, mySubstrate, param, mydelegate, xPos, yPos, helpText, width, 45)
    {
    }

    /// <summary>
    /// Standard constructor initializing the groupbox
    /// </summary>
    /// <param name="parentFrame">gui this GroupBox exists in</param>
    /// <param name="mySubstrate">substrate object which is represented by this grpboxtxt</param>
    /// <param name="param">substrate parameter which is represented by this grpboxtxt, 
    /// must be referring to a physValue</param>
    /// <param name="mydelegate">function that is called when txtbox looses focus. can
    /// check the value on validity</param>
    /// <param name="xPos">x-coordinate of position of GroupBox</param>
    /// <param name="yPos">y-coordinate of position of GroupBox</param>
    /// <param name="helpText">text visualized as help while txtbox has focus</param>
    /// <param name="width">width of the GroupBox</param>
    /// <param name="height">height of the GroupBox</param>
    public GrpBoxPhys(gui_substrate parentFrame, substrate mySubstrate, String param,
                      LeaveDelegate mydelegate, int xPos, int yPos, String helpText, int width, int height)
      : this()
    {
      // save parameters in local fields

      this.mySubstrate = mySubstrate;
      this.param = param;
      this.mydelegate = mydelegate;
      this.helpText = helpText;
      parent = parentFrame;

      // get to be displayed param from substrate

      physValue myValue = mySubstrate.get_params_of(param);

      //
      
      ToolTip tt = new ToolTip();

      // set attributes of this GrpBoxTxt

      Bounds = new Rectangle(new Point(xPos, yPos), new Size(width, height));
      
      // set attributes of groupbox

      grpBox.Bounds = new Rectangle(new Point(0, 0), new Size(width, height));
      grpBox.Text = myValue.Symbol + ":";

      tt.SetToolTip(grpBox, myValue.Label);

      // set attributes of textbox

      int cmb_width = 60;   // width of combobox

      txtValue.Bounds = new Rectangle(new Point(6, 19),
                                      new Size(width - 4 - cmb_width - 6 - 6, height - 19 - 6));
      txtValue.Text = System.Xml.XmlConvert.ToString(myValue.Value);

      tt.SetToolTip(txtValue, myValue.Label);

      // set attributes of ComboBox for unit

      cmbUnit.Bounds = new Rectangle(new Point(width - cmb_width - 6, 18),
                                     new Size(cmb_width, height - 18 - 6));
      
      // TODO, hier sollte eine Liste eigefügt werden, welche dem Konstruktur
      // übergeben wird
      cmbUnit.Items.Add(myValue.Unit);

      cmbUnit.SelectedItem = myValue.Unit;

      tt.SetToolTip(cmbUnit, "unit");
    }



    // -------------------------------------------------------------------------------------
    //                            !!! PUBLIC METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// Set value of txtValue txtbox to param of mySubstrate
    /// </summary>
    /// <param name="mySubstrate">new substrate</param>
    public void setSubstrate(substrate mySubstrate)
    {
      this.mySubstrate = mySubstrate;

      physValue myValue= mySubstrate.get_params_of(param);

      txtValue.Text = System.Xml.XmlConvert.ToString(myValue.Value);
      cmbUnit.SelectedItem = myValue.Unit;
    }

    /// <summary>
    /// get value of txtValue txtbox
    /// </summary>
    /// <returns>Text property of txtbox txtValue</returns>
    public String getValue()
    {
      return txtValue.Text;
    }

    /// <summary>
    /// get value of txtValue txtbox
    /// </summary>
    /// <returns>Text property of txtbox txtValue as double</returns>
    public double getValueD()
    {
      double myvalue;

      getValueD(out myvalue);

      return myvalue;
    }

    /// <summary>
    /// get value of txtValue txtbox
    /// </summary>
    /// <param name="myvalue">Text property of txtbox txtValue as double</param>
    /// <returns>true if txtvalue could be converted to double, else false</returns>
    public bool getValueD(out double myvalue)
    {
      return checkIfDouble(txtValue.Text, param, out myvalue); 
    }

    /// <summary>
    /// tests if given String can be converted to double. if not a messagebox is displayed
    /// </summary>
    /// <param name="myValue">some string, should be a numeric</param>
    /// <param name="param">symbol of the parameter</param>
    /// <returns>true if txtvalue could be converted to double, else false</returns>
    public static bool checkIfDouble(String myValue, String param)
    {
      double myvalue;

      return checkIfDouble(myValue, param, out myvalue);
    }

    /// <summary>
    /// tests if given String can be converted to double. if not a messagebox is displayed
    /// </summary>
    /// <param name="myValue">some string, should be a numeric</param>
    /// <param name="param">symbol of the parameter</param>
    /// <param name="myvalue">returned double value, on error = 0</param>
    /// <returns>true if txtvalue could be converted to double, else false</returns>
    public static bool checkIfDouble(String myValue, String param, out double myvalue)
    {
      myvalue = 0;

      if (myValue.Length == 0)
      {
        MessageBox.Show(String.Format("Parameter {0} is empty! Will be replaced by 0.", param), 
          "Empty parameter", MessageBoxButtons.OK, MessageBoxIcon.Warning);
      }

      try
      {
        myvalue = System.Xml.XmlConvert.ToDouble(myValue);

        return true;
      }
      catch
      {
        MessageBox.Show("Kann Wert von " + param + ": " + myValue + " nicht in double konvertieren!",
          "Fehler in Textfeld!", MessageBoxButtons.OK, MessageBoxIcon.Error);

        return false;
      }
    }
    
    

    // -------------------------------------------------------------------------------------
    //                            !!! PROTECTED METHODS !!!
    // -------------------------------------------------------------------------------------



    // -------------------------------------------------------------------------------------
    //                            !!! PRIVATE METHODS !!!
    // -------------------------------------------------------------------------------------

    /*====================         CALLBACKS         ====================*/

    /*====================         Changed CALLBACKS         ====================*/

    /// <summary>
    /// Changed Callback of txtValue
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    private void txtValue_TextChanged(object sender, EventArgs e)
    {
      parent.substrateModified(true);
    }

    /// <summary>
    /// Changed Callback of cmbUnit
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    private void cmbUnit_SelectedIndexChanged(object sender, EventArgs e)
    {
      parent.substrateModified(true);
    }

    /*====================         Enter CALLBACKS         ====================*/

    /// <summary>
    /// is called when txtbox gets focus
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    private void txtValue_Enter(object sender, EventArgs e)
    {
      parent.setHelpText(helpText);
    }

    /*====================         Leave CALLBACKS         ====================*/

    /// <summary>
    /// is called when txtbox looses focus
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    private void txtValue_Leave(object sender, EventArgs e)
    {
      // check if param is valid, numeric ...

      if (mydelegate(txtValue.Text, param))
      {
        // save value in substrate
        // TODO - ganz wichtig!!!!!!!!!!!!!!
        // Einheit überprüfen, wenn diese veränderbar wird
        // diese muss mit einheit übereinstimmen mit der physValue in substrate
        // abgespeichert wird
        mySubstrate.set_params_of(param, getValueD());
      }
      else
      {
        // do nothing
      }

      //

      parent.setHelpTextToDefault();
    }



    // -------------------------------------------------------------------------------------
    //                            !!! PRIVATE FIELDS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// Needed to get access to other controls on the gui
    /// </summary>
    private gui_substrate parent;

    /// <summary>
    /// the substrate object whose param is visualized by this grpBox
    /// </summary>
    private substrate mySubstrate;

    /// <summary>
    /// parameter of substrate which is visualized by this grpBox
    /// must be referring to a physValue
    /// </summary>
    private String param;

    /// <summary>
    /// text, which is displayed as help, while txtbox has focus
    /// </summary>
    private String helpText;

    /// <summary>
    /// method, which is called when txtbox looses focus
    /// </summary>
    private LeaveDelegate mydelegate;



  }


}
