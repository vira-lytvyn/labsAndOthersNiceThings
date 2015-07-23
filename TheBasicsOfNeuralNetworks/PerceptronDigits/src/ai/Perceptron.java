package ai;

/**
 * Однослойный n-нейронный перцептрон
 */
public class Perceptron {

    Neuron[] neurons; // слой нейронов
    int n, m;

    /**
     * Конструктор
     * @param n - число нейронов
     * @param m - число входов каждого нейрона скрытого слоя
     */
    public Perceptron(int n, int m)
    {
        this.n = n;
        this.m = m;
        neurons = new Neuron[n];
        for (int j = 0; j < n; j++) {
            neurons[j] = new Neuron(m);
        }        
    }

    /**
     * Распознавание образа
     * @param x - входной вектор
     * @return - выходной образ
     */
    public int[] recognize(int[] x)
    {
        int[] y = new int[neurons.length];
        
        for (int j = 0; j < neurons.length; j++) {
            y[j] = neurons[j].transfer(x);
        }
        
        return y;
    }

    /**
     * Инициализация начальных весов
     * малым случайным значением
     */
    public void initWeights() {        
        for (int j = 0; j < neurons.length; j++) {
            neurons[j].initWeights(10);
        }
    }

    /**
     * Обучение перцептрона
     * @param x - входной вектор
     * @param y - правильный выходной вектор
     */
    public void teach(int[] x, int[] y)
    {
        int d;
        int v = 1; // скорость обучения

        int[] t = recognize(x);
        while (!equal(t, y)) {

            // подстройка весов каждого нейрона
            for (int j = 0; j < neurons.length; j++) {
                d = y[j] - t[j];
                neurons[j].changeWeights(v, d, x);
            }
            t = recognize(x);
        }
    }

    /**
     * Сравнивание двух векторов
     * @param a - первый вектор
     * @param b - второй вектор
     * @return boolean
     */
    private boolean equal(int[] a, int[] b) {
        if (a.length != b.length) return false;
        for (int i = 0; i < a.length; i++) {
            if (a[i] != b[i]) return false;
        }
        return true;
    }

    public int getN() {
        return n;
    }

    public int getM() {
        return m;
    }

}
