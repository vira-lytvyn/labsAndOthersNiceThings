namespace WaveAlg.HelperForms
{
    partial class About
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
            this.AboutField = new System.Windows.Forms.RichTextBox();
            this.SuspendLayout();
            // 
            // AboutField
            // 
            this.AboutField.Location = new System.Drawing.Point(9, 10);
            this.AboutField.Margin = new System.Windows.Forms.Padding(2, 2, 2, 2);
            this.AboutField.Name = "AboutField";
            this.AboutField.ReadOnly = true;
            this.AboutField.Size = new System.Drawing.Size(391, 149);
            this.AboutField.TabIndex = 0;
            this.AboutField.Text = "";
            // 
            // About
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(413, 186);
            this.Controls.Add(this.AboutField);
            this.Margin = new System.Windows.Forms.Padding(2, 2, 2, 2);
            this.Name = "About";
            this.Text = "Про програму";
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.RichTextBox AboutField;
    }
}