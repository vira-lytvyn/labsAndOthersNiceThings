namespace Perevantajzennya
{
    partial class Form1
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
            this.Rah = new System.Windows.Forms.Button();
            this.L1 = new System.Windows.Forms.Label();
            this.L2 = new System.Windows.Forms.Label();
            this.L3 = new System.Windows.Forms.Label();
            this.label1 = new System.Windows.Forms.Label();
            this.First = new System.Windows.Forms.TextBox();
            this.Second = new System.Windows.Forms.TextBox();
            this.Third = new System.Windows.Forms.TextBox();
            this.Stb = new System.Windows.Forms.TextBox();
            this.Resul = new System.Windows.Forms.Label();
            this.figurname = new System.Windows.Forms.Label();
            this.comboBox1 = new System.Windows.Forms.ComboBox();
            this.label2 = new System.Windows.Forms.Label();
            this.L4 = new System.Windows.Forms.Label();
            this.Fourth = new System.Windows.Forms.TextBox();
            this.SuspendLayout();
            // 
            // Rah
            // 
            this.Rah.Location = new System.Drawing.Point(502, 230);
            this.Rah.Name = "Rah";
            this.Rah.Size = new System.Drawing.Size(75, 23);
            this.Rah.TabIndex = 0;
            this.Rah.Text = "Do";
            this.Rah.UseVisualStyleBackColor = true;
            this.Rah.Click += new System.EventHandler(this.Rah_Click);
            // 
            // L1
            // 
            this.L1.AutoSize = true;
            this.L1.Location = new System.Drawing.Point(23, 64);
            this.L1.Name = "L1";
            this.L1.Size = new System.Drawing.Size(48, 13);
            this.L1.TabIndex = 1;
            this.L1.Text = "First side";
            this.L1.Visible = false;
            // 
            // L2
            // 
            this.L2.AutoSize = true;
            this.L2.Location = new System.Drawing.Point(23, 103);
            this.L2.Name = "L2";
            this.L2.Size = new System.Drawing.Size(66, 13);
            this.L2.TabIndex = 2;
            this.L2.Text = "Second side";
            this.L2.Visible = false;
            // 
            // L3
            // 
            this.L3.AutoSize = true;
            this.L3.Location = new System.Drawing.Point(23, 140);
            this.L3.Name = "L3";
            this.L3.Size = new System.Drawing.Size(53, 13);
            this.L3.TabIndex = 3;
            this.L3.Text = "Third side";
            this.L3.Visible = false;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.label1.Location = new System.Drawing.Point(23, 20);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(81, 17);
            this.label1.TabIndex = 4;
            this.label1.Text = "Input data";
            // 
            // First
            // 
            this.First.Location = new System.Drawing.Point(102, 64);
            this.First.Name = "First";
            this.First.Size = new System.Drawing.Size(100, 20);
            this.First.TabIndex = 5;
            this.First.Visible = false;
            // 
            // Second
            // 
            this.Second.Location = new System.Drawing.Point(102, 103);
            this.Second.Name = "Second";
            this.Second.Size = new System.Drawing.Size(100, 20);
            this.Second.TabIndex = 6;
            this.Second.Visible = false;
            // 
            // Third
            // 
            this.Third.Location = new System.Drawing.Point(102, 140);
            this.Third.Name = "Third";
            this.Third.Size = new System.Drawing.Size(100, 20);
            this.Third.TabIndex = 7;
            this.Third.Visible = false;
            // 
            // Stb
            // 
            this.Stb.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.Stb.Location = new System.Drawing.Point(247, 210);
            this.Stb.Name = "Stb";
            this.Stb.Size = new System.Drawing.Size(100, 23);
            this.Stb.TabIndex = 8;
            // 
            // Resul
            // 
            this.Resul.AutoSize = true;
            this.Resul.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.Resul.Location = new System.Drawing.Point(23, 210);
            this.Resul.Name = "Resul";
            this.Resul.Size = new System.Drawing.Size(66, 17);
            this.Resul.TabIndex = 9;
            this.Resul.Text = "Area of ";
            // 
            // figurname
            // 
            this.figurname.AutoSize = true;
            this.figurname.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.figurname.Location = new System.Drawing.Point(89, 210);
            this.figurname.Name = "figurname";
            this.figurname.Size = new System.Drawing.Size(0, 17);
            this.figurname.TabIndex = 10;
            // 
            // comboBox1
            // 
            this.comboBox1.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.comboBox1.FormattingEnabled = true;
            this.comboBox1.Items.AddRange(new object[] {
            "Rectangle",
            "Square ",
            "Triangle",
            "Trapeze"});
            this.comboBox1.Location = new System.Drawing.Point(394, 56);
            this.comboBox1.Name = "comboBox1";
            this.comboBox1.Size = new System.Drawing.Size(121, 24);
            this.comboBox1.TabIndex = 11;
            this.comboBox1.SelectedIndexChanged += new System.EventHandler(this.comboBox1_SelectedIndexChanged);
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.label2.Location = new System.Drawing.Point(378, 20);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(137, 17);
            this.label2.TabIndex = 12;
            this.label2.Text = "Choose the figure";
            // 
            // L4
            // 
            this.L4.AutoSize = true;
            this.L4.Location = new System.Drawing.Point(23, 175);
            this.L4.Name = "L4";
            this.L4.Size = new System.Drawing.Size(59, 13);
            this.L4.TabIndex = 13;
            this.L4.Text = "Fourth side";
            this.L4.Visible = false;
            // 
            // Fourth
            // 
            this.Fourth.Location = new System.Drawing.Point(102, 175);
            this.Fourth.Name = "Fourth";
            this.Fourth.Size = new System.Drawing.Size(100, 20);
            this.Fourth.TabIndex = 14;
            this.Fourth.Visible = false;
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(589, 265);
            this.Controls.Add(this.Fourth);
            this.Controls.Add(this.L4);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.comboBox1);
            this.Controls.Add(this.figurname);
            this.Controls.Add(this.Resul);
            this.Controls.Add(this.Stb);
            this.Controls.Add(this.Third);
            this.Controls.Add(this.Second);
            this.Controls.Add(this.First);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.L3);
            this.Controls.Add(this.L2);
            this.Controls.Add(this.L1);
            this.Controls.Add(this.Rah);
            this.Name = "Form1";
            this.Text = "Form1";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Button Rah;
        private System.Windows.Forms.Label L1;
        private System.Windows.Forms.Label L2;
        private System.Windows.Forms.Label L3;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.TextBox First;
        private System.Windows.Forms.TextBox Second;
        private System.Windows.Forms.TextBox Third;
        private System.Windows.Forms.TextBox Stb;
        private System.Windows.Forms.Label Resul;
        private System.Windows.Forms.Label figurname;
        private System.Windows.Forms.ComboBox comboBox1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label L4;
        private System.Windows.Forms.TextBox Fourth;
    }
}

