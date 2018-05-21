// DotNetNuke® - http://www.dnnsoftware.com
//
// Copyright (c) 2002-2016, DNN Corp.
// All rights reserved.

if (typeof dnn === 'undefined' || !dnn ) dnn = {};
if (typeof dnn.wiki === 'undefined') dnn.wiki = {};
    
(function(dnn) {
    'use strict';

    dnn.wiki.ColumnTable = function ColumnTable(settings) {
        var that = this;

        function Row(rowSequence) {
            var row = this;

            this.columns = ko.observableArray([new Column(row, 1)]);

            this.rspacer = {
                click: function () {
                },
                mouseOver: function (rowIndex, e) {
                    if (e.which != 1) {
                        return null;
                    }

                    $.each(that.rows(),
                        function (unused, r) {
                            r.columns.push(new Column(r, rowSequence * (row.columns().length + 1)));
                        });
                }
            };
        }

         function Column(row, sequence) {
            var column = this;

            this.sequence = ko.observable(sequence);

            this.click = function () {
                var indexOf = that.rows().indexOf(row);
                if (indexOf >= 0) {
                    that.rows.splice(indexOf + 1, that.rows().length - indexOf);
                }

                indexOf = row.columns().indexOf(column);

                $.each(that.rows(),
                    function (unused, r) {
                        if (indexOf >= 0) {
                            r.columns.splice(indexOf + 1, r.columns().length - indexOf);
                        }
                    });
            };

            this.mouseOver = function (col, e) {
                if (e.which != 1) {
                    return null;
                }

                var indexOf = row.columns().indexOf(column);
                
                if (indexOf == row.columns().length - 1) {
                    column.click();
                }

                indexOf = that.rows().indexOf(row);
                
                if (indexOf == that.rows().length - 1) {
                    column.click();
                }
            };
        }


        this.rows = ko.observableArray([new Row(1)]);

        this.columnCount = ko.computed(
            function() {
                return that.rows()[0].columns().length;
            });

        this.bspacer = {
            click: function() {
            },
            mouseOver: function (row, e) {
                if (e.which != 1) {
                    return null;
                }

                var r = new Row(that.rows().length + 1);

                var c = that.rows()[0].columns().length - 1;

                for (var i = 0; i < c; ++i) {
                    r.columns.push(new Column(r, that.rows().length * (r.columns().length + 1)));
                }

                that.rows.push(r);
            }
        };

        this.updateControl = function() {
        };
    };
})(window.dnn);
