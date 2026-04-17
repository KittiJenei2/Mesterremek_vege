namespace FreshSzalonAdmin.Forms
{
    partial class SzolgaltatokForm
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
            this.cmbDolgozo = new MaterialSkin.Controls.MaterialComboBox();
            this.cmbLehetoseg = new MaterialSkin.Controls.MaterialComboBox();
            this.btnMentes = new MaterialSkin.Controls.MaterialButton();
            this.btnMegse = new MaterialSkin.Controls.MaterialButton();
            this.materialLabel1 = new MaterialSkin.Controls.MaterialLabel();
            this.materialLabel2 = new MaterialSkin.Controls.MaterialLabel();
            this.SuspendLayout();
            // 
            // cmbDolgozo
            // 
            this.cmbDolgozo.AutoResize = false;
            this.cmbDolgozo.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(255)))), ((int)(((byte)(255)))), ((int)(((byte)(255)))));
            this.cmbDolgozo.Depth = 0;
            this.cmbDolgozo.DrawMode = System.Windows.Forms.DrawMode.OwnerDrawVariable;
            this.cmbDolgozo.DropDownHeight = 174;
            this.cmbDolgozo.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cmbDolgozo.DropDownWidth = 121;
            this.cmbDolgozo.Font = new System.Drawing.Font("Microsoft Sans Serif", 14F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Pixel);
            this.cmbDolgozo.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(222)))), ((int)(((byte)(0)))), ((int)(((byte)(0)))), ((int)(((byte)(0)))));
            this.cmbDolgozo.FormattingEnabled = true;
            this.cmbDolgozo.IntegralHeight = false;
            this.cmbDolgozo.ItemHeight = 43;
            this.cmbDolgozo.Location = new System.Drawing.Point(6, 103);
            this.cmbDolgozo.MaxDropDownItems = 4;
            this.cmbDolgozo.MouseState = MaterialSkin.MouseState.OUT;
            this.cmbDolgozo.Name = "cmbDolgozo";
            this.cmbDolgozo.Size = new System.Drawing.Size(441, 49);
            this.cmbDolgozo.StartIndex = 0;
            this.cmbDolgozo.TabIndex = 0;
            // 
            // cmbLehetoseg
            // 
            this.cmbLehetoseg.AutoResize = false;
            this.cmbLehetoseg.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(255)))), ((int)(((byte)(255)))), ((int)(((byte)(255)))));
            this.cmbLehetoseg.Depth = 0;
            this.cmbLehetoseg.DrawMode = System.Windows.Forms.DrawMode.OwnerDrawVariable;
            this.cmbLehetoseg.DropDownHeight = 174;
            this.cmbLehetoseg.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cmbLehetoseg.DropDownWidth = 121;
            this.cmbLehetoseg.Font = new System.Drawing.Font("Microsoft Sans Serif", 14F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Pixel);
            this.cmbLehetoseg.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(222)))), ((int)(((byte)(0)))), ((int)(((byte)(0)))), ((int)(((byte)(0)))));
            this.cmbLehetoseg.FormattingEnabled = true;
            this.cmbLehetoseg.IntegralHeight = false;
            this.cmbLehetoseg.ItemHeight = 43;
            this.cmbLehetoseg.Location = new System.Drawing.Point(6, 189);
            this.cmbLehetoseg.MaxDropDownItems = 4;
            this.cmbLehetoseg.MouseState = MaterialSkin.MouseState.OUT;
            this.cmbLehetoseg.Name = "cmbLehetoseg";
            this.cmbLehetoseg.Size = new System.Drawing.Size(441, 49);
            this.cmbLehetoseg.StartIndex = 0;
            this.cmbLehetoseg.TabIndex = 1;
            // 
            // btnMentes
            // 
            this.btnMentes.AutoSizeMode = System.Windows.Forms.AutoSizeMode.GrowAndShrink;
            this.btnMentes.Density = MaterialSkin.Controls.MaterialButton.MaterialButtonDensity.Default;
            this.btnMentes.Depth = 0;
            this.btnMentes.HighEmphasis = true;
            this.btnMentes.Icon = null;
            this.btnMentes.Location = new System.Drawing.Point(7, 267);
            this.btnMentes.Margin = new System.Windows.Forms.Padding(4, 6, 4, 6);
            this.btnMentes.MouseState = MaterialSkin.MouseState.HOVER;
            this.btnMentes.Name = "btnMentes";
            this.btnMentes.NoAccentTextColor = System.Drawing.Color.Empty;
            this.btnMentes.Size = new System.Drawing.Size(79, 36);
            this.btnMentes.TabIndex = 2;
            this.btnMentes.Text = "Mentés";
            this.btnMentes.Type = MaterialSkin.Controls.MaterialButton.MaterialButtonType.Contained;
            this.btnMentes.UseAccentColor = false;
            this.btnMentes.UseVisualStyleBackColor = true;
            this.btnMentes.Click += new System.EventHandler(this.btnMentes_Click);
            // 
            // btnMegse
            // 
            this.btnMegse.AutoSizeMode = System.Windows.Forms.AutoSizeMode.GrowAndShrink;
            this.btnMegse.Density = MaterialSkin.Controls.MaterialButton.MaterialButtonDensity.Default;
            this.btnMegse.Depth = 0;
            this.btnMegse.HighEmphasis = true;
            this.btnMegse.Icon = null;
            this.btnMegse.Location = new System.Drawing.Point(87, 267);
            this.btnMegse.Margin = new System.Windows.Forms.Padding(4, 6, 4, 6);
            this.btnMegse.MouseState = MaterialSkin.MouseState.HOVER;
            this.btnMegse.Name = "btnMegse";
            this.btnMegse.NoAccentTextColor = System.Drawing.Color.Empty;
            this.btnMegse.Size = new System.Drawing.Size(70, 36);
            this.btnMegse.TabIndex = 3;
            this.btnMegse.Text = "Mégse";
            this.btnMegse.Type = MaterialSkin.Controls.MaterialButton.MaterialButtonType.Contained;
            this.btnMegse.UseAccentColor = false;
            this.btnMegse.UseVisualStyleBackColor = true;
            this.btnMegse.Click += new System.EventHandler(this.btnMegse_Click);
            // 
            // materialLabel1
            // 
            this.materialLabel1.AutoSize = true;
            this.materialLabel1.Depth = 0;
            this.materialLabel1.Font = new System.Drawing.Font("Roboto", 14F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Pixel);
            this.materialLabel1.Location = new System.Drawing.Point(3, 81);
            this.materialLabel1.MouseState = MaterialSkin.MouseState.HOVER;
            this.materialLabel1.Name = "materialLabel1";
            this.materialLabel1.Size = new System.Drawing.Size(135, 19);
            this.materialLabel1.TabIndex = 4;
            this.materialLabel1.Text = "Válassz dolgozót...";
            // 
            // materialLabel2
            // 
            this.materialLabel2.AutoSize = true;
            this.materialLabel2.Depth = 0;
            this.materialLabel2.Font = new System.Drawing.Font("Roboto", 14F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Pixel);
            this.materialLabel2.Location = new System.Drawing.Point(3, 167);
            this.materialLabel2.MouseState = MaterialSkin.MouseState.HOVER;
            this.materialLabel2.Name = "materialLabel2";
            this.materialLabel2.Size = new System.Drawing.Size(154, 19);
            this.materialLabel2.TabIndex = 5;
            this.materialLabel2.Text = "Válassz lehetőséget...";
            // 
            // SzolgaltatokForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(465, 315);
            this.Controls.Add(this.materialLabel2);
            this.Controls.Add(this.materialLabel1);
            this.Controls.Add(this.btnMegse);
            this.Controls.Add(this.btnMentes);
            this.Controls.Add(this.cmbLehetoseg);
            this.Controls.Add(this.cmbDolgozo);
            this.Name = "SzolgaltatokForm";
            this.Text = "SzolgaltatokForm";
            this.Load += new System.EventHandler(this.SzolgaltatokForm_Load);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private MaterialSkin.Controls.MaterialComboBox cmbDolgozo;
        private MaterialSkin.Controls.MaterialComboBox cmbLehetoseg;
        private MaterialSkin.Controls.MaterialButton btnMentes;
        private MaterialSkin.Controls.MaterialButton btnMegse;
        private MaterialSkin.Controls.MaterialLabel materialLabel1;
        private MaterialSkin.Controls.MaterialLabel materialLabel2;
    }
}