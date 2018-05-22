(function () {
    // Invoking JavaScript Strict Mode
    'use strict';
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // Definition of the RazorCart Application                                                                                                                                                          //
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    angular
        // Modules
        .module('RazorCart')
        // Configuration
        .config(function ($locationProvider, $compileProvider, toastrConfig) {
            //disabled html5Mode to prevent angular from encoding slash in product SEO URL
            $locationProvider.html5Mode(false);
        })
        // Controllers
        .controller('detailsCtrl', detailsCtrl)
        // Dependencies
        .requires.push('ngStarRating', 'ngPickaDate')
    ;
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // Product Details Module Controller                                                                                                                                                                //
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    function detailsCtrl($scope, $filter, $window, $timeout, sharedProvider, dataProvider, globalFunctions, toastr) {
        var vm = this;

        $scope.des;
        vm.init = function (model) {
            vm.moduleId = model.ModuleID;
            vm.storeName = model.StoreName;
            vm.localResource = model.LocalResource;
            vm.product = model.Product;
            vm.variants = model.Variants;
            vm.isSaleEnabled = model.IsSaleEnabled;
            vm.manageInventory = model.ManageInventory;
            vm.showReviews = model.ShowReviews;
            vm.productImages = model.ProductImages;
            vm.productReviews = model.ProductReviews;
            vm.sliderImages = model.SliderImages;
            vm.checkoutPage = model.CheckoutPage;
            vm.productListPage = model.ProductListPage;
            vm.booking = model.Booking;
            vm.newRate = {};
            angular.element(document.getElementById('rzcContainer_' + vm.moduleId)).attr('ng-init', '');
            for (var i = 0; i < model.VariantList.length; i++) {
                var mod = model.VariantList[0];
                if (mod.Variants.length>0) {
                    var mode = mod.Variants[0];

                    if (mode.VariantDesc != '' && mode.VariantDesc != null) {
                        $scope.des = mode.VariantDesc;
                        break;
                    }


                }
            }
        };
       
        vm.shoppingCart = function () {
            var request = dataProvider.getShoppingCart(vm.moduleId, vm.shipping);
            request.then(function (response) {
                sharedProvider.updateCart(response.data.CartList, response.data.CartTotals);
                vm.rebinding = false;
            });
        };
        vm.changeImage = function (name) {
            if (name) {
                var dImages = '';
                angular.forEach(angular.element('[name="' + name + '"]'), function (element) {
                    switch (element.tagName) {
                        case 'INPUT':
                            if (element.checked)
                                dImages = element.getAttribute('data-images') || dImages;
                            break;
                        case 'SELECT':
                            var option = element.selectedOptions[element.selectedOptions.length - 1];
                            if (option)
                                dImages = option.getAttribute('data-images') || dImages;
                            break;
                    }
                });
                var imageIds = [];
                angular.forEach(dImages.split(','), function (sid) {
                    var id = parseInt(sid);
                    if (!isNaN(id) && imageIds.indexOf(id) === -1) {
                        imageIds.push(id);
                    }
                });
                if (imageIds.length) {
                    angular.element('img[u="thumb"][data-id="imageId_' + imageIds[0] + '"]').click();
                }
            }
        };
        vm.myChangeImage = function (varient) {

            angular.element('img[u="thumb"][data-id="imageId_' + varient.VariantImage + '"]').click();
            var myEl = angular.element(document.querySelector('#varDesc'));
           // myEl.html(varient.VariantDesc);
            $scope.des = varient.VariantDesc;
        }
      
        vm.price = function (name,varient) {
            vm.changeImage(name);
            if (varient != undefined)
           vm.myChangeImage(varient);
            vm.rebinding = true;
            var quantity = 1, price = null, variants = {}, booking = {};
            if (vm.productQuantity)
                quantity = vm.productQuantity;
            if (!isNaN(vm.productPrice))
                price = vm.productPrice;
            if (vm.variantsData)
                variants = vm.variantsData;
            if (varient != undefined) {
                var id = varient.VariantID;
                vm.variantsData.group_1 = id;
            }
            if (vm.booking)
                booking = vm.booking;
            var request = dataProvider.getProduct(vm.moduleId, vm.product.ProductID, quantity, 1250, variants, booking);
            request.then(function (response) {
                if (globalFunctions.getResponseType(response.status) == 'Successful') {
                    vm.product.UnitCost = response.data.Product.UnitCost;
                    vm.product.SalePrice = response.data.Product.SalePrice;
                    vm.product.ModelNumber = response.data.Product.ModelNumber;
                    vm.product.QuantityOnHand = response.data.Product.QuantityOnHand;
                    
                }
                else {
                    console.log((vm.localResource['PriceError.Text'] || 'Unable to get price | ERR:') + ' ' + response.status);
                    toastr.error((vm.localResource['PriceError.Text'] || 'Unable to get price | ERR:') + ' ' + response.data.Message, vm.storeName);
                }
                vm.rebinding = false;
            });
        };
        vm.addToCart = function () {
            vm.rebinding = true;
            var quantity = 1, price = null, variants = {}, variantsFiles = {}, booking = {};
            if (vm.productQuantity)
                quantity = vm.productQuantity;
            if (!isNaN(vm.productPrice))
                price = vm.productPrice;
            if (vm.variantsData)
                variants = vm.variantsData;
            if (vm.variantsFiles)
                variantsFiles = vm.variantsFiles;
            if (vm.booking)
                booking = vm.booking;
            var request = dataProvider.addShoppingCart(vm.moduleId, vm.product.ProductID, null, quantity, price, variants, variantsFiles, booking, vm.inputs);
            request.then(function (response) {
                if (globalFunctions.getResponseType(response.status) == 'Successful') {
                    switch (response.data.Action) {
                        case 'UseMiniCart':
                            vm.shoppingCart();
                            toastr.success((vm.localResource['AddedToCart.Text'] || 'Successfully added [PRODUCT] to cart.').replace('[PRODUCT]', vm.product.ModelName), vm.storeName);
                            break;
                        case 'RedirectToCheckout':
                            $window.location.href = response.data.Url;
                            break;
                        case 'OpenCustomModal':
                            vm.shoppingCart();
                            $timeout(function () {
                                dnnModal.show(response.data.Modal, true, 600, 800, true, response.data.Url);
                            });
                            break;
                    }
                }
                else if (globalFunctions.getResponseType(response.status) == 'ClientError') {
                    vm.rebinding = false;
                    toastr.warning(response.data.Message, vm.storeName);
                }
                else {
                    vm.rebinding = false;
                    console.log((vm.localResource['AddToCartError.Text'] || 'Unable to add to cart | ERR:') + ' ' + response.status);
                    toastr.error((vm.localResource['AddToCartError.Text'] || 'Unable to add to cart | ERR:') + ' ' + response.data.Message, vm.storeName);
                }
            });
        };
        vm.addToWishlist = function () {
            vm.rebinding = true;
            var quantity = 1, price = null, variants = {}, variantsFiles = {}, booking = {};
            if (vm.productQuantity)
                quantity = vm.productQuantity;
            if (!isNaN(vm.productPrice))
                price = vm.productPrice;
            if (vm.variantsData)
                variants = vm.variantsData;
            if (vm.variantsFiles)
                variantsFiles = vm.variantsFiles;
            if (vm.booking)
                booking = vm.booking;
            var request = dataProvider.addWishlist(vm.moduleId, vm.product.ProductID, quantity, price, variants, variantsFiles, booking);
            request.then(function (response) {
                if (globalFunctions.getResponseType(response.status) == 'Successful') {
                    sharedProvider.updateWishlist(response.data.SavedCart);
                    toastr.success((vm.localResource['AddedToWishlist.Text'] || 'Successfully added [PRODUCT] to wishlist.').replace('[PRODUCT]', vm.product.ModelName), vm.storeName);
                }
                else if (globalFunctions.getResponseType(response.status) == 'ClientError') {
                    toastr.warning(response.data.Message, vm.storeName);
                }
                else {
                    console.log((vm.localResource['AddToWishlistError.Text'] || 'Unable to add to wishlist | ERR:') + ' ' + response.status);
                    toastr.error((vm.localResource['AddToWishlistError.Text'] || 'Unable to add to wishlist | ERR:') + ' ' + response.data.Message, vm.storeName);
                }
                vm.rebinding = false;
            });
        };
        vm.zoom = function (panID, zoomImage) {
            angular.element(document).ready(function () {
                angular.element(document.getElementById('zoompan_' + panID)).zoom({ url: zoomImage });
            });
        };
        vm.listProductReviews = function () {
            var request = dataProvider.listProductReviews(vm.moduleId, vm.product.ProductID);
            request.then(function (response) {
                if (globalFunctions.getResponseType(response.status) == 'Successful') {
                    vm.productReviews = response.data.ProductReviews;
                }
                else {
                    console.log((vm.localResource['GetReviewsError.Text'] || 'Unable to get product reviews | ERR:') + ' ' + response.status);
                    toastr.error((vm.localResource['GetReviewsError.Text'] || 'Unable to get product reviews | ERR:') + ' ' + response.data.Message, vm.storeName);
                }
            });
        };
        vm.submitReview = function () {
            var request = dataProvider.addProductReview(vm.moduleId, vm.product.ProductID, vm.newRate.Rate, vm.newRate.Comments, vm.newRate.NickName);
            request.then(function (response) {
                if (globalFunctions.getResponseType(response.status) == 'Successful') {
                    vm.listProductReviews();
                    toastr.success((vm.localResource['SubmitedReview.Text'] || 'Successfully submitted a review for [PRODUCT].').replace('[PRODUCT]', vm.product.ModelName), vm.storeName);
                    vm.writeReview = !vm.writeReview;
                }
                else {
                    console.log((vm.localResource['SubmitReviewsError.Text'] || 'Unable to submit product review | ERR:') + ' ' + response.status);
                    toastr.error((vm.localResource['SubmitReviewsError.Text'] || 'Unable to submit product review | ERR:') + ' ' + response.data.Message, vm.storeName);
                }
            });
        };
        vm.bookingChange = function () {
            $timeout(function () {
                var request = dataProvider.getProductBooking(vm.moduleId, vm.product.ProductID, vm.booking.start, vm.booking.end);
                request.then(function (response) {
                    if (globalFunctions.getResponseType(response.status) == 'Successful') {
                        vm.booking.start.dateOptions = response.data.Booking.start.dateOptions;
                        vm.booking.start.timeOptions = response.data.Booking.start.timeOptions;
                        vm.booking.end.dateOptions = response.data.Booking.end.dateOptions;
                        vm.booking.end.timeOptions = response.data.Booking.end.timeOptions;
                    }
                    else {
                        console.log((vm.localResource['GetBookingData.Text'] || 'Unable to get product booking data | ERR:') + ' ' + response.status);
                        toastr.error((vm.localResource['GetBookingData.Text'] || 'Unable to get product booking data | ERR:') + ' ' + response.data.Message, vm.storeName);
                    }
                });
            }, 50);
        };
        vm.setBookingEnd = function () {
            if (vm.booking.end.serverMaxValue == undefined) {
                if (vm.booking.end.max.constructor === Array && Array.isArray(vm.booking.end.max))
                    vm.booking.end.serverMaxValue = new Date(vm.booking.end.max[0], vm.booking.end.max[1], vm.booking.end.max[2]);
                else if (vm.booking.end.max.constructor === Date && vm.booking.end.max instanceof Date)
                    vm.booking.end.serverMaxValue = new Date(vm.booking.end.max);
            }
            $timeout(function () {
                if (vm.booking.min > -1) {
                    var startValue = new Date(vm.booking.start.value ? vm.booking.start.value : new Date());
                    vm.booking.end.min = new Date(startValue.setDate(startValue.getDate() + vm.booking.min));
                }
                if (vm.booking.max > -1) {
                    var startValue = new Date(vm.booking.start.value ? vm.booking.start.value : new Date());
                    vm.booking.end.max = new Date(startValue.setDate(startValue.getDate() + vm.booking.max));
                }
                else {
                    vm.booking.end.max = new Date(vm.booking.end.serverMaxValue);
                }
                var endMinDate, endMaxDate, firstEndMaxDate;
                if (vm.booking.end.min.constructor === Array && Array.isArray(vm.booking.end.min))
                    endMinDate = new Date(vm.booking.end.min[0], vm.booking.end.min[1], vm.booking.end.min[2]);
                else if (vm.booking.end.min.constructor === Date && vm.booking.end.min instanceof Date)
                    endMinDate = new Date(vm.booking.end.min);
                if (vm.booking.end.max.constructor === Array && Array.isArray(vm.booking.end.max))
                    endMaxDate = new Date(vm.booking.end.max[0], vm.booking.end.max[1], vm.booking.end.max[2]);
                else if (vm.booking.end.max.constructor === Date && vm.booking.end.max instanceof Date)
                    endMaxDate = new Date(vm.booking.end.max);

                firstEndMaxDate = endMaxDate;
                angular.forEach(vm.booking.start.dateOptions.disable, function (value, index) {
                    if (value.constructor === Number && Number.isInteger(value)) {
                        for (var d = endMinDate; d <= endMaxDate; d.setDate(d.getDate() + 1)) {
                            if ((value == d.getDay() + 1)) {
                                if (d < firstEndMaxDate)
                                    firstEndMaxDate = d;
                                break;
                            }
                        }
                    }
                    else if (value.constructor === Array && Array.isArray(value)) {
                        var d = new Date(value[0], value[1], value[2]);
                        if (d < firstEndMaxDate && d > endMinDate)
                            firstEndMaxDate = d;
                    }
                    else if (value.constructor === Object && value instanceof Object) {
                        var d = new Date(value.from[0], value.from[1], value.from[2]);
                        if (d < firstEndMaxDate && d > endMinDate)
                            firstEndMaxDate = d;
                    }
                });
                vm.booking.end.max = firstEndMaxDate;
            });
        };
        vm.parseBooking = function (object) {
            Object.keys(object).forEach(function (key, index) {
                Object.keys(object[key]).forEach(function (prop, level) {
                    if (object[key].hasOwnProperty(prop) && object[key][prop] != null && object[key][prop] != undefined) {
                        if (typeof object[key][prop] == 'string' || object[key][prop] instanceof String) {
                            object[key][prop] = new Date(JSON.parse(JSON.stringify(object[key][prop])));
                        }
                        else if (typeof object[key][prop] == 'object' || object[key][prop] instanceof Object) {
                            Object.keys(object[key][prop]).forEach(function (option, type) {
                                if (typeof object[key][prop][option] == 'object' || object[key][prop] instanceof Object) {

                                }
                            });
                        }
                    }
                });
            });
            return object;
        };
        vm.navigateShareUrl = function ($event) {
            $event.preventDefault();
            var url = $event.currentTarget.getAttribute('href');
            var winWidth = Math.min(600, screen.width - 15);
            var winHeight = Math.min(550, screen.height - 15);
            var winTop = (screen.height / 2) - (winHeight / 2);
            var winLeft = (screen.width / 2) - (winWidth / 2);
            window.open(url, 'Share-Product', 'width=' + winWidth + ',height=' + winHeight + ',top=' + winTop + ',left=' + winLeft + ',menubar=no,toolbar=no,status=no,resizable=yes,scrollbars=yes');
        };
    };
    // End of RazorCart IIFE
}());