namespace Statistics
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
            System.Windows.Forms.DataVisualization.Charting.ChartArea chartArea1 = new System.Windows.Forms.DataVisualization.Charting.ChartArea();
            System.Windows.Forms.DataVisualization.Charting.Legend legend1 = new System.Windows.Forms.DataVisualization.Charting.Legend();
            System.Windows.Forms.DataVisualization.Charting.Series series1 = new System.Windows.Forms.DataVisualization.Charting.Series();
            this.panel1 = new System.Windows.Forms.Panel();
            this.RandomSampleCH = new System.Windows.Forms.DataVisualization.Charting.Chart();
            this.panel2 = new System.Windows.Forms.Panel();
            this.CalculateBTN = new System.Windows.Forms.Button();
            this.GenerateBTN = new System.Windows.Forms.Button();
            this.StudentNumberTB = new System.Windows.Forms.TextBox();
            this.label7 = new System.Windows.Forms.Label();
            this.AvgGarmonicTB = new System.Windows.Forms.TextBox();
            this.label6 = new System.Windows.Forms.Label();
            this.AvgGeometricsTB = new System.Windows.Forms.TextBox();
            this.label5 = new System.Windows.Forms.Label();
            this.AvgSquareTB = new System.Windows.Forms.TextBox();
            this.label4 = new System.Windows.Forms.Label();
            this.MedianTB = new System.Windows.Forms.TextBox();
            this.label3 = new System.Windows.Forms.Label();
            this.FashionTB = new System.Windows.Forms.TextBox();
            this.label2 = new System.Windows.Forms.Label();
            this.AvgArithmeticsTB = new System.Windows.Forms.TextBox();
            this.label1 = new System.Windows.Forms.Label();
            this.panel1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.RandomSampleCH)).BeginInit();
            this.panel2.SuspendLayout();
            this.SuspendLayout();
            // 
            // panel1
            // 
            this.panel1.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D;
            this.panel1.Controls.Add(this.RandomSampleCH);
            this.panel1.Location = new System.Drawing.Point(1, 1);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(603, 368);
            this.panel1.TabIndex = 0;
            // 
            // RandomSampleCH
            // 
            chartArea1.Name = "ChartArea1";
            this.RandomSampleCH.ChartAreas.Add(chartArea1);
            legend1.Name = "Legend1";
            this.RandomSampleCH.Legends.Add(legend1);
            this.RandomSampleCH.Location = new System.Drawing.Point(3, 3);
            this.RandomSampleCH.Name = "RandomSampleCH";
            series1.ChartArea = "ChartArea1";
            series1.Legend = "Legend1";
            series1.Name = " ";
            this.RandomSampleCH.Series.Add(series1);
            this.RandomSampleCH.Size = new System.Drawing.Size(593, 358);
            this.RandomSampleCH.TabIndex = 0;
            // 
            // panel2
            // 
            this.panel2.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D;
            this.panel2.Controls.Add(this.CalculateBTN);
            this.panel2.Controls.Add(this.GenerateBTN);
            this.panel2.Controls.Add(this.StudentNumberTB);
            this.panel2.Controls.Add(this.label7);
            this.panel2.Controls.Add(this.AvgGarmonicTB);
            this.panel2.Controls.Add(this.label6);
            this.panel2.Controls.Add(this.AvgGeometricsTB);
            this.panel2.Controls.Add(this.label5);
            this.panel2.Controls.Add(this.AvgSquareTB);
            this.panel2.Controls.Add(this.label4);
            this.panel2.Controls.Add(this.MedianTB);
            this.panel2.Controls.Add(this.label3);
            this.panel2.Controls.Add(this.FashionTB);
            this.panel2.Controls.Add(this.label2);
            this.panel2.Controls.Add(this.AvgArithmeticsTB);
            this.panel2.Controls.Add(this.label1);
            this.panel2.Location = new System.Drawing.Point(610, 1);
            this.panel2.Name = "panel2";
            this.panel2.Size = new System.Drawing.Size(277, 368);
            this.panel2.TabIndex = 1;
            // 
            // CalculateBTN
            // 
            this.CalculateBTN.Location = new System.Drawing.Point(183, 331);
            this.CalculateBTN.Name = "CalculateBTN";
            this.CalculateBTN.Size = new System.Drawing.Size(83, 23);
            this.CalculateBTN.TabIndex = 15;
            this.CalculateBTN.Text = "Обчислити";
            this.CalculateBTN.UseVisualStyleBackColor = true;
            this.CalculateBTN.Click += new System.EventHandler(this.CalculateBTN_Click);
            // 
            // GenerateBTN
            // 
            this.GenerateBTN.Location = new System.Drawing.Point(18, 332);
            this.GenerateBTN.Name = "GenerateBTN";
            this.GenerateBTN.Size = new System.Drawing.Size(86, 23);
            this.GenerateBTN.TabIndex = 14;
            this.GenerateBTN.Text = "Згенерувати";
            this.GenerateBTN.UseVisualStyleBackColor = true;
            this.GenerateBTN.Click += new System.EventHandler(this.GenerateBTN_Click);
            // 
            // StudentNumberTB
            // 
            this.StudentNumberTB.Enabled = false;
            this.StudentNumberTB.Location = new System.Drawing.Point(183, 20);
            this.StudentNumberTB.Name = "StudentNumberTB";
            this.StudentNumberTB.Size = new System.Drawing.Size(84, 20);
            this.StudentNumberTB.TabIndex = 13;
            this.StudentNumberTB.Text = "7";
            // 
            // label7
            // 
            this.label7.AutoSize = true;
            this.label7.Location = new System.Drawing.Point(15, 20);
            this.label7.Name = "label7";
            this.label7.Size = new System.Drawing.Size(96, 13);
            this.label7.TabIndex = 12;
            this.label7.Text = "Варіант в журналі";
            // 
            // AvgGarmonicTB
            // 
            this.AvgGarmonicTB.Enabled = false;
            this.AvgGarmonicTB.Location = new System.Drawing.Point(183, 230);
            this.AvgGarmonicTB.Name = "AvgGarmonicTB";
            this.AvgGarmonicTB.Size = new System.Drawing.Size(84, 20);
            this.AvgGarmonicTB.TabIndex = 11;
            // 
            // label6
            // 
            this.label6.AutoSize = true;
            this.label6.Location = new System.Drawing.Point(15, 233);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(109, 13);
            this.label6.TabIndex = 10;
            this.label6.Text = "Середнє гармонічне";
            // 
            // AvgGeometricsTB
            // 
            this.AvgGeometricsTB.Enabled = false;
            this.AvgGeometricsTB.Location = new System.Drawing.Point(183, 195);
            this.AvgGeometricsTB.Name = "AvgGeometricsTB";
            this.AvgGeometricsTB.Size = new System.Drawing.Size(84, 20);
            this.AvgGeometricsTB.TabIndex = 9;
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Location = new System.Drawing.Point(15, 198);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(118, 13);
            this.label5.TabIndex = 8;
            this.label5.Text = "Середнє геометричне";
            // 
            // AvgSquareTB
            // 
            this.AvgSquareTB.Enabled = false;
            this.AvgSquareTB.Location = new System.Drawing.Point(183, 160);
            this.AvgSquareTB.Name = "AvgSquareTB";
            this.AvgSquareTB.Size = new System.Drawing.Size(84, 20);
            this.AvgSquareTB.TabIndex = 7;
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(15, 163);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(117, 13);
            this.label4.TabIndex = 6;
            this.label4.Text = "Середнє квадратичне";
            // 
            // MedianTB
            // 
            this.MedianTB.Enabled = false;
            this.MedianTB.Location = new System.Drawing.Point(183, 125);
            this.MedianTB.Name = "MedianTB";
            this.MedianTB.Size = new System.Drawing.Size(84, 20);
            this.MedianTB.TabIndex = 5;
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(15, 128);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(89, 13);
            this.label3.TabIndex = 4;
            this.label3.Text = "Медіана вибірки";
            // 
            // FashionTB
            // 
            this.FashionTB.Enabled = false;
            this.FashionTB.Location = new System.Drawing.Point(183, 90);
            this.FashionTB.Name = "FashionTB";
            this.FashionTB.Size = new System.Drawing.Size(84, 20);
            this.FashionTB.TabIndex = 3;
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(15, 93);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(75, 13);
            this.label2.TabIndex = 2;
            this.label2.Text = "Мода вибірки";
            // 
            // AvgArithmeticsTB
            // 
            this.AvgArithmeticsTB.Enabled = false;
            this.AvgArithmeticsTB.Location = new System.Drawing.Point(183, 55);
            this.AvgArithmeticsTB.Name = "AvgArithmeticsTB";
            this.AvgArithmeticsTB.Size = new System.Drawing.Size(84, 20);
            this.AvgArithmeticsTB.TabIndex = 1;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(15, 55);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(121, 13);
            this.label1.TabIndex = 0;
            this.label1.Text = "Середнє арифметичне";
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(888, 370);
            this.Controls.Add(this.panel2);
            this.Controls.Add(this.panel1);
            this.Name = "Form1";
            this.Text = "Обчислення середніх величин";
            this.panel1.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.RandomSampleCH)).EndInit();
            this.panel2.ResumeLayout(false);
            this.panel2.PerformLayout();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Panel panel1;
        private System.Windows.Forms.DataVisualization.Charting.Chart RandomSampleCH;
        private System.Windows.Forms.Panel panel2;
        private System.Windows.Forms.TextBox AvgGeometricsTB;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.TextBox AvgSquareTB;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.TextBox MedianTB;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.TextBox FashionTB;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.TextBox AvgArithmeticsTB;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.TextBox AvgGarmonicTB;
        private System.Windows.Forms.Label label6;
        private System.Windows.Forms.TextBox StudentNumberTB;
        private System.Windows.Forms.Label label7;
        private System.Windows.Forms.Button CalculateBTN;
        private System.Windows.Forms.Button GenerateBTN;
    }
}

