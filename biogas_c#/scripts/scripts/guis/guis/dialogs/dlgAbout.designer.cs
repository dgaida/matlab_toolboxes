namespace matlab_guis.dialogs
{
  partial class dlgAbout
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
      this.pictureBox1 = new System.Windows.Forms.PictureBox();
      this.lbl_gecoc = new System.Windows.Forms.LinkLabel();
      this.label6 = new System.Windows.Forms.Label();
      ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).BeginInit();
      this.SuspendLayout();
      // 
      // pictureBox1
      // 
      this.pictureBox1.BackColor = System.Drawing.Color.White;
      this.pictureBox1.BackgroundImage = global::guis.Properties.Resources.GECOC_kombi_final;
      this.pictureBox1.BackgroundImageLayout = System.Windows.Forms.ImageLayout.Stretch;
      this.pictureBox1.Location = new System.Drawing.Point(106, 76);
      this.pictureBox1.Name = "pictureBox1";
      this.pictureBox1.Size = new System.Drawing.Size(274, 65);
      this.pictureBox1.TabIndex = 10;
      this.pictureBox1.TabStop = false;
      // 
      // lbl_gecoc
      // 
      this.lbl_gecoc.AutoSize = true;
      this.lbl_gecoc.BackColor = System.Drawing.Color.White;
      this.lbl_gecoc.Location = new System.Drawing.Point(103, 213);
      this.lbl_gecoc.Name = "lbl_gecoc";
      this.lbl_gecoc.Size = new System.Drawing.Size(79, 13);
      this.lbl_gecoc.TabIndex = 9;
      this.lbl_gecoc.TabStop = true;
      this.lbl_gecoc.Text = "www.gecoc.de";
      // 
      // label6
      // 
      this.label6.BackColor = System.Drawing.Color.White;
      this.label6.Location = new System.Drawing.Point(12, 213);
      this.label6.Name = "label6";
      this.label6.Size = new System.Drawing.Size(85, 37);
      this.label6.TabIndex = 8;
      this.label6.Text = "Homepage:";
      // 
      // dlgAbout
      // 
      this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
      this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
      this.BackgroundImage = global::guis.Properties.Resources.creditsBackground;
      this.BackgroundImageLayout = System.Windows.Forms.ImageLayout.Stretch;
      this.ClientSize = new System.Drawing.Size(434, 412);
      this.Controls.Add(this.pictureBox1);
      this.Controls.Add(this.lbl_gecoc);
      this.Controls.Add(this.label6);
      this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
      this.MaximizeBox = false;
      this.Name = "dlgAbout";
      this.Text = "Über gui_substrate";
      ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).EndInit();
      this.ResumeLayout(false);
      this.PerformLayout();

    }

    #endregion

    private System.Windows.Forms.PictureBox pictureBox1;
    private System.Windows.Forms.LinkLabel lbl_gecoc;
    private System.Windows.Forms.Label label6;

  }
}