namespace RSAAlgoritm
{
    partial class MainApp
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
            this.EnterText = new System.Windows.Forms.RichTextBox();
            this.label1 = new System.Windows.Forms.Label();
            this.CryptedText = new System.Windows.Forms.RichTextBox();
            this.label2 = new System.Windows.Forms.Label();
            this.DecryptedText = new System.Windows.Forms.RichTextBox();
            this.label3 = new System.Windows.Forms.Label();
            this.Crypt = new System.Windows.Forms.Button();
            this.Decrypt = new System.Windows.Forms.Button();
            this.menuStrip1 = new System.Windows.Forms.MenuStrip();
            this.fILEToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.keysToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.generateKeysToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.label4 = new System.Windows.Forms.Label();
            this.label5 = new System.Windows.Forms.Label();
            this.PPrime = new System.Windows.Forms.TextBox();
            this.QPrime = new System.Windows.Forms.TextBox();
            this.menuStrip1.SuspendLayout();
            this.SuspendLayout();
            // 
            // EnterText
            // 
            this.EnterText.Location = new System.Drawing.Point(9, 39);
            this.EnterText.Margin = new System.Windows.Forms.Padding(2, 2, 2, 2);
            this.EnterText.Name = "EnterText";
            this.EnterText.Size = new System.Drawing.Size(208, 96);
            this.EnterText.TabIndex = 0;
            this.EnterText.Text = "";
            this.EnterText.TextChanged += new System.EventHandler(this.EnterText_TextChanged);
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(9, 23);
            this.label1.Margin = new System.Windows.Forms.Padding(2, 0, 2, 0);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(135, 13);
            this.label1.TabIndex = 1;
            this.label1.Text = "Enter Your string to encrypt";
            // 
            // CryptedText
            // 
            this.CryptedText.Location = new System.Drawing.Point(9, 166);
            this.CryptedText.Margin = new System.Windows.Forms.Padding(2, 2, 2, 2);
            this.CryptedText.Name = "CryptedText";
            this.CryptedText.Size = new System.Drawing.Size(208, 96);
            this.CryptedText.TabIndex = 2;
            this.CryptedText.Text = "";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(9, 150);
            this.label2.Margin = new System.Windows.Forms.Padding(2, 0, 2, 0);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(46, 13);
            this.label2.TabIndex = 3;
            this.label2.Text = "Crypted:";
            // 
            // DecryptedText
            // 
            this.DecryptedText.Location = new System.Drawing.Point(9, 299);
            this.DecryptedText.Margin = new System.Windows.Forms.Padding(2, 2, 2, 2);
            this.DecryptedText.Name = "DecryptedText";
            this.DecryptedText.Size = new System.Drawing.Size(208, 96);
            this.DecryptedText.TabIndex = 4;
            this.DecryptedText.Text = "";
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(9, 275);
            this.label3.Margin = new System.Windows.Forms.Padding(2, 0, 2, 0);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(59, 13);
            this.label3.TabIndex = 5;
            this.label3.Text = "Decrypted:";
            // 
            // Crypt
            // 
            this.Crypt.Location = new System.Drawing.Point(250, 299);
            this.Crypt.Margin = new System.Windows.Forms.Padding(2, 2, 2, 2);
            this.Crypt.Name = "Crypt";
            this.Crypt.Size = new System.Drawing.Size(97, 48);
            this.Crypt.TabIndex = 6;
            this.Crypt.Text = "Crypt!";
            this.Crypt.UseVisualStyleBackColor = true;
            this.Crypt.Click += new System.EventHandler(this.Crypt_Click);
            // 
            // Decrypt
            // 
            this.Decrypt.Location = new System.Drawing.Point(250, 366);
            this.Decrypt.Margin = new System.Windows.Forms.Padding(2, 2, 2, 2);
            this.Decrypt.Name = "Decrypt";
            this.Decrypt.Size = new System.Drawing.Size(97, 51);
            this.Decrypt.TabIndex = 7;
            this.Decrypt.Text = "Decrypt";
            this.Decrypt.UseVisualStyleBackColor = true;
            this.Decrypt.Click += new System.EventHandler(this.Decrypt_Click);
            // 
            // menuStrip1
            // 
            this.menuStrip1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.fILEToolStripMenuItem,
            this.keysToolStripMenuItem});
            this.menuStrip1.Location = new System.Drawing.Point(0, 0);
            this.menuStrip1.Name = "menuStrip1";
            this.menuStrip1.Padding = new System.Windows.Forms.Padding(4, 2, 0, 2);
            this.menuStrip1.Size = new System.Drawing.Size(403, 24);
            this.menuStrip1.TabIndex = 8;
            this.menuStrip1.Text = "menuStrip1";
            // 
            // fILEToolStripMenuItem
            // 
            this.fILEToolStripMenuItem.Name = "fILEToolStripMenuItem";
            this.fILEToolStripMenuItem.Size = new System.Drawing.Size(40, 20);
            this.fILEToolStripMenuItem.Text = "FILE";
            // 
            // keysToolStripMenuItem
            // 
            this.keysToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.generateKeysToolStripMenuItem});
            this.keysToolStripMenuItem.Name = "keysToolStripMenuItem";
            this.keysToolStripMenuItem.Size = new System.Drawing.Size(43, 20);
            this.keysToolStripMenuItem.Text = "Keys";
            // 
            // generateKeysToolStripMenuItem
            // 
            this.generateKeysToolStripMenuItem.Name = "generateKeysToolStripMenuItem";
            this.generateKeysToolStripMenuItem.Size = new System.Drawing.Size(152, 22);
            this.generateKeysToolStripMenuItem.Text = "Generate Keys";
            this.generateKeysToolStripMenuItem.Click += new System.EventHandler(this.generateKeysToolStripMenuItem_Click);
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(237, 39);
            this.label4.Margin = new System.Windows.Forms.Padding(2, 0, 2, 0);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(22, 13);
            this.label4.TabIndex = 9;
            this.label4.Text = "p= ";
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Location = new System.Drawing.Point(237, 79);
            this.label5.Margin = new System.Windows.Forms.Padding(2, 0, 2, 0);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(22, 13);
            this.label5.TabIndex = 10;
            this.label5.Text = "q= ";
            // 
            // PPrime
            // 
            this.PPrime.Location = new System.Drawing.Point(284, 39);
            this.PPrime.Margin = new System.Windows.Forms.Padding(2, 2, 2, 2);
            this.PPrime.Name = "PPrime";
            this.PPrime.Size = new System.Drawing.Size(72, 20);
            this.PPrime.TabIndex = 11;
            // 
            // QPrime
            // 
            this.QPrime.Location = new System.Drawing.Point(284, 79);
            this.QPrime.Margin = new System.Windows.Forms.Padding(2, 2, 2, 2);
            this.QPrime.Name = "QPrime";
            this.QPrime.Size = new System.Drawing.Size(72, 20);
            this.QPrime.TabIndex = 12;
            // 
            // MainApp
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(403, 457);
            this.Controls.Add(this.QPrime);
            this.Controls.Add(this.PPrime);
            this.Controls.Add(this.label5);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.Decrypt);
            this.Controls.Add(this.Crypt);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.DecryptedText);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.CryptedText);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.EnterText);
            this.Controls.Add(this.menuStrip1);
            this.MainMenuStrip = this.menuStrip1;
            this.Margin = new System.Windows.Forms.Padding(2, 2, 2, 2);
            this.Name = "MainApp";
            this.ShowIcon = false;
            this.Text = "RSA Kryzhanovskyi";
            this.menuStrip1.ResumeLayout(false);
            this.menuStrip1.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Button Crypt;
        public System.Windows.Forms.RichTextBox EnterText;
        public System.Windows.Forms.RichTextBox CryptedText;
        public System.Windows.Forms.RichTextBox DecryptedText;
        public System.Windows.Forms.Button Decrypt;
        private System.Windows.Forms.MenuStrip menuStrip1;
        private System.Windows.Forms.ToolStripMenuItem fILEToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem keysToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem generateKeysToolStripMenuItem;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.Label label5;
        public System.Windows.Forms.TextBox PPrime;
        public System.Windows.Forms.TextBox QPrime;
    }
}

