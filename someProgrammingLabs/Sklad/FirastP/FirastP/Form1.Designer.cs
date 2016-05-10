namespace FirastP
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
            this.panel1 = new System.Windows.Forms.Panel();
            this.splitContainer1 = new System.Windows.Forms.SplitContainer();
            this.l1z = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.label1 = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.label4 = new System.Windows.Forms.Label();
            this.label5 = new System.Windows.Forms.Label();
            this.TBGroup = new System.Windows.Forms.TextBox();
            this.TBName = new System.Windows.Forms.TextBox();
            this.TBAutor = new System.Windows.Forms.TextBox();
            this.TBPrice = new System.Windows.Forms.TextBox();
            this.TBNum = new System.Windows.Forms.TextBox();
            this.AddBut = new System.Windows.Forms.Button();
            this.DGSklad = new System.Windows.Forms.DataGridView();
            this.DGSum = new System.Windows.Forms.DataGridView();
            this.panel1.SuspendLayout();
            this.splitContainer1.Panel1.SuspendLayout();
            this.splitContainer1.Panel2.SuspendLayout();
            this.splitContainer1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.DGSklad)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.DGSum)).BeginInit();
            this.SuspendLayout();
            // 
            // panel1
            // 
            this.panel1.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(192)))), ((int)(((byte)(255)))), ((int)(((byte)(192)))));
            this.panel1.Controls.Add(this.AddBut);
            this.panel1.Controls.Add(this.TBNum);
            this.panel1.Controls.Add(this.TBPrice);
            this.panel1.Controls.Add(this.TBAutor);
            this.panel1.Controls.Add(this.TBName);
            this.panel1.Controls.Add(this.TBGroup);
            this.panel1.Controls.Add(this.label5);
            this.panel1.Controls.Add(this.label4);
            this.panel1.Controls.Add(this.label3);
            this.panel1.Controls.Add(this.label1);
            this.panel1.Controls.Add(this.label2);
            this.panel1.Controls.Add(this.l1z);
            this.panel1.Location = new System.Drawing.Point(0, 3);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(930, 134);
            this.panel1.TabIndex = 0;
            // 
            // splitContainer1
            // 
            this.splitContainer1.Location = new System.Drawing.Point(-1, -2);
            this.splitContainer1.Name = "splitContainer1";
            this.splitContainer1.Orientation = System.Windows.Forms.Orientation.Horizontal;
            // 
            // splitContainer1.Panel1
            // 
            this.splitContainer1.Panel1.Controls.Add(this.DGSklad);
            this.splitContainer1.Panel1.Controls.Add(this.panel1);
            // 
            // splitContainer1.Panel2
            // 
            this.splitContainer1.Panel2.Controls.Add(this.DGSum);
            this.splitContainer1.Size = new System.Drawing.Size(930, 568);
            this.splitContainer1.SplitterDistance = 344;
            this.splitContainer1.TabIndex = 1;
            // 
            // l1z
            // 
            this.l1z.AutoSize = true;
            this.l1z.Font = new System.Drawing.Font("Microsoft Sans Serif", 10.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.l1z.Location = new System.Drawing.Point(338, 11);
            this.l1z.Name = "l1z";
            this.l1z.Size = new System.Drawing.Size(192, 17);
            this.l1z.TabIndex = 0;
            this.l1z.Text = "Введіть дані у таблицю: ";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(20, 48);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(39, 13);
            this.label2.TabIndex = 1;
            this.label2.Text = "Група ";
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(175, 48);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(39, 13);
            this.label1.TabIndex = 2;
            this.label1.Text = "Назва";
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(424, 48);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(56, 13);
            this.label3.TabIndex = 3;
            this.label3.Text = "Виробник";
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(582, 48);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(29, 13);
            this.label4.TabIndex = 4;
            this.label4.Text = "Ціна";
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Location = new System.Drawing.Point(707, 48);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(53, 13);
            this.label5.TabIndex = 5;
            this.label5.Text = "Кількість";
            // 
            // TBGroup
            // 
            this.TBGroup.Location = new System.Drawing.Point(23, 88);
            this.TBGroup.Name = "TBGroup";
            this.TBGroup.Size = new System.Drawing.Size(149, 20);
            this.TBGroup.TabIndex = 6;
            // 
            // TBName
            // 
            this.TBName.Location = new System.Drawing.Point(178, 88);
            this.TBName.Name = "TBName";
            this.TBName.Size = new System.Drawing.Size(243, 20);
            this.TBName.TabIndex = 7;
            // 
            // TBAutor
            // 
            this.TBAutor.Location = new System.Drawing.Point(427, 88);
            this.TBAutor.Name = "TBAutor";
            this.TBAutor.Size = new System.Drawing.Size(152, 20);
            this.TBAutor.TabIndex = 8;
            // 
            // TBPrice
            // 
            this.TBPrice.Location = new System.Drawing.Point(585, 88);
            this.TBPrice.Name = "TBPrice";
            this.TBPrice.Size = new System.Drawing.Size(119, 20);
            this.TBPrice.TabIndex = 9;
            // 
            // TBNum
            // 
            this.TBNum.Location = new System.Drawing.Point(710, 88);
            this.TBNum.Name = "TBNum";
            this.TBNum.Size = new System.Drawing.Size(100, 20);
            this.TBNum.TabIndex = 10;
            // 
            // AddBut
            // 
            this.AddBut.Location = new System.Drawing.Point(832, 88);
            this.AddBut.Name = "AddBut";
            this.AddBut.Size = new System.Drawing.Size(85, 20);
            this.AddBut.TabIndex = 11;
            this.AddBut.Text = "Додати дані";
            this.AddBut.UseVisualStyleBackColor = true;
            this.AddBut.Click += new System.EventHandler(this.AddBut_Click);
            // 
            // DGSklad
            // 
            this.DGSklad.BackgroundColor = System.Drawing.Color.FromArgb(((int)(((byte)(192)))), ((int)(((byte)(255)))), ((int)(((byte)(255)))));
            this.DGSklad.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.DGSklad.Location = new System.Drawing.Point(0, 133);
            this.DGSklad.Name = "DGSklad";
            this.DGSklad.Size = new System.Drawing.Size(930, 208);
            this.DGSklad.TabIndex = 1;
            // 
            // DGSum
            // 
            this.DGSum.BackgroundColor = System.Drawing.Color.FromArgb(((int)(((byte)(255)))), ((int)(((byte)(255)))), ((int)(((byte)(192)))));
            this.DGSum.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.DGSum.Location = new System.Drawing.Point(0, -1);
            this.DGSum.Name = "DGSum";
            this.DGSum.Size = new System.Drawing.Size(930, 221);
            this.DGSum.TabIndex = 0;
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(928, 566);
            this.Controls.Add(this.splitContainer1);
            this.Name = "Form1";
            this.Text = "Дослідження класів ";
            this.Load += new System.EventHandler(this.Form1_Load);
            this.panel1.ResumeLayout(false);
            this.panel1.PerformLayout();
            this.splitContainer1.Panel1.ResumeLayout(false);
            this.splitContainer1.Panel2.ResumeLayout(false);
            this.splitContainer1.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.DGSklad)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.DGSum)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Panel panel1;
        private System.Windows.Forms.SplitContainer splitContainer1;
        private System.Windows.Forms.TextBox TBName;
        private System.Windows.Forms.TextBox TBGroup;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label l1z;
        private System.Windows.Forms.Button AddBut;
        private System.Windows.Forms.TextBox TBNum;
        private System.Windows.Forms.TextBox TBPrice;
        private System.Windows.Forms.TextBox TBAutor;
        private System.Windows.Forms.DataGridView DGSklad;
        private System.Windows.Forms.DataGridView DGSum;

    }
}

