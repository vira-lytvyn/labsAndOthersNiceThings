using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Drawing;
using System.Windows.Forms;
using System.ComponentModel;

namespace Graphichok
{
    class ModelGraphic
    {
        int l, i, ne, krokx, kroky, mx, my;
        double al, bl, h, maxx, maxy, miny, minx, kx, ky, zx, zy, gx, gy, ax, by;
        double f(double x)
        {
            double z;
            z = Math.Sin(x) * x;
            return z;
        }
        public void tabular(ref double[] xe, ref double[] ye)
        {
            ne = xe.GetUpperBound(0) - 1;
            al = -40;
            bl = 90;
            h = (bl - al) / ne;
            xe[0] = al;
            for (i = 0; i <= ne - 1; i++)
            {
                ye[i] = f(xe[i]);
                xe[i + 1] = xe[i] + h;
            }
        }
        double getmaxy(double[] y)
        {
            int nt = y.GetUpperBound(0);
            double R = y[0];
            for (i = 0; i <= nt - 1; i++)
            {
                if (R < y[i])
                    R = y[i];
            }
            return R;
        }
        double getminy(double[] y)
        {
            int nt = y.GetUpperBound(0);
            double R = y[0];
            for (i = 0; i <= nt - 1; i++)
            {
                if (R > y[i])
                    R = y[i];
            }
            return R;
        }
        public void MalGraphik(ref double[] xe, ref double[] ye, int ne, Graphics g)
        {
            maxx = xe[ne - 2];
            minx = xe[0];
            maxy = getmaxy(ye);
            miny = getminy(ye);
            l = 60;
            Pen penBlue = new Pen(Color.Blue);
            Pen penYellow = new Pen(Color.Yellow);
            Pen penAqua = new Pen(Color.Aqua);
            g.DrawLine(penBlue, 90, 30, 110, 40);
            SolidBrush MalBrush = new SolidBrush(Color.Aqua);
            SolidBrush TextBrush = new SolidBrush(Color.Black);
            mx = 700;
            my = 300;
            g.Clear(Color.White);
            kx = (mx - 2 * l) / (maxx - minx);
            ky = (my - 2 * l) / (miny - maxy);
            zx = (mx * minx - l * (minx + maxx)) / (minx - maxx);
            zy = (my * maxy - l * (miny + maxy)) / (maxy - miny);
            if (minx * maxx <= 0)                 //{"плаваючі" осі}
            { gx = 0; }
            if (minx * maxx > 0)
            { gx = minx; }
            if ((minx * maxx > 0) && (minx < 0))
            { gx = maxx; }
            if (miny * maxy <= 0)
            { gy = 0; }
            if ((miny * maxy > 0) && (miny > 0))
            { gy = miny; }
            if ((miny * maxy > 0) && (miny < 0))
            { gy = maxy; }
            ax = kx * gx + zx;            //{координати (0,0)}
            by = ky * gy + zy;
            Font ff;
            ff = new Font("Arial", 14);

            try
            {
                g.DrawLine(penAqua, l, Convert.ToInt32(by), mx - l, Convert.ToInt32(by));
                g.DrawLine(penAqua, Convert.ToInt32(ax), l, Convert.ToInt32(ax), my - l);
                g.DrawLine(penAqua, mx - l, Convert.ToInt32(by), mx - l - 14, Convert.ToInt32(by) - 5);
                g.DrawLine(penAqua, mx - l, Convert.ToInt32(by), mx - l - 14, Convert.ToInt32(by) + 5);
                g.DrawLine(penAqua, Convert.ToInt32(ax), 1, Convert.ToInt32(ax)-5, l+14);
                g.DrawLine(penAqua, Convert.ToInt32(ax), 1, Convert.ToInt32(ax)+5, l+14);
            }
            catch
            {
                MessageBox.Show("Sorry, something wrong");
                return;
            }
            g.DrawString("OY", ff, TextBrush, mx - (l / 2) - 25, Convert.ToInt32(by) - 15);
            g.DrawString("OX", ff, TextBrush, Convert.ToInt32(ax), l - 35);
            krokx = (mx - 2 * l) / 10;
            kroky = (my - 2 * l) / 10;
            for (i = 1; i <= 10; i++)
            {
                g.DrawLine(penAqua, l, l + i * kroky, mx - 1, l + i * kroky);
                g.DrawLine(penAqua, l + i * krokx, 1, l + i * krokx, my - 1);
            }
            g.DrawRectangle(penYellow, l, l, mx - 2 * l, my - 2 * l);
            int x1, y1, x2, y2;
            for (i = 0; i <= (ne - 2); i++)
            {
                x1 = Convert.ToInt32(kx * xe[i] + zx);
                y1 = Convert.ToInt32(ky * ye[i] + zy);
                x2 = Convert.ToInt32(kx * xe[i+1] + zx);
                y2 = Convert.ToInt32(ky * ye[i+1] + zy);
                g.DrawLine(penBlue, x1, y1, x2, y2);
            }
        }
    }
}
