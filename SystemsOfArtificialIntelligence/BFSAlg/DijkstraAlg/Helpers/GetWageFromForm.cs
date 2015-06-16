using System;
using DijkstraAlg.HelperForms;

namespace DijkstraAlg.Helpers
{
    public static class GetWageFromForm
    {
        public static int GetWage(Wage ourForm)
        {
            var result = Convert.ToInt32(ourForm.SetWage.Text);
            return result;
        }
    }
}
