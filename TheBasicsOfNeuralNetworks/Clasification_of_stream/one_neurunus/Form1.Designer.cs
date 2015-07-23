namespace one_neurunus
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
            System.Windows.Forms.DataVisualization.Charting.ChartArea chartArea2 = new System.Windows.Forms.DataVisualization.Charting.ChartArea();
            System.Windows.Forms.DataVisualization.Charting.Legend legend2 = new System.Windows.Forms.DataVisualization.Charting.Legend();
            System.Windows.Forms.DataVisualization.Charting.Series series4 = new System.Windows.Forms.DataVisualization.Charting.Series();
            System.Windows.Forms.DataVisualization.Charting.Series series5 = new System.Windows.Forms.DataVisualization.Charting.Series();
            System.Windows.Forms.DataVisualization.Charting.Series series6 = new System.Windows.Forms.DataVisualization.Charting.Series();
            this.viNM = new System.Windows.Forms.DataVisualization.Charting.Chart();
            this.speedTB = new System.Windows.Forms.TextBox();
            this.sygmaTB = new System.Windows.Forms.TextBox();
            this.speedL = new System.Windows.Forms.Label();
            this.sygmaL = new System.Windows.Forms.Label();
            this.maxIterL = new System.Windows.Forms.Label();
            this.errorL = new System.Windows.Forms.Label();
            this.maxIterTB = new System.Windows.Forms.TextBox();
            this.errorTB = new System.Windows.Forms.TextBox();
            this.studyBtn = new System.Windows.Forms.Button();
            this.testBtn = new System.Windows.Forms.Button();
            this.label3 = new System.Windows.Forms.Label();
            this.stPairsTB = new System.Windows.Forms.TextBox();
            this.label4 = new System.Windows.Forms.Label();
            this.IterationsTB = new System.Windows.Forms.TextBox();
            this.label1 = new System.Windows.Forms.Label();
            this.MX1TB = new System.Windows.Forms.TextBox();
            this.label2 = new System.Windows.Forms.Label();
            this.MX2TB = new System.Windows.Forms.TextBox();
            this.label5 = new System.Windows.Forms.Label();
            this.DX2TB = new System.Windows.Forms.TextBox();
            this.label6 = new System.Windows.Forms.Label();
            this.DX1TB = new System.Windows.Forms.TextBox();
            ((System.ComponentModel.ISupportInitialize)(this.viNM)).BeginInit();
            this.SuspendLayout();
            // 
            // viNM
            // 
            this.viNM.BorderlineWidth = 3;
            chartArea2.Name = "ChartArea1";
            this.viNM.ChartAreas.Add(chartArea2);
            legend2.Name = "Legend1";
            this.viNM.Legends.Add(legend2);
            this.viNM.Location = new System.Drawing.Point(2, 2);
            this.viNM.Name = "viNM";
            this.viNM.Palette = System.Windows.Forms.DataVisualization.Charting.ChartColorPalette.Fire;
            series4.ChartArea = "ChartArea1";
            series4.ChartType = System.Windows.Forms.DataVisualization.Charting.SeriesChartType.Point;
            series4.Legend = "Legend1";
            series4.MarkerSize = 8;
            series4.Name = "Class1";
            series4.YValuesPerPoint = 2;
            series5.BorderWidth = 3;
            series5.ChartArea = "ChartArea1";
            series5.ChartType = System.Windows.Forms.DataVisualization.Charting.SeriesChartType.Spline;
            series5.Legend = "Legend1";
            series5.Name = "Devider";
            series6.ChartArea = "ChartArea1";
            series6.ChartType = System.Windows.Forms.DataVisualization.Charting.SeriesChartType.Point;
            series6.Legend = "Legend1";
            series6.MarkerSize = 8;
            series6.Name = "Class2";
            this.viNM.Series.Add(series4);
            this.viNM.Series.Add(series5);
            this.viNM.Series.Add(series6);
            this.viNM.Size = new System.Drawing.Size(501, 396);
            this.viNM.TabIndex = 0;
            this.viNM.Text = "viNM";
            // 
            // speedTB
            // 
            this.speedTB.Location = new System.Drawing.Point(683, 94);
            this.speedTB.Name = "speedTB";
            this.speedTB.Size = new System.Drawing.Size(70, 20);
            this.speedTB.TabIndex = 3;
            this.speedTB.Text = "0,9";
            // 
            // sygmaTB
            // 
            this.sygmaTB.Location = new System.Drawing.Point(683, 129);
            this.sygmaTB.Name = "sygmaTB";
            this.sygmaTB.Size = new System.Drawing.Size(70, 20);
            this.sygmaTB.TabIndex = 4;
            this.sygmaTB.Text = "1";
            // 
            // speedL
            // 
            this.speedL.AutoSize = true;
            this.speedL.Location = new System.Drawing.Point(509, 101);
            this.speedL.Name = "speedL";
            this.speedL.Size = new System.Drawing.Size(109, 13);
            this.speedL.TabIndex = 5;
            this.speedL.Text = "Швидкість навчання";
            // 
            // sygmaL
            // 
            this.sygmaL.AutoSize = true;
            this.sygmaL.Location = new System.Drawing.Point(509, 136);
            this.sygmaL.Name = "sygmaL";
            this.sygmaL.Size = new System.Drawing.Size(142, 13);
            this.sygmaL.TabIndex = 6;
            this.sygmaL.Text = "Крутизна функції активації";
            // 
            // maxIterL
            // 
            this.maxIterL.AutoSize = true;
            this.maxIterL.Location = new System.Drawing.Point(509, 208);
            this.maxIterL.Name = "maxIterL";
            this.maxIterL.Size = new System.Drawing.Size(127, 13);
            this.maxIterL.TabIndex = 10;
            this.maxIterL.Text = "Макс. кількість ітерацій";
            // 
            // errorL
            // 
            this.errorL.AutoSize = true;
            this.errorL.Location = new System.Drawing.Point(509, 172);
            this.errorL.Name = "errorL";
            this.errorL.Size = new System.Drawing.Size(50, 13);
            this.errorL.TabIndex = 9;
            this.errorL.Text = "Похибка";
            // 
            // maxIterTB
            // 
            this.maxIterTB.Location = new System.Drawing.Point(683, 201);
            this.maxIterTB.Name = "maxIterTB";
            this.maxIterTB.Size = new System.Drawing.Size(70, 20);
            this.maxIterTB.TabIndex = 8;
            this.maxIterTB.Text = "1000";
            // 
            // errorTB
            // 
            this.errorTB.Location = new System.Drawing.Point(683, 165);
            this.errorTB.Name = "errorTB";
            this.errorTB.Size = new System.Drawing.Size(70, 20);
            this.errorTB.TabIndex = 7;
            this.errorTB.Text = "0,01";
            // 
            // studyBtn
            // 
            this.studyBtn.Location = new System.Drawing.Point(512, 375);
            this.studyBtn.Name = "studyBtn";
            this.studyBtn.Size = new System.Drawing.Size(70, 24);
            this.studyBtn.TabIndex = 13;
            this.studyBtn.Text = "Навчити";
            this.studyBtn.UseVisualStyleBackColor = true;
            this.studyBtn.Click += new System.EventHandler(this.studyBtn_Click);
            // 
            // testBtn
            // 
            this.testBtn.Location = new System.Drawing.Point(678, 375);
            this.testBtn.Name = "testBtn";
            this.testBtn.Size = new System.Drawing.Size(75, 23);
            this.testBtn.TabIndex = 14;
            this.testBtn.Text = "Тестувати";
            this.testBtn.UseVisualStyleBackColor = true;
            this.testBtn.Click += new System.EventHandler(this.testBtn_Click);
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(509, 242);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(130, 13);
            this.label3.TabIndex = 22;
            this.label3.Text = "Кількість навчаючих пар";
            // 
            // stPairsTB
            // 
            this.stPairsTB.Location = new System.Drawing.Point(683, 235);
            this.stPairsTB.Name = "stPairsTB";
            this.stPairsTB.Size = new System.Drawing.Size(70, 20);
            this.stPairsTB.TabIndex = 21;
            this.stPairsTB.Text = "100";
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(509, 276);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(129, 13);
            this.label4.TabIndex = 24;
            this.label4.Text = "Кількість епох навчання";
            // 
            // IterationsTB
            // 
            this.IterationsTB.Enabled = false;
            this.IterationsTB.Location = new System.Drawing.Point(683, 269);
            this.IterationsTB.Name = "IterationsTB";
            this.IterationsTB.Size = new System.Drawing.Size(70, 20);
            this.IterationsTB.TabIndex = 23;
            this.IterationsTB.Text = "0";
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(509, 22);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(22, 13);
            this.label1.TabIndex = 26;
            this.label1.Text = "M1";
            // 
            // MX1TB
            // 
            this.MX1TB.Location = new System.Drawing.Point(548, 19);
            this.MX1TB.Name = "MX1TB";
            this.MX1TB.Size = new System.Drawing.Size(70, 20);
            this.MX1TB.TabIndex = 25;
            this.MX1TB.Text = "0,21";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(509, 48);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(22, 13);
            this.label2.TabIndex = 28;
            this.label2.Text = "M2";
            // 
            // MX2TB
            // 
            this.MX2TB.Location = new System.Drawing.Point(548, 45);
            this.MX2TB.Name = "MX2TB";
            this.MX2TB.Size = new System.Drawing.Size(70, 20);
            this.MX2TB.TabIndex = 27;
            this.MX2TB.Text = "0,95";
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Location = new System.Drawing.Point(644, 45);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(21, 13);
            this.label5.TabIndex = 32;
            this.label5.Text = "D2";
            // 
            // DX2TB
            // 
            this.DX2TB.Location = new System.Drawing.Point(683, 42);
            this.DX2TB.Name = "DX2TB";
            this.DX2TB.Size = new System.Drawing.Size(70, 20);
            this.DX2TB.TabIndex = 31;
            this.DX2TB.Text = "0,2";
            // 
            // label6
            // 
            this.label6.AutoSize = true;
            this.label6.Location = new System.Drawing.Point(644, 19);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(21, 13);
            this.label6.TabIndex = 30;
            this.label6.Text = "D1";
            // 
            // DX1TB
            // 
            this.DX1TB.Location = new System.Drawing.Point(683, 16);
            this.DX1TB.Name = "DX1TB";
            this.DX1TB.Size = new System.Drawing.Size(70, 20);
            this.DX1TB.TabIndex = 29;
            this.DX1TB.Text = "0,12";
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(767, 406);
            this.Controls.Add(this.label5);
            this.Controls.Add(this.DX2TB);
            this.Controls.Add(this.label6);
            this.Controls.Add(this.DX1TB);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.MX2TB);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.MX1TB);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.IterationsTB);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.stPairsTB);
            this.Controls.Add(this.testBtn);
            this.Controls.Add(this.studyBtn);
            this.Controls.Add(this.maxIterL);
            this.Controls.Add(this.errorL);
            this.Controls.Add(this.maxIterTB);
            this.Controls.Add(this.errorTB);
            this.Controls.Add(this.sygmaL);
            this.Controls.Add(this.speedL);
            this.Controls.Add(this.sygmaTB);
            this.Controls.Add(this.speedTB);
            this.Controls.Add(this.viNM);
            this.Name = "Form1";
            this.Text = "Класифікація вхідного потоку даних";
            ((System.ComponentModel.ISupportInitialize)(this.viNM)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.DataVisualization.Charting.Chart viNM;
        private System.Windows.Forms.TextBox speedTB;
        private System.Windows.Forms.TextBox sygmaTB;
        private System.Windows.Forms.Label speedL;
        private System.Windows.Forms.Label sygmaL;
        private System.Windows.Forms.Label maxIterL;
        private System.Windows.Forms.Label errorL;
        private System.Windows.Forms.TextBox maxIterTB;
        private System.Windows.Forms.TextBox errorTB;
        private System.Windows.Forms.Button studyBtn;
        private System.Windows.Forms.Button testBtn;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.TextBox stPairsTB;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.TextBox IterationsTB;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.TextBox MX1TB;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.TextBox MX2TB;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.TextBox DX2TB;
        private System.Windows.Forms.Label label6;
        private System.Windows.Forms.TextBox DX1TB;
    }
}

