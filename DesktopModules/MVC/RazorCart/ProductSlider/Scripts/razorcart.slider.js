﻿(function () {
    // Invoking JavaScript Strict Mode
    'use strict';
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // Definition of the RazorCart Application                                                                                                                                                          //
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    angular
        // Modules
        .module('RazorCart')
        // Controllers
        .controller('sliderCtrl', sliderCtrl)
    ;
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // ProductSlider Module Controller                                                                                                                                                                  //
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    function sliderCtrl($scope, $filter, $window, $timeout, sharedProvider, dataProvider, globalFunctions, toastr) {
        var vm = this;
        vm.init = function (model) {
            vm.moduleId = model.ModuleID;
            vm.storeName = model.StoreName;
            vm.dataSource = model.DataSource;
            vm.isSaleEnabled = model.IsSaleEnabled;
            vm.manageInventory = model.ManageInventory;
            vm.products = model.Products;
            vm.productDetailsPage = model.ProductDetailsPage;
            angular.element(document.getElementById('rzcContainer_' + vm.moduleId)).attr('ng-init', '');
        };
        vm.carousel = function (object) {
            $timeout(function () {
                angular.element(document.getElementById('owl-carousel-' + vm.moduleId)).owlCarousel({
                    loop: true,
                    nav: false,
                    margin: 10,
                    responsiveClass: true,
                    responsiveBaseElement: '#owl-carousel-' + vm.moduleId,
                    responsive: {
                        0: { items: 1 },
                        480: { items: 2 },
                        768: { items: 3 },
                        992: { items: 4 },
                        1200: { items: 5 },
                        1440: { items: 6 }
                    }
                });
            }, 0);
        };
        vm.get = function () {
            var request = dataProvider.getShoppingCart(vm.moduleId, vm.shipping);
            request.then(function (response) {
                sharedProvider.updateCart(response.data.CartList, response.data.CartTotals);
                vm.inProgress = false;
            });
        };
        vm.addToCart = function ($index) {
            vm.inProgress = true;
            var product = vm.products[$index];
            if (product.HasVariants || product.Booking || (!product.QuantityOnHand && !vm.manageInventory)) {
                $window.location.href = product.ProductDetailUrl;
            }
            else {
                var quantity = 1, price = null;
                var request = dataProvider.addShoppingCart(vm.moduleId, product.ProductID, null, quantity, price, new Object());
                request.then(function (response) {
                    if (globalFunctions.getResponseType(response.status) == 'Successful') {
                        switch (response.data.Action) {
                            case 'UseMiniCart':
                                vm.get();
                                toastr.success('Successfully added ' + product.ModelName + ' to cart.', vm.storeName);
                                break;
                            case 'RedirectToCheckout':
                                $window.location.href = response.data.Url;
                                break;
                            case 'OpenCustomModal':
                                vm.get();
                                $timeout(function () {
                                    dnnModal.show(response.data.Modal, true, 600, 800, true, response.data.Url);
                                });
                                break;
                        }
                    }
                    else if (globalFunctions.getResponseType(response.status) == 'ClientError') {
                        toastr.warning(response.data.Message, vm.storeName);
                        vm.inProgress = false;
                    }
                    else {
                        console.log('Unable to add | ERR: ' + response.status);
                        toastr.error(response.data.Message, vm.storeName);
                        vm.inProgress = false;
                    }
                });
            }
        };
    };
    // End of RazorCart IIFE
}());