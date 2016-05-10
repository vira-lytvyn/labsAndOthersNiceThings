using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Drawing;
using System.ComponentModel;
using System.Windows.Forms;

namespace Graphik
{
    public class Grafik
    {
        int krokx, kroky, i, mx, my, x1, x2, y1, y2, gx0, gy0;
        double maxx, minx, maxy, miny, kx, ky, zx, zy, gx, gy, kgzx, kgzy, cx, cy;
        double pidpys;
        short L, hor, vert;
        string str;
        
        double getmaxy(double[] y)                              //ф-ція для знаходження максимального елементу масиву
        {
            int n_mas = y.GetUpperBound(0);                     //визначення розмірності масиву
            double rez = y[0];
            for (i = 0; i < n_mas; i++)
                if (y[i] > rez) rez = y[i];
            return rez;                                         //повернення результату
        }

        double getminy(double[] y)                              //ф-ція для знаходження мінімального елементу масиву
        {
            int n_mas = y.GetUpperBound(0);                     //визначення розмірності масиву
            double rez = y[0];
            for (i = 0; i < n_mas; i++)
                if (y[i] < rez) rez = y[i];
            return rez;                                         //повернення результату
        }

        public void ModelGrafik(ref double[] xgr, ref double[] ygr, int ne, Graphics g )   //метод для рисування графіка
        {
            maxx = xgr[ne - 1];
            minx = xgr[0];
            maxy = getmaxy(ygr);
            miny = getminy(ygr);
            L = 40;                                             //"пуста" область від країв панелі для підписів графіка                                                               
            short i;
            Pen penRed = new Pen(Color.Blue);                    //олівець для рисування осей
            Pen penBlue = new Pen(Color.Blue);        //олівець для рисування гратки
            Pen penGreen = new Pen(Color.Aqua);            //олівець для рисування графіка          
            Pen penDarkBlue = new Pen(Color.DarkBlue);
            SolidBrush textBrush = new SolidBrush(Color.Black);     //пензель для підписів
            Font text = new Font("Arial", 10);                                      //шрифт для підписів
            mx = 600;                                           //розмір поля для графіка (панелі) по осі х
            my = 600;                                           //розмір панелі по осі у
            g.Clear(Color.Azure);                               //очищення поля для графіка
            //розрахунок коефіцієнтів масштабування для графіка
            kx = (mx - 2 * L) / (maxx - minx);
            ky = (my - 2 * L) / (miny - maxy);
            zx = (mx * minx - L * (minx + maxx)) / (minx - maxx);
            zy = (my * maxy - L * (miny + maxy)) / (maxy - miny);
            if (minx * maxx <= 0)
                gx = 0;
            if ((minx * maxx > 0) && (minx > 0))
                gx = minx;
            if ((minx * maxx > 0)) //&& (minx < 0))
                gx = maxx;
            if (miny * maxy <= 0)
                gy = 0;
            if ((miny * maxy > 0)) //&& (miny > 0))
                gy = miny;
            if ((miny * maxy > 0) && (miny < 0))
                gy = maxy;
            kgzx = kx * gx + zx;
            kgzy = ky * gy + zy;
            gx0 = Convert.ToInt32(kgzx);
            gy0 = Convert.ToInt32(kgzy);
            //коефіцієнти для гратки
            krokx = (mx - 2 * L) / 10;
            kroky = (my - 2 * L) / 10;
            if (minx * maxx < 0)
                cx = (Math.Abs(minx) * krokx) / (gx0 - L);
            else
                cx = (Math.Abs(maxx - minx) * krokx) / (mx - 2 * L);
            if (miny * maxy < 0)
                cy = (Math.Abs(maxy) * kroky) / (gy0 - L);
            else
                cy = (Math.Abs(maxy - miny) * kroky) / (my - 2 * L);
            //малюємо гратку
            //вертикальні лінії у 1 та 4 чвертях
            vert = 1;
            while ((gx0 + vert * krokx) < (mx - L))
            {
                g.DrawLine(penBlue, gx0 + vert * krokx, L, gx0 + vert * krokx, my - L);
                if ((gx0 + vert * krokx) < (mx - L - 10))
                    g.DrawLine(penDarkBlue, gx0 + vert * krokx, gy0 - 5, gx0 + vert * krokx, gy0 + 5);
                vert++;
            }
            for (i = 1; i < vert; i++)
            {
                if (minx * maxx < 0)
                {
                    pidpys = 0 + i * cx;
                    str = pidpys.ToString("F2");
                }
                else
                {
                    pidpys = minx + i * cx;
                    str = pidpys.ToString("F2");
                }
                g.DrawString(str, text, textBrush, gx0 + i * krokx, gy0 + 10);
            }
            //вертикальні лінії у 2 та 3 чвертях
            vert = 1;
            while ((gx0 - vert * krokx) > L)
            {
                g.DrawLine(penBlue, gx0 - vert * krokx, L, gx0 - vert * krokx, my - L);
                g.DrawLine(penDarkBlue, gx0 - vert * krokx, gy0 - 5, gx0 - vert * krokx, gy0 + 5);
                vert++;
            }
            for (i = 1; i < vert; i++)
            {
                if (minx * maxx < 0)
                {
                    pidpys = 0 - i * cx;
                    str = pidpys.ToString("F2");
                }
                else
                {
                    pidpys = maxx - i * cx;
                    str = pidpys.ToString("F2");
                }
                g.DrawString(str, text, textBrush, gx0 - i * krokx, gy0 + 10);
            }
            //горизонтальні лінії у 1 та 2 чвертях
            hor = 1;
            while ((gy0 - hor * kroky) > L)
            {
                g.DrawLine(penBlue, L, gy0 - hor * kroky, mx - L, gy0 - hor * kroky);
                if ((gy0 - hor * kroky) > (L + 10))
                    g.DrawLine(penDarkBlue, gx0 - 5, gy0 - hor * kroky, gx0 + 5, gy0 - hor * kroky);
                hor++;
            }
            for (i = 1; i < hor; i++)
            {
                if (miny * maxy < 0)
                {
                    pidpys = 0 + i * cy;
                    str = pidpys.ToString("F2");
                }
                else
                {
                    pidpys = miny + i * cy;
                    str = pidpys.ToString("F2");
                }
                g.DrawString(str, text, textBrush, gx0 - 28, gy0 - i * kroky);
            }
            //горизонтальні лінії у 3 та 4 чвертях
            hor = 1;
            while ((gy0 + hor * kroky) < (my - L))
            {
                g.DrawLine(penBlue, L, gy0 + hor * kroky, mx - L, gy0 + hor * kroky);
                g.DrawLine(penDarkBlue, gx0 - 5, gy0 + hor * kroky, gx0 + 5, gy0 + hor * kroky);
                hor++;
            }
            for (i = 1; i < hor; i++)
            {
                if (miny * maxy < 0)
                {
                    pidpys = 0 - i * cy;
                    str = pidpys.ToString("F2");
                }
                else
                {
                    pidpys = maxy - i * cy;
                    str = pidpys.ToString("F2");
                }
                g.DrawString(str, text, textBrush, gx0 - 28, gy0 + i * kroky);
            }

            g.DrawRectangle(penBlue, L, L, mx - 2 * L, my - 2 * L);                 //контури поля графіка
            g.DrawString("x", text, textBrush, mx - L / 2 - 20, Convert.ToInt32(kgzy) - 15);
            g.DrawString("f(x)", text, textBrush, Convert.ToInt32(kgzx), L - 35);
            if(minx*maxx<=0)
                if(miny*maxy<=0)
                    g.DrawString("0;0", text, textBrush, gx0,gy0+10);
            //малюємо осі координат
            //перевіряємо код у блоці try на помилки
            try
            {
                g.DrawLine(penRed, new Point(L, gy0), new Point(mx - L, gy0));
                g.DrawLine(penRed, new Point(gx0, L), new Point(gx0, my - L));
                g.DrawLine(penRed, new Point(mx - L, gy0), new Point(mx - L - 15, gy0 - 5));
                g.DrawLine(penRed, new Point(mx - L, gy0), new Point(mx - L - 15, gy0 + 5));
                g.DrawLine(penRed, gx0, L, gx0 + 5, L + 15);
                g.DrawLine(penRed, gx0, L, gx0 - 5, L + 15);
            }
            catch
            {
                MessageBox.Show("Розбіжність");
                return;
            }
            //малюємо графік 
            for (i = 0; i < ne - 1; i++)
            {
                x1 = Convert.ToInt32(kx * xgr[i] + zx);
                y1 = Convert.ToInt32(ky * ygr[i] + zy);
                x2 = Convert.ToInt32(kx * xgr[i + 1] + zx);
                y2 = Convert.ToInt32(ky * ygr[i + 1] + zy);
                g.DrawLine(penGreen, x1, y1, x2, y2);
            }
        }
    }
}
