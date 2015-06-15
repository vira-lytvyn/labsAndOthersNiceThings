using System;
using System.Collections.Generic;

namespace Qschema
{
    public class Calculation
    {
        public static List<double> GetValues(MainApp app) {
            var interval = Convert.ToDouble(app.Interval.Text);
            var allTime = Convert.ToInt32(app.AllTime.Text);
            double totalProcced = 0;
            double totalFailed = 0;
            var channelNumbers = 0;
            if (app.ChanelOne.Checked) {
                channelNumbers++;
            }
            if (app.ChanelTwo.Checked) {
                channelNumbers++;
            }
            if (channelNumbers == 0) {
                throw new Exception();
            }
            var maxForOneInterval = Convert.ToInt32(app.MaxForOneInterval.Text);
            var canProcced = Convert.ToInt32(app.CanProcced.Text);
            for(int i = 0; i <allTime;i++ ) {
                var currentNumberOfClients = GetCurrentNumberOfClients(maxForOneInterval);
                var currentNumberOfInterval = (double) currentNumberOfClients/interval;
                var canChanelProcced = canProcced * interval * channelNumbers;
                totalProcced += canChanelProcced;
                totalFailed += currentNumberOfInterval;
            }
            var result = new List<double> {totalProcced, totalFailed};
            return result;
        }

        private static int GetCurrentNumberOfClients(int maxForOneInterval) {
            var randomizer = new Random();
            var result = randomizer.Next(0, maxForOneInterval);
            return result;
        }
    }
}
