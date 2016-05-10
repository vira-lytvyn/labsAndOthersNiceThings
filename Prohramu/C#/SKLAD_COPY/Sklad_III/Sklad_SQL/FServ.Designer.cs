namespace Sklad_SQL
{
    partial class FServ
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
            this.FservBOk = new System.Windows.Forms.Button();
            this.FservTB = new System.Windows.Forms.TextBox();
            this.SuspendLayout();
            // 
            // FservBOk
            // 
            this.FservBOk.Location = new System.Drawing.Point(374, 127);
            this.FservBOk.Margin = new System.Windows.Forms.Padding(4, 4, 4, 4);
            this.FservBOk.Name = "FservBOk";
            this.FservBOk.Size = new System.Drawing.Size(112, 36);
            this.FservBOk.TabIndex = 0;
            this.FservBOk.Text = "¬вести";
            this.FservBOk.UseVisualStyleBackColor = true;
            this.FservBOk.Click += new System.EventHandler(this.FservBOk_Click);
            // 
            // FservTB
            // 
            this.FservTB.Location = new System.Drawing.Point(49, 62);
            this.FservTB.Margin = new System.Windows.Forms.Padding(4, 4, 4, 4);
            this.FservTB.Name = "FservTB";
            this.FservTB.Size = new System.Drawing.Size(744, 26);
            this.FservTB.TabIndex = 1;
            // 
            // FServ
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 18F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.SystemColors.GradientInactiveCaption;
            this.ClientSize = new System.Drawing.Size(849, 207);
            this.Controls.Add(this.FservTB);
            this.Controls.Add(this.FservBOk);
            this.Font = new System.Drawing.Font("Comic Sans MS", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.Margin = new System.Windows.Forms.Padding(4, 4, 4, 4);
            this.Name = "FServ";
            this.Text = "FServ";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Button FservBOk;
        private System.Windows.Forms.TextBox FservTB;
    }
}