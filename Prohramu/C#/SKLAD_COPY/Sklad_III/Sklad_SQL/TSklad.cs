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
        public DataTable TabSklad = new DataTable();        //Оголошуємо public-поле з іменем TabSklad типу DataTable
        public DataView SkladView;      // Оголошуємо змінну типу DataView для можливості фільтрування і сортування   
        public string FiltrCriteria;    // Оголошуємо змінну для зберігання критерію фільтрування
        public string SortCriteria;     // Оголошуємо змінну для зберігання критерію сортування
        public DataGridViewComboBoxColumn cGrupaCB;
        public DataTable DovGrupa = new DataTable();

        public TSklad()         // Конструктор класу TSklad; 
        {
            // Створюємо стовпці таблиці 
            // Тут cNpp, cNameGroup, cNameProduct, cProduser, cCount, cPrise, cVartist - назви об'єктів
            // типу DataColumn, а кириличні слова у лапках - значення їхніх властивості ColumName.
            // Назва стовпця ColumName може бути і кирилична
            SkladView = new DataView(TabSklad);     // Створюємо змінну типу DataView для можливості фільтрування і сортування
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
            DGV.Columns["№_пп"].Width = 50;
            DGV.Columns["Група"].Width = 160;
            DGV.Columns["Назва"].Width = 180;
            DGV.Columns["Виробник"].Width = 180;
            DGV.Columns["Ціна"].Width = 80;
            DGV.Columns["Кількість"].Width = 80;
            DGV.Columns["Вартість"].Width = 80;
            DGV.Columns["№_пп"].DefaultCellStyle.BackColor = Color.Green;
        }

        public void ZapTabFile()
        {
            // ZapTabFile Метод для записування таблиці у текстовий файл. Файл назвемо FtabSklad.txt
            string sNameFile, textRow;
            // Визначимо з допомогою методу Directory.GetCurrentDirectory() ім’я каталогу з *.exe-файлом проекту,для наступного запису туди нашої таблиці 
            string sdir = Directory.GetCurrentDirectory();
            sNameFile = sdir + @"\FTabSklad.txt";   // Це шлях і ім'я файла, куди ми будемо записувати таблицю
            try
            {
                if (File.Exists(sNameFile))
                {
                    File.Delete(sNameFile);
                }
                // StreamWriter - це клас для записування записів у текстовий файл
                using (StreamWriter sw = new StreamWriter(sNameFile))   // Створимо екземпляр класу StreamWriter, який записуватиме рядки 
                {
                    foreach (DataRow rr in TabSklad.Rows)   // Для кожного рядка rr із таблиці TabSklad
                    {
                        // Побудуєм текстовий образ рядка, об'єднуючи значення полів таблиці у один рядок,розділяючи їх символом ";"
                        textRow = rr["Група"] + ";" + rr["Назва"] + ";" + rr["Виробник"] + ";" +
                                Convert.ToString(rr["Кількість"]) + ";" + Convert.ToString(rr["Ціна"]);
                        sw.WriteLine(textRow);  // Запишемо рядок у файл
                    }
                }
            }
            catch(Exception e)  //Якщо не вдалося записати, видати повідомлення про помилку
            {
                MessageBox.Show("Таблиця не записана");
            }
        }

        public void ReadTabFile(DataGridView DGS)
        {
            //ReadTabFile Метод для читання рядків  з текстового файлу і додавання їх до таблиці. 
            string sNameFile, textRow;
            string pGrupa, pNazva, pVyrobnyk, sKilkist, sCina;
            int pKilkist;
            decimal PCina;
            int i, ip;                        
            TabSklad.Rows.Clear();  // Очищаємо усі старі рядки таблиці, які можливо були туди заведені
            // Визначимо каталог, де було записано файл таблиці
            string sdir = Directory.GetCurrentDirectory();
            sNameFile = sdir + @"\FTabSklad.txt";   // Це повне ім'я файла, який містить таблицю
            using (StreamReader sr = new StreamReader(sNameFile))
            {
                while (sr.Peek() >= 0)    // Зчитуємо рядки допоки вони є у файлі, sr - StreamReader
                {
                    pGrupa = "";
                    pNazva = "";
                    pVyrobnyk = "";
                    sKilkist = "";
                    sCina = "";
                    textRow = sr.ReadLine();    // StreamReader запише нам у змінну textRow черговий рядок файлу
                    i = textRow.IndexOf(';') - 1;   //  Оскільки поля при записуванні у файл ми розділяли символом ';', то тепер 
                    //шукаємо його з допомогою методу IndexOf для типу string 
                    for (int j = 0; j <= i; j++)      // перші символи від 0 до і-1 - це група товару
                    {
                        pGrupa = pGrupa + textRow[j];       // переприсуєм їх у змінну pGrupa
                    }
                    ip = i + 2;     // запам'ятовуємо позицію першого розділювача
                    i = textRow.IndexOf(';', ip) - 1;       // знаходимо наступний розділювач
                    for (int j = ip; j <= i; j++)
                    {
                        pNazva = pNazva + textRow[j];       //символи від ip  до і-1 - це назва товару
                    }
                    ip = i + 2;     // запам'ятовуємо позицію другого розділювача
                    i = textRow.IndexOf(';', ip) - 1;       // знаходимо наступний розділювач
                    for (int j = ip; j <= i; j++)
                    {
                        pVyrobnyk = pVyrobnyk + textRow[j];
                    }
                    ip = i + 2;     // запам'ятовуємо позицію розділювача
                    i = textRow.IndexOf(';', ip) - 1;       // знаходимо наступний розділювач
                    for (int j = ip; j <= i; j++)
                    {
                        sKilkist= sKilkist + textRow[j];
                    }
                    ip = i + 2;     // запам'ятовуємо позицію розділювача                    
                    for (int j = ip; j <= textRow.Length-1; j++)
                    {
                        sCina = sCina + textRow[j];
                    }
                    //Перетворимо стрінгові значення кількості і ціни відповідно у int32 і  Decimal
                    pKilkist = Convert.ToInt32(sKilkist);
                    PCina = Convert.ToDecimal(sCina);
                    // Додаємо новий рядок до таблиці використовуючи метод TSkladAddRow
                    TSkladAddRow(pGrupa, pNazva, pVyrobnyk, pKilkist, PCina);
                }
            }
            SetSumy(DGS);
        }

        public void TSkladValFiltr(String PFilter, DataGridView DGV)
        {
            // TSkladValFiltr - метод для накладання на нашу табицю і відповідно на DataGridView фільтру по значеннях стовпців
            try
            {
                SkladView.RowFilter = PFilter;      // встановлюємо значення фільтру
                FiltrCriteria = PFilter;
                // Назначаємо гріду SkladView як джерело даних
                DGV.DataSource = SkladView;
            }
            catch
            {
                MessageBox.Show("Введений фільтр невірний");
                return;
            }
        }

        public void TSkladValSort(String PSort, DataGridView DGV, DataGridView DGVSum)
        {
            // TSkladValSort - метод для встановлення порядку сортування
            try
            {
                SkladView.Sort = PSort;     // встановлюємо критерій сортування
                SortCriteria = PSort;
                DGV.DataSource = SkladView;
                DGV.Refresh();
            }
            catch
            {
                MessageBox.Show("Введений критерій сортування невірний");
                return;
            }
        }

        public void SeekNazva(string sNazva, DataGridView DGV)
        {
            int nn;     // nn - номер шуканого рядка
            nn = -5;    // від'ємне значення буде означати, що рядок з шуканою назвою не знайдено
            for (int i = 0; i < DGV.Rows.Count; i++)
            {
                if ((string)DGV.Rows[i].Cells["Назва"].Value == sNazva)
                {
                    nn = i;     // якщо назви співпали, то ми знайшли шуканий рядок. Записуємо його номер у nn
                    break;      // виходимо з циклу.
                }
            }
            if (nn >= 0)          // Якщо рядок знайдено, то показуємо його і виділяєм
            {
                DGV.FirstDisplayedCell = DGV.Rows[nn].Cells["Назва"];
                DGV.Rows[nn].Selected = true;
                DGV.CurrentCell = DGV.Rows[nn].Cells["Назва"];      // Встановимо знайдений рядок як поточний
            }
            else
            {
                MessageBox.Show("Значення не знайдено");
            }
        }

        public void SetSumy(DataGridView DGV)
        {
            // Створимо таблицю для підсумків, запишемо у неї підсумки і назначим цю таблицю джерелом даних для DGV
            string sGrupa, ssort;
            decimal DSuma;
            int i;
            DataTable TabSkladSum = new DataTable();
            // Таблиця підсумків буде складатись із 2 стовпців - група та вартість.
            DataColumn cNameGroupS = new DataColumn("Група");
            DataColumn cVartistS = new DataColumn("Вартість");
            cNameGroupS.DataType = System.Type.GetType("System.String");
            cVartistS.DataType = System.Type.GetType("System.Decimal");
            // Додаєм стовпці до таблиці
            TabSkladSum.Columns.Add(cNameGroupS);
            TabSkladSum.Columns.Add(cVartistS);
            ssort = SkladView.Sort;     //Запам'ятаємо можливо заданий користувачем критерій сортування
            SkladView.Sort = "Група";   // Встановимо сортування по групах товару. SkladView.Count - кількість рядків
            i = 0;
            while (i < SkladView.Count) // Для всіх рядків  із таблиці TabSklad, впорядкованої по групах
            {
                sGrupa = (string)SkladView[i]["Група"];     // Вибираєм чергову групу товару
                DSuma = 0.0M;                               // Обнулюємо значення суми вартостей для кожної групи
                while ((i < SkladView.Count) & (sGrupa == (string)SkladView[i]["Група"]))
                {
                    try     // Можливо у якомусь рядку не записана вартість, тому скористаємось засобами try - catch
                    {
                        DSuma = DSuma + (decimal)SkladView[i]["Вартість"];  // накопичуєм суму вартостей по групі
                    }
                    catch
                    {
                        SkladView[i]["Вартість"] = 0M;
                    }
                    i++;
                    if (i == SkladView.Count)
                        break;
                }
                DataRow rowSkladSum = TabSkladSum.NewRow();
                rowSkladSum["Група"] = sGrupa;
                rowSkladSum["Вартість"] = DSuma;
                TabSkladSum.Rows.Add(rowSkladSum);      // Додаємо сформований рядок до таблиці підсумків
            }
            DGV.DataSource = TabSkladSum;
            SkladView.Sort = SortCriteria;  // Відновимо критерій сортування, тому що для сум було встановлено сортування по групі
        }

        public void CreateDovGrupa()
        {
            // Створимо таблицю для довідника груп, запишемо у неї дані простим присвоєнням
            DataColumn cNameGroup = new DataColumn("Група");
            cNameGroup.DataType = System.Type.GetType("System.String");
            DovGrupa.Columns.Add(cNameGroup);
            DataRow rowSklad0 = DovGrupa.NewRow();
            rowSklad0[cNameGroup] = "Книги";
            DovGrupa.Rows.Add(rowSklad0);

            DataRow rowSklad1 = DovGrupa.NewRow();
            rowSklad1[cNameGroup] = "CD";
            DovGrupa.Rows.Add(rowSklad1);

            DataRow rowSklad2 = DovGrupa.NewRow();
            rowSklad2[cNameGroup] = "DVD";
            DovGrupa.Rows.Add(rowSklad2);

            DataRow rowSklad3 = DovGrupa.NewRow();
            rowSklad3[cNameGroup] = "Мобільні телефони";
            DovGrupa.Rows.Add(rowSklad3);

            DataRow rowSklad4 = DovGrupa.NewRow();
            rowSklad4[cNameGroup] = "Плеєри";
            DovGrupa.Rows.Add(rowSklad4);

            DataRow rowSklad5 = DovGrupa.NewRow();
            rowSklad5[cNameGroup] = "Аксесуари";
            DovGrupa.Rows.Add(rowSklad5);

            DataRow rowSklad6 = DovGrupa.NewRow();
            rowSklad6[cNameGroup] = "Дисплеї";
            DovGrupa.Rows.Add(rowSklad6);

            DataRow rowSklad7 = DovGrupa.NewRow();
            rowSklad7[cNameGroup] = "Корпуси";
            DovGrupa.Rows.Add(rowSklad7);

            DataRow rowSklad8 = DovGrupa.NewRow();
            rowSklad8[cNameGroup] = "Блоки живлення";
            DovGrupa.Rows.Add(rowSklad8);

            DataRow rowSklad9 = DovGrupa.NewRow();
            rowSklad9[cNameGroup] = "Клавіатури";
            DovGrupa.Rows.Add(rowSklad9);

            int nn = DovGrupa.Rows.Count;
        }

        public void AddComboGrupa(DataGridView DGV)
        {
            // Цей метод замінить стовбець назв груп товарів у гріді таблиці складу на новий стовбець.
            // Від старого він буде відрізнятися тим, що при клацанні на його комірку буде відкриватись вікно-випадайка,
            // з якого користувач зможе вибрати групу товару і внести її у комірку простим клацанням миші
            // Окрім спрощення введення інформації такий спосіб іще гарантує, що у комірку завжди буде введено лише допустиме значення
            DataGridViewComboBoxColumn cGrupaCB = new DataGridViewComboBoxColumn();
            cGrupaCB.DataPropertyName = "Група";
            cGrupaCB.Name = "cNameGroupComb";
            cGrupaCB.HeaderText = "Група";
            cGrupaCB.DropDownWidth = 160;
            cGrupaCB.Width = 160;
            cGrupaCB.MaxDropDownItems = 7;
            cGrupaCB.FlatStyle = FlatStyle.Flat;
            cGrupaCB.ValueType = System.Type.GetType("System.String");
            String s;
            Int32 n;
            n = DovGrupa.Rows.Count;
            foreach (DataRow r in DovGrupa.Rows)
            {
                s = (string)r["Група"];
                cGrupaCB.Items.AddRange(r["Група"]);
            }
            DGV.Columns.Add(cGrupaCB);
            String ss;
            foreach (DataGridViewRow rrr in DGV.Rows)
            {
                ss = (string)rrr.Cells["Група"].Value;
                rrr.Cells["Група"].Value = rrr.Cells["Група"].Value;
            }
            DGV.Columns.Remove("Група");
            DGV.Columns["cNameGroupComb"].Name = "Група";
            DGV.Columns["Група"].DisplayIndex = 1;
            DGV.Refresh();
        }

    }
}
