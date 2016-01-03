using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;

namespace NeurowebLibrary
{
    public class NeuroWebClusterisator
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

        public NeuroWebClusterisator(int _inputVectorLength, int _neuronsCount)
        {
            this.inputVectorLength = _inputVectorLength;
            this.neuronsCount = _neuronsCount;

            //Init wArray
            /*
            omegaArray = new double[2][];
            omegaArray[0] = new double[2];
            omegaArray[1] = new double[2];
            omegaArray[0][0] = 1.0 / 2.0;
            omegaArray[0][1] = 1.0 / 2.0;
            omegaArray[1][0] = 1.0 / 2.0;
            omegaArray[1][1] = 1.0 / 8.0;
            */

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
        }

        public double[] GetOuts(double[] inputVector)
        {
            double[] outs = new double[neuronsCount];
            
            for (int i = 0; i < neuronsCount; i++)
            {
                double curOut = 0;
                for (int j = 0; j < inputVectorLength; j++)
                {
                    double delta = omegaArray[i][j] * inputVector[j];
                    curOut += delta;
                }
                outs[i] = curOut;
            }

            return outs;
        }

        public int Run(double[] inputVector)
        {
            double outMax = 0;
            int winnerIndex = 0;
            for (int i = 0; i < neuronsCount; i++)
            {
                double curOut = 0;
                for (int j = 0; j < inputVectorLength; j++)
                {
                    curOut += omegaArray[i][j] * inputVector[j];
                }

                if ((i == 0) || (curOut > outMax))
                {
                    outMax = curOut;
                    winnerIndex = i;
                }
            }

            return winnerIndex;
        }
    }
}
