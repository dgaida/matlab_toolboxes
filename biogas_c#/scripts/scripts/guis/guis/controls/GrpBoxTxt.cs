/**
 * This class defines a groupbox containing a text field to specify some value. 
 * 
 * TODOs:
 * - see TODOs, momentan keine
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

using biogas;       // for substrate



namespace matlab_guis
{
  /// <summary>
  /// This class defines a groupbox containing a text field to specify some value. 
  /// 
  /// </summary>
  public partial class GrpBoxTxt : UserControl
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
    public GrpBoxTxt()
    {
      InitializeComponent();
    }

    /// <summary>
    /// Standard constructor initializing the groupbox
    /// with default width and height and an empty helptext
    /// </summary>
    /// <param name="parentFrame">gui this GroupBox exists in</param>
    /// <param name="mySubstrate">substrate object which is represented by this grpboxtxt</param>
    /// <param name="param">substrate parameter which is represented by this grpboxtxt</param>
    /// <param name="mydelegate">function that is called when txtbox looses focus. can
    /// check the value on validity</param>
    /// <param name="xPos">x-coordinate of position of GroupBox</param>
    /// <param name="yPos">y-coordinate of position of GroupBox</param>
    /// <param name="id_unit">id + unit of physValue</param>
    /// <param name="label">label of physValue, is the title of the GroupBox</param>
    public GrpBoxTxt(gui_substrate parentFrame, substrate mySubstrate, String param,
                     LeaveDelegate mydelegate, int xPos, int yPos,
                     String id_unit, String label)
      : this(parentFrame, mySubstrate, param, mydelegate, xPos, yPos, id_unit, label, "")
    {
    }

    /// <summary>
    /// Standard constructor initializing the groupbox
    /// with default width and height
    /// </summary>
    /// <param name="parentFrame">gui this GroupBox exists in</param>
    /// <param name="mySubstrate">substrate object which is represented by this grpboxtxt</param>
    /// <param name="param">substrate parameter which is represented by this grpboxtxt</param>
    /// <param name="mydelegate">function that is called when txtbox looses focus. can
    /// check the value on validity</param>
    /// <param name="xPos">x-coordinate of position of GroupBox</param>
    /// <param name="yPos">y-coordinate of position of GroupBox</param>
    /// <param name="id_unit">id + unit of physValue</param>
    /// <param name="label">label of physValue, is the title of the GroupBox</param>
    /// <param name="helpText">text visualized as help while txtbox has focus</param>
    public GrpBoxTxt(gui_substrate parentFrame, substrate mySubstrate, String param,
                     LeaveDelegate mydelegate, int xPos, int yPos,
                     String id_unit, String label, String helpText)
      : this(parentFrame, mySubstrate, param, mydelegate, xPos, yPos, id_unit, label, helpText, 120)
    {
    }

    /// <summary>
    /// Standard constructor initializing the groupbox
    /// with default height
    /// </summary>
    /// <param name="parentFrame">gui this GroupBox exists in</param>
    /// <param name="mySubstrate">substrate object which is represented by this grpboxtxt</param>
    /// <param name="param">substrate parameter which is represented by this grpboxtxt</param>
    /// <param name="mydelegate">function that is called when txtbox looses focus. can
    /// check the value on validity</param>
    /// <param name="xPos">x-coordinate of position of GroupBox</param>
    /// <param name="yPos">y-coordinate of position of GroupBox</param>
    /// <param name="id_unit">id + unit of physValue</param>
    /// <param name="label">label of physValue, is the title of the GroupBox</param>
    /// <param name="helpText">text visualized as help while txtbox has focus</param>
    /// <param name="width">width of the GroupBox</param>
    public GrpBoxTxt(gui_substrate parentFrame, substrate mySubstrate, String param,
                     LeaveDelegate mydelegate, int xPos, int yPos,
                     String id_unit, String label, String helpText, int width)
      : this(parentFrame, mySubstrate, param, mydelegate, xPos, yPos, id_unit, label, helpText, width, 45)
    {
    }
        
    /// <summary>
    /// Standard constructor initializing the groupbox
    /// </summary>
    /// <param name="parentFrame">gui this GroupBox exists in</param>
    /// <param name="mySubstrate">substrate object which is represented by this grpboxtxt</param>
    /// <param name="param">substrate parameter which is represented by this grpboxtxt</param>
    /// <param name="mydelegate">function that is called when txtbox looses focus. can
    /// check the value on validity</param>
    /// <param name="xPos">x-coordinate of position of GroupBox</param>
    /// <param name="yPos">y-coordinate of position of GroupBox</param>
    /// <param name="id_unit">id + unit of physValue</param>
    /// <param name="label">label of physValue, is the title of the GroupBox</param>
    /// <param name="helpText">text visualized as help while txtbox has focus</param>
    /// <param name="width">width of the GroupBox</param>
    /// <param name="height">height of the GroupBox</param>
    public GrpBoxTxt(gui_substrate parentFrame, substrate mySubstrate, String param, 
                     LeaveDelegate mydelegate, int xPos, int yPos,
                     String id_unit, String label, String helpText, int width, int height)
      : this()
    {
      // save parameters in local fields

      this.mySubstrate = mySubstrate;
      this.param = param;
      this.mydelegate = mydelegate;
      this.helpText = helpText;
      parent = parentFrame;


      // get to be displayed param from substrate
      
      String value = mySubstrate.get_param_of_s(param);

      //

      ToolTip tt = new ToolTip();

      // set attributes of this GrpBoxTxt

      Bounds = new Rectangle(new Point(xPos, yPos), new Size(width, height));
      
      // set attributes of groupbox

      grpBox.Bounds = new Rectangle(new Point(0, 0), new Size(width, height));
      grpBox.Text = id_unit + ":";

      tt.SetToolTip(grpBox, label);

      // set attributes of txtBox

      txtValue.Bounds = new Rectangle(new Point(6, 19), 
                                      new Size(width - 6 - 6, height - 19 - 6));
      txtValue.Text = value;

      tt.SetToolTip(txtValue, label);
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

      txtValue.Text = mySubstrate.get_param_of_s(param);
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
      double myvalue = 0;

      try
      {
        myvalue = System.Xml.XmlConvert.ToDouble(getValue());
      }
      catch
      {
        MessageBox.Show("Kann Wert von " + param + ": " + getValue() + " nicht in double konvertieren!", 
          "Fehler in Textfeld!", MessageBoxButtons.OK, MessageBoxIcon.Error);
      }

      return myvalue;
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
      // bspw. muss eingegebene ID auf eindeutigkeit und gültigkeit überprüft werden
      // bei änderung des namen muss lstSubstrates aktualisiert werden, zumindest der 
      // entsprechende eintrag

      // check if param is valid, numeric, or if id valid...

      if (mydelegate(txtValue.Text, param))
      {
        // save value in substrate

        mySubstrate.set_params_of(param, getValue());
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
