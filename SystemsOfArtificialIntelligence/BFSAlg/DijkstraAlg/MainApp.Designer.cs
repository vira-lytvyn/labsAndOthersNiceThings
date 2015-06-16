namespace DijkstraAlg
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
            this.DrawingBox = new System.Windows.Forms.PictureBox();
            this.panel1 = new System.Windows.Forms.Panel();
            this.Generate = new System.Windows.Forms.Button();
            this.Result = new System.Windows.Forms.TextBox();
            this.FindWay = new System.Windows.Forms.Button();
            this.label2 = new System.Windows.Forms.Label();
            this.Clear_Draw_Box = new System.Windows.Forms.Button();
            this.label1 = new System.Windows.Forms.Label();
            this.AlgType = new System.Windows.Forms.ComboBox();
            ((System.ComponentModel.ISupportInitialize)(this.DrawingBox)).BeginInit();
            this.panel1.SuspendLayout();
            this.SuspendLayout();
            // 
            // DrawingBox
            // 
            this.DrawingBox.BackColor = System.Drawing.Color.White;
            this.DrawingBox.Location = new System.Drawing.Point(9, 11);
            this.DrawingBox.Margin = new System.Windows.Forms.Padding(2);
            this.DrawingBox.Name = "DrawingBox";
            this.DrawingBox.Size = new System.Drawing.Size(686, 449);
            this.DrawingBox.TabIndex = 0;
            this.DrawingBox.TabStop = false;
            // 
            // panel1
            // 
            this.panel1.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D;
            this.panel1.Controls.Add(this.Generate);
            this.panel1.Controls.Add(this.Result);
            this.panel1.Controls.Add(this.FindWay);
            this.panel1.Controls.Add(this.label2);
            this.panel1.Controls.Add(this.Clear_Draw_Box);
            this.panel1.Controls.Add(this.label1);
            this.panel1.Controls.Add(this.AlgType);
            this.panel1.Location = new System.Drawing.Point(700, 11);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(141, 449);
            this.panel1.TabIndex = 12;
            // 
            // Generate
            // 
            this.Generate.Location = new System.Drawing.Point(18, 267);
            this.Generate.Margin = new System.Windows.Forms.Padding(2);
            this.Generate.Name = "Generate";
            this.Generate.Size = new System.Drawing.Size(100, 35);
            this.Generate.TabIndex = 1;
            this.Generate.Text = "Намалювати граф";
            this.Generate.UseVisualStyleBackColor = true;
            this.Generate.Click += new System.EventHandler(this.Generate_Click);
            // 
            // Result
            // 
            this.Result.Location = new System.Drawing.Point(18, 133);
            this.Result.Margin = new System.Windows.Forms.Padding(2);
            this.Result.Name = "Result";
            this.Result.Size = new System.Drawing.Size(102, 20);
            this.Result.TabIndex = 11;
            this.Result.Text = "80";
            // 
            // FindWay
            // 
            this.FindWay.Location = new System.Drawing.Point(18, 327);
            this.FindWay.Margin = new System.Windows.Forms.Padding(2);
            this.FindWay.Name = "FindWay";
            this.FindWay.Size = new System.Drawing.Size(100, 35);
            this.FindWay.TabIndex = 2;
            this.FindWay.Text = "Знайти шлях";
            this.FindWay.UseVisualStyleBackColor = true;
            this.FindWay.Click += new System.EventHandler(this.FindWay_Click);
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(15, 107);
            this.label2.Margin = new System.Windows.Forms.Padding(2, 0, 2, 0);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(93, 13);
            this.label2.TabIndex = 10;
            this.label2.Text = "Кінцева вершина";
            // 
            // Clear_Draw_Box
            // 
            this.Clear_Draw_Box.Location = new System.Drawing.Point(18, 387);
            this.Clear_Draw_Box.Margin = new System.Windows.Forms.Padding(2);
            this.Clear_Draw_Box.Name = "Clear_Draw_Box";
            this.Clear_Draw_Box.Size = new System.Drawing.Size(100, 35);
            this.Clear_Draw_Box.TabIndex = 7;
            this.Clear_Draw_Box.Text = "Очистити робочу область";
            this.Clear_Draw_Box.UseVisualStyleBackColor = true;
            this.Clear_Draw_Box.Click += new System.EventHandler(this.Clear_Draw_Box_Click);
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(15, 23);
            this.label1.Margin = new System.Windows.Forms.Padding(2, 0, 2, 0);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(90, 13);
            this.label1.TabIndex = 9;
            this.label1.Text = "Вибір алгоритму";
            // 
            // AlgType
            // 
            this.AlgType.FormattingEnabled = true;
            this.AlgType.Location = new System.Drawing.Point(18, 49);
            this.AlgType.Margin = new System.Windows.Forms.Padding(2);
            this.AlgType.Name = "AlgType";
            this.AlgType.Size = new System.Drawing.Size(102, 21);
            this.AlgType.TabIndex = 8;
            // 
            // MainApp
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(850, 467);
            this.Controls.Add(this.panel1);
            this.Controls.Add(this.DrawingBox);
            this.Margin = new System.Windows.Forms.Padding(2);
            this.Name = "MainApp";
            this.ShowIcon = false;
            this.Text = "Алгоритми пошуку вшир та вглиб";
            ((System.ComponentModel.ISupportInitialize)(this.DrawingBox)).EndInit();
            this.panel1.ResumeLayout(false);
            this.panel1.PerformLayout();
            this.ResumeLayout(false);

        }

        #endregion

        public System.Windows.Forms.PictureBox DrawingBox;
        private System.Windows.Forms.Panel panel1;
        public System.Windows.Forms.Button Generate;
        public System.Windows.Forms.TextBox Result;
        public System.Windows.Forms.Button FindWay;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Button Clear_Draw_Box;
        private System.Windows.Forms.Label label1;
        public System.Windows.Forms.ComboBox AlgType;
    }
}

