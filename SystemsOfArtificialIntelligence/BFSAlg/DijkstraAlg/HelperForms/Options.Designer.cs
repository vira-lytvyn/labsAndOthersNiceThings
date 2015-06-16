namespace DijkstraAlg.HelperForms
{
    partial class Options
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
            this.ColorPallete = new System.Windows.Forms.ColorDialog();
            this.la = new System.Windows.Forms.Label();
            this.NumberOfPoints = new System.Windows.Forms.NumericUpDown();
            ((System.ComponentModel.ISupportInitialize)(this.NumberOfPoints)).BeginInit();
            this.SuspendLayout();
            // 
            // la
            // 
            this.la.AutoSize = true;
            this.la.Location = new System.Drawing.Point(12, 29);
            this.la.Name = "la";
            this.la.Size = new System.Drawing.Size(184, 17);
            this.la.TabIndex = 0;
            this.la.Text = "How many points generate?";
            // 
            // NumberOfPoints
            // 
            this.NumberOfPoints.Location = new System.Drawing.Point(235, 29);
            this.NumberOfPoints.Name = "NumberOfPoints";
            this.NumberOfPoints.Size = new System.Drawing.Size(81, 22);
            this.NumberOfPoints.TabIndex = 1;
            this.NumberOfPoints.ValueChanged += new System.EventHandler(this.NumberOfPoints_ValueChanged);
            // 
            // Options
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(395, 253);
            this.Controls.Add(this.NumberOfPoints);
            this.Controls.Add(this.la);
            this.Name = "Options";
            this.Text = "Options";
            ((System.ComponentModel.ISupportInitialize)(this.NumberOfPoints)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.ColorDialog ColorPallete;
        private System.Windows.Forms.Label la;
        public System.Windows.Forms.NumericUpDown NumberOfPoints;
    }
}