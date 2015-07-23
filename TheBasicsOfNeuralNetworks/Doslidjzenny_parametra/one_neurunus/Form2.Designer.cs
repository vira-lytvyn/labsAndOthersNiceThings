namespace one_neurunus
{
    partial class DependencesForm
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
            System.Windows.Forms.DataVisualization.Charting.ChartArea chartArea2 = new System.Windows.Forms.DataVisualization.Charting.ChartArea();
            System.Windows.Forms.DataVisualization.Charting.Legend legend2 = new System.Windows.Forms.DataVisualization.Charting.Legend();
            System.Windows.Forms.DataVisualization.Charting.Series series2 = new System.Windows.Forms.DataVisualization.Charting.Series();
            System.Windows.Forms.DataVisualization.Charting.ChartArea chartArea3 = new System.Windows.Forms.DataVisualization.Charting.ChartArea();
            System.Windows.Forms.DataVisualization.Charting.Legend legend3 = new System.Windows.Forms.DataVisualization.Charting.Legend();
            System.Windows.Forms.DataVisualization.Charting.Series series3 = new System.Windows.Forms.DataVisualization.Charting.Series();
            System.Windows.Forms.DataVisualization.Charting.ChartArea chartArea4 = new System.Windows.Forms.DataVisualization.Charting.ChartArea();
            System.Windows.Forms.DataVisualization.Charting.Legend legend4 = new System.Windows.Forms.DataVisualization.Charting.Legend();
            System.Windows.Forms.DataVisualization.Charting.Series series4 = new System.Windows.Forms.DataVisualization.Charting.Series();
            this.DependenceTC = new System.Windows.Forms.TabControl();
            this.ErrorTP = new System.Windows.Forms.TabPage();
            this.ErrorCH = new System.Windows.Forms.DataVisualization.Charting.Chart();
            this.AlphaTP = new System.Windows.Forms.TabPage();
            this.AlphaCH = new System.Windows.Forms.DataVisualization.Charting.Chart();
            this.SpeedTP = new System.Windows.Forms.TabPage();
            this.SpeedCH = new System.Windows.Forms.DataVisualization.Charting.Chart();
            this.WeigthTP = new System.Windows.Forms.TabPage();
            this.WeightCH = new System.Windows.Forms.DataVisualization.Charting.Chart();
            this.DependenceTC.SuspendLayout();
            this.ErrorTP.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.ErrorCH)).BeginInit();
            this.AlphaTP.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.AlphaCH)).BeginInit();
            this.SpeedTP.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.SpeedCH)).BeginInit();
            this.WeigthTP.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.WeightCH)).BeginInit();
            this.SuspendLayout();
            // 
            // DependenceTC
            // 
            this.DependenceTC.Controls.Add(this.ErrorTP);
            this.DependenceTC.Controls.Add(this.AlphaTP);
            this.DependenceTC.Controls.Add(this.SpeedTP);
            this.DependenceTC.Controls.Add(this.WeigthTP);
            this.DependenceTC.Location = new System.Drawing.Point(0, -1);
            this.DependenceTC.Name = "DependenceTC";
            this.DependenceTC.SelectedIndex = 0;
            this.DependenceTC.Size = new System.Drawing.Size(572, 364);
            this.DependenceTC.TabIndex = 0;
            // 
            // ErrorTP
            // 
            this.ErrorTP.Controls.Add(this.ErrorCH);
            this.ErrorTP.Location = new System.Drawing.Point(4, 22);
            this.ErrorTP.Name = "ErrorTP";
            this.ErrorTP.Padding = new System.Windows.Forms.Padding(3);
            this.ErrorTP.Size = new System.Drawing.Size(564, 338);
            this.ErrorTP.TabIndex = 0;
            this.ErrorTP.Text = "Похибки навчання";
            this.ErrorTP.UseVisualStyleBackColor = true;
            // 
            // ErrorCH
            // 
            chartArea1.Name = "ChartArea1";
            this.ErrorCH.ChartAreas.Add(chartArea1);
            legend1.Name = "Legend1";
            this.ErrorCH.Legends.Add(legend1);
            this.ErrorCH.Location = new System.Drawing.Point(-4, 0);
            this.ErrorCH.Name = "ErrorCH";
            this.ErrorCH.Palette = System.Windows.Forms.DataVisualization.Charting.ChartColorPalette.Chocolate;
            series1.BorderWidth = 3;
            series1.ChartArea = "ChartArea1";
            series1.ChartType = System.Windows.Forms.DataVisualization.Charting.SeriesChartType.Spline;
            series1.Legend = "Legend1";
            series1.Name = " ";
            this.ErrorCH.Series.Add(series1);
            this.ErrorCH.Size = new System.Drawing.Size(568, 342);
            this.ErrorCH.TabIndex = 0;
            // 
            // AlphaTP
            // 
            this.AlphaTP.Controls.Add(this.AlphaCH);
            this.AlphaTP.Location = new System.Drawing.Point(4, 22);
            this.AlphaTP.Name = "AlphaTP";
            this.AlphaTP.Padding = new System.Windows.Forms.Padding(3);
            this.AlphaTP.Size = new System.Drawing.Size(564, 338);
            this.AlphaTP.TabIndex = 1;
            this.AlphaTP.Text = "Коефіцієнта функції активації";
            this.AlphaTP.UseVisualStyleBackColor = true;
            // 
            // AlphaCH
            // 
            chartArea2.Name = "ChartArea1";
            this.AlphaCH.ChartAreas.Add(chartArea2);
            legend2.Name = "Legend1";
            this.AlphaCH.Legends.Add(legend2);
            this.AlphaCH.Location = new System.Drawing.Point(-3, 0);
            this.AlphaCH.Name = "AlphaCH";
            this.AlphaCH.Palette = System.Windows.Forms.DataVisualization.Charting.ChartColorPalette.SemiTransparent;
            series2.BorderWidth = 3;
            series2.ChartArea = "ChartArea1";
            series2.ChartType = System.Windows.Forms.DataVisualization.Charting.SeriesChartType.Spline;
            series2.Legend = "Legend1";
            series2.Name = " ";
            this.AlphaCH.Series.Add(series2);
            this.AlphaCH.Size = new System.Drawing.Size(567, 342);
            this.AlphaCH.TabIndex = 1;
            // 
            // SpeedTP
            // 
            this.SpeedTP.Controls.Add(this.SpeedCH);
            this.SpeedTP.Location = new System.Drawing.Point(4, 22);
            this.SpeedTP.Name = "SpeedTP";
            this.SpeedTP.Size = new System.Drawing.Size(564, 338);
            this.SpeedTP.TabIndex = 2;
            this.SpeedTP.Text = "Швидкості навчання";
            this.SpeedTP.UseVisualStyleBackColor = true;
            // 
            // SpeedCH
            // 
            chartArea3.Name = "ChartArea1";
            this.SpeedCH.ChartAreas.Add(chartArea3);
            legend3.Name = "Legend1";
            this.SpeedCH.Legends.Add(legend3);
            this.SpeedCH.Location = new System.Drawing.Point(-4, 3);
            this.SpeedCH.Name = "SpeedCH";
            this.SpeedCH.Palette = System.Windows.Forms.DataVisualization.Charting.ChartColorPalette.Berry;
            series3.BorderWidth = 3;
            series3.ChartArea = "ChartArea1";
            series3.ChartType = System.Windows.Forms.DataVisualization.Charting.SeriesChartType.Spline;
            series3.Legend = "Legend1";
            series3.Name = " ";
            this.SpeedCH.Series.Add(series3);
            this.SpeedCH.Size = new System.Drawing.Size(568, 339);
            this.SpeedCH.TabIndex = 1;
            // 
            // WeigthTP
            // 
            this.WeigthTP.Controls.Add(this.WeightCH);
            this.WeigthTP.Location = new System.Drawing.Point(4, 22);
            this.WeigthTP.Name = "WeigthTP";
            this.WeigthTP.Size = new System.Drawing.Size(564, 338);
            this.WeigthTP.TabIndex = 3;
            this.WeigthTP.Text = "Початкових значень ваг";
            this.WeigthTP.UseVisualStyleBackColor = true;
            // 
            // WeightCH
            // 
            chartArea4.Name = "ChartArea1";
            this.WeightCH.ChartAreas.Add(chartArea4);
            legend4.Name = "Legend1";
            this.WeightCH.Legends.Add(legend4);
            this.WeightCH.Location = new System.Drawing.Point(-4, 0);
            this.WeightCH.Name = "WeightCH";
            this.WeightCH.Palette = System.Windows.Forms.DataVisualization.Charting.ChartColorPalette.Fire;
            series4.BorderWidth = 3;
            series4.ChartArea = "ChartArea1";
            series4.ChartType = System.Windows.Forms.DataVisualization.Charting.SeriesChartType.Spline;
            series4.Legend = "Legend1";
            series4.Name = " ";
            this.WeightCH.Series.Add(series4);
            this.WeightCH.Size = new System.Drawing.Size(568, 342);
            this.WeightCH.TabIndex = 1;
            // 
            // DependencesForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(572, 365);
            this.Controls.Add(this.DependenceTC);
            this.Name = "DependencesForm";
            this.Text = "Зображення залежності кількості епох навчання від ";
            this.Load += new System.EventHandler(this.DependencesForm_Load);
            this.DependenceTC.ResumeLayout(false);
            this.ErrorTP.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.ErrorCH)).EndInit();
            this.AlphaTP.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.AlphaCH)).EndInit();
            this.SpeedTP.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.SpeedCH)).EndInit();
            this.WeigthTP.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.WeightCH)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.TabControl DependenceTC;
        private System.Windows.Forms.TabPage ErrorTP;
        private System.Windows.Forms.TabPage AlphaTP;
        private System.Windows.Forms.DataVisualization.Charting.Chart ErrorCH;
        private System.Windows.Forms.TabPage SpeedTP;
        private System.Windows.Forms.TabPage WeigthTP;
        private System.Windows.Forms.DataVisualization.Charting.Chart AlphaCH;
        private System.Windows.Forms.DataVisualization.Charting.Chart SpeedCH;
        private System.Windows.Forms.DataVisualization.Charting.Chart WeightCH;
    }
}