void TriS(int age, float x1,float y1,float x2,float y2,float x3,float y3)
{
        age++;
	int FinalAge;
	float xd, yd, ye, xe, xf, yf;
	if (age == FinalAge)
                {
                        Image1->Canvas->MoveTo(x1, y1);
                        Image1->Canvas->LineTo(x2, y2);
                        Image1->Canvas->LineTo(x3, y3);
                        Image1->Canvas->LineTo(x1, y1);
                }
	else
                {
                         xd = floor((x1+x2)/2);
                         yd = ceil((y1+y2)/2);

                         xe = ceil((x2+x3)/2);
                         ye = ceil((y2+y3)/2);

                         xf = ceil((x1+x3)/2);
                         yf = ceil((y1+y3)/2);
			TriS(age,x1,y1,xd,yd,xf,yf);
			TriS(age,xd,yd,x2,y2,xe,ye);
			TriS(age,xf,yf,xe,ye,x3,y3);
		}
}