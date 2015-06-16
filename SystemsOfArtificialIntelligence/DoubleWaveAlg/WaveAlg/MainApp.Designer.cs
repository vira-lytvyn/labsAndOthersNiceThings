namespace WaveAlg
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
            this.components = new System.ComponentModel.Container();
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle1 = new System.Windows.Forms.DataGridViewCellStyle();
            this.DataMatrix = new System.Windows.Forms.DataGridView();
            this.Generator = new System.Windows.Forms.Button();
            this.FindWay = new System.Windows.Forms.Button();
            this.label1 = new System.Windows.Forms.Label();
            this.NumSize = new System.Windows.Forms.NumericUpDown();
            this.BestResult = new System.Windows.Forms.TextBox();
            this.MenuStrip = new System.Windows.Forms.MenuStrip();
            this.fILEToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.exitToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.oPTIONSToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.optionsToolStripMenuItem1 = new System.Windows.Forms.ToolStripMenuItem();
            this.hELPToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.aboutWaveAlgToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.TooltipManager = new System.Windows.Forms.ToolTip(this.components);
            this.Clear = new System.Windows.Forms.Button();
            this.CircleMethod = new System.Windows.Forms.RadioButton();
            this.CrossMethod = new System.Windows.Forms.RadioButton();
            this.DrawBestWay = new System.Windows.Forms.Button();
            this.label4 = new System.Windows.Forms.Label();
            this.Path = new System.Windows.Forms.TextBox();
            this.panel1 = new System.Windows.Forms.Panel();
            this.panel2 = new System.Windows.Forms.Panel();
            ((System.ComponentModel.ISupportInitialize)(this.DataMatrix)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.NumSize)).BeginInit();
            this.MenuStrip.SuspendLayout();
            this.panel1.SuspendLayout();
            this.panel2.SuspendLayout();
            this.SuspendLayout();
            // 
            // DataMatrix
            // 
            this.DataMatrix.AllowUserToAddRows = false;
            this.DataMatrix.AllowUserToDeleteRows = false;
            this.DataMatrix.AllowUserToResizeColumns = false;
            this.DataMatrix.AllowUserToResizeRows = false;
            this.DataMatrix.AutoSizeColumnsMode = System.Windows.Forms.DataGridViewAutoSizeColumnsMode.Fill;
            this.DataMatrix.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.DataMatrix.ColumnHeadersVisible = false;
            this.DataMatrix.Location = new System.Drawing.Point(9, 34);
            this.DataMatrix.Margin = new System.Windows.Forms.Padding(2);
            this.DataMatrix.Name = "DataMatrix";
            this.DataMatrix.RowHeadersVisible = false;
            this.DataMatrix.RowHeadersWidth = 20;
            dataGridViewCellStyle1.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleCenter;
            dataGridViewCellStyle1.NullValue = null;
            this.DataMatrix.RowsDefaultCellStyle = dataGridViewCellStyle1;
            this.DataMatrix.RowTemplate.Height = 24;
            this.DataMatrix.Size = new System.Drawing.Size(400, 290);
            this.DataMatrix.TabIndex = 0;
            // 
            // Generator
            // 
            this.Generator.Location = new System.Drawing.Point(15, 129);
            this.Generator.Margin = new System.Windows.Forms.Padding(2);
            this.Generator.Name = "Generator";
            this.Generator.Size = new System.Drawing.Size(166, 22);
            this.Generator.TabIndex = 1;
            this.Generator.Text = "Згенерувати початкові дані";
            this.Generator.UseVisualStyleBackColor = true;
            this.Generator.Click += new System.EventHandler(this.Generator_Click);
            // 
            // FindWay
            // 
            this.FindWay.Location = new System.Drawing.Point(16, 155);
            this.FindWay.Margin = new System.Windows.Forms.Padding(2);
            this.FindWay.Name = "FindWay";
            this.FindWay.Size = new System.Drawing.Size(165, 22);
            this.FindWay.TabIndex = 2;
            this.FindWay.Text = "Знайти шлях";
            this.FindWay.UseVisualStyleBackColor = true;
            this.FindWay.Click += new System.EventHandler(this.FindWay_Click);
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(13, 16);
            this.label1.Margin = new System.Windows.Forms.Padding(2, 0, 2, 0);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(70, 13);
            this.label1.TabIndex = 3;
            this.label1.Text = "Розмірність:";
            // 
            // NumSize
            // 
            this.NumSize.Location = new System.Drawing.Point(123, 14);
            this.NumSize.Margin = new System.Windows.Forms.Padding(2);
            this.NumSize.Name = "NumSize";
            this.NumSize.Size = new System.Drawing.Size(58, 20);
            this.NumSize.TabIndex = 4;
            this.NumSize.ValueChanged += new System.EventHandler(this.Size_ValueChanged);
            // 
            // BestResult
            // 
            this.BestResult.Location = new System.Drawing.Point(123, 243);
            this.BestResult.Margin = new System.Windows.Forms.Padding(2);
            this.BestResult.Name = "BestResult";
            this.BestResult.Size = new System.Drawing.Size(61, 20);
            this.BestResult.TabIndex = 10;
            this.BestResult.Visible = false;
            // 
            // MenuStrip
            // 
            this.MenuStrip.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.fILEToolStripMenuItem,
            this.oPTIONSToolStripMenuItem,
            this.hELPToolStripMenuItem});
            this.MenuStrip.Location = new System.Drawing.Point(0, 0);
            this.MenuStrip.Name = "MenuStrip";
            this.MenuStrip.Padding = new System.Windows.Forms.Padding(4, 2, 0, 2);
            this.MenuStrip.Size = new System.Drawing.Size(630, 24);
            this.MenuStrip.TabIndex = 11;
            this.MenuStrip.Text = "menuStrip1";
            // 
            // fILEToolStripMenuItem
            // 
            this.fILEToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.exitToolStripMenuItem});
            this.fILEToolStripMenuItem.Name = "fILEToolStripMenuItem";
            this.fILEToolStripMenuItem.Size = new System.Drawing.Size(53, 20);
            this.fILEToolStripMenuItem.Text = "Меню";
            // 
            // exitToolStripMenuItem
            // 
            this.exitToolStripMenuItem.Name = "exitToolStripMenuItem";
            this.exitToolStripMenuItem.Size = new System.Drawing.Size(107, 22);
            this.exitToolStripMenuItem.Text = "Вийти";
            this.exitToolStripMenuItem.Click += new System.EventHandler(this.exitToolStripMenuItem_Click);
            // 
            // oPTIONSToolStripMenuItem
            // 
            this.oPTIONSToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.optionsToolStripMenuItem1});
            this.oPTIONSToolStripMenuItem.Name = "oPTIONSToolStripMenuItem";
            this.oPTIONSToolStripMenuItem.Size = new System.Drawing.Size(84, 20);
            this.oPTIONSToolStripMenuItem.Text = "Властивості";
            // 
            // optionsToolStripMenuItem1
            // 
            this.optionsToolStripMenuItem1.Name = "optionsToolStripMenuItem1";
            this.optionsToolStripMenuItem1.Size = new System.Drawing.Size(136, 22);
            this.optionsToolStripMenuItem1.Text = "Параметри";
            this.optionsToolStripMenuItem1.Click += new System.EventHandler(this.optionsToolStripMenuItem1_Click);
            // 
            // hELPToolStripMenuItem
            // 
            this.hELPToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.aboutWaveAlgToolStripMenuItem});
            this.hELPToolStripMenuItem.Name = "hELPToolStripMenuItem";
            this.hELPToolStripMenuItem.Size = new System.Drawing.Size(74, 20);
            this.hELPToolStripMenuItem.Text = "Помічник";
            // 
            // aboutWaveAlgToolStripMenuItem
            // 
            this.aboutWaveAlgToolStripMenuItem.Name = "aboutWaveAlgToolStripMenuItem";
            this.aboutWaveAlgToolStripMenuItem.Size = new System.Drawing.Size(154, 22);
            this.aboutWaveAlgToolStripMenuItem.Text = "Про програму";
            this.aboutWaveAlgToolStripMenuItem.Click += new System.EventHandler(this.aboutWaveAlgToolStripMenuItem_Click);
            // 
            // Clear
            // 
            this.Clear.Location = new System.Drawing.Point(16, 36);
            this.Clear.Margin = new System.Windows.Forms.Padding(2);
            this.Clear.Name = "Clear";
            this.Clear.Size = new System.Drawing.Size(165, 24);
            this.Clear.TabIndex = 13;
            this.Clear.Text = "Очистити матрицю";
            this.Clear.UseVisualStyleBackColor = true;
            this.Clear.Click += new System.EventHandler(this.Clear_Click);
            // 
            // CircleMethod
            // 
            this.CircleMethod.AutoSize = true;
            this.CircleMethod.Location = new System.Drawing.Point(16, 70);
            this.CircleMethod.Margin = new System.Windows.Forms.Padding(2);
            this.CircleMethod.Name = "CircleMethod";
            this.CircleMethod.Size = new System.Drawing.Size(129, 17);
            this.CircleMethod.TabIndex = 15;
            this.CircleMethod.TabStop = true;
            this.CircleMethod.Text = "у восьми напрямках";
            this.CircleMethod.UseVisualStyleBackColor = true;
            // 
            // CrossMethod
            // 
            this.CrossMethod.AutoSize = true;
            this.CrossMethod.Location = new System.Drawing.Point(16, 91);
            this.CrossMethod.Margin = new System.Windows.Forms.Padding(2);
            this.CrossMethod.Name = "CrossMethod";
            this.CrossMethod.Size = new System.Drawing.Size(137, 17);
            this.CrossMethod.TabIndex = 16;
            this.CrossMethod.TabStop = true;
            this.CrossMethod.Text = "в чотирьох напрямках";
            this.CrossMethod.UseVisualStyleBackColor = true;
            // 
            // DrawBestWay
            // 
            this.DrawBestWay.Location = new System.Drawing.Point(16, 181);
            this.DrawBestWay.Margin = new System.Windows.Forms.Padding(2);
            this.DrawBestWay.Name = "DrawBestWay";
            this.DrawBestWay.Size = new System.Drawing.Size(165, 22);
            this.DrawBestWay.TabIndex = 17;
            this.DrawBestWay.Text = "Підсвітити найкоротший шлях";
            this.DrawBestWay.UseVisualStyleBackColor = true;
            this.DrawBestWay.Click += new System.EventHandler(this.DrawBestWay_Click_1);
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(2, 18);
            this.label4.Margin = new System.Windows.Forms.Padding(2, 0, 2, 0);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(39, 13);
            this.label4.TabIndex = 18;
            this.label4.Text = "Шлях: ";
            // 
            // Path
            // 
            this.Path.Location = new System.Drawing.Point(56, 11);
            this.Path.Margin = new System.Windows.Forms.Padding(2);
            this.Path.Name = "Path";
            this.Path.Size = new System.Drawing.Size(539, 20);
            this.Path.TabIndex = 19;
            // 
            // panel1
            // 
            this.panel1.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D;
            this.panel1.Controls.Add(this.label4);
            this.panel1.Controls.Add(this.Path);
            this.panel1.Location = new System.Drawing.Point(9, 347);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(614, 49);
            this.panel1.TabIndex = 20;
            // 
            // panel2
            // 
            this.panel2.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D;
            this.panel2.Controls.Add(this.Clear);
            this.panel2.Controls.Add(this.Generator);
            this.panel2.Controls.Add(this.DrawBestWay);
            this.panel2.Controls.Add(this.FindWay);
            this.panel2.Controls.Add(this.CrossMethod);
            this.panel2.Controls.Add(this.label1);
            this.panel2.Controls.Add(this.CircleMethod);
            this.panel2.Controls.Add(this.NumSize);
            this.panel2.Controls.Add(this.BestResult);
            this.panel2.Location = new System.Drawing.Point(423, 34);
            this.panel2.Name = "panel2";
            this.panel2.Size = new System.Drawing.Size(200, 290);
            this.panel2.TabIndex = 21;
            // 
            // MainApp
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(630, 404);
            this.Controls.Add(this.panel2);
            this.Controls.Add(this.panel1);
            this.Controls.Add(this.DataMatrix);
            this.Controls.Add(this.MenuStrip);
            this.MainMenuStrip = this.MenuStrip;
            this.Margin = new System.Windows.Forms.Padding(2);
            this.Name = "MainApp";
            this.ShowIcon = false;
            this.Text = "Двонапрямлений хвильовий алгоритм";
            ((System.ComponentModel.ISupportInitialize)(this.DataMatrix)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.NumSize)).EndInit();
            this.MenuStrip.ResumeLayout(false);
            this.MenuStrip.PerformLayout();
            this.panel1.ResumeLayout(false);
            this.panel1.PerformLayout();
            this.panel2.ResumeLayout(false);
            this.panel2.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        public System.Windows.Forms.DataGridView DataMatrix;
        public System.Windows.Forms.Button Generator;
        public System.Windows.Forms.Button FindWay;
        private System.Windows.Forms.Label label1;
        public System.Windows.Forms.NumericUpDown NumSize;
        public System.Windows.Forms.TextBox BestResult;
        private System.Windows.Forms.MenuStrip MenuStrip;
        private System.Windows.Forms.ToolStripMenuItem fILEToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem exitToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem oPTIONSToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem optionsToolStripMenuItem1;
        private System.Windows.Forms.ToolStripMenuItem hELPToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem aboutWaveAlgToolStripMenuItem;
        private System.Windows.Forms.ToolTip TooltipManager;
        public System.Windows.Forms.Button Clear;
        public System.Windows.Forms.RadioButton CircleMethod;
        public System.Windows.Forms.RadioButton CrossMethod;
        public System.Windows.Forms.Button DrawBestWay;
        private System.Windows.Forms.Label label4;
        public System.Windows.Forms.TextBox Path;
        private System.Windows.Forms.Panel panel1;
        private System.Windows.Forms.Panel panel2;

    }
}

