using System.Drawing;

namespace WaveAlg.Administrating
{
    /// <summary>
    /// Get Data value from option form
    /// </summary>
    public struct OptionStruct
    {
        public bool BestWayEnabled;
        public bool AllWaysEnabled;
        public int ZeroesPercentage;
        public Color BestWayColor;
    }

    /// <summary>
    /// struct wich represents BestWaypoint
    /// </summary>
    public struct BestWayPointStruct
    {
        public Point Point;
        public int Value;
    }
}
