using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using RazorCart.Core.ActionPipeline;

namespace Integration.Example
{
    class MyPipeline : PipelineManager
    {
        /// <summary>
        /// Register the Pipeline Action List to be executed once an item(s) added to cart
        /// </summary>
        /// <returns>A <see cref="RazorCart.Core.ActionPipeline.PipelineAction[]"/></returns>
        protected override PipelineAction[] ListCartPipelineActions()
        {
            return new PipelineAction[]
            {
                new MyPreAddToCart(),
                new ValidateProduct(),
                new ValidateCustomer(),
                new AddToCart(),
                new MyOnAddToCartComplete()
            };
        }

        /// <summary>
        /// Register the Pipeline Action List to be executed on cart totals calculation
        /// </summary>
        /// <returns>A <see cref="RazorCart.Core.ActionPipeline.PipelineAction[]"/></returns>
        protected override PipelineAction[] ListCalculatorPipelineActions()
        {
            return new PipelineAction[]
            {
                new CalculateSubTotal(),
                new CalculateOrderDiscount(),
                new CalculateCouponDiscount(),
                new CalculateShipping(),
                new CalculateHandling(),
                new MyCalculateTax(),
                new CalculateFinal()
            };
        }

        /// <summary>
        /// Register the Pipeline Action List to be executed on cart checkout
        /// </summary>
        /// <returns>A <see cref="RazorCart.Core.ActionPipeline.PipelineAction[]"/></returns>
        protected override PipelineAction[] ListCheckoutPipelineActions()
        {
            return new PipelineAction[]
            {
                new ValidateOrder(),
                new SaveCustomerRecord(),
                new SaveOrderRecord(),
                new SavePaymentRecord(),
                new ProcessPaymentGateway(),
                new UpdatePaymentRecord(),
                new UpdateInventory(),
                new SaveUserInfo(),
                new SendEmail(),
                new MyOnCheckoutComplete()
            };
        }
    }
}
