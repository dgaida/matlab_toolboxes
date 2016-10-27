namespace matlab_guis
{
  partial class GrpBoxTxt
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

    #region Vom Komponenten-Designer generierter Code

    /// <summary> 
    /// Erforderliche Methode für die Designerunterstützung. 
    /// Der Inhalt der Methode darf nicht mit dem Code-Editor geändert werden.
    /// </summary>
    private void InitializeComponent()
    {
      this.grpBox = new System.Windows.Forms.GroupBox();
      this.txtValue = new System.Windows.Forms.TextBox();
      this.grpBox.SuspendLayout();
      this.SuspendLayout();
      // 
      // grpBox
      // 
      this.grpBox.Controls.Add(this.txtValue);
      this.grpBox.Location = new System.Drawing.Point(0, 0);
      this.grpBox.Name = "grpBox";
      this.grpBox.Size = new System.Drawing.Size(120, 45);
      this.grpBox.TabIndex = 0;
      this.grpBox.TabStop = false;
      // 
      // txtValue
      // 
      this.txtValue.Location = new System.Drawing.Point(6, 19);
      this.txtValue.Name = "txtValue";
      this.txtValue.Size = new System.Drawing.Size(108, 20);
      this.txtValue.TabIndex = 0;
      this.txtValue.TextChanged += new System.EventHandler(this.txtValue_TextChanged);
      this.txtValue.Leave += new System.EventHandler(this.txtValue_Leave);
      this.txtValue.Enter += new System.EventHandler(this.txtValue_Enter);
      // 
      // GrpBoxTxt
      // 
      this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
      this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
      this.Controls.Add(this.grpBox);
      this.Name = "GrpBoxTxt";
      this.Size = new System.Drawing.Size(120, 45);
      this.grpBox.ResumeLayout(false);
      this.grpBox.PerformLayout();
      this.ResumeLayout(false);

    }

    #endregion

    private System.Windows.Forms.GroupBox grpBox;
    private System.Windows.Forms.TextBox txtValue;
  }
}
