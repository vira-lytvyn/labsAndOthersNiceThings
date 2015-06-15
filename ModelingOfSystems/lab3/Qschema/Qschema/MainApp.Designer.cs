namespace Qschema
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
            this.Interval = new System.Windows.Forms.TextBox();
            this.label2 = new System.Windows.Forms.Label();
            this.Find = new System.Windows.Forms.Button();
            this.Done = new System.Windows.Forms.TextBox();
            this.NotDone = new System.Windows.Forms.TextBox();
            this.label3 = new System.Windows.Forms.Label();
            this.label4 = new System.Windows.Forms.Label();
            this.label5 = new System.Windows.Forms.Label();
            this.CanProcced = new System.Windows.Forms.TextBox();
            this.label6 = new System.Windows.Forms.Label();
            this.MaxForOneInterval = new System.Windows.Forms.TextBox();
            this.Stopper = new System.Windows.Forms.Button();
            this.ChanelOne = new System.Windows.Forms.CheckBox();
            this.ChanelTwo = new System.Windows.Forms.CheckBox();
            this.label1 = new System.Windows.Forms.Label();
            this.AllTime = new System.Windows.Forms.TextBox();
            this.panel1 = new System.Windows.Forms.Panel();
            this.panel2 = new System.Windows.Forms.Panel();
            this.panel3 = new System.Windows.Forms.Panel();
            this.panel4 = new System.Windows.Forms.Panel();
            this.panel1.SuspendLayout();
            this.panel2.SuspendLayout();
            this.panel3.SuspendLayout();
            this.panel4.SuspendLayout();
            this.SuspendLayout();
            // 
            // Interval
            // 
            this.Interval.Location = new System.Drawing.Point(185, 82);
            this.Interval.Margin = new System.Windows.Forms.Padding(2, 2, 2, 2);
            this.Interval.Name = "Interval";
            this.Interval.Size = new System.Drawing.Size(50, 20);
            this.Interval.TabIndex = 1;
            this.Interval.Text = "3";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(14, 85);
            this.label2.Margin = new System.Windows.Forms.Padding(2, 0, 2, 0);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(50, 13);
            this.label2.TabIndex = 3;
            this.label2.Text = "інтервал";
            // 
            // Find
            // 
            this.Find.Location = new System.Drawing.Point(17, 11);
            this.Find.Margin = new System.Windows.Forms.Padding(2, 2, 2, 2);
            this.Find.Name = "Find";
            this.Find.Size = new System.Drawing.Size(108, 24);
            this.Find.TabIndex = 4;
            this.Find.Text = "Почати роботу";
            this.Find.UseVisualStyleBackColor = true;
            this.Find.Click += new System.EventHandler(this.Find_Click);
            // 
            // Done
            // 
            this.Done.Location = new System.Drawing.Point(129, 10);
            this.Done.Margin = new System.Windows.Forms.Padding(2, 2, 2, 2);
            this.Done.Name = "Done";
            this.Done.Size = new System.Drawing.Size(58, 20);
            this.Done.TabIndex = 5;
            // 
            // NotDone
            // 
            this.NotDone.Location = new System.Drawing.Point(129, 38);
            this.NotDone.Margin = new System.Windows.Forms.Padding(2, 2, 2, 2);
            this.NotDone.Name = "NotDone";
            this.NotDone.Size = new System.Drawing.Size(58, 20);
            this.NotDone.TabIndex = 6;
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(11, 41);
            this.label3.Margin = new System.Windows.Forms.Padding(2, 0, 2, 0);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(114, 13);
            this.label3.TabIndex = 7;
            this.label3.Text = "Відмовлено клієнтам";
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(11, 13);
            this.label4.Margin = new System.Windows.Forms.Padding(2, 0, 2, 0);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(106, 13);
            this.label4.TabIndex = 8;
            this.label4.Text = "Обслужено клієнтів";
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Location = new System.Drawing.Point(14, 14);
            this.label5.Margin = new System.Windows.Forms.Padding(2, 0, 2, 0);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(144, 13);
            this.label5.TabIndex = 9;
            this.label5.Text = "пропускна здатність( шт/с)";
            // 
            // CanProcced
            // 
            this.CanProcced.Location = new System.Drawing.Point(185, 11);
            this.CanProcced.Margin = new System.Windows.Forms.Padding(2, 2, 2, 2);
            this.CanProcced.Name = "CanProcced";
            this.CanProcced.Size = new System.Drawing.Size(50, 20);
            this.CanProcced.TabIndex = 10;
            this.CanProcced.Text = "4";
            // 
            // label6
            // 
            this.label6.AutoSize = true;
            this.label6.Location = new System.Drawing.Point(14, 37);
            this.label6.Margin = new System.Windows.Forms.Padding(2, 0, 2, 0);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(148, 13);
            this.label6.TabIndex = 11;
            this.label6.Text = "макс.  кількість за інтервал";
            // 
            // MaxForOneInterval
            // 
            this.MaxForOneInterval.Location = new System.Drawing.Point(185, 34);
            this.MaxForOneInterval.Margin = new System.Windows.Forms.Padding(2, 2, 2, 2);
            this.MaxForOneInterval.Name = "MaxForOneInterval";
            this.MaxForOneInterval.Size = new System.Drawing.Size(50, 20);
            this.MaxForOneInterval.TabIndex = 12;
            this.MaxForOneInterval.Text = "7";
            // 
            // Stopper
            // 
            this.Stopper.Location = new System.Drawing.Point(129, 11);
            this.Stopper.Margin = new System.Windows.Forms.Padding(2, 2, 2, 2);
            this.Stopper.Name = "Stopper";
            this.Stopper.Size = new System.Drawing.Size(106, 24);
            this.Stopper.TabIndex = 13;
            this.Stopper.Text = "Припинити";
            this.Stopper.UseVisualStyleBackColor = true;
            this.Stopper.Click += new System.EventHandler(this.Stopper_Click);
            // 
            // ChanelOne
            // 
            this.ChanelOne.AutoSize = true;
            this.ChanelOne.Checked = true;
            this.ChanelOne.CheckState = System.Windows.Forms.CheckState.Checked;
            this.ChanelOne.Location = new System.Drawing.Point(11, 14);
            this.ChanelOne.Margin = new System.Windows.Forms.Padding(2, 2, 2, 2);
            this.ChanelOne.Name = "ChanelOne";
            this.ChanelOne.Size = new System.Drawing.Size(152, 17);
            this.ChanelOne.TabIndex = 14;
            this.ChanelOne.Text = "Увімкнути перший канал";
            this.ChanelOne.UseVisualStyleBackColor = true;
            // 
            // ChanelTwo
            // 
            this.ChanelTwo.AutoSize = true;
            this.ChanelTwo.Checked = true;
            this.ChanelTwo.CheckState = System.Windows.Forms.CheckState.Checked;
            this.ChanelTwo.Location = new System.Drawing.Point(11, 44);
            this.ChanelTwo.Margin = new System.Windows.Forms.Padding(2, 2, 2, 2);
            this.ChanelTwo.Name = "ChanelTwo";
            this.ChanelTwo.Size = new System.Drawing.Size(148, 17);
            this.ChanelTwo.TabIndex = 15;
            this.ChanelTwo.Text = "Увімкнути другий канал";
            this.ChanelTwo.UseVisualStyleBackColor = true;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(14, 61);
            this.label1.Margin = new System.Windows.Forms.Padding(2, 0, 2, 0);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(111, 13);
            this.label1.TabIndex = 16;
            this.label1.Text = "тривалість роботи(с)";
            // 
            // AllTime
            // 
            this.AllTime.Location = new System.Drawing.Point(185, 58);
            this.AllTime.Margin = new System.Windows.Forms.Padding(2, 2, 2, 2);
            this.AllTime.Name = "AllTime";
            this.AllTime.Size = new System.Drawing.Size(50, 20);
            this.AllTime.TabIndex = 17;
            this.AllTime.Text = "40";
            // 
            // panel1
            // 
            this.panel1.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D;
            this.panel1.Controls.Add(this.ChanelOne);
            this.panel1.Controls.Add(this.ChanelTwo);
            this.panel1.Location = new System.Drawing.Point(12, 110);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(189, 72);
            this.panel1.TabIndex = 18;
            // 
            // panel2
            // 
            this.panel2.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D;
            this.panel2.Controls.Add(this.label4);
            this.panel2.Controls.Add(this.Done);
            this.panel2.Controls.Add(this.NotDone);
            this.panel2.Controls.Add(this.label3);
            this.panel2.Location = new System.Drawing.Point(12, 13);
            this.panel2.Name = "panel2";
            this.panel2.Size = new System.Drawing.Size(195, 83);
            this.panel2.TabIndex = 19;
            // 
            // panel3
            // 
            this.panel3.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D;
            this.panel3.Controls.Add(this.label5);
            this.panel3.Controls.Add(this.Interval);
            this.panel3.Controls.Add(this.label2);
            this.panel3.Controls.Add(this.AllTime);
            this.panel3.Controls.Add(this.CanProcced);
            this.panel3.Controls.Add(this.label1);
            this.panel3.Controls.Add(this.label6);
            this.panel3.Controls.Add(this.MaxForOneInterval);
            this.panel3.Location = new System.Drawing.Point(224, 12);
            this.panel3.Name = "panel3";
            this.panel3.Size = new System.Drawing.Size(248, 115);
            this.panel3.TabIndex = 20;
            // 
            // panel4
            // 
            this.panel4.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D;
            this.panel4.Controls.Add(this.Stopper);
            this.panel4.Controls.Add(this.Find);
            this.panel4.Location = new System.Drawing.Point(224, 136);
            this.panel4.Name = "panel4";
            this.panel4.Size = new System.Drawing.Size(248, 46);
            this.panel4.TabIndex = 21;
            // 
            // MainApp
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(490, 197);
            this.Controls.Add(this.panel4);
            this.Controls.Add(this.panel3);
            this.Controls.Add(this.panel2);
            this.Controls.Add(this.panel1);
            this.Margin = new System.Windows.Forms.Padding(2, 2, 2, 2);
            this.Name = "MainApp";
            this.ShowIcon = false;
            this.Text = "Система масового обслуговування";
            this.panel1.ResumeLayout(false);
            this.panel1.PerformLayout();
            this.panel2.ResumeLayout(false);
            this.panel2.PerformLayout();
            this.panel3.ResumeLayout(false);
            this.panel3.PerformLayout();
            this.panel4.ResumeLayout(false);
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Button Find;
        public System.Windows.Forms.TextBox Interval;
        public System.Windows.Forms.TextBox Done;
        public System.Windows.Forms.TextBox NotDone;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.Label label5;
        public System.Windows.Forms.TextBox CanProcced;
        private System.Windows.Forms.Label label6;
        public System.Windows.Forms.TextBox MaxForOneInterval;
        private System.Windows.Forms.Button Stopper;
        public System.Windows.Forms.CheckBox ChanelOne;
        public System.Windows.Forms.CheckBox ChanelTwo;
        private System.Windows.Forms.Label label1;
        public System.Windows.Forms.TextBox AllTime;
        private System.Windows.Forms.Panel panel1;
        private System.Windows.Forms.Panel panel2;
        private System.Windows.Forms.Panel panel3;
        private System.Windows.Forms.Panel panel4;
    }
}

