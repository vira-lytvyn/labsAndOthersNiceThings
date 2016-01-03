using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;

namespace NeurowebLibrary
{
    public class NeuroWeb
    {
        private int neuronsCount;
        private int inputVectorLength;
        private double[][] omegaArray;

        public int NeuronsCount
        {
            get
            {
                return this.neuronsCount;
            }
        }

        public int InputVectorLength
        {
            get
            {
                return this.inputVectorLength;
            }
        }

        public double[][] OmegaArray
        {
            get
            {
                return this.omegaArray;
            }
            set
            {
                omegaArray = value;
            }
        }

        public NeuroWeb(int _inputVectorLength, int _neuronsCount)
        {
            this.inputVectorLength = _inputVectorLength;
            this.neuronsCount = _neuronsCount;
            
            //Init wArray
            Random random = new Random();
            omegaArray = new double[neuronsCount][];
            for (int i = 0; i < neuronsCount; i++)
            {
                omegaArray[i] = new double[inputVectorLength];
                for (int j = 0; j < inputVectorLength; j++)
                {
                    omegaArray[i][j] = 1.0 - random.NextDouble() * 2.0;
                }
            }

            /*
            omegaArray = new double[2][];
            omegaArray[0] = new double[2];
            omegaArray[1] = new double[2];
            omegaArray[0][0] = -20000;
            omegaArray[0][1] = -20000;
            omegaArray[1][0] = 1;
            omegaArray[1][1] = 1;
            */
        }

        public double[] GetOuts(double[] inputVector)
        {
            double[] outs = new double[neuronsCount];
            
            for (int i = 0; i < neuronsCount; i++)
            {
                double curOut = 0;
                for (int j = 0; j < inputVectorLength; j++)
                {
                    curOut += Math.Pow(omegaArray[i][j] - inputVector[j], 2.0);
                }
                outs[i] = Math.Sqrt(curOut);
            }

            return outs;
        }

        public int Run(double[] inputVector)
        {
            double outMin = 0;
            int winnerIndex = 0;

            double[] outs = GetOuts(inputVector);
            for (int i = 0; i < neuronsCount; i++)
            {
                if (i == 0)
                {
                    outMin = outs[i];
                    winnerIndex = 0;
                }
                else if (outs[i] < outMin)
                {
                    outMin = outs[i];
                    winnerIndex = i;
                }
            }

            return winnerIndex;
        }
    }
}
