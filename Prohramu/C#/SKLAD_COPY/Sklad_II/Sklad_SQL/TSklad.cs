using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.Drawing;
using System.Windows.Forms;
using System.IO;

namespace Sklad_SQL
{
    class TSklad
    {
        public DataTable TabSklad = new DataTable();        //��������� public-���� � ������ TabSklad ���� DataTable
        public DataView SkladView;      // ��������� ����� ���� DataView ��� ��������� ������������ � ����������   
        public string FiltrCriteria;    // ��������� ����� ��� ��������� ������� ������������
        public string SortCriteria;     // ��������� ����� ��� ��������� ������� ����������

        public TSklad()         // ����������� ����� TSklad; 
        {
            // ��������� ������� ������� 
            // ��� cNpp, cNameGroup, cNameProduct, cProduser, cCount, cPrise, cVartist - ����� ��'����
            // ���� DataColumn, � ��������� ����� � ������ - �������� ����� ���������� ColumName.
            // ����� ������� ColumName ���� ���� � ���������
            SkladView = new DataView(TabSklad);     // ��������� ����� ���� DataView ��� ��������� ������������ � ����������
            DataColumn cNpp = new DataColumn("�_��");
            DataColumn cNameGroup = new DataColumn("�����");
            DataColumn cNameProduct = new DataColumn("�����");
            DataColumn cProduser = new DataColumn("��������");
            DataColumn cCount = new DataColumn("ʳ������");
            DataColumn cPrise = new DataColumn("ֳ��");
            DataColumn cVartist = new DataColumn("�������");
            //��������� ���� �����, �� ������ ���������� � ��������
            cNpp.DataType = System.Type.GetType("System.Int32");
            cNameGroup.DataType = System.Type.GetType("System.String");
            cNameProduct.DataType=System.Type.GetType("System.String");
            cProduser.DataType = System.Type.GetType("System.String");
            cCount.DataType = System.Type.GetType("System.Int32");
            cPrise.DataType = System.Type.GetType("System.Decimal");
            cVartist.DataType = System.Type.GetType("System.Decimal");
            // ����� ������� �� �������
            TabSklad.Columns.Add(cNpp);
            TabSklad.Columns.Add(cNameGroup);
            TabSklad.Columns.Add(cNameProduct);
            TabSklad.Columns.Add(cProduser);
            TabSklad.Columns.Add(cPrise);
            TabSklad.Columns.Add(cCount);
            TabSklad.Columns.Add(cVartist);
        }

        // ����� TSkladAddRow ��� ��������� ����� �� �������
        public void TSkladAddRow(string pNameGroup, string pNameProduct, string pProduser, int pCount, decimal pPrise)
        {
            int nn;
            nn = TabSklad.Rows.Count;
            // ��������� ����� rowSklad �� ����� ������� TabSklad
            // ����� ����� ���� ������ ���� � ���� � �������, �� � ������� �������
            DataRow rowSklad = TabSklad.NewRow();
            rowSklad["�_��"] = nn++;        // ���������� ��������� ���� ��������, �������� ����� ���������
            rowSklad["�����"] = pNameGroup;
            rowSklad["�����"] = pNameProduct;
            rowSklad["��������"] = pProduser;
            rowSklad["ֳ��"] = pPrise;
            rowSklad["ʳ������"] = pCount;
            rowSklad["�������"] = pCount * pPrise;
            TabSklad.Rows.Add(rowSklad);    // ������ ����������� ����� �� �������
        }

        // ColumnPropSet - �� ����� ��� ������������ ������ ������������ �������� DataGridView 
        public void ColumnPropSet(DataGridView DGV)
        {
            DGV.Columns["�_��"].HeaderText = "� �/�";
            DGV.Columns["�����"].HeaderText = "�����";
            DGV.Columns["�����"].HeaderText = "�����";
            DGV.Columns["��������"].HeaderText = "��������";
            DGV.Columns["ֳ��"].HeaderText = "ֳ��";
            DGV.Columns["ʳ������"].HeaderText = "ʳ������";
            DGV.Columns["�������"].HeaderText = "�������";
            DGV.Columns["�_��"].ReadOnly = true;    // ������� ����� � ������� ���������� ���������, �� ���������� ����������� ������� � ��� ���� 
            DGV.Columns["�������"].ReadOnly = true;
            DGV.Columns["�_��"].Width = 40;
            DGV.Columns["�����"].Width = 100;
            DGV.Columns["�����"].Width = 160;
            DGV.Columns["��������"].Width = 160;
            DGV.Columns["ֳ��"].Width = 70;
            DGV.Columns["ʳ������"].Width = 70;
            DGV.Columns["�������"].Width = 70;
            DGV.Columns["�_��"].DefaultCellStyle.BackColor = Color.Green;
        }

        public void ZapTabFile()
        {
            // ZapTabFile ����� ��� ����������� ������� � ��������� ����. ���� ������� FtabSklad.txt
            string sNameFile, textRow;
            // ��������� � ��������� ������ Directory.GetCurrentDirectory() ��� �������� � *.exe-������ �������,��� ���������� ������ ���� ���� ������� 
            string sdir = Directory.GetCurrentDirectory();
            sNameFile = sdir + @"\FTabSklad.txt";   // �� ���� � ��'� �����, ���� �� ������ ���������� �������
            try
            {
                if (File.Exists(sNameFile))
                {
                    File.Delete(sNameFile);
                }
                // StreamWriter - �� ���� ��� ����������� ������ � ��������� ����
                using (StreamWriter sw = new StreamWriter(sNameFile))   // �������� ��������� ����� StreamWriter, ���� ������������ ����� 
                {
                    foreach (DataRow rr in TabSklad.Rows)   // ��� ������� ����� rr �� ������� TabSklad
                    {
                        // ������� ��������� ����� �����, ��'������� �������� ���� ������� � ���� �����,��������� �� �������� ";"
                        textRow = rr["�����"] + ";" + rr["�����"] + ";" + rr["��������"] + ";" +
                                Convert.ToString(rr["ʳ������"]) + ";" + Convert.ToString(rr["ֳ��"]);
                        sw.WriteLine(textRow);  // �������� ����� � ����
                    }
                }
            }
            catch(Exception e)  //���� �� ������� ��������, ������ ����������� ��� �������
            {
                MessageBox.Show("������� �� ��������");
            }
        }

        public void ReadTabFile(DataGridView DGS)
        {
            //ReadTabFile ����� ��� ������� �����  � ���������� ����� � ��������� �� �� �������. 
            string sNameFile, textRow;
            string pGrupa, pNazva, pVyrobnyk, sKilkist, sCina;
            int pKilkist;
            decimal PCina;
            int i, ip;                        
            TabSklad.Rows.Clear();  // ������� �� ���� ����� �������, �� ������� ���� ���� ��������
            // ��������� �������, �� ���� �������� ���� �������
            string sdir = Directory.GetCurrentDirectory();
            sNameFile = sdir + @"\FTabSklad.txt";   // �� ����� ��'� �����, ���� ������ �������
            using (StreamReader sr = new StreamReader(sNameFile))
            {
                while (sr.Peek() >= 0)    // ������� ����� ������ ���� � � ����, sr - StreamReader
                {
                    pGrupa = "";
                    pNazva = "";
                    pVyrobnyk = "";
                    sKilkist = "";
                    sCina = "";
                    textRow = sr.ReadLine();    // StreamReader ������ ��� � ����� textRow �������� ����� �����
                    i = textRow.IndexOf(';') - 1;   //  ������� ���� ��� ����������� � ���� �� �������� �������� ';', �� ����� 
                    //������ ���� � ��������� ������ IndexOf ��� ���� string 
                    for (int j = 0; j <= i; j++)      // ����� ������� �� 0 �� �-1 - �� ����� ������
                    {
                        pGrupa = pGrupa + textRow[j];       // ���������� �� � ����� pGrupa
                    }
                    ip = i + 2;     // �����'������� ������� ������� ����������
                    i = textRow.IndexOf(';', ip) - 1;       // ��������� ��������� ���������
                    for (int j = ip; j <= i; j++)
                    {
                        pNazva = pNazva + textRow[j];       //������� �� ip  �� �-1 - �� ����� ������
                    }
                    ip = i + 2;     // �����'������� ������� ������� ����������
                    i = textRow.IndexOf(';', ip) - 1;       // ��������� ��������� ���������
                    for (int j = ip; j <= i; j++)
                    {
                        pVyrobnyk = pVyrobnyk + textRow[j];
                    }
                    ip = i + 2;     // �����'������� ������� ����������
                    i = textRow.IndexOf(';', ip) - 1;       // ��������� ��������� ���������
                    for (int j = ip; j <= i; j++)
                    {
                        sKilkist= sKilkist + textRow[j];
                    }
                    ip = i + 2;     // �����'������� ������� ����������                    
                    for (int j = ip; j <= textRow.Length-1; j++)
                    {
                        sCina = sCina + textRow[j];
                    }
                    //����������� ������� �������� ������� � ���� �������� � int32 �  Decimal
                    pKilkist = Convert.ToInt32(sKilkist);
                    PCina = Convert.ToDecimal(sCina);
                    // ������ ����� ����� �� ������� �������������� ����� TSkladAddRow
                    TSkladAddRow(pGrupa, pNazva, pVyrobnyk, pKilkist, PCina);
                }
            }
            SetSumy(DGS);
        }

        public void TSkladValFiltr(String PFilter, DataGridView DGV)
        {
            // TSkladValFiltr - ����� ��� ���������� �� ���� ������ � �������� �� DataGridView ������� �� ��������� ��������
            try
            {
                SkladView.RowFilter = PFilter;      // ������������ �������� �������
                FiltrCriteria = PFilter;
                // ��������� ���� SkladView �� ������� �����
                DGV.DataSource = SkladView;
            }
            catch
            {
                MessageBox.Show("�������� ������ �������");
                return;
            }
        }

        public void TSkladValSort(String PSort, DataGridView DGV, DataGridView DGVSum)
        {
            // TSkladValSort - ����� ��� ������������ ������� ����������
            try
            {
                SkladView.Sort = PSort;     // ������������ ������� ����������
                SortCriteria = PSort;
                DGV.DataSource = SkladView;
                DGV.Refresh();
            }
            catch
            {
                MessageBox.Show("�������� ������� ���������� �������");
                return;
            }
        }

        public void SeekNazva(string sNazva, DataGridView DGV)
        {
            int nn;     // nn - ����� �������� �����
            nn = -5;    // ��'���� �������� ���� ��������, �� ����� � ������� ������ �� ��������
            for (int i = 0; i < DGV.Rows.Count; i++)
            {
                if ((string)DGV.Rows[i].Cells["�����"].Value == sNazva)
                {
                    nn = i;     // ���� ����� �������, �� �� ������� ������� �����. �������� ���� ����� � nn
                    break;      // �������� � �����.
                }
            }
            if (nn >= 0)          // ���� ����� ��������, �� �������� ���� � �������
            {
                DGV.FirstDisplayedCell = DGV.Rows[nn].Cells["�����"];
                DGV.Rows[nn].Selected = true;
                DGV.CurrentCell = DGV.Rows[nn].Cells["�����"];      // ���������� ��������� ����� �� ��������
            }
            else
            {
                MessageBox.Show("�������� �� ��������");
            }
        }

        public void SetSumy(DataGridView DGV)
        {
            // �������� ������� ��� �������, �������� � �� ������� � �������� �� ������� �������� ����� ��� DGV
            string sGrupa, ssort;
            decimal DSuma;
            int i;
            DataTable TabSkladSum = new DataTable();
            // ������� ������� ���� ���������� �� 2 �������� - ����� �� �������.
            DataColumn cNameGroupS = new DataColumn("�����");
            DataColumn cVartistS = new DataColumn("�������");
            cNameGroupS.DataType = System.Type.GetType("System.String");
            cVartistS.DataType = System.Type.GetType("System.Decimal");
            // ����� ������� �� �������
            TabSkladSum.Columns.Add(cNameGroupS);
            TabSkladSum.Columns.Add(cVartistS);
            ssort = SkladView.Sort;     //�����'����� ������� ������� ������������ ������� ����������
            SkladView.Sort = "�����";   // ���������� ���������� �� ������ ������. SkladView.Count - ������� �����
            i = 0;
            while (i < SkladView.Count) // ��� ��� �����  �� ������� TabSklad, ������������ �� ������
            {
                sGrupa = (string)SkladView[i]["�����"];     // ������� ������� ����� ������
                DSuma = 0.0M;                               // ��������� �������� ���� ��������� ��� ����� �����
                while ((i < SkladView.Count) & (sGrupa == (string)SkladView[i]["�����"]))
                {
                    try     // ������� � ������� ����� �� �������� �������, ���� ������������ �������� try - catch
                    {
                        DSuma = DSuma + (decimal)SkladView[i]["�������"];  // ��������� ���� ��������� �� ����
                    }
                    catch
                    {
                        SkladView[i]["�������"] = 0M;
                    }
                    i++;
                    if (i == SkladView.Count)
                        break;
                }
                DataRow rowSkladSum = TabSkladSum.NewRow();
                rowSkladSum["�����"] = sGrupa;
                rowSkladSum["�������"] = DSuma;
                TabSkladSum.Rows.Add(rowSkladSum);      // ������ ����������� ����� �� ������� �������
            }
            DGV.DataSource = TabSkladSum;
            SkladView.Sort = SortCriteria;  // ³������� ������� ����������, ���� �� ��� ��� ���� ����������� ���������� �� ����
        }



    }
}
