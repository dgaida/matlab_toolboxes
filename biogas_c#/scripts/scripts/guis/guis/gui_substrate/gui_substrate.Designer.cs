namespace matlab_guis
{
  partial class gui_substrate
  {
    /// <summary>
    /// Required designer variable.
    /// </summary>
    private System.ComponentModel.IContainer components = null;

    /// <summary>
    /// Clean up any resources being used.
    /// </summary>
    /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
    protected override void Dispose(bool disposing)
    {
      if (disposing && (components != null))
      {
        components.Dispose();
      }
      base.Dispose(disposing);
    }

    #region Windows Form Designer generated code

    /// <summary>
    /// Required method for Designer support - do not modify
    /// the contents of this method with the code editor.
    /// </summary>
    private void InitializeComponent()
    {
      System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(gui_substrate));
      this.grpWeender = new System.Windows.Forms.GroupBox();
      this.grpGeneral = new System.Windows.Forms.GroupBox();
      this.grpSubstrateClass = new System.Windows.Forms.GroupBox();
      this.cmbSubstrateClass = new System.Windows.Forms.ComboBox();
      this.grpPhys = new System.Windows.Forms.GroupBox();
      this.grpModel = new System.Windows.Forms.GroupBox();
      this.grpList = new System.Windows.Forms.GroupBox();
      this.cmdPrint = new System.Windows.Forms.Button();
      this.cmdDel = new System.Windows.Forms.Button();
      this.cmdAdd = new System.Windows.Forms.Button();
      this.lstSubstrates = new System.Windows.Forms.ListBox();
      this.mnuMain = new System.Windows.Forms.MenuStrip();
      this.mnuFile = new System.Windows.Forms.ToolStripMenuItem();
      this.menuNew = new System.Windows.Forms.ToolStripMenuItem();
      this.menuOpen = new System.Windows.Forms.ToolStripMenuItem();
      this.menuLine1 = new System.Windows.Forms.ToolStripSeparator();
      this.menuSave = new System.Windows.Forms.ToolStripMenuItem();
      this.menuSaveAs = new System.Windows.Forms.ToolStripMenuItem();
      this.menuLine2 = new System.Windows.Forms.ToolStripSeparator();
      this.menuQuit = new System.Windows.Forms.ToolStripMenuItem();
      this.mnuHelp = new System.Windows.Forms.ToolStripMenuItem();
      this.menuInfo = new System.Windows.Forms.ToolStripMenuItem();
      this.panel1 = new System.Windows.Forms.Panel();
      this.dlgOpenFile = new System.Windows.Forms.OpenFileDialog();
      this.dlgSaveFile = new System.Windows.Forms.SaveFileDialog();
      this.statusStrip = new System.Windows.Forms.StatusStrip();
      this.lblStatus = new System.Windows.Forms.ToolStripStatusLabel();
      this.grpHelp = new System.Windows.Forms.GroupBox();
      this.lblHelp = new System.Windows.Forms.Label();
      this.grpLanguage = new System.Windows.Forms.GroupBox();
      this.radGerman = new System.Windows.Forms.RadioButton();
      this.radEnglish = new System.Windows.Forms.RadioButton();
      this.grpGeneral.SuspendLayout();
      this.grpSubstrateClass.SuspendLayout();
      this.grpList.SuspendLayout();
      this.mnuMain.SuspendLayout();
      this.statusStrip.SuspendLayout();
      this.grpHelp.SuspendLayout();
      this.grpLanguage.SuspendLayout();
      this.SuspendLayout();
      // 
      // grpWeender
      // 
      resources.ApplyResources(this.grpWeender, "grpWeender");
      this.grpWeender.Name = "grpWeender";
      this.grpWeender.TabStop = false;
      // 
      // grpGeneral
      // 
      this.grpGeneral.Controls.Add(this.grpSubstrateClass);
      resources.ApplyResources(this.grpGeneral, "grpGeneral");
      this.grpGeneral.Name = "grpGeneral";
      this.grpGeneral.TabStop = false;
      // 
      // grpSubstrateClass
      // 
      this.grpSubstrateClass.Controls.Add(this.cmbSubstrateClass);
      resources.ApplyResources(this.grpSubstrateClass, "grpSubstrateClass");
      this.grpSubstrateClass.Name = "grpSubstrateClass";
      this.grpSubstrateClass.TabStop = false;
      // 
      // cmbSubstrateClass
      // 
      this.cmbSubstrateClass.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
      this.cmbSubstrateClass.FormattingEnabled = true;
      resources.ApplyResources(this.cmbSubstrateClass, "cmbSubstrateClass");
      this.cmbSubstrateClass.Name = "cmbSubstrateClass";
      // 
      // grpPhys
      // 
      resources.ApplyResources(this.grpPhys, "grpPhys");
      this.grpPhys.Name = "grpPhys";
      this.grpPhys.TabStop = false;
      // 
      // grpModel
      // 
      resources.ApplyResources(this.grpModel, "grpModel");
      this.grpModel.Name = "grpModel";
      this.grpModel.TabStop = false;
      // 
      // grpList
      // 
      this.grpList.Controls.Add(this.cmdPrint);
      this.grpList.Controls.Add(this.cmdDel);
      this.grpList.Controls.Add(this.cmdAdd);
      this.grpList.Controls.Add(this.lstSubstrates);
      resources.ApplyResources(this.grpList, "grpList");
      this.grpList.Name = "grpList";
      this.grpList.TabStop = false;
      // 
      // cmdPrint
      // 
      resources.ApplyResources(this.cmdPrint, "cmdPrint");
      this.cmdPrint.Name = "cmdPrint";
      this.cmdPrint.UseVisualStyleBackColor = true;
      this.cmdPrint.Click += new System.EventHandler(this.btnPrint_Click);
      // 
      // cmdDel
      // 
      resources.ApplyResources(this.cmdDel, "cmdDel");
      this.cmdDel.Name = "cmdDel";
      this.cmdDel.UseVisualStyleBackColor = true;
      this.cmdDel.Click += new System.EventHandler(this.cmdDel_Click);
      // 
      // cmdAdd
      // 
      resources.ApplyResources(this.cmdAdd, "cmdAdd");
      this.cmdAdd.Name = "cmdAdd";
      this.cmdAdd.UseVisualStyleBackColor = true;
      this.cmdAdd.Click += new System.EventHandler(this.cmdAdd_Click);
      // 
      // lstSubstrates
      // 
      this.lstSubstrates.FormattingEnabled = true;
      resources.ApplyResources(this.lstSubstrates, "lstSubstrates");
      this.lstSubstrates.Name = "lstSubstrates";
      this.lstSubstrates.SelectedIndexChanged += new System.EventHandler(this.lstSubstrates_SelectedIndexChanged);
      // 
      // mnuMain
      // 
      this.mnuMain.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.mnuFile,
            this.mnuHelp});
      resources.ApplyResources(this.mnuMain, "mnuMain");
      this.mnuMain.Name = "mnuMain";
      // 
      // mnuFile
      // 
      this.mnuFile.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.menuNew,
            this.menuOpen,
            this.menuLine1,
            this.menuSave,
            this.menuSaveAs,
            this.menuLine2,
            this.menuQuit});
      this.mnuFile.Name = "mnuFile";
      resources.ApplyResources(this.mnuFile, "mnuFile");
      // 
      // menuNew
      // 
      this.menuNew.Name = "menuNew";
      resources.ApplyResources(this.menuNew, "menuNew");
      this.menuNew.Click += new System.EventHandler(this.menuNew_Click);
      // 
      // menuOpen
      // 
      this.menuOpen.Name = "menuOpen";
      resources.ApplyResources(this.menuOpen, "menuOpen");
      this.menuOpen.Click += new System.EventHandler(this.menuOpen_Click);
      // 
      // menuLine1
      // 
      this.menuLine1.Name = "menuLine1";
      resources.ApplyResources(this.menuLine1, "menuLine1");
      // 
      // menuSave
      // 
      this.menuSave.Name = "menuSave";
      resources.ApplyResources(this.menuSave, "menuSave");
      this.menuSave.Click += new System.EventHandler(this.menuSave_Click);
      // 
      // menuSaveAs
      // 
      this.menuSaveAs.Name = "menuSaveAs";
      resources.ApplyResources(this.menuSaveAs, "menuSaveAs");
      this.menuSaveAs.Click += new System.EventHandler(this.menuSaveAs_Click);
      // 
      // menuLine2
      // 
      this.menuLine2.Name = "menuLine2";
      resources.ApplyResources(this.menuLine2, "menuLine2");
      // 
      // menuQuit
      // 
      this.menuQuit.Name = "menuQuit";
      resources.ApplyResources(this.menuQuit, "menuQuit");
      this.menuQuit.Click += new System.EventHandler(this.menuQuit_Click);
      // 
      // mnuHelp
      // 
      this.mnuHelp.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.menuInfo});
      this.mnuHelp.Name = "mnuHelp";
      resources.ApplyResources(this.mnuHelp, "mnuHelp");
      // 
      // menuInfo
      // 
      this.menuInfo.Name = "menuInfo";
      resources.ApplyResources(this.menuInfo, "menuInfo");
      this.menuInfo.Click += new System.EventHandler(this.menuInfo_Click);
      // 
      // panel1
      // 
      this.panel1.BackgroundImage = global::guis.Properties.Resources.GECOC_final_small_trans;
      resources.ApplyResources(this.panel1, "panel1");
      this.panel1.Name = "panel1";
      // 
      // dlgOpenFile
      // 
      this.dlgOpenFile.FileName = "substrate_gummersbach.xml";
      resources.ApplyResources(this.dlgOpenFile, "dlgOpenFile");
      // 
      // dlgSaveFile
      // 
      resources.ApplyResources(this.dlgSaveFile, "dlgSaveFile");
      // 
      // statusStrip
      // 
      this.statusStrip.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.lblStatus});
      resources.ApplyResources(this.statusStrip, "statusStrip");
      this.statusStrip.Name = "statusStrip";
      // 
      // lblStatus
      // 
      this.lblStatus.Name = "lblStatus";
      resources.ApplyResources(this.lblStatus, "lblStatus");
      // 
      // grpHelp
      // 
      this.grpHelp.Controls.Add(this.lblHelp);
      resources.ApplyResources(this.grpHelp, "grpHelp");
      this.grpHelp.Name = "grpHelp";
      this.grpHelp.TabStop = false;
      // 
      // lblHelp
      // 
      resources.ApplyResources(this.lblHelp, "lblHelp");
      this.lblHelp.Name = "lblHelp";
      // 
      // grpLanguage
      // 
      this.grpLanguage.Controls.Add(this.radGerman);
      this.grpLanguage.Controls.Add(this.radEnglish);
      resources.ApplyResources(this.grpLanguage, "grpLanguage");
      this.grpLanguage.Name = "grpLanguage";
      this.grpLanguage.TabStop = false;
      // 
      // radGerman
      // 
      resources.ApplyResources(this.radGerman, "radGerman");
      this.radGerman.Name = "radGerman";
      this.radGerman.UseVisualStyleBackColor = true;
      this.radGerman.CheckedChanged += new System.EventHandler(this.radGerman_CheckedChanged);
      // 
      // radEnglish
      // 
      resources.ApplyResources(this.radEnglish, "radEnglish");
      this.radEnglish.Checked = true;
      this.radEnglish.Name = "radEnglish";
      this.radEnglish.TabStop = true;
      this.radEnglish.UseVisualStyleBackColor = true;
      this.radEnglish.CheckedChanged += new System.EventHandler(this.radEnglish_CheckedChanged);
      // 
      // gui_substrate
      // 
      resources.ApplyResources(this, "$this");
      this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
      this.Controls.Add(this.grpLanguage);
      this.Controls.Add(this.grpHelp);
      this.Controls.Add(this.statusStrip);
      this.Controls.Add(this.panel1);
      this.Controls.Add(this.grpList);
      this.Controls.Add(this.grpModel);
      this.Controls.Add(this.grpPhys);
      this.Controls.Add(this.grpGeneral);
      this.Controls.Add(this.grpWeender);
      this.Controls.Add(this.mnuMain);
      this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
      this.MainMenuStrip = this.mnuMain;
      this.MaximizeBox = false;
      this.Name = "gui_substrate";
      this.FormClosing += new System.Windows.Forms.FormClosingEventHandler(this.gui_substrate_FormClosing);
      this.grpGeneral.ResumeLayout(false);
      this.grpSubstrateClass.ResumeLayout(false);
      this.grpList.ResumeLayout(false);
      this.mnuMain.ResumeLayout(false);
      this.mnuMain.PerformLayout();
      this.statusStrip.ResumeLayout(false);
      this.statusStrip.PerformLayout();
      this.grpHelp.ResumeLayout(false);
      this.grpLanguage.ResumeLayout(false);
      this.grpLanguage.PerformLayout();
      this.ResumeLayout(false);
      this.PerformLayout();

    }

    #endregion

    private System.Windows.Forms.GroupBox grpWeender;
    private System.Windows.Forms.GroupBox grpGeneral;
    private System.Windows.Forms.GroupBox grpSubstrateClass;
    private System.Windows.Forms.ComboBox cmbSubstrateClass;
    private System.Windows.Forms.GroupBox grpPhys;
    private System.Windows.Forms.GroupBox grpModel;
    private System.Windows.Forms.GroupBox grpList;
    private System.Windows.Forms.Button cmdDel;
    private System.Windows.Forms.ListBox lstSubstrates;
    private System.Windows.Forms.Button cmdAdd;
    private System.Windows.Forms.MenuStrip mnuMain;
    private System.Windows.Forms.ToolStripMenuItem mnuFile;
    private System.Windows.Forms.ToolStripMenuItem menuNew;
    private System.Windows.Forms.ToolStripMenuItem menuOpen;
    private System.Windows.Forms.ToolStripSeparator menuLine1;
    private System.Windows.Forms.ToolStripMenuItem menuSave;
    private System.Windows.Forms.ToolStripSeparator menuLine2;
    private System.Windows.Forms.ToolStripMenuItem menuQuit;
    private System.Windows.Forms.ToolStripMenuItem mnuHelp;
    private System.Windows.Forms.Panel panel1;
    private System.Windows.Forms.ToolStripMenuItem menuSaveAs;
    private System.Windows.Forms.OpenFileDialog dlgOpenFile;
    private System.Windows.Forms.ToolStripMenuItem menuInfo;
    private System.Windows.Forms.SaveFileDialog dlgSaveFile;
    private System.Windows.Forms.StatusStrip statusStrip;
    private System.Windows.Forms.ToolStripStatusLabel lblStatus;
    private System.Windows.Forms.GroupBox grpHelp;
    private System.Windows.Forms.Label lblHelp;
    private System.Windows.Forms.GroupBox grpLanguage;
    private System.Windows.Forms.RadioButton radGerman;
    private System.Windows.Forms.RadioButton radEnglish;
    private System.Windows.Forms.Button cmdPrint;

  }
}