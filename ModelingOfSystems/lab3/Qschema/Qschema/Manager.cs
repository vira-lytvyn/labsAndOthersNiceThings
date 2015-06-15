using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Qschema
{
    public class Manager
    {
        public static void Manage(MainApp app)
        {
            var results = Calculation.GetValues(app);
            app.Done.Text = results[0].ToString();


            var notDone = Math.Abs(results[0] - results[1]);

            app.NotDone.Text = notDone.ToString();
            if (results[0] > results[1])
            {
                app.NotDone.Text = "0";
            }
        }
    }
}
