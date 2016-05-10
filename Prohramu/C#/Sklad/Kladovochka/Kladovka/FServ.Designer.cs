namespace Kladovka
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
            this.FservTB = new System.Windows.Forms.TextBox();
            this.FservBOk = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // FservTB
            // 
            this.FservTB.Location = new System.Drawing.Point(13, 13);
            this.FservTB.Name = "FservTB";
            this.FservTB.Size = new System.Drawing.Size(744, 20);
            this.FservTB.TabIndex = 0;
            // 
            // FservBOk
            // 
            this.FservBOk.Location = new System.Drawing.Point(363, 70);
            this.FservBOk.Name = "FservBOk";
            this.FservBOk.Size = new System.Drawing.Size(75, 23);
            this.FservBOk.TabIndex = 1;
            this.FservBOk.Text = "Ввести";
            this.FservBOk.UseVisualStyleBackColor = true;
            this.FservBOk.Click += new System.EventHandler(this.FservBOk_Click);
            // 
            // FServ
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(769, 137);
            this.Controls.Add(this.FservBOk);
            this.Controls.Add(this.FservTB);
            this.Name = "FServ";
            this.Text = "FServ";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.TextBox FservTB;
        private System.Windows.Forms.Button FservBOk;
    }
}