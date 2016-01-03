using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;

namespace NeurowebLibrary
{
    public class EducateClusterisator
    {
        private NeuroWebClusterisator neuroWeb;
        private double eta;
        private double[][] educationSets;
        private int educationSetsCount;

        public NeuroWebClusterisator GetNeuroWeb
        {
            get
            {
                return this.neuroWeb;
            }
        }

        public EducateClusterisator(int _neuronsCount, int _inputVectorLength, double _eta, double[][] _educationSets, int _educationSetsCount)
        {
            neuroWeb = new NeuroWebClusterisator(_inputVectorLength, _neuronsCount);
            this.eta = _eta;
            this.educationSets = _educationSets;
            this.educationSetsCount = _educationSetsCount;
        }

        public int StartEducation(double eps, int maxInterationsCount)
        {
            int iterationsCount = 0;
            while (true)
            {
                double[][] omegaOld = new double[neuroWeb.NeuronsCount][];
                double[][] omegaNew = new double[neuroWeb.NeuronsCount][];
                double[][] omegaDelta = new double[neuroWeb.NeuronsCount][];
                for (int i = 0; i < neuroWeb.NeuronsCount; i++)
                {
                    omegaOld[i] = new double[neuroWeb.InputVectorLength];
                    omegaNew[i] = new double[neuroWeb.InputVectorLength];
                    omegaDelta[i] = new double[neuroWeb.InputVectorLength];
                }

                for (int i = 0; i < neuroWeb.NeuronsCount; i++)
                    for (int j = 0; j < neuroWeb.InputVectorLength; j++)
                    {
                        omegaOld[i][j] = neuroWeb.OmegaArray[i][j];
                    }

                for (int curSetNum = 0; curSetNum < educationSetsCount; curSetNum++)
                {
                    double[] outs = neuroWeb.GetOuts(educationSets[curSetNum]);

                    // Get winner index
                    int winnerIndex = 0;
                    double maxOut = outs[0];
                    for (int i = 1; i < neuroWeb.NeuronsCount; i++)
                    {
                        if (outs[i] > maxOut)
                        {
                            maxOut = outs[i];
                            winnerIndex = i;
                        }
                    }

                    // Educate winner
                    for (int i = 0; i < neuroWeb.InputVectorLength; i++)
                    {
                        double delta = eta * (educationSets[curSetNum][i] - neuroWeb.OmegaArray[winnerIndex][i]);
                        neuroWeb.OmegaArray[winnerIndex][i] += delta;
                    }
                }
                iterationsCount++;

                for (int i = 0; i < neuroWeb.NeuronsCount; i++)
                    for (int j = 0; j < neuroWeb.InputVectorLength; j++)
                    {
                        omegaNew[i][j] = neuroWeb.OmegaArray[i][j];
                    }

                bool isEducated = true;
                for (int i = 0; i < neuroWeb.NeuronsCount; i++)
                    for (int j = 0; j < neuroWeb.InputVectorLength; j++)
                    {
                        if (omegaNew[i][j] != omegaOld[i][j]) isEducated = false;
                    }

                if (isEducated) break;

                if (iterationsCount >= maxInterationsCount)
                {
                    break;
                }
            }

            return iterationsCount;
        }
    }
}
