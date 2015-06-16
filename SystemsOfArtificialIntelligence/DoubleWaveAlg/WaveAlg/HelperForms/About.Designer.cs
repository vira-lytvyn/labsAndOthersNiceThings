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
            this.AboutField.Location = new System.Drawing.Point(12, 12);
            this.AboutField.Name = "AboutField";
            this.AboutField.ReadOnly = true;
            this.AboutField.Size = new System.Drawing.Size(520, 183);
            this.AboutField.TabIndex = 0;
            this.AboutField.Text = "";
            // 
            // About
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(551, 229);
            this.Controls.Add(this.AboutField);
            this.Name = "About";
            this.Text = "About";
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.RichTextBox AboutField;
    }
}