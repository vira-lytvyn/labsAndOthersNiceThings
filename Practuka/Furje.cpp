void Furje(Vector1 X, Vector2 Y, double Tp, Vector2 Yg)
{
    w=2*M_PI/Tp;
    for (k=0; k<25; k++)
    {
        KOM=k*w;
        G=0;
        D=0;
        for (i=0; i<500; i++)
        {
            s=KOM*X[i];
            G=G+Y[i]*cos(s);
            D=D+Y[i]*sin(s);
        }
        a[k]=2*G/500;
        b[k]=2*D/500;
    }
    a[0]=0;
    for (i=0; i<500; i++)
        a[0]=a[0]+Y[i];
    a[0]=a[0]/500;
    for (i=0; i<500; i++)
    {
        s=0;
        D=X[i]*w;
        for (k=0; k<25; k++)
        {
            KOM=k*D;
            s=s+b[k]*sin(KOM)+a[k]*cos(KOM);
        }
        Yg[i]=a[0]+s;
    }
}