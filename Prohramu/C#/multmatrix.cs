using System;
class MultMatrix
{
	public static void Main()
	{		 
		 Console.WriteLine("Vvedit rozmiry matrytsi:");
		 Console.WriteLine("N=");
		 int n=Convert.ToInt32(Console.ReadLine());
		 Console.WriteLine("M=");
		 int m=Convert.ToInt32(Console.ReadLine());
		 Console.WriteLine("K=");
		 int k=Convert.ToInt32(Console.ReadLine());
		 
		 double[,] A = new double[n,m]; 
		double[,] B = new double[m,k];
		double[,] C = new double[n,k];	
		int i,j,l;
		
		Console.WriteLine("Vvedit matrytsju A[{0},{1}]",n,m);
		for(i=0;i<n;i++)
		{
			for(j=0;j<m;j++)
			{
				Console.Write("a[{0},{1}]=",i+1,j+1);
				A[i,j]=Convert.ToInt32(Console.ReadLine());
			}
			Console.WriteLine();
		}
		
		Console.WriteLine("Vvedit matrytsju B[{0},{1}]",m,k);
		for(j=0;j<m;j++)
		{
			for(l=0;l<k;l++)
			{
				Console.Write("b[{0},{1}]=",j+1,l+1);
				B[j,l]=Convert.ToInt32(Console.ReadLine());
			}
			Console.WriteLine();
		}

		//prosto tak, bo perevirky tut ne treba	
		if(A.GetLength(1)!=B.GetLength(0))
		{
			Console.WriteLine("Pomylka rozmirnosti");
			return;
		}
		else
		{
			for( i=0;i<n;i++)
				for( j=0;j<k;j++)
				{
					double s=0;
					for( l=0;l<m;l++)
						s+=A[i,l]*B[l,j];
					C[i,j]=s;
				}	
		}
		
		//rezultat
		
		Console.WriteLine("Rezultat mnojennja matryts C[{0},{1}]=A[{2},{3}]*B[{4},{5}]",n,k,n,m,m,k);
		for(i=0;i<n;i++)
		{
			for(l=0;l<k;l++)
			{
				Console.Write("c[{0},{1}]={2}\t",i+1,l+1,C[i,l]);
			}
			Console.WriteLine();
		}
		
	}
}