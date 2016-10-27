namespace matlab_guis
{
  partial class gui_plant
  {
    /// <summary>
    /// Erforderliche Designervariable.
    /// </summary>
    private System.ComponentModel.IContainer components = null;

    /// <summary>
    /// Verwendete Ressourcen bereinigen.
    /// </summary>
    /// <param name="disposing">True, wenn verwaltete Ressourcen gelöscht werden sollen; andernfalls False.</param>
    protected override void Dispose(bool disposing)
    {
      if (disposing && (components != null))
      {
        components.Dispose();
      }
      base.Dispose(disposing);
    }

    #region Vom Windows Form-Designer generierter Code

    /// <summary>
    /// Erforderliche Methode für die Designerunterstützung.
    /// Der Inhalt der Methode darf nicht mit dem Code-Editor geändert werden.
    /// </summary>
    private void InitializeComponent()
    {
      this.button1 = new System.Windows.Forms.Button();
      this.listBox1 = new System.Windows.Forms.ListBox();
      this.comboBox1 = new System.Windows.Forms.ComboBox();
      this.groupBox1 = new System.Windows.Forms.GroupBox();
      this.label1 = new System.Windows.Forms.Label();
      this.tabControl1 = new System.Windows.Forms.TabControl();
      this.tabPage1 = new System.Windows.Forms.TabPage();
      this.tabPage2 = new System.Windows.Forms.TabPage();
      this.led1 = new NationalInstruments.UI.WindowsForms.Led();
      this.knob1 = new NationalInstruments.UI.WindowsForms.Knob();
      this.switch1 = new NationalInstruments.UI.WindowsForms.Switch();
      this.meter1 = new NationalInstruments.UI.WindowsForms.Meter();
      this.tank1 = new NationalInstruments.UI.WindowsForms.Tank();
      this.ledArray1 = new NationalInstruments.UI.WindowsForms.LedArray();
      this.numericEdit1 = new NationalInstruments.UI.WindowsForms.NumericEdit();
      this.waveformGraph1 = new NationalInstruments.UI.WindowsForms.WaveformGraph();
      this.xAxis1 = new NationalInstruments.UI.XAxis();
      this.yAxis1 = new NationalInstruments.UI.YAxis();
      this.waveformPlot1 = new NationalInstruments.UI.WaveformPlot();
      this.tabControl1.SuspendLayout();
      this.tabPage1.SuspendLayout();
      ((System.ComponentModel.ISupportInitialize)(this.led1)).BeginInit();
      ((System.ComponentModel.ISupportInitialize)(this.knob1)).BeginInit();
      ((System.ComponentModel.ISupportInitialize)(this.switch1)).BeginInit();
      ((System.ComponentModel.ISupportInitialize)(this.meter1)).BeginInit();
      ((System.ComponentModel.ISupportInitialize)(this.tank1)).BeginInit();
      ((System.ComponentModel.ISupportInitialize)(this.ledArray1.ItemTemplate)).BeginInit();
      ((System.ComponentModel.ISupportInitialize)(this.numericEdit1)).BeginInit();
      ((System.ComponentModel.ISupportInitialize)(this.waveformGraph1)).BeginInit();
      this.SuspendLayout();
      // 
      // button1
      // 
      this.button1.Location = new System.Drawing.Point(366, 103);
      this.button1.Name = "button1";
      this.button1.Size = new System.Drawing.Size(75, 23);
      this.button1.TabIndex = 0;
      this.button1.Text = "button1";
      this.button1.UseVisualStyleBackColor = true;
      // 
      // listBox1
      // 
      this.listBox1.FormattingEnabled = true;
      this.listBox1.Location = new System.Drawing.Point(12, 187);
      this.listBox1.Name = "listBox1";
      this.listBox1.Size = new System.Drawing.Size(120, 95);
      this.listBox1.TabIndex = 1;
      // 
      // comboBox1
      // 
      this.comboBox1.FormattingEnabled = true;
      this.comboBox1.Location = new System.Drawing.Point(331, 45);
      this.comboBox1.Name = "comboBox1";
      this.comboBox1.Size = new System.Drawing.Size(124, 21);
      this.comboBox1.TabIndex = 2;
      // 
      // groupBox1
      // 
      this.groupBox1.Location = new System.Drawing.Point(501, 103);
      this.groupBox1.Name = "groupBox1";
      this.groupBox1.Size = new System.Drawing.Size(200, 100);
      this.groupBox1.TabIndex = 3;
      this.groupBox1.TabStop = false;
      this.groupBox1.Text = "groupBox1";
      // 
      // label1
      // 
      this.label1.AutoSize = true;
      this.label1.Location = new System.Drawing.Point(196, 133);
      this.label1.Name = "label1";
      this.label1.Size = new System.Drawing.Size(35, 13);
      this.label1.TabIndex = 4;
      this.label1.Text = "label1";
      // 
      // tabControl1
      // 
      this.tabControl1.Controls.Add(this.tabPage1);
      this.tabControl1.Controls.Add(this.tabPage2);
      this.tabControl1.Location = new System.Drawing.Point(277, 229);
      this.tabControl1.Name = "tabControl1";
      this.tabControl1.SelectedIndex = 0;
      this.tabControl1.Size = new System.Drawing.Size(312, 215);
      this.tabControl1.TabIndex = 5;
      // 
      // tabPage1
      // 
      this.tabPage1.Controls.Add(this.waveformGraph1);
      this.tabPage1.Location = new System.Drawing.Point(4, 22);
      this.tabPage1.Name = "tabPage1";
      this.tabPage1.Padding = new System.Windows.Forms.Padding(3);
      this.tabPage1.Size = new System.Drawing.Size(304, 189);
      this.tabPage1.TabIndex = 0;
      this.tabPage1.Text = "tabPage1";
      this.tabPage1.UseVisualStyleBackColor = true;
      // 
      // tabPage2
      // 
      this.tabPage2.Location = new System.Drawing.Point(4, 22);
      this.tabPage2.Name = "tabPage2";
      this.tabPage2.Padding = new System.Windows.Forms.Padding(3);
      this.tabPage2.Size = new System.Drawing.Size(192, 74);
      this.tabPage2.TabIndex = 1;
      this.tabPage2.Text = "tabPage2";
      this.tabPage2.UseVisualStyleBackColor = true;
      // 
      // led1
      // 
      this.led1.LedStyle = NationalInstruments.UI.LedStyle.Round3D;
      this.led1.Location = new System.Drawing.Point(125, 456);
      this.led1.Name = "led1";
      this.led1.Size = new System.Drawing.Size(64, 64);
      this.led1.TabIndex = 6;
      // 
      // knob1
      // 
      this.knob1.Location = new System.Drawing.Point(30, 12);
      this.knob1.Name = "knob1";
      this.knob1.Size = new System.Drawing.Size(160, 152);
      this.knob1.TabIndex = 7;
      // 
      // switch1
      // 
      this.switch1.Location = new System.Drawing.Point(595, 380);
      this.switch1.Name = "switch1";
      this.switch1.Size = new System.Drawing.Size(64, 96);
      this.switch1.SwitchStyle = NationalInstruments.UI.SwitchStyle.VerticalToggle3D;
      this.switch1.TabIndex = 8;
      // 
      // meter1
      // 
      this.meter1.Location = new System.Drawing.Point(30, 317);
      this.meter1.Name = "meter1";
      this.meter1.Size = new System.Drawing.Size(214, 100);
      this.meter1.TabIndex = 9;
      // 
      // tank1
      // 
      this.tank1.Location = new System.Drawing.Point(378, 504);
      this.tank1.Name = "tank1";
      this.tank1.Size = new System.Drawing.Size(110, 152);
      this.tank1.TabIndex = 10;
      // 
      // ledArray1
      // 
      // 
      // 
      // 
      this.ledArray1.ItemTemplate.LedStyle = NationalInstruments.UI.LedStyle.Square3D;
      this.ledArray1.ItemTemplate.Location = new System.Drawing.Point(0, 0);
      this.ledArray1.ItemTemplate.Name = "";
      this.ledArray1.ItemTemplate.Size = new System.Drawing.Size(48, 48);
      this.ledArray1.ItemTemplate.TabIndex = 0;
      this.ledArray1.ItemTemplate.TabStop = false;
      this.ledArray1.LayoutMode = NationalInstruments.UI.ControlArrayLayoutMode.Horizontal;
      this.ledArray1.Location = new System.Drawing.Point(80, 589);
      this.ledArray1.Name = "ledArray1";
      this.ledArray1.Size = new System.Drawing.Size(188, 67);
      this.ledArray1.TabIndex = 11;
      // 
      // numericEdit1
      // 
      this.numericEdit1.Location = new System.Drawing.Point(561, 541);
      this.numericEdit1.Name = "numericEdit1";
      this.numericEdit1.Size = new System.Drawing.Size(120, 20);
      this.numericEdit1.TabIndex = 12;
      // 
      // waveformGraph1
      // 
      this.waveformGraph1.Location = new System.Drawing.Point(6, 6);
      this.waveformGraph1.Name = "waveformGraph1";
      this.waveformGraph1.Plots.AddRange(new NationalInstruments.UI.WaveformPlot[] {
            this.waveformPlot1});
      this.waveformGraph1.Size = new System.Drawing.Size(272, 168);
      this.waveformGraph1.TabIndex = 13;
      this.waveformGraph1.UseColorGenerator = true;
      this.waveformGraph1.XAxes.AddRange(new NationalInstruments.UI.XAxis[] {
            this.xAxis1});
      this.waveformGraph1.YAxes.AddRange(new NationalInstruments.UI.YAxis[] {
            this.yAxis1});
      // 
      // waveformPlot1
      // 
      this.waveformPlot1.XAxis = this.xAxis1;
      this.waveformPlot1.YAxis = this.yAxis1;
      // 
      // gui_plant
      // 
      this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
      this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
      this.ClientSize = new System.Drawing.Size(790, 688);
      this.Controls.Add(this.numericEdit1);
      this.Controls.Add(this.ledArray1);
      this.Controls.Add(this.tank1);
      this.Controls.Add(this.meter1);
      this.Controls.Add(this.switch1);
      this.Controls.Add(this.knob1);
      this.Controls.Add(this.led1);
      this.Controls.Add(this.tabControl1);
      this.Controls.Add(this.label1);
      this.Controls.Add(this.groupBox1);
      this.Controls.Add(this.comboBox1);
      this.Controls.Add(this.listBox1);
      this.Controls.Add(this.button1);
      this.Name = "gui_plant";
      this.Text = "Form1";
      this.tabControl1.ResumeLayout(false);
      this.tabPage1.ResumeLayout(false);
      ((System.ComponentModel.ISupportInitialize)(this.led1)).EndInit();
      ((System.ComponentModel.ISupportInitialize)(this.knob1)).EndInit();
      ((System.ComponentModel.ISupportInitialize)(this.switch1)).EndInit();
      ((System.ComponentModel.ISupportInitialize)(this.meter1)).EndInit();
      ((System.ComponentModel.ISupportInitialize)(this.tank1)).EndInit();
      ((System.ComponentModel.ISupportInitialize)(this.ledArray1.ItemTemplate)).EndInit();
      ((System.ComponentModel.ISupportInitialize)(this.numericEdit1)).EndInit();
      ((System.ComponentModel.ISupportInitialize)(this.waveformGraph1)).EndInit();
      this.ResumeLayout(false);
      this.PerformLayout();

    }

    #endregion

    private System.Windows.Forms.Button button1;
    private System.Windows.Forms.ListBox listBox1;
    private System.Windows.Forms.ComboBox comboBox1;
    private System.Windows.Forms.GroupBox groupBox1;
    private System.Windows.Forms.Label label1;
    private System.Windows.Forms.TabControl tabControl1;
    private System.Windows.Forms.TabPage tabPage1;
    private System.Windows.Forms.TabPage tabPage2;
    private NationalInstruments.UI.WindowsForms.Led led1;
    private NationalInstruments.UI.WindowsForms.Knob knob1;
    private NationalInstruments.UI.WindowsForms.Switch switch1;
    private NationalInstruments.UI.WindowsForms.Meter meter1;
    private NationalInstruments.UI.WindowsForms.Tank tank1;
    private NationalInstruments.UI.WindowsForms.LedArray ledArray1;
    private NationalInstruments.UI.WindowsForms.WaveformGraph waveformGraph1;
    private NationalInstruments.UI.WaveformPlot waveformPlot1;
    private NationalInstruments.UI.XAxis xAxis1;
    private NationalInstruments.UI.YAxis yAxis1;
    private NationalInstruments.UI.WindowsForms.NumericEdit numericEdit1;
  }
}

