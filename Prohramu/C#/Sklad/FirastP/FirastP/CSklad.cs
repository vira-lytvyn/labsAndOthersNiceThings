using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Drawing;
using System.Windows.Forms;

namespace FirastP
{
    
    class CSklad
    {
        public DataTable TabSklad = new DataTable();
        public CSklad()
        {
            DataColumn cNpp = new DataColumn(" Н п/п ");
            DataColumn cNGroup = new DataColumn(" Група ");
            DataColumn cNProduct = new DataColumn(" Назва продукту ");
            DataColumn cNAuotr = new DataColumn(" Виробник ");
            DataColumn cNPrice = new DataColumn(" Ціна ");
            DataColumn cNNum = new DataColumn(" Кількість ");
            DataColumn cNCost = new DataColumn(" Вартість ");
            cNpp.DataType = System.Type.GetType("System.Int32");
            cNGroup.DataType = System.Type.GetType("System.String");
            cNProduct.DataType = System.Type.GetType("System.String");
            cNPrice.DataType = System.Type.GetType("System.Decimal");
            cNNum.DataType = System.Type.GetType("System.Int32");
            cNCost.DataType = System.Type.GetType("System.Decimal");
            TabSklad.Columns.Add(cNpp);
            TabSklad.Columns.Add(cNGroup);
            TabSklad.Columns.Add(cNProduct);
            TabSklad.Columns.Add(cNAuotr);
            TabSklad.Columns.Add(cNPrice);
            TabSklad.Columns.Add(cNNum);
            TabSklad.Columns.Add(cNCost);
        }
        public void CAddRow(string pNGroup, string pNProduct, string pNAutor, int pNNum, decimal pNPrice)
        {
            int nn;
            nn = TabSklad.Rows.Count;
            DataRow rowSklad = TabSklad.NewRow();
            rowSklad[0] = nn++;
            rowSklad[1]=pNGroup;
            rowSklad[2]=pNProduct;
            rowSklad[3]=pNAutor;
            rowSklad[4]=pNPrice;
            rowSklad[" Кількість "]=pNNum;
            rowSklad[" Вартість "] = pNNum * pNPrice;
            TabSklad.Rows.Add(rowSklad);
        }
        public void ColumnPropSet(DataGridView DGV)//задає властивості стовпцям
        {
            DGV.Columns["N_пп"].HeaderText = "№ п/п";
            DGV.Columns["Група"].HeaderText = "Група";
            DGV.Columns["Назва"].HeaderText = "Назва";
            DGV.Columns["Виробник"].HeaderText = "Виробник";
            DGV.Columns["Ціна"].HeaderText = "Ціна";
            DGV.Columns["Кількість"].HeaderText = "Кількість";
            DGV.Columns["Вартість"].HeaderText = "Вартість";
            DGV.Columns["N_пп"].ReadOnly = true;
            DGV.Columns["N_пп"].Width = 40;
            DGV.Columns["Група"].Width = 100;
            DGV.Columns["Назва"].Width = 160;
            DGV.Columns["Виробник"].Width = 160;
            DGV.Columns["Ціна"].Width = 70;
            DGV.Columns["Кількість"].Width = 70;
            DGV.Columns["Вартість"].Width = 70;
            DGV.Columns[0].DefaultCellStyle.BackColor = Color.Green;
        }
    }
    
}
