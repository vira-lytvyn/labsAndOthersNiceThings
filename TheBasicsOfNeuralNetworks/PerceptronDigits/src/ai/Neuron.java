package ai;

import java.util.Random;

/**
 * Нейрон с пороговой функцией
 */
public class Neuron
{
    private int[] w;        // веса синапсов    
    private int s = 50;     // порог

    /**
     * Конструктор
     * @param m - число входов
     */
    Neuron(int m)
    {
        w = new int[m];
    }

    /**
     * Передаточная функция
     * @param x - входной вектор
     * @return - выходное значение нейрона
     */
    public int transfer(int[] x)
    {
        return activator(adder(x));
    }

    /**
     * Инициализация начальных весов синапсов
     * небольшими случайными значениями
     * @param n - от 0 до n
     */
    public void initWeights(int n)
    {
        Random rand = new Random();
        for (int i = 0; i < w.length; i++) {
            w[i] = rand.nextInt(n);
        }
    }

    /**
     * Модификация весов синапсов для обучения
     * @param v - скорость обучения
     * @param d - разница между выходом нейрона и нужным выходом
     * @param x - входной вектор
     */
    public void changeWeights(int v, int d, int[] x)
    {
        for (int i = 0; i < w.length; i++) {
            w[i] += v*d*x[i];
        }
    }

    /**
     * Сумматор
     * @param x - входной вектор
     * @return - невзвешенная сумма nec (биас не используется)
     */
    private int adder(int[] x)
    {
        int nec = 0;
        for (int i = 0; i < x.length; i++) {
            nec += x[i] * w[i];
        }
        return nec;
    }

    /**
     * Нелинейный преобразователь или функция активации,
     * в данном случае - жесткая пороговая функция,
     * имеющая область значений {0;1}
     * @param nec - выход сумматора
     * @return
     */
    private int activator(int nec)
    {
        if (nec >= s) return 1;
        else return 0;
    }
}
