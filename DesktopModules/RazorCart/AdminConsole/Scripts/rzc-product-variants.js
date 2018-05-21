// DropDown Lists - Conditional Variants
function rcConVariantDDL(objectID) {
    var arrShow = $('#' + objectID).find(':selected').attr('data-con_var');
    var shObjects = arrShow.split("~");
    for (i = 0; i < shObjects.length; i++) {
        $('[id$="rcVariantGroup' + shObjects[i] + '"]').show();
    }

    var arrHide = new Array;
    $('#' + objectID + ' option:not(:selected)').each(function () {
        arrHide.push($(this).attr('data-con_var'));
    })
    for (i = 0; i < arrHide.length; i++) {
        var hiObjects = arrHide[i].split("~");
        for (m = 0; m < hiObjects.length; m++) {
            $('[id$="rcVariantGroup' + hiObjects[m] + '"]').hide();
        }
    }
}

// Radio Buttons - Conditional Variants
function rcConVariantRB(objectName) {
    var arrShow = $('input:radio:checked[name="' + objectName + '"]').attr('data-con_var');
    var shObjects = arrShow.split("~");
    for (i = 0; i < shObjects.length; i++) {
        $('[id$="rcVariantGroup' + shObjects[i] + '"]').show();
    }

    var arrHide = new Array;
    $('input:radio:not(:checked)[name="' + objectName + '"]').each(function () {
        arrHide.push($(this).attr('data-con_var'));
    })
    for (i = 0; i < arrHide.length; i++) {
        var hiObjects = arrHide[i].split("~");
        for (m = 0; m < hiObjects.length; m++) {
            $('[id$="rcVariantGroup' + hiObjects[m] + '"]').hide();
        }
    }
}

// Check Boxes - Conditional Variants
function rcConVariantCB(objectName) {
    var arrShow = new Array;
    $('input:checkbox:checked[name="' + objectName + '"]').each(function () {
        arrShow.push($(this).attr('data-con_var'));
    })
    for (i = 0; i < arrShow.length; i++) {
        var shObjects = arrShow[i].split("~");
        for (m = 0; m < shObjects.length; m++) {
            $('[id$="rcVariantGroup' + shObjects[m] + '"]').show();
        }
    }

    var arrHide = new Array;
    $('input:checkbox:not(:checked)[name="' + objectName + '"]').each(function () {
        arrHide.push($(this).attr('data-con_var'));
    })
    for (i = 0; i < arrHide.length; i++) {
        var hiObjects = arrHide[i].split("~");
        for (m = 0; m < hiObjects.length; m++) {
            $('[id$="rcVariantGroup' + hiObjects[m] + '"]').hide();
        }
    }
}

// Custom Method - Conditional Variants
// rcConVariant("Objects ID's" string, "New Prop Value" bool)
// ex. rcConVariant('1~2~3~4~5~6~7~8', false) :: hide the variant groups 1 to 8
//     rcConVariant('1~2~3~4~5~6~7~8', true)  :: show the variant groups 1 to 8
//function rcConVariant(objectIDs, objectProp) {
//    var objects = objectIDs.split("~");
//    if (objectProp == false) {
//        for (i = 0; i < objects.length; i++) {
//            $('[id$="rcVariantGroup' + objects[i] + '"]').hide();
//        }
//    }
//    else if (objectProp == true) {
//        for (i = 0; i < objects.length; i++) {
//            $('[id$="rcVariantGroup' + objects[i] + '"]').show();
//        }
//    }
//}