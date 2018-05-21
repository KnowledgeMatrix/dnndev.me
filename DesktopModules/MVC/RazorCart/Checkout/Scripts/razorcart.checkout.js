(function () {
    // Invoking JavaScript Strict Mode
    'use strict';
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // Definition of the RazorCart Application                                                                                                                                                          //
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    angular
        // Modules
        .module('RazorCart')
        // Controllers
        .controller('checkoutCtrl', checkoutCtrl)
    ;
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // Checkout Module Controller                                                                                                                                                                       //
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    function checkoutCtrl($scope, $filter, $window, $location, $rootScope, $timeout, $q, sharedProvider, dataProvider, globalFunctions, toastr) {
        var vm = this;
        $rootScope.$on('$locationChangeSuccess', function (event, newLocation, oldLocation) {
            var defaultParams = [{ key: 'Display', value: 'cart' }];
            if (newLocation.toLowerCase() !== oldLocation.toLowerCase()) {
                vm.displayMode = globalFunctions.getUrlParameter('Display', $location.absUrl());
                switch (vm.displayMode) {
                    case 'cart':
                    default:
                        if (!vm.orderStatus || !vm.orderStatus.Success)
                            vm.viewState = 'ShoppingCart';
                        else
                            globalFunctions.updateUrlLocation(true, [{ key: 'Display', value: 'status' }]);
                        break;
                    case 'review':
                        if ($scope['rzcForm_' + vm.moduleId].$valid && (!vm.orderStatus || !vm.orderStatus.Success))
                            vm.viewState = 'ReviewOrder';
                        else
                            globalFunctions.updateUrlLocation(true, defaultParams);
                        break;
                    case 'status':
                        if (vm.orderStatus)
                            vm.viewState = 'OrderStatus';
                        else
                            globalFunctions.updateUrlLocation(true, defaultParams);
                        break;
                }
            }
            else {
                if (!(vm.viewState == 'OrderStatus' && vm.orderStatus))
                    globalFunctions.updateUrlLocation(true, defaultParams);
            }
        });
        $scope.$watch(function () {
            return sharedProvider.getCart();
        }, function (newValue) {
            vm.cartList = newValue.cartList;
            vm.cartTotals = newValue.cartTotals;
        }, true);
        $scope.$watch(function () {
            return sharedProvider.getWishlist();
        }, function (newValue) {
            vm.wishlist = newValue;
        }, true);
        vm.init = function (model) {
            vm.moduleId = model.ModuleID;
            vm.storeName = model.StoreName;
            vm.viewState = model.ViewState;
            vm.billingPayments = model.BillingPayments;
            vm.walletItems = model.WalletItems;
            vm.expMonths = model.ExpMonths;
            vm.expYears = model.ExpYears;
            vm.countries = model.Countries;
            vm.shippingRegions = model.ShippingRegions;
            vm.billingRegions = model.BillingRegions;
            vm.shipping = model.Shipping;
            vm.billing = model.Billing;
            vm.orderStatus = model.PaymentStatus;
            vm.requireRecalculate = model.IsCalculateRequired;
            vm.shippingMethods = model.ShippingMethods;
            vm.phoneCarriers = model.PhoneCarriers;
            sharedProvider.updateCart(model.CartList, model.CartTotals);
            sharedProvider.updateWishlist(model.Wishlist);
            angular.element(document.getElementById('rzcContainer_' + vm.moduleId)).attr('ng-init', '');
        };
        vm.get = function () {
            var deferred = $q.defer();
            var request = dataProvider.getShoppingCart(vm.moduleId, vm.shipping);
            request.then(function (response) {
                $timeout(function () {
                    sharedProvider.updateCart(response.data.CartList, response.data.CartTotals);
                    vm.shippingMethods = response.data.ShippingMethods;
                    if (!vm.shippingMethods.length) {
                        vm.shipping.Method = null;
                    }
                    else {
                        if (!$filter('filter')(vm.shippingMethods, { Code: vm.shipping.Method }, true).length)
                            vm.shipping.Method = vm.shippingMethods[0].Code;
                    }
                    if (vm.billing.Payment) {
                        vm.billPaymentChange();
                    }
                });
                deferred.resolve();
            });
            return deferred.promise;
        };
        vm.update = function () {
            vm.updating = true;
            var updateList = [];
            angular.forEach(vm.cartList, function (cartItem, i) {
                updateList.push({ CartID: cartItem.CartID, ProductID: cartItem.ProductID, Quantity: cartItem.ClientQuantity });
            });
            var request = dataProvider.updateShoppingCart(vm.moduleId, updateList);
            request.then(function (response) {
                if (globalFunctions.getResponseType(response.status) == 'Successful') {
                    if (vm.shipping.Calculated) {
                        vm.calculate();
                    }
                    vm.get().then(function () {
                        vm.updating = false;
                        toastr.success('The cart was updated successfully.', vm.storeName);
                    });
                }
                else if (globalFunctions.getResponseType(response.status) == 'ClientError') {
                    vm.updating = false;
                    toastr.warning(response.data.Message, vm.storeName);
                }
                else {
                    vm.updating = false;
                    console.log('Unable to update | ERR: ' + response.status);
                    toastr.error('Unable to update | ERR: ' + response.status, vm.storeName);
                }
            });
        };
        vm.delete = function (index) {
            vm.deleting = true;
            var request = dataProvider.deleteShoppingCart(vm.moduleId, vm.cartList[index].CartID);
            request.then(function (response) {
                if (globalFunctions.getResponseType(response.status) == 'Successful') {
                    if (vm.shipping.Calculated) {
                        vm.calculate();
                    }
                    vm.get().then(function () {
                        vm.deleting = false;
                        toastr.success('Successfully deleted ' + vm.cartList[index].ProductName + ' from the cart.', vm.storeName);
                    });
                }
                else if (globalFunctions.getResponseType(response.status) == 'ClientError') {
                    vm.deleting = false;
                    toastr.warning(response.data.Message, vm.storeName);
                }
                else {
                    vm.deleting = false;
                    console.log('Unable to delete | ERR: ' + response.status);
                    toastr.error('Unable to delete | ERR: ' + response.status, vm.storeName);
                }
            });
        };
        vm.clear = function () {
            vm.deleting = true;
            var request = dataProvider.clearShoppingCart(vm.moduleId);
            request.then(function (response) {
                if (globalFunctions.getResponseType(response.status) == 'Successful') {
                    sharedProvider.updateCart(response.data.CartList, response.data.CartTotals);
                    if (vm.shippingMethods.length > 0) {
                        vm.shippingMethods = [];
                        vm.shipping.Method = null;
                    }
                    toastr.success('The cart was cleared successfully.', vm.storeName);
                }
                else if (globalFunctions.getResponseType(response.status) == 'ClientError') {
                    toastr.warning(response.data.Message, vm.storeName);
                }
                else {
                    console.log('Unable to delete | ERR: ' + response.status);
                    toastr.error('Unable to delete | ERR: ' + response.status, vm.storeName);
                }
                vm.deleting = false;
            });
        };
        vm.coupon = function () {
            vm.applying = true;
            var request = dataProvider.applyCouponCode(vm.moduleId, vm.cartTotals.Coupon);
            request.then(function (response) {
                if (globalFunctions.getResponseType(response.status) == 'Successful') {
                    vm.get().then(function () {
                        vm.applying = false;
                        toastr.success('Coupon: ' + response.data.Coupon + ' was applied.', vm.storeName);
                    });
                }
                else if (globalFunctions.getResponseType(response.status) == 'ClientError') {
                    vm.applying = false;
                    toastr.warning(response.data.Message, vm.storeName);
                }
                else {
                    console.log('Unable to apply coupon | ERR: ' + response.status);
                    toastr.error(response.data.Message, vm.storeName);
                    vm.applying = false;
                }
            });
        };
        vm.calculate = function () {
            vm.calculating = true;
            var request = dataProvider.calculateShipping(vm.moduleId, vm.shipping);
            request.then(function (response) {
                if (globalFunctions.getResponseType(response.status) == 'Successful') {
                    vm.shippingMethods = response.data.ShippingMethods;
                    if (!$filter('filter')(vm.shippingMethods, { Code: vm.shipping.Method }, true).length) {
                        vm.shipping.Method = null;
                    }
                    else {
                        vm.shipMethodChange();
                    }
                }
                else if (globalFunctions.getResponseType(response.status) == 'ClientError') {
                    toastr.warning(response.data.Message, vm.storeName);
                }
                else {
                    console.log('Unable to calculate | ERR: ' + response.status);
                    toastr.error('Unable to calculate shipping rate(s) | ERR: ' + response.status, vm.storeName);
                }
                vm.calculating = false;
                vm.shipping.Calculated = true;
            });
        };
        vm.save = function () {
            vm.saving = true;
            var request = dataProvider.saveWishlist(vm.moduleId);
            request.then(function (response) {
                if (globalFunctions.getResponseType(response.status) == 'Successful') {
                    toastr.success('Your shopping cart was successfully saved into your wishlist.', vm.storeName);
                }
                else if (globalFunctions.getResponseType(response.status) == 'ClientError') {
                    vm.saving = true;
                    toastr.warning(response.data.Message, vm.storeName);
                }
                else {
                    console.log('Unable to save | ERR: ' + response.status);
                    toastr.error('Unable to save shopping cart | ERR: ' + response.status, vm.storeName);
                }
                vm.saving = false;
            });
        };
        vm.restore = function ($event) {
            $event.preventDefault();
            vm.restoring = true;
            var checkedItems = $filter('filter')(vm.wishlist, { Checked: true }, true);
            var request = dataProvider.restoreWishlist(vm.moduleId, checkedItems.map(function (cartItem) { return cartItem.CartID; }));
            request.then(function (response) {
                if (globalFunctions.getResponseType(response.status) == 'Successful') {
                    toastr.success('Your wishlist was successfully restored into your cart.', vm.storeName);
                }
                else if (globalFunctions.getResponseType(response.status) == 'ClientError') {
                    toastr.warning(response.data.Message, vm.storeName);
                }
                else {
                    console.log('Unable to restore saved cart | ERR: ' + response.status);
                    toastr.error('Unable to restore saved cart | ERR: ' + response.status, vm.storeName);
                }
                vm.restoring = false;
            });
        };
        vm.unsave = function ($event) {
            $event.preventDefault();
            vm.unsaving = true;
            var checkedItems = $filter('filter')(vm.wishlist, { Checked: true }, true);
            var request = dataProvider.deleteWishlist(vm.moduleId, checkedItems.map(function (cartItem) { return cartItem.CartID; }));
            request.then(function (response) {
                if (globalFunctions.getResponseType(response.status) == 'Successful') {
                    var request = dataProvider.getWishlist(vm.moduleId);
                    request.then(function (response) {
                        if (globalFunctions.getResponseType(response.status) == 'Successful')
                            sharedProvider.updateWishlist(response.data.SavedCart);
                    });
                    toastr.success('Your wishlist saved cart was successfully deleted.', vm.storeName);
                }
                else if (globalFunctions.getResponseType(response.status) == 'ClientError') {
                    toastr.warning(response.data.Message, vm.storeName);
                }
                else {
                    console.log('Unable to delete saved cart | ERR: ' + response.status);
                    toastr.error('Unable to delete saved cart | ERR: ' + response.status, vm.storeName);
                }
                vm.unsaving = false;
            });
        };
        vm.showSaved = function (index) {
            angular.forEach(vm.wishlist, function (savedCart, i) {
                if (index == i)
                    savedCart.Visible = !savedCart.Visible;
                else
                    savedCart.Visible = false;
            });
        };
        vm.editSavedCart = function (index) {
            angular.forEach(vm.wishlist, function (savedCart, i) {
                if (index == i)
                    savedCart.EditMode = !savedCart.EditMode;
                else
                    savedCart.EditMode = false;
            });
        };
        vm.editSavedCartDescription = function (index) {
            var savedCart = vm.wishlist[index];
            if (savedCart) {
                var request = dataProvider.editWishlist(vm.moduleId, savedCart);
                request.then(function (response) {
                    if (globalFunctions.getResponseType(response.status) == 'Successful') {
                        toastr.success('Your wishlist saved cart was successfully updated.', vm.storeName);
                    }
                    else {
                        console.log('Unable to update saved cart | ERR: ' + response.status);
                        toastr.error('Unable to update saved cart | ERR: ' + response.status, vm.storeName);
                    }
                });
                savedCart.EditMode = false;
            }
        };
        vm.review = function () {
            var shipment = $filter('filter')(vm.shippingMethods, { Code: vm.shipping.Method }, true);
            if (shipment.length)
                vm.shipping.MethodType = shipment[0].Text;
            var payment = $filter('filter')(vm.billingPayments, { PayMethodID: parseInt(vm.billing.Payment) }, true);
            if (payment.length)
            {
                if (vm.billing.Wallet) {
                    var wallet = $filter('filter')(vm.walletItems, { ID: parseInt(vm.billing.Wallet) }, true);
                    if (wallet.length) {
                        vm.billing.PaymentMethod = wallet[0].WalletName;
                        vm.billing.MaskAcctNo = wallet[0].MaskAcctNo;
                    }
                }
                else {
                    vm.billing.PaymentMethod = payment[0].Name;
                    if (vm.selectedPayment && payment[0].GatewayProcessMode == 'Direct') {
                        if (vm.selectedPayment.DisplayType == 'CreditCard')
                            vm.billing.MaskAcctNo = vm.billing.CardNumber.replace(/[^0-9]+/g, '').replace(/\d(?=\d{4})/g, "*");
                        else if (vm.selectedPayment.DisplayType == 'ECheck')
                            vm.billing.MaskAcctNo = vm.billing.AccountNumber.replace(/[^0-9]+/g, '').replace(/\d(?=\d{4})/g, "*");
                    }
                    else
                        vm.billing.MaskAcctNo = null;
                }
                vm.checkoutButton = payment[0].CheckoutButton;
                if (vm.checkoutButton) {
                    $timeout(function () {
                        eval(vm.checkoutButton.RenderScript);
                    });
                }
            }
            var params = [{ key: 'Display', value: 'review' }];
            globalFunctions.updateUrlLocation(true, params);
        };
        vm.saveWallet = function () {
            vm.submitting = true;
            var request = dataProvider.saveWallet(vm.moduleId, vm.billing);
            request.then(function (response) {
                if (globalFunctions.getResponseType(response.status) == 'Successful') {
                    vm.walletItems = response.data.WalletItems;
                    toastr.success('Your wallet item was successfully created.', vm.storeName);
                    vm.walletForm = false;
                }
                else {
                    console.log('Unable to submit wallet item | ERR: ' + response.status);
                    toastr.error('Unable to submit wallet item | ERR: ' + response.data.Message, vm.storeName);
                }
                vm.submitted = false;
                vm.submitting = false;
            });
        };
        vm.editWallet = function (index) {
            var item = vm.walletItems[index];
            var payments = $filter('filter')(vm.billingPayments, { Type: item.PayType }, true);
            if (payments) {
                vm.billing = {};
                vm.billing.Wallet = item.ID;
                vm.billing.Payment = payments[0].PayMethodID.toString();
                vm.billPaymentChange();
                switch (payments[0].Type) {
                    case 'CreditCard':
                        vm.billing.CardNumber = item.MaskAcctNo;
                        vm.billing.ExpMonth = item.ExpRoute ? item.ExpRoute.substring(0, 2) : null;
                        vm.billing.ExpYear = item.ExpRoute ? '20' + item.ExpRoute.substring(2, 4) : null;
                        break;
                    case 'ACHChecking':
                    case 'ACHSavings':
                        vm.billing.AccountNumber = item.MaskAcctNo;
                        vm.billing.RoutingNumber = item.ExpRoute;
                        break;
                }
                vm.billing.WalletName = item.WalletName;
                vm.billing.FullName = item.BillingName;
                vm.billing.Address1 = item.Address1;
                vm.billing.Address2 = item.Address2;
                vm.billing.City = item.City;
                vm.billing.PostalCode = item.Zip;
                vm.billing.CountryID = item.CountryID;
                vm.billCountryChange().then(function () {
                    vm.billing.RegionID = item.RegionID;
                });
                vm.walletForm = true;
            }
        };
        vm.deleteWallet = function (index) {
            if (confirm('Are you sure?')) {
                var request = dataProvider.deleteWallet(vm.moduleId, vm.walletItems[index].ID);
                request.then(function (response) {
                    if (globalFunctions.getResponseType(response.status) == 'Successful') {
                        vm.walletItems = response.data.WalletItems;
                        toastr.success('Your wallet item was successfully deleted.', vm.storeName);
                    }
                    else {
                        console.log('Unable to delete | ERR: ' + response.status);
                        toastr.error('Unable to delete | ERR: ' + response.status, vm.storeName);
                    }
                });
            }
        };
        vm.back = function () {
            var params = [{ key: 'Display', value: 'cart' }];
            globalFunctions.updateUrlLocation(true, params);
        };
        vm.submit = function () {
            vm.submitting = true;
            var payment = $filter('filter')(vm.billingPayments, { PayMethodID: parseInt(vm.billing.Payment) }, true);
            if (payment.length) {
                if (payment[0].OnSubmitClientScript) {
                    var promise = eval(payment[0].OnSubmitClientScript);
                    promise.then(function (result) {
                        if (vm.inputs)
                            vm.inputs['OnSubmitClientScript'] = result;
                        else
                            vm.inputs = { 'OnSubmitClientScript': result };
                        vm.placeOrder();
                    }).catch(function (error) {
                        console.log(error);
                        $timeout(function () {
                            vm.submitting = false;
                        });
                    });
                }
                else
                    vm.placeOrder();
            }
            else
                vm.placeOrder();
        };
        vm.placeOrder = function () {
            var request = dataProvider.submitOrder(vm.moduleId, vm.shipping, vm.billing, vm.inputs);
            request.then(function (response) {
                var params = [{ key: 'Display', value: 'status' }];
                if (globalFunctions.getResponseType(response.status) == 'Successful') {
                    if (!response.data.Redirect) {
                        vm.orderStatus = response.data.PaymentStatus;
                        globalFunctions.updateUrlLocation(true, params);
                    }
                    else {
                        $window.location.href = response.data.PaymentUri;
                    }
                }
                else {
                    console.log('Unable to submit order | ERR: ' + response.status);
                    vm.orderStatus = { Notes: response.data.Message };
                    globalFunctions.updateUrlLocation(true, params);
                }
                vm.submitting = false;
            });
        };
        vm.download = function (index) {
            var request = dataProvider.download(vm.moduleId, vm.orderStatus.OrderID, vm.cartList[index].ProductID);
            request.then(function (response) {
                if (globalFunctions.getResponseType(response.status) == 'Successful') {
                    $window.location.assign(response.data.DownloadUrl);
                }
                else {
                    console.log('Unable to download file | ERR: ' + response.status);
                    toastr.error('Unauthorized request to download ' + vm.cartList[index].ProductName, vm.storeName);
                }
            });
        };
        vm.cartHasBooking = function () {
            var hasBooking = false;
            angular.forEach(vm.cartList, function (cartItem, i) {
                if (cartItem.CartBooking.IsBooking)
                    hasBooking = true;
            });
            return hasBooking;
        };
        vm.shipCountryChange = function () {
            var deferred = $q.defer();
            var country = $filter('filter')(vm.countries, { EntryID: vm.shipping.CountryID }, true);
            if (country.length) {
                var request = dataProvider.getRegions(vm.moduleId, country[0].Value);
                request.then(function (response) {
                    vm.shipping.RegionID = null;
                    vm.shippingRegions = response.data;
                    deferred.resolve();
                });
            }
            if (vm.requireRecalculate)
                vm.get();
            return deferred.promise;
        };
        vm.billCountryChange = function () {
            var deferred = $q.defer();
            var country = $filter('filter')(vm.countries, { EntryID: vm.billing.CountryID }, true);
            if (country.length) {
                var request = dataProvider.getRegions(vm.moduleId, country[0].Value);
                request.then(function (response) {
                    vm.billing.RegionID = null;
                    vm.billingRegions = response.data;
                    deferred.resolve();
                });
            }
            return deferred.promise;
        };
        vm.shipMethodChange = function () {
            var shipment = $filter('filter')(vm.shippingMethods, { Code: vm.shipping.Method }, true);
            if (shipment.length) {
                vm.cartTotals.ShippingTotal = shipment[0].Price;
                vm.grandTotal();
            }
        };
        vm.validateShippingInfo = function () {
            if (vm.shipping) {
                if (vm.shipping.Address1 && vm.shipping.City && vm.shipping.PostalCode && vm.shipping.CountryID && vm.shipping.RegionID)
                    return true;
                else
                    return false;
            }
        };
        vm.defaultPayment = function () {
            if (!vm.billing.Payment && vm.billingPayments.length) {
                vm.billing.Payment = vm.billingPayments[0].PayMethodID.toString();
                vm.billPaymentChange();
            }
        };
        vm.billPaymentChange = function () {
            var payment = $filter('filter')(vm.billingPayments, { PayMethodID: parseInt(vm.billing.Payment) }, true);
            if (payment.length) {
                vm.selectedPayment = { ProcessMode: payment[0].GatewayProcessMode, PayType: payment[0].Type };
                switch (payment[0].Type) {
                    case 'CreditCard':
                        vm.selectedPayment.DisplayType = 'CreditCard';
                        break;
                    case 'ACHChecking':
                    case 'ACHSavings':
                        vm.selectedPayment.DisplayType = 'ECheck';
                        break;
                    case 'PO':
                        vm.selectedPayment.DisplayType = 'PurchaseOrder';
                        break;
                    default:
                        vm.selectedPayment.DisplayType = 'None';
                        break;
                }
                var surchargeAmount = payment[0].SurchargeAmount,
                    surchargePercentage = vm.cartTotals.SubTotal * payment[0].SurchargePercentage / 100;
                vm.cartTotals.Surcharge = surchargeAmount + surchargePercentage;
                vm.grandTotal();
            }
        };
        vm.shipAddressChange = function ($event) {
            vm.updating = true;
            if (vm.shippingMethods.length > 0) {
                vm.shipping.Calculated = null;
            }
            vm.get().then(function () {
                vm.updating = false;
            });
        };
        vm.grandTotal = function () {
            vm.cartTotals.GrandTotal = vm.cartTotals.SubTotal + vm.cartTotals.Discount + vm.cartTotals.MemberDiscount +
                vm.cartTotals.ShippingTotal + vm.cartTotals.HandlingCharge + vm.cartTotals.TaxTotal + vm.cartTotals.Surcharge;
            sharedProvider.updateCart(vm.cartList, vm.cartTotals);
        };
        vm.shipEmailChange = function () {
            $timeout(function () {
                var request = dataProvider.updateCartEmail(vm.moduleId, vm.shipping.Email);
                request.then(function (response) {
                    if (response.statusText != 'OK') {
                        console.log('Unable to update email address | ERR: ' + response.status);
                    }
                });
            }, 250);
        };
        vm.copyInfo = function () {
            vm.billing.FullName = (vm.shipping.FirstName != null ? vm.shipping.FirstName : '') + ' ' + (vm.shipping.LastName != null ? vm.shipping.LastName : '');
            vm.billing.FullName = vm.billing.FullName.trim();
            vm.billing.Address1 = vm.shipping.Address1;
            vm.billing.Address2 = vm.shipping.Address2;
            vm.billing.City = vm.shipping.City;
            vm.billing.PostalCode = vm.shipping.PostalCode;
            vm.billing.CountryID = vm.shipping.CountryID;
            vm.billingRegions = vm.shippingRegions;
            vm.billing.RegionID = vm.shipping.RegionID;
        };
        vm.print = function () {
            var styles = '.center{position:absolute;top:50%;left:50%;transform:translateX(-50%) translateY(-50%)}' +
                '.loader{border:16px solid #f3f3f3;border-radius:50%;border-top:14px solid #3498db;border-bottom:14px solid #3498db;width:60px;height:60px;animation:spin 2s linear infinite}' +
                '@keyframes spin{0%{transform:rotate(0)}100%{transform:rotate(360deg)}}';
            var popup = $window.open('', '_blank', 'fullscreen=yes');
            popup.document.open();
            popup.document.write('<html><head></head><style type="text/css">' + styles + '</style><body><div class="center loader"></div></body></html>');
            popup.document.close();
            var request = dataProvider.printtUserOrder(vm.moduleId, vm.orderStatus.OrderID);
            request.then(function (response) {
                popup.document.open();
                if (globalFunctions.getResponseType(response.status) == 'Successful') {
                    popup.document.write('<html><head></head><body onload="window.print()">' + response.data + '</body></html>');
                }
                else {
                    popup.document.write('<html><head></head><body>Unable to print order | ERR: ' + response.data.Message + '</body></html>');
                    console.log('Unable to print order | ERR: ' + response.status);
                    toastr.error('Unable to print order ' + response.data.Message, vm.storeName);
                }
                popup.document.close();
            });
        };
    };
    // End of RazorCart IIFE
}());