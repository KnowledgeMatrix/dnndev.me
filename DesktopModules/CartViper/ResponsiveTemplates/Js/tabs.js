jQuery(document).ready(function () {

    //When page loads...
    jQuery(".tab_content").hide(); //Hide all content
    equalHeight(jQuery("ul.tabs li"));


    //check to see if we have a tab selected already
    var tab = location.hash;
    if (tab != '' && tab.indexOf('#V') == 0) {
        DisplayTab(jQuery("a[href='#" + tab.substring(2) + "']").parent());

        if (jQuery('#Form').attr('action').indexOf('#V') == -1) {
            jQuery('#Form').attr('action', jQuery('#Form').attr('action') + tab);
        }

    } else {
        jQuery("ul.tabs li:first").addClass("active").show(); //Activate first tab
        jQuery(".tab_content:first").show(); //Show first tab content
    }

    //On Click Event
    jQuery("ul.tabs li").click(function () {
        DisplayTab(this);
        location.hash = 'V' + jQuery(this).find("a").attr("href").substring(1);

        var action = jQuery('#Form').attr('action');
        if (action.indexOf('#V') > -1) {
            action = action.substring(0, action.indexOf('#V'));
        }

        jQuery('#Form').attr('action', action + '#V' + jQuery(this).find("a").attr("href").substring(1));

        return false;
    });

});

function DisplayTab(selectedTab) {
    jQuery("ul.tabs li").removeClass("active"); //Remove any "active" class
    jQuery(selectedTab).addClass("active"); //Add "active" class to selected tab
    jQuery(".tab_content").hide(); //Hide all tab content

    var activeTab = jQuery(selectedTab).find("a").attr("href"); //Find the href attribute value to identify the active tab + content
    jQuery(activeTab).fadeIn(); //Fade in the active ID content
}

function equalHeight(group) {
    var tallest = 0;
    group.each(function () {
        var thisHeight = jQuery(this).height();
        if (thisHeight > tallest) {
            tallest = thisHeight;
        }
    });
    group.height(tallest);
}