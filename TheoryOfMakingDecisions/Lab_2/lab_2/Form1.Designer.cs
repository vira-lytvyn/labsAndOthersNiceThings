namespace lab_2
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
            this.inputPDataGridView = new System.Windows.Forms.DataGridView();
            this.inputQDataGridView = new System.Windows.Forms.DataGridView();
            this.resultDataGridView = new System.Windows.Forms.DataGridView();
            this.logicFunctionList = new System.Windows.Forms.ComboBox();
            this.testButton = new System.Windows.Forms.Button();
            this.useCheckBox = new System.Windows.Forms.CheckBox();
            this.outputPanel = new System.Windows.Forms.Panel();
            this.label1 = new System.Windows.Forms.Label();
            this.inputPanel = new System.Windows.Forms.Panel();
            this.label3 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            ((System.ComponentModel.ISupportInitialize)(this.inputPDataGridView)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.inputQDataGridView)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.resultDataGridView)).BeginInit();
            this.outputPanel.SuspendLayout();
            this.inputPanel.SuspendLayout();
            this.SuspendLayout();
            // 
            // inputPDataGridView
            // 
            this.inputPDataGridView.AllowUserToAddRows = false;
            this.inputPDataGridView.AllowUserToDeleteRows = false;
            this.inputPDataGridView.AutoSizeColumnsMode = System.Windows.Forms.DataGridViewAutoSizeColumnsMode.Fill;
            this.inputPDataGridView.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.inputPDataGridView.ColumnHeadersVisible = false;
            this.inputPDataGridView.Location = new System.Drawing.Point(14, 50);
            this.inputPDataGridView.Name = "inputPDataGridView";
            this.inputPDataGridView.RowHeadersVisible = false;
            this.inputPDataGridView.Size = new System.Drawing.Size(145, 120);
            this.inputPDataGridView.TabIndex = 0;
            // 
            // inputQDataGridView
            // 
            this.inputQDataGridView.AllowUserToAddRows = false;
            this.inputQDataGridView.AllowUserToDeleteRows = false;
            this.inputQDataGridView.AutoSizeColumnsMode = System.Windows.Forms.DataGridViewAutoSizeColumnsMode.Fill;
            this.inputQDataGridView.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.inputQDataGridView.ColumnHeadersVisible = false;
            this.inputQDataGridView.Location = new System.Drawing.Point(182, 50);
            this.inputQDataGridView.Name = "inputQDataGridView";
            this.inputQDataGridView.RowHeadersVisible = false;
            this.inputQDataGridView.Size = new System.Drawing.Size(145, 120);
            this.inputQDataGridView.TabIndex = 1;
            // 
            // resultDataGridView
            // 
            this.resultDataGridView.AllowUserToAddRows = false;
            this.resultDataGridView.AllowUserToDeleteRows = false;
            this.resultDataGridView.AutoSizeColumnsMode = System.Windows.Forms.DataGridViewAutoSizeColumnsMode.Fill;
            this.resultDataGridView.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.resultDataGridView.ColumnHeadersVisible = false;
            this.resultDataGridView.Location = new System.Drawing.Point(17, 50);
            this.resultDataGridView.Name = "resultDataGridView";
            this.resultDataGridView.ReadOnly = true;
            this.resultDataGridView.RowHeadersVisible = false;
            this.resultDataGridView.Size = new System.Drawing.Size(145, 120);
            this.resultDataGridView.TabIndex = 2;
            // 
            // logicFunctionList
            // 
            this.logicFunctionList.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.logicFunctionList.FormattingEnabled = true;
            this.logicFunctionList.Items.AddRange(new object[] {
            "Об\'єднання",
            "Перетин",
            "Різниця P\\Q",
            "Симетрична різниця",
            "Доповнення",
            "Обернене відношення",
            "Композиція"});
            this.logicFunctionList.Location = new System.Drawing.Point(342, 50);
            this.logicFunctionList.Name = "logicFunctionList";
            this.logicFunctionList.Size = new System.Drawing.Size(153, 21);
            this.logicFunctionList.TabIndex = 3;
            this.logicFunctionList.SelectedIndexChanged += new System.EventHandler(this.logicFunctionList_SelectedIndexChanged);
            // 
            // testButton
            // 
            this.testButton.Location = new System.Drawing.Point(420, 185);
            this.testButton.Name = "testButton";
            this.testButton.Size = new System.Drawing.Size(75, 23);
            this.testButton.TabIndex = 4;
            this.testButton.Text = "Знайти";
            this.testButton.UseVisualStyleBackColor = true;
            this.testButton.Click += new System.EventHandler(this.testButton_Click);
            // 
            // useCheckBox
            // 
            this.useCheckBox.AutoSize = true;
            this.useCheckBox.Location = new System.Drawing.Point(342, 153);
            this.useCheckBox.Name = "useCheckBox";
            this.useCheckBox.Size = new System.Drawing.Size(121, 17);
            this.useCheckBox.TabIndex = 5;
            this.useCheckBox.Text = "Для  відношення P";
            this.useCheckBox.UseVisualStyleBackColor = true;
            // 
            // outputPanel
            // 
            this.outputPanel.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D;
            this.outputPanel.Controls.Add(this.label1);
            this.outputPanel.Controls.Add(this.resultDataGridView);
            this.outputPanel.Location = new System.Drawing.Point(12, 12);
            this.outputPanel.Name = "outputPanel";
            this.outputPanel.Size = new System.Drawing.Size(177, 223);
            this.outputPanel.TabIndex = 6;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(14, 19);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(59, 13);
            this.label1.TabIndex = 6;
            this.label1.Text = "Результат";
            // 
            // inputPanel
            // 
            this.inputPanel.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D;
            this.inputPanel.Controls.Add(this.label3);
            this.inputPanel.Controls.Add(this.label2);
            this.inputPanel.Controls.Add(this.inputPDataGridView);
            this.inputPanel.Controls.Add(this.inputQDataGridView);
            this.inputPanel.Controls.Add(this.useCheckBox);
            this.inputPanel.Controls.Add(this.logicFunctionList);
            this.inputPanel.Controls.Add(this.testButton);
            this.inputPanel.Location = new System.Drawing.Point(207, 12);
            this.inputPanel.Name = "inputPanel";
            this.inputPanel.Size = new System.Drawing.Size(506, 223);
            this.inputPanel.TabIndex = 7;
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(179, 19);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(77, 13);
            this.label3.TabIndex = 8;
            this.label3.Text = "Відношення Q";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(11, 19);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(76, 13);
            this.label2.TabIndex = 7;
            this.label2.Text = "Відношення P";
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(721, 247);
            this.Controls.Add(this.inputPanel);
            this.Controls.Add(this.outputPanel);
            this.Name = "Form1";
            this.Text = "Операції над бінарними відношеннями";
            ((System.ComponentModel.ISupportInitialize)(this.inputPDataGridView)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.inputQDataGridView)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.resultDataGridView)).EndInit();
            this.outputPanel.ResumeLayout(false);
            this.outputPanel.PerformLayout();
            this.inputPanel.ResumeLayout(false);
            this.inputPanel.PerformLayout();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.DataGridView inputPDataGridView;
        private System.Windows.Forms.DataGridView inputQDataGridView;
        private System.Windows.Forms.DataGridView resultDataGridView;
        private System.Windows.Forms.ComboBox logicFunctionList;
        private System.Windows.Forms.Button testButton;
        private System.Windows.Forms.CheckBox useCheckBox;
        private System.Windows.Forms.Panel outputPanel;
        private System.Windows.Forms.Panel inputPanel;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label label2;
    }
}

