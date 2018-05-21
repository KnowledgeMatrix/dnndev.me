(function () {
    // Invoking JavaScript Strict Mode
    'use strict';
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // Definition of the RazorCart Application                                                                                                                                                          //
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    angular.module('RazorCart')
        // Controllers
        .controller('accountCtrl', accountCtrl)
    ;
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // My Account Module Controller                                                                                                                                                                  //
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    function accountCtrl($scope, $filter, $window, $location, $rootScope, $timeout, $q, sharedProvider, globalFunctions, dataProvider, toastr) {
        var vm = this;
        $rootScope.$on('$locationChangeSuccess', function (event, newLocation, oldLocation) {
            if (!new RegExp(newLocation, 'i').test(oldLocation)) {
                vm.tabName = $location.hash() ? $location.hash().toLowerCase() : 'dashboard';
                //vm.rebindPage();
            }
        });
        $rootScope.$watch(function () { return $location.absUrl() }, function (newLocation, oldLocation) {
            if ($rootScope.actualLocation === newLocation) {
                //Handle Browser's Back/Forward buttons
            }
        });
        vm.init = function (model) {
            vm.portalId = model.PortalID;
            vm.moduleId = model.ModuleID;
            vm.storeName = model.StoreName;
            vm.localResource = model.LocalResource;
            vm.orders = model.Orders;
            vm.shipping = model.Shipping;
            vm.billing = model.Billing;
            vm.walletItems = model.WalletItems;
            vm.subscriptionItems = model.SubscriptionItems;
            vm.downloadableItems = model.DownloadableItems;
            vm.billingPayments = model.BillingPayments;
            vm.countries = model.Countries;
            vm.shippingRegions = model.ShippingRegions;
            vm.billingRegions = model.BillingRegions;
            vm.expMonths = model.ExpMonths;
            vm.expYears = model.ExpYears;
            vm.tabName = $location.hash() ? $location.hash().toLowerCase() : 'dashboard';
            vm.sqlMinDate = new Date(1753, 1, 1);
            angular.element(document.getElementById('rzcContainer_' + vm.moduleId)).attr('ng-init', '');
        };
        vm.viewOrder = function (index) {
            var deferred = $q.defer();
            vm.submitting = true;
            var orderID = vm.orders[index].OrderID;
            var request = dataProvider.getUserOrder(vm.moduleId, orderID);
            request.then(function (response) {
                if (globalFunctions.getResponseType(response.status) == 'Successful') {
                    vm.order = response.data.Order;
                    vm.payment = response.data.Payment;
                    vm.subscription = response.data.Subscription;
                    vm.detailMode = true;
                }
                else {
                    toastr.error(response.data.Message, vm.storeName);
                }
                vm.submitting = false;
                deferred.resolve();
            });
            return deferred.promise;
        };
        vm.menuClass = function (tabName) {
            if (new RegExp(tabName, 'i').test(vm.tabName)) {
                return 'active disabled';
            } else {
                return '';
            }
        };
        vm.unsubscribe = function (orderID, subscriptionID) {
            vm.submitting = true;
            var request = dataProvider.cancelOrderSubscription(vm.moduleId, orderID || vm.order.OrderID, subscriptionID);
            request.then(function (response) {
                if (globalFunctions.getResponseType(response.status) == 'Successful') {
                    if (vm.subscription && vm.subscription.OrderID === response.data.Subscription.OrderID && vm.subscription.SubscriptionID === response.data.Subscription.SubscriptionID)
                        vm.subscription = response.data.Subscription;
                    angular.forEach(vm.subscriptionItems, function (subscription, i) {
                        if (subscription.Item1.OrderID === response.data.Subscription.OrderID && subscription.Item1.SubscriptionID === response.data.Subscription.SubscriptionID) {
                            subscription.Item1 = response.data.Subscription;
                        }
                    });
                    toastr.success(response.data.Message, vm.storeName);
                }
                else {
                    toastr.error(response.data.Message, vm.storeName);
                }
                vm.submitting = false;
            });
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
        vm.saveWallet = function () {
            vm.submitting = true;
            var request = dataProvider.saveWallet(vm.moduleId, vm.billing);
            request.then(function (response) {
                if (globalFunctions.getResponseType(response.status) == 'Successful') {
                    vm.walletItems = response.data.WalletItems;
                    toastr.success(vm.localResource['WalletItemCreated.Text'] || 'Your wallet item was successfully created.', vm.storeName);
                    vm.walletForm = false;
                }
                else {
                    console.log((vm.localResource['WalletItemCreateError.Text'] || 'Unable to submit wallet item | ERR:') + ' ' + response.status);
                    toastr.error((vm.localResource['WalletItemCreateError.Text'] || 'Unable to submit wallet item | ERR:') + ' ' + response.data.Message, vm.storeName);
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
            if (confirm(vm.localResource['WalletItemDeleteConfirm.Text'] || 'Are you sure?')) {
                var request = dataProvider.deleteWallet(vm.moduleId, vm.walletItems[index].ID);
                request.then(function (response) {
                    if (globalFunctions.getResponseType(response.status) == 'Successful') {
                        vm.walletItems = response.data.WalletItems;
                        toastr.success(vm.localResource['WalletItemDeleted.Text'] || 'Your wallet item was successfully deleted.', vm.storeName);
                    }
                    else {
                        console.log((vm.localResource['WalletItemDeleteError.Text'] || 'Unable to delete wallet item | ERR:') + ' ' + response.status);
                        toastr.error((vm.localResource['WalletItemDeleteError.Text'] || 'Unable to delete wallet item | ERR:') + ' '  + response.status, vm.storeName);
                    }
                });
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
            }
        };
        vm.saveAddress = function () {
            vm.submitting = true;
            var request = dataProvider.saveCustomer(vm.moduleId, vm.shipping);
            request.then(function (response) {
                if (globalFunctions.getResponseType(response.status) == 'Successful') {
                    vm.customer = response.data.Customer;
                    toastr.success(vm.localResource['AddressUpdated.Text'] || 'Your address was successfully updated.', vm.storeName);
                    vm.walletForm = false;
                }
                else {
                    console.log((vm.localResource['AddressUpdateError.Text'] || 'Unable to save customer\'s address | ERR:') + ' ' + response.status);
                    toastr.error((vm.localResource['AddressUpdateError.Text'] || 'Unable to save customer\'s address | ERR:') + ' ' + response.data.Message, vm.storeName);
                }
                vm.submitted = false;
                vm.submitting = false;
            });
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
            return deferred.promise;
        };
        vm.download = function (index) {
            var request = dataProvider.download(vm.moduleId, vm.downloadableItems[index].OrderID, vm.downloadableItems[index].ProductID);
            request.then(function (response) {
                if (globalFunctions.getResponseType(response.status) == 'Successful') {
                    $window.location.assign(response.data.DownloadUrl);
                }
                else {
                    console.log((vm.localResource['DownloadError.Text'] || 'Unable to download file | ERR:') + ' ' + response.status);
                    toastr.error((vm.localResource['DownloadDenied.Text'] || 'Unauthorized request to download') + ' ' + vm.cartList[index].ProductName, vm.storeName);
                }
            });
        };
        vm.print = function (index) {
            var orderID;
            if (index != undefined)
                orderID = vm.orders[index].OrderID;
            else
                orderID = vm.order.OrderID;
            var styles = '.center{position:absolute;top:50%;left:50%;transform:translateX(-50%) translateY(-50%)}' +
                '.loader{border:16px solid #f3f3f3;border-radius:50%;border-top:14px solid #3498db;border-bottom:14px solid #3498db;width:60px;height:60px;animation:spin 2s linear infinite}' +
                '@keyframes spin{0%{transform:rotate(0)}100%{transform:rotate(360deg)}}';
            var popup = $window.open('', '_blank', 'fullscreen=yes');
            popup.document.open();
            popup.document.write('<html><head></head><style type="text/css">' + styles + '</style><body><div class="center loader"></div></body></html>');
            popup.document.close();
            var request = dataProvider.printtUserOrder(vm.moduleId, orderID);
            request.then(function (response) {
                popup.document.open();
                if (globalFunctions.getResponseType(response.status) == 'Successful') {
                    popup.document.write('<html><head></head><body onload="window.print()">' + response.data + '</body></html>');
                }
                else {
                    popup.document.write('<html><head></head><body>' + (vm.localResource['PrintError.Text'] || 'Unable to print order | ERR:') + ' ' + response.data.Message + '</body></html>');
                    console.log((vm.localResource['PrintError.Text'] || 'Unable to print order | ERR:') + ' ' + response.status);
                    toastr.error((vm.localResource['PrintError.Text'] || 'Unable to print order | ERR:') + ' ' + response.data.Message, vm.storeName);
                }
                popup.document.close();
            });
        };
        vm.getRangeArray = function (min, max, step) {
            return globalFunctions.getRangeArray(min, max, step);
        };
    };
    // End of RazorCart IIFE
}());