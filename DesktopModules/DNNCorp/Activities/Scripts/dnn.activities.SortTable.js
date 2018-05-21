// DotNetNuke® - http://www.dnnsoftware.com
// Copyright (c) 2002-2016, DNN Corp.
// by DNN Corporation
// All Rights Reserved

if (typeof dnn === 'undefined' || !dnn) dnn = {};
if (typeof dnn.activities === 'undefined') dnn.activities = {};

(function (dnn) {
    'use strict';
    dnn.activities.SortTable = function SortTable($, table, collection, sortfn) {
        var that = this;

        this.table = table;
        this.collection = collection;
        this.columns = [];
        this.ascending = false;
        this.column = null;
        this.isInitColumns = false;

        this.initColumns = function() {
            this.columns = [];
            $.each(table.tHead.children[0].children,
                function (index, element) {
                    if (element.children.length === 0) {
                        return null;
                    }

                    var link = element.children[0];
                    if (link.hash && link.id) {
                        that.columns.push({
                            columnName: link.hash.substr(1),
                            id: link.id
                        });
                    }

                    return null;
                });
        };

        this.ensureInitColumns = function() {
            if (!that.isInitColumns) {
                that.initColumns();
                that.isInitColumns = true;
            }
        };

        this.updateColumns = function () {
            that.ensureInitColumns();
            $.each(that.columns,
                function (index, c) {
                    $("#" + c.id).removeClass().addClass(that.getColumnClass(c.columnName));
                });
        };
        
        this.sort = function (caller, evt) {
            var clickedColumn = evt.currentTarget.hash.substring(1);

            if (that.column === clickedColumn) {
                that.ascending = !that.ascending;
            }
            else {
                that.ascending = true;
            }

            that.column = clickedColumn;

            if (sortfn != null) {
                that.collection.sort(
                    function (a, b) {
                        return sortfn(that.column, that.ascending, a, b);
                    });
            }

            that.updateColumns();
        };

        this.manualSort = function () {
            switch (arguments.length) {
                case 0:
                    break;
                case 2:
                    this.ascending = arguments[1];
                case 1:
                    this.column = arguments[0];
                    break;
            }

            that.collection.sort(
                function (a, b) {
                    return sortfn(that.column, that.ascending, a, b);
                });

            that.updateColumns();
        };

        this.getColumnClass = function (columnName) {
            if (columnName === that.column) {
                return (that.ascending) ? 'asc' : 'desc';
            }
            return '';
        };
    };
})(window.dnn);