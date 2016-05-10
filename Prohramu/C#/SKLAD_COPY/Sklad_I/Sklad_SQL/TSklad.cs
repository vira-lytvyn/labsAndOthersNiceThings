using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.Drawing;
using System.Windows.Forms;

namespace Sklad_SQL
{
    class TSklad
    {
        public DataTable TabSklad = new DataTable();        //Оголошуємо public-поле з іменем TabSklad типу DataTable

        public TSklad()         // Конструктор класу TSklad; 
        {
            // Створюємо стовпці таблиці 
            // Тут cNpp, cNameGroup, cNameProduct, cProduser, cCount, cPrise, cVartist - назви об'єктів
            // типу DataColumn, а кириличні слова у лапках - значення їхніх властивості ColumName.
            // Назва стовпця ColumName може бути і кирилична
            DataColumn cNpp = new DataColumn("№_пп");
            DataColumn cNameGroup = new DataColumn("Група");
            DataColumn cNameProduct = new DataColumn("Назва");
            DataColumn cProduser = new DataColumn("Виробник");
            DataColumn cCount = new DataColumn("Кількість");
            DataColumn cPrise = new DataColumn("Ціна");
            DataColumn cVartist = new DataColumn("Вартість");
            //Оголошуємо типи даних, що будуть зберігатися у стовпцях
            cNpp.DataType = System.Type.GetType("System.Int32");
            cNameGroup.DataType = System.Type.GetType("System.String");
            cNameProduct.DataType=System.Type.GetType("System.String");
            cProduser.DataType = System.Type.GetType("System.String");
            cCount.DataType = System.Type.GetType("System.Int32");
            cPrise.DataType = System.Type.GetType("System.Decimal");
            cVartist.DataType = System.Type.GetType("System.Decimal");
            // Додаєм стовпці до таблиці
            TabSklad.Columns.Add(cNpp);
            TabSklad.Columns.Add(cNameGroup);
            TabSklad.Columns.Add(cNameProduct);
            TabSklad.Columns.Add(cProduser);
            TabSklad.Columns.Add(cPrise);
            TabSklad.Columns.Add(cCount);
            TabSklad.Columns.Add(cVartist);
        }

        // Метод TSkladAddRow для додавання рядків до таблиці
        public void TSkladAddRow(string pNameGroup, string pNameProduct, string pProduser, int pCount, decimal pPrise)
        {
            int nn;
            nn = TabSklad.Rows.Count;
            // Оголошуємо змінну rowSklad як рядок таблиці TabSklad
            // Такий рядок буде містити поля з тими ж назвами, що й стовпці таблиці
            DataRow rowSklad = TabSklad.NewRow();
            rowSklad["№_пп"] = nn++;        // присвоюємо значенням полів значення, отримані через параметри
            rowSklad["Група"] = pNameGroup;
            rowSklad["Назва"] = pNameProduct;
            rowSklad["Виробник"] = pProduser;
            rowSklad["Ціна"] = pPrise;
            rowSklad["Кількість"] = pCount;
            rowSklad["Вартість"] = pCount * pPrise;
            TabSklad.Rows.Add(rowSklad);    // Додаємо сформований рядок до таблиці
        }

        // ColumnPropSet - це метод для встановлення деяких властивостей стовпців DataGridView 
        public void ColumnPropSet(DataGridView DGV)
        {
            DGV.Columns["№_пп"].HeaderText = "№ п/п";
            DGV.Columns["Група"].HeaderText = "Група";
            DGV.Columns["Назва"].HeaderText = "Назва";
            DGV.Columns["Виробник"].HeaderText = "Виробник";
            DGV.Columns["Ціна"].HeaderText = "Ціна";
            DGV.Columns["Кількість"].HeaderText = "Кількість";
            DGV.Columns["Вартість"].HeaderText = "Вартість";
            DGV.Columns["№_пп"].ReadOnly = true;    // Оскільки номер і вартість формуються програмно, то заборонимо користувачу вводити у них дані 
            DGV.Columns["Вартість"].ReadOnly = true;
            DGV.Columns["№_пп"].Width = 40;
            DGV.Columns["Група"].Width = 100;
            DGV.Columns["Назва"].Width = 160;
            DGV.Columns["Виробник"].Width = 160;
            DGV.Columns["Ціна"].Width = 70;
            DGV.Columns["Кількість"].Width = 70;
            DGV.Columns["Вартість"].Width = 70;
            DGV.Columns["№_пп"].DefaultCellStyle.BackColor = Color.Green;
        }

    }
}
