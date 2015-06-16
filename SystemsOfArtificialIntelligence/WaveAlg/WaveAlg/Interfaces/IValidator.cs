using System.Drawing;

namespace WaveAlg.Interfaces
{
    public interface IValidator
    {
        bool IsValidForFindBestWay(MainApp app);

        bool IsValidForDrawing(MainApp app);

        bool IsNearOnlyZeroes(MainApp app, Point current);

        bool ExistDublicatesControlWords(MainApp app);
    }
}
