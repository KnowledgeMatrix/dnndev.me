
    //angular
    //    // Modules
    //    .module('HeaderModule')
    //    // Controllers
    //    .controller('CategoryListCtrl', categoryCtrl)
//;


var app = angular.module("HeaderModule", []);

app.controller("categoryCtrl", function ($scope) {
    var vm = this;
    var CtegoryList = [];
    var partsList = [];
    var mensList = [];
    var parentcat = [];
    var womensList = [];
    var merchandiseList = [];
    var teamShelbyList = [];
    var outletList = [];
   var foundationList = [];

    vm.init = function (model) {
        for (var i = 0; i <model.length; i++) {
            switch (model[i].ParentName.toLowerCase().replace(" ", "")) {
                case 'shellbyparts':
                    partsList.push(model[i]);
                    break;
                case 'men’sapparel': 
                    mensList.push(model[i]);
                    break;
                case 'woman’sapparel':
                    womensList.push(model[i]);
                    break;
                case 'merchandise':
                    merchandiseList.push(model[i])
                    break;
                case 'teamshelby': 
                    teamShelbyList.push(model[i]);
                    break;
                case 'outlet': 
                    outletList.push(model[i]);
                    break;
                case 'foundation': 
                    foundationList.push(model[i]);
                    break;
                //default: if (model[i].CategoryName == 'Outlet' && outletList.length==0)
                //    outletList.push(model[i]);
                //    break;
            }
        }
        if (partsList.length!=0)
        CtegoryList.push(partsList);
        if (mensList.length != 0)
        CtegoryList.push(mensList);
        if (womensList.length != 0)
        CtegoryList.push(womensList);
        if (merchandiseList.length != 0)
        CtegoryList.push(merchandiseList);
        if (teamShelbyList.length != 0)
        CtegoryList.push(teamShelbyList);
        if (outletList.length != 0)
        CtegoryList.push(outletList);
        if (foundationList.length != 0)
        CtegoryList.push(foundationList);


        $scope.partsList = CtegoryList;
        $scope.parentLocation = window.parent.location.origin;
    };
    
      
   

});
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // Category Menu Module Controller                                                                                                                                                                  //
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //function categoryCtrl($scope, $filter, $location, $rootScope, $timeout, sharedProvider, globalFunctions, dataProvider) {
    //    var vm = this;
    //    $rootScope.$on('$locationChangeSuccess', function (event, newLocation, oldLocation) {
    //        vm.actualLocation = $location.absUrl();
    //        //Rebind Data If needed - like if department list got changed in url
    //    });
    //    $rootScope.$watch(function () { return $location.absUrl() }, function (newLocation, oldLocation) {
    //        if (false && vm.actualLocation && newLocation.toLowerCase() === vm.actualLocation.toLowerCase()) {
    //            //Handle Browser's Back/Forward buttons
    //            angular.forEach(sharedProvider.getPathParams($location.absUrl()).params, function (ngValue, ngKey) {
    //                if (ngKey.toLowerCase() === vm.categoryUrlKey.toLowerCase()) {
    //                    vm.catSEOUrlList = ngValue.split('~');
    //                }
    //            });
    //            vm.selectAllCategories(null, vm.categories);
    //        }
    //    });
    //    vm.init = function (model) {
    //        sharedProvider.updateProductListInfo('useFriendlyUrl', model.UseFriendlyUrl);
    //        sharedProvider.updateProductListInfo('absoluteBaseUrl', model.AbsoluteBaseUrl);
    //        sharedProvider.initPathParams($location.absUrl(), model.UrlParams);
    //        /////////////
    //        vm.moduleId = model.ModuleID;
    //        vm.storeName = model.StoreName;
    //        vm.categoryUrlKey = model.CategoryUrlKey;
    //        sharedProvider.addCategoryUrlKey(vm.categoryUrlKey);
    //        vm.categoryMenuURL = model.CategoryMenuURL;
    //        vm.useHyperlinks = model.UseHyperlinks;
    //        vm.productListPage = model.ProductListPage;
    //        vm.catSEOUrlList = model.CatSEOUrlList.length ? model.CatSEOUrlList.split('~') : [];
    //        vm.enableMultiSelection = model.EnableMultiSelection;
    //        vm.highlightSelectedCategories = model.HighlightSelectedCategories;
    //        vm.showCheckBoxes = model.ShowCheckBoxes;
    //        vm.treeIconType = model.TreeIconType; // Possible Values = { 'PlusMinus' , 'Arrows' }
    //        vm.showProdCount = model.ShowProdCount;
    //        vm.enableXmlPriceList = model.EnableXmlPriceList;
    //        vm.categories = vm.populateCategoryTree(model.Categories);
    //        angular.element(document.getElementById('rzcContainer_' + vm.moduleId)).attr('ng-init', '');
    //    };
    //    vm.getRangeArray = function (min, max, step) {
    //        return globalFunctions.getRangeArray(min, max, step);
    //    };
    //    vm.populateCategoryTree = function (categories) {
    //        //First be sure of the array sorting, should be ParentID asc, then SortOrder asc
    //        categories = $filter('orderBy')(categories, ['ParentID', 'SortOrder']);
    //        //This Function Called Once to convert flat category list to Tree
    //        var categoryTree = [], childrenOf = {};
    //        var category, categoryId, parentId;
    //        for (var i = 0; i < categories.length; i++) {
    //            category = categories[i];
    //            categoryId = category.CategoryID;
    //            parentId = category.ParentID || 0;
    //            // every category may have children
    //            childrenOf[categoryId] = childrenOf[categoryId] || [];
    //            // init its children
    //            category.Childs = childrenOf[categoryId];
    //            category.CatSEOURL = category.CatSEOURL ? category.CatSEOURL : category.CategoryID.toString();
    //            var index = vm.catSEOUrlList.map(function (key) {
    //                return key.toLowerCase();
    //            }).indexOf(category.CatSEOURL.toLowerCase());
    //            category.IsSelected = index > -1 ? true : false;
    //            var parent = $filter('filter')(categories, function (cat) { return cat.CategoryID === parentId; })[0];
    //            category.Depth = 1 + (parent ? parent.Depth : 0);
    //            if (parentId !== 0) {
    //                // init its parent's children object
    //                childrenOf[parentId] = childrenOf[parentId] || [];
    //                // push it into its parent's children object
    //                childrenOf[parentId].push(category);
    //            } else {
    //                categoryTree.push(category);
    //            }
    //        };

    //        return categoryTree;
    //    };
    //    vm.checkIfExpanded = function (category) {
    //        if (typeof category.IsExpanded !== 'undefined') {
    //            return category.IsExpanded;
    //        } else {
    //            if (category.DirectChildsCount > 0 && category.Childs.length) {
    //                category.IsExpanded = true;
    //            } else {
    //                category.IsExpanded = false;
    //            }
    //        }
    //    };
    //    vm.getExpandableClass = function (category) {
    //        var expandableClass = 'glyphicon-none';
    //        if (category.DirectChildsCount > 0) {
    //            if (vm.checkIfExpanded(category)) {
    //                expandableClass = vm.treeIconType === 'Arrows' ? 'glyphicon-chevron-down' : 'glyphicon-minus';
    //            } else {
    //                expandableClass = vm.treeIconType === 'Arrows' ? 'glyphicon-chevron-right' : 'glyphicon-plus';
    //            }
    //        }
    //        return expandableClass;
    //    };
    //    vm.expandNode = function ($event, category) {
    //        $event.preventDefault();
    //        $event.stopPropagation();
    //        if (category.DirectChildsCount > 0) {
    //            if (category.IsExpanded) {
    //                category.IsExpanded = false;
    //                category.VirtualChilds = category.Childs;
    //                category.Childs = [];
    //            } else {
    //                category.IsExpanded = true;
    //                if (typeof category.VirtualChilds !== 'undefined' && category.VirtualChilds.length) {
    //                    category.Childs = category.VirtualChilds;
    //                } else {
    //                    category.loadingChilds = true;
    //                    var request = dataProvider.listCategoryDirectChilds(vm.moduleId, category.CategoryID, vm.showProdCount);
    //                    request.then(function (response) {
    //                        angular.forEach(response.data.Categories, function (cat) {
    //                            cat.Childs = [];
    //                            cat.CatSEOURL = cat.CatSEOURL ? cat.CatSEOURL : cat.CategoryID.toString();
    //                            var index = vm.catSEOUrlList.map(function (key) {
    //                                return key.toLowerCase();
    //                            }).indexOf(cat.CatSEOURL.toLowerCase());
    //                            cat.IsSelected = index > -1 ? true : false;
    //                            cat.Depth = 1 + category.Depth;
    //                        });
    //                        category.Childs = response.data.Categories;
    //                        $timeout(function () {
    //                            category.loadingChilds = false;
    //                        }, 150);
    //                    });
    //                }
    //            }
    //        }
    //    };
    //    vm.selectCategory = function (selectIt, category) {
    //        // When selectIt = null then get the IsSelected value from the catSEOUrlList
    //        if (selectIt === null) {
    //            var index = vm.catSEOUrlList.map(function (key) {
    //                return key.toLowerCase();
    //            }).indexOf(category.CatSEOURL.toLowerCase());
    //            category.IsSelected = index > -1 ? true : false;
    //        } else {
    //            category.IsSelected = selectIt;
    //            if (selectIt) {
    //                if (vm.useHyperlinks)
    //                    window.location.href = vm.categoryMenuURL.replace('{0}', category.CatSEOURL);
    //                else
    //                    vm.catSEOUrlList.push(category.CatSEOURL);
    //            } else {
    //                var index = vm.catSEOUrlList.map(function (key) {
    //                    return key.toLowerCase();
    //                }).indexOf(category.CatSEOURL.toLowerCase());
    //                if (index > -1) {
    //                    vm.catSEOUrlList.splice(index, 1);
    //                }
    //            }
    //        }
    //    };
    //    vm.selectAllCategories = function (selectIt, categories) {
    //        angular.forEach(categories, function (category) {
    //            vm.selectCategory(selectIt, category);
    //            vm.selectAllCategories(selectIt, category.Childs);
    //        });
    //    };
    //    vm.toggleCategory = function ($event, category) {
    //        $event.preventDefault();
    //        $event.stopPropagation();
    //        //Bind category.IsSelected to wasSelected variable in case of enableMultiSelection setting was disabled
    //        var wasSelected = category.IsSelected;
    //        if (!vm.enableMultiSelection) {
    //            vm.selectAllCategories(false, vm.categories);
    //        }
    //        if (wasSelected) {
    //            vm.selectCategory(false, category);
    //        } else {
    //            vm.selectCategory(true, category);
    //        }
    //        sharedProvider.updateProductListInfo('isRebindProducts', true);
    //        var params = [
    //            {
    //                key: vm.categoryUrlKey,
    //                value: vm.catSEOUrlList.length ? vm.catSEOUrlList.join('~') : null
    //            }
    //        ];
    //        globalFunctions.updateUrlLocation(true, params);
    //    };
    //};
    // End of RazorCart IIFE
