using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;

namespace NeurowebLibrary
{
    public class Education
    {
        private NeuroWeb neuroWeb;
        private double eta;
        private double[][] educationSets;
        private int educationSetsCount;

        public NeuroWeb NeuroWeb
        {
            get
            {
                return this.neuroWeb;
            }
            set
            {
                this.neuroWeb = value;
            }
        }

        public Education(int _neuronsCount, int _inputVectorLength, double _eta, double[][] _educationSets, int _educationSetsCount)
        {
            neuroWeb = new NeuroWeb(_inputVectorLength, _neuronsCount);
            this.eta = _eta;
            this.educationSets = _educationSets;
            this.educationSetsCount = _educationSetsCount;
        }

        public int StartEducation(int maxInterationsCount)
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
                    // Get winner index
                    int winnerIndex = neuroWeb.Run(educationSets[curSetNum]);

                    // Get distance
                    double distance = 0;
                    for (int i = 0; i < neuroWeb.InputVectorLength; i++)
                    {
                        distance += Math.Pow(neuroWeb.OmegaArray[winnerIndex][i] - educationSets[curSetNum][i], 2.0);
                    }
                    distance = Math.Sqrt(distance);

                    // Educate winner
                    for (int i = 0; i < neuroWeb.InputVectorLength; i++)
                    {
                        double delta = eta * (educationSets[curSetNum][i] - neuroWeb.OmegaArray[winnerIndex][i]) * distance;
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

        public double[] GetEntropies()
        {
            double[] entropies = new double[neuroWeb.NeuronsCount];
            for (int i = 0; i < neuroWeb.NeuronsCount; i++)
            {
                entropies[i] = 0;
                for (int j = 0; j < educationSetsCount; j++)
                {
                    int neuronIndex = neuroWeb.Run(educationSets[j]);
                    if (neuronIndex == i)
                    {
                        double r = 0;
                        for (int k = 0; k < neuroWeb.InputVectorLength; k++)
                        {
                            r += Math.Pow((educationSets[j][k] - neuroWeb.OmegaArray[i][k]), 2.0);
                        }
                        entropies[i] += Math.Sqrt(r);
                    }
                }
            }
            return entropies;
        }

        public int GetBadVectorsCount(double entropyBound)
        {
            double[] entropies = GetEntropies();
            int badVectorsCount = 0;
            for (int i = 0; i < entropies.Length; i++)
            {
                if (entropies[i] > entropyBound) badVectorsCount++;
            }
            return badVectorsCount;
        }
    }
}
