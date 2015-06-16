namespace WaveAlg.HelperForms
{
    partial class Options
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
            this.BestWayEnabled = new System.Windows.Forms.CheckBox();
            this.label3 = new System.Windows.Forms.Label();
            this.label1 = new System.Windows.Forms.Label();
            this.ZeroesPercent = new System.Windows.Forms.NumericUpDown();
            this.TooltipManager = new System.Windows.Forms.ToolTip(this.components);
            this.ColorPallete = new System.Windows.Forms.ColorDialog();
            this.ColorSet = new System.Windows.Forms.Button();
            ((System.ComponentModel.ISupportInitialize)(this.ZeroesPercent)).BeginInit();
            this.SuspendLayout();
            // 
            // BestWayEnabled
            // 
            this.BestWayEnabled.AutoSize = true;
            this.BestWayEnabled.Location = new System.Drawing.Point(12, 210);
            this.BestWayEnabled.Name = "BestWayEnabled";
            this.BestWayEnabled.Size = new System.Drawing.Size(128, 21);
            this.BestWayEnabled.TabIndex = 11;
            this.BestWayEnabled.Text = "Show Best Way";
            this.TooltipManager.SetToolTip(this.BestWayEnabled, "Default value is TRUE");
            this.BestWayEnabled.UseVisualStyleBackColor = true;
            this.BestWayEnabled.CheckedChanged += new System.EventHandler(this.BestWayEnabled_CheckedChanged);
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(112, 151);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(92, 17);
            this.label3.TabIndex = 10;
            this.label3.Text = "Show results:";
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(24, 23);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(180, 17);
            this.label1.TabIndex = 13;
            this.label1.Text = "Percentage of zeroes 1 to :";
            // 
            // ZeroesPercent
            // 
            this.ZeroesPercent.Location = new System.Drawing.Point(210, 23);
            this.ZeroesPercent.Name = "ZeroesPercent";
            this.ZeroesPercent.Size = new System.Drawing.Size(61, 22);
            this.ZeroesPercent.TabIndex = 14;
            this.ZeroesPercent.Value = new decimal(new int[] {
            6,
            0,
            0,
            0});
            this.ZeroesPercent.ValueChanged += new System.EventHandler(this.ZeroesPercent_ValueChanged);
            // 
            // ColorSet
            // 
            this.ColorSet.Location = new System.Drawing.Point(210, 219);
            this.ColorSet.Name = "ColorSet";
            this.ColorSet.Size = new System.Drawing.Size(94, 42);
            this.ColorSet.TabIndex = 15;
            this.ColorSet.Text = "Set Color";
            this.ColorSet.UseVisualStyleBackColor = true;
            this.ColorSet.Click += new System.EventHandler(this.ColorSet_Click);
            // 
            // Options
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(316, 273);
            this.Controls.Add(this.ColorSet);
            this.Controls.Add(this.ZeroesPercent);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.BestWayEnabled);
            this.Controls.Add(this.label3);
            this.Name = "Options";
            this.ShowIcon = false;
            this.Text = "Options";
            ((System.ComponentModel.ISupportInitialize)(this.ZeroesPercent)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        public System.Windows.Forms.CheckBox BestWayEnabled;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label label1;
        public System.Windows.Forms.NumericUpDown ZeroesPercent;
        private System.Windows.Forms.ToolTip TooltipManager;
        private System.Windows.Forms.Button ColorSet;
        public System.Windows.Forms.ColorDialog ColorPallete;
    }
}