using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using RazorCart.Core.ActionPipeline;

namespace Integration.Example
{
    class MyCalculateTax : CalculateTax
    {
        public override PipelineAction Clone() { return new MyCalculateTax(); }
        public override int ActionID() { return 3; }
        public override string ActionName() { return "Custom.MyCalculateTax()"; }
        public override bool IsDisposable() { return false; }
        public override ActionEndResult Execute(VATContext context)
        {
            var result = base.Execute(context); // this is optional depending on business logic
            if (result.Success)
            {
                #region Example to collect extra 1% tax only within the United States

                if (context.ShippingData.CountryCode == "US")
                {
                    context.CartTotals.TaxRate += 0.01M;
                    context.CartTotals.TaxTotal += context.CartTotals.SubTotal * 0.01M;
                }

                #endregion
            }

            return new ActionEndResult() { Success = true, FailureMessage = string.Empty };
        }
    }
}
