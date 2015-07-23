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
            System.Windows.Forms.DataVisualization.Charting.ChartArea chartArea3 = new System.Windows.Forms.DataVisualization.Charting.ChartArea();
            System.Windows.Forms.DataVisualization.Charting.Legend legend3 = new System.Windows.Forms.DataVisualization.Charting.Legend();
            System.Windows.Forms.DataVisualization.Charting.Series series5 = new System.Windows.Forms.DataVisualization.Charting.Series();
            System.Windows.Forms.DataVisualization.Charting.Series series6 = new System.Windows.Forms.DataVisualization.Charting.Series();
            this.viNM = new System.Windows.Forms.DataVisualization.Charting.Chart();
            this.label1 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.speedTB = new System.Windows.Forms.TextBox();
            this.sygmaTB = new System.Windows.Forms.TextBox();
            this.speedL = new System.Windows.Forms.Label();
            this.sygmaL = new System.Windows.Forms.Label();
            this.maxIterL = new System.Windows.Forms.Label();
            this.errorL = new System.Windows.Forms.Label();
            this.maxIterTB = new System.Windows.Forms.TextBox();
            this.errorTB = new System.Windows.Forms.TextBox();
            this.studyPairsGV = new System.Windows.Forms.DataGridView();
            this.studyPairsL = new System.Windows.Forms.Label();
            this.studyBtn = new System.Windows.Forms.Button();
            this.testBtn = new System.Windows.Forms.Button();
            this.label8 = new System.Windows.Forms.Label();
            this.testX2TB = new System.Windows.Forms.TextBox();
            this.testX1TB = new System.Windows.Forms.TextBox();
            this.label9 = new System.Windows.Forms.Label();
            this.label10 = new System.Windows.Forms.Label();
            this.testOutTB = new System.Windows.Forms.TextBox();
            ((System.ComponentModel.ISupportInitialize)(this.viNM)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.studyPairsGV)).BeginInit();
            this.SuspendLayout();
            // 
            // viNM
            // 
            this.viNM.BorderlineWidth = 3;
            chartArea3.Name = "ChartArea1";
            this.viNM.ChartAreas.Add(chartArea3);
            legend3.Name = "Legend1";
            this.viNM.Legends.Add(legend3);
            this.viNM.Location = new System.Drawing.Point(12, 91);
            this.viNM.Name = "viNM";
            this.viNM.Palette = System.Windows.Forms.DataVisualization.Charting.ChartColorPalette.Fire;
            series5.ChartArea = "ChartArea1";
            series5.ChartType = System.Windows.Forms.DataVisualization.Charting.SeriesChartType.Point;
            series5.Legend = "Legend1";
            series5.Name = "Pairs";
            series5.YValuesPerPoint = 2;
            series6.ChartArea = "ChartArea1";
            series6.ChartType = System.Windows.Forms.DataVisualization.Charting.SeriesChartType.Line;
            series6.Legend = "Legend1";
            series6.Name = "Devider";
            this.viNM.Series.Add(series5);
            this.viNM.Series.Add(series6);
            this.viNM.Size = new System.Drawing.Size(466, 378);
            this.viNM.TabIndex = 0;
            this.viNM.Text = "viNM";
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(13, 4);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(92, 13);
            this.label1.TabIndex = 1;
            this.label1.Text = "Блок тестування";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(509, 4);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(103, 13);
            this.label2.TabIndex = 2;
            this.label2.Text = "Блок вхідних даних";
            // 
            // speedTB
            // 
            this.speedTB.Location = new System.Drawing.Point(632, 261);
            this.speedTB.Name = "speedTB";
            this.speedTB.Size = new System.Drawing.Size(121, 20);
            this.speedTB.TabIndex = 3;
            this.speedTB.Text = "0,8";
            // 
            // sygmaTB
            // 
            this.sygmaTB.Location = new System.Drawing.Point(632, 304);
            this.sygmaTB.Name = "sygmaTB";
            this.sygmaTB.Size = new System.Drawing.Size(121, 20);
            this.sygmaTB.TabIndex = 4;
            this.sygmaTB.Text = "1";
            // 
            // speedL
            // 
            this.speedL.AutoSize = true;
            this.speedL.Location = new System.Drawing.Point(509, 268);
            this.speedL.Name = "speedL";
            this.speedL.Size = new System.Drawing.Size(109, 13);
            this.speedL.TabIndex = 5;
            this.speedL.Text = "Швидкість навчання";
            // 
            // sygmaL
            // 
            this.sygmaL.AutoSize = true;
            this.sygmaL.Location = new System.Drawing.Point(509, 311);
            this.sygmaL.Name = "sygmaL";
            this.sygmaL.Size = new System.Drawing.Size(142, 13);
            this.sygmaL.TabIndex = 6;
            this.sygmaL.Text = "Крутизна функції активації";
            // 
            // maxIterL
            // 
            this.maxIterL.AutoSize = true;
            this.maxIterL.Location = new System.Drawing.Point(509, 392);
            this.maxIterL.Name = "maxIterL";
            this.maxIterL.Size = new System.Drawing.Size(168, 13);
            this.maxIterL.TabIndex = 10;
            this.maxIterL.Text = "Максимальна кількість ітерацій";
            // 
            // errorL
            // 
            this.errorL.AutoSize = true;
            this.errorL.Location = new System.Drawing.Point(509, 349);
            this.errorL.Name = "errorL";
            this.errorL.Size = new System.Drawing.Size(50, 13);
            this.errorL.TabIndex = 9;
            this.errorL.Text = "Похибки";
            // 
            // maxIterTB
            // 
            this.maxIterTB.Location = new System.Drawing.Point(632, 385);
            this.maxIterTB.Name = "maxIterTB";
            this.maxIterTB.Size = new System.Drawing.Size(121, 20);
            this.maxIterTB.TabIndex = 8;
            this.maxIterTB.Text = "200";
            // 
            // errorTB
            // 
            this.errorTB.Location = new System.Drawing.Point(632, 342);
            this.errorTB.Name = "errorTB";
            this.errorTB.Size = new System.Drawing.Size(121, 20);
            this.errorTB.TabIndex = 7;
            this.errorTB.Text = "0,005";
            // 
            // studyPairsGV
            // 
            this.studyPairsGV.AllowUserToAddRows = false;
            this.studyPairsGV.AllowUserToDeleteRows = false;
            this.studyPairsGV.AutoSizeColumnsMode = System.Windows.Forms.DataGridViewAutoSizeColumnsMode.Fill;
            this.studyPairsGV.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.studyPairsGV.ColumnHeadersVisible = false;
            this.studyPairsGV.Location = new System.Drawing.Point(512, 81);
            this.studyPairsGV.Name = "studyPairsGV";
            this.studyPairsGV.RowHeadersVisible = false;
            this.studyPairsGV.Size = new System.Drawing.Size(241, 153);
            this.studyPairsGV.TabIndex = 11;
            // 
            // studyPairsL
            // 
            this.studyPairsL.AutoSize = true;
            this.studyPairsL.Location = new System.Drawing.Point(509, 54);
            this.studyPairsL.Name = "studyPairsL";
            this.studyPairsL.Size = new System.Drawing.Size(80, 13);
            this.studyPairsL.TabIndex = 12;
            this.studyPairsL.Text = "Навчаючі пари";
            // 
            // studyBtn
            // 
            this.studyBtn.Location = new System.Drawing.Point(683, 445);
            this.studyBtn.Name = "studyBtn";
            this.studyBtn.Size = new System.Drawing.Size(70, 24);
            this.studyBtn.TabIndex = 13;
            this.studyBtn.Text = "Навчити";
            this.studyBtn.UseVisualStyleBackColor = true;
            this.studyBtn.Click += new System.EventHandler(this.studyBtn_Click);
            // 
            // testBtn
            // 
            this.testBtn.Location = new System.Drawing.Point(403, 54);
            this.testBtn.Name = "testBtn";
            this.testBtn.Size = new System.Drawing.Size(75, 23);
            this.testBtn.TabIndex = 14;
            this.testBtn.Text = "Тестувати";
            this.testBtn.UseVisualStyleBackColor = true;
            this.testBtn.Click += new System.EventHandler(this.testBtn_Click);
            // 
            // label8
            // 
            this.label8.AutoSize = true;
            this.label8.Location = new System.Drawing.Point(13, 64);
            this.label8.Name = "label8";
            this.label8.Size = new System.Drawing.Size(18, 13);
            this.label8.TabIndex = 18;
            this.label8.Text = "x2";
            // 
            // testX2TB
            // 
            this.testX2TB.Location = new System.Drawing.Point(50, 56);
            this.testX2TB.Name = "testX2TB";
            this.testX2TB.Size = new System.Drawing.Size(55, 20);
            this.testX2TB.TabIndex = 16;
            // 
            // testX1TB
            // 
            this.testX1TB.Location = new System.Drawing.Point(50, 30);
            this.testX1TB.Name = "testX1TB";
            this.testX1TB.Size = new System.Drawing.Size(55, 20);
            this.testX1TB.TabIndex = 15;
            // 
            // label9
            // 
            this.label9.AutoSize = true;
            this.label9.Location = new System.Drawing.Point(13, 37);
            this.label9.Name = "label9";
            this.label9.Size = new System.Drawing.Size(18, 13);
            this.label9.TabIndex = 17;
            this.label9.Text = "x1";
            // 
            // label10
            // 
            this.label10.AutoSize = true;
            this.label10.Location = new System.Drawing.Point(139, 37);
            this.label10.Name = "label10";
            this.label10.Size = new System.Drawing.Size(12, 13);
            this.label10.TabIndex = 20;
            this.label10.Text = "y";
            // 
            // testOutTB
            // 
            this.testOutTB.Enabled = false;
            this.testOutTB.Location = new System.Drawing.Point(166, 30);
            this.testOutTB.Name = "testOutTB";
            this.testOutTB.Size = new System.Drawing.Size(117, 20);
            this.testOutTB.TabIndex = 19;
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(765, 481);
            this.Controls.Add(this.label10);
            this.Controls.Add(this.testOutTB);
            this.Controls.Add(this.label8);
            this.Controls.Add(this.label9);
            this.Controls.Add(this.testX2TB);
            this.Controls.Add(this.testX1TB);
            this.Controls.Add(this.testBtn);
            this.Controls.Add(this.studyBtn);
            this.Controls.Add(this.studyPairsL);
            this.Controls.Add(this.studyPairsGV);
            this.Controls.Add(this.maxIterL);
            this.Controls.Add(this.errorL);
            this.Controls.Add(this.maxIterTB);
            this.Controls.Add(this.errorTB);
            this.Controls.Add(this.sygmaL);
            this.Controls.Add(this.speedL);
            this.Controls.Add(this.sygmaTB);
            this.Controls.Add(this.speedTB);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.viNM);
            this.Name = "Form1";
            this.Text = "Однонейронна мережа";
            ((System.ComponentModel.ISupportInitialize)(this.viNM)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.studyPairsGV)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.DataVisualization.Charting.Chart viNM;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.TextBox speedTB;
        private System.Windows.Forms.TextBox sygmaTB;
        private System.Windows.Forms.Label speedL;
        private System.Windows.Forms.Label sygmaL;
        private System.Windows.Forms.Label maxIterL;
        private System.Windows.Forms.Label errorL;
        private System.Windows.Forms.TextBox maxIterTB;
        private System.Windows.Forms.TextBox errorTB;
        private System.Windows.Forms.DataGridView studyPairsGV;
        private System.Windows.Forms.Label studyPairsL;
        private System.Windows.Forms.Button studyBtn;
        private System.Windows.Forms.Button testBtn;
        private System.Windows.Forms.Label label8;
        private System.Windows.Forms.TextBox testX2TB;
        private System.Windows.Forms.TextBox testX1TB;
        private System.Windows.Forms.Label label9;
        private System.Windows.Forms.Label label10;
        private System.Windows.Forms.TextBox testOutTB;
    }
}

