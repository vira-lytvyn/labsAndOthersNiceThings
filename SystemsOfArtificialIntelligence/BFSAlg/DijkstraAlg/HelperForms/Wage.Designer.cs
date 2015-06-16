namespace DijkstraAlg.HelperForms
{
    partial class Wage
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
            this.label1 = new System.Windows.Forms.Label();
            this.SetWage = new System.Windows.Forms.TextBox();
            this.SetWage_button = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(30, 26);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(139, 17);
            this.label1.TabIndex = 0;
            this.label1.Text = "Please Select Wage:";
            // 
            // SetWage
            // 
            this.SetWage.Location = new System.Drawing.Point(196, 26);
            this.SetWage.Name = "SetWage";
            this.SetWage.Size = new System.Drawing.Size(100, 22);
            this.SetWage.TabIndex = 1;
            // 
            // SetWage_button
            // 
            this.SetWage_button.Location = new System.Drawing.Point(236, 82);
            this.SetWage_button.Name = "SetWage_button";
            this.SetWage_button.Size = new System.Drawing.Size(94, 31);
            this.SetWage_button.TabIndex = 2;
            this.SetWage_button.Text = "Set Wage";
            this.SetWage_button.UseVisualStyleBackColor = true;
            this.SetWage_button.Click += new System.EventHandler(this.SetWage_button_Click);
            // 
            // Wage
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(361, 125);
            this.Controls.Add(this.SetWage_button);
            this.Controls.Add(this.SetWage);
            this.Controls.Add(this.label1);
            this.Name = "Wage";
            this.ShowIcon = false;
            this.Text = "Wage";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label label1;
        public System.Windows.Forms.TextBox SetWage;
        private System.Windows.Forms.Button SetWage_button;
    }
}