<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UserBadges.ascx.cs" Inherits="DotNetNuke.Professional.Activities.UserBadges" %>

<div class="badge-tooltip-content hidden" data-bind="css: { 'loading-tooltip': loading() }">
    <a href="#" class="tooltip-close-button dnnRight" title="Close" aria-label="Close"></a>
    <!-- ko ifnot: loading -->
    <!-- ko if: error -->
    <span class="dnnLeft" data-bind="text: error"></span>
    <!-- /ko -->
    <!-- ko ifnot: error -->
    <!-- ko with: card -->
    <strong>
        <em data-bind="text: badge().badgeName"></em>
        <label class="how-to-earn"><%= LocalizeString("HowToEarn") %></label>
        <span data-bind="text: badge().description"></span>
    </strong>

    <div class="dnnClear completed-by" data-bind="visible: $root.completedByVisible ">
        <label class="dnnLeft"><%= LocalizeString("CompletedBy") %></label>
        <ul class="dnnLeft">
            <!-- ko foreach: userBadges -->
            <li class="dnnLeft">
                <a data-bind="attr: {href: profileUrl }">
                    <em>
                        <img data-bind="attr: {src: avatarUrl, alt: displayName, title: displayName }" alt="Avatar Image" />
                    </em>
                </a>
            </li>
            <!-- /ko -->
        </ul>
    </div>
    <!-- /ko -->
    <!-- /ko -->
    <!-- /ko -->
</div>

<asp:Panel runat="server" ID="ScopeWrapper" CssClass="dnnClear">
    <!-- ko with: $root.componentFactory.resolve('UserBadgesController') -->
    <ul id="badgeList" class="dnnClear dnnBadgeList">
        <!-- ko foreach: results -->
        <!-- ko if: !$root.isMobileView() -->
        <li data-bind="attachTooltips: true" class="badgeContainer dnnLeft">
            <img class="badgeImage dnnLeft" data-bind="attr: {src: imageUrl }" alt="" onerror="this.onerror = null; this.src = '<%= ResolveClientUrl(DotNetNuke.Mechanics.Components.Common.Constants.DefaultBadgeImage) %>'"  />
            <strong class="dnnLeft">
                <em data-bind="text: badgeName"></em>
                <span data-bind="text: tierName()"></span>
            </strong>
        </li>
        <!-- /ko -->
        <!-- ko if: $root.isMobileView() -->
        <li class="badgeContainer dnnLeft" data-bind="click: loadDetail">
            <img class="badgeImage dnnLeft" data-bind="attr: { src: imageUrl }" alt="" onerror="this.onerror = null; this.src = '<%= ResolveClientUrl(DotNetNuke.Mechanics.Components.Common.Constants.DefaultBadgeImage) %>'"  />
            <strong class="dnnLeft">
                <em data-bind="text: badgeName"></em>
                <span data-bind="text: tierName()"></span>
            </strong>
            <div data-bind="visible: cardMobileLoaded" class="dnnMobileUserBadgeDetail">
                <!-- ko with: cardMobile -->
                <div>
                    <b><%= LocalizeString("HowToEarn") %></b>&nbsp;&nbsp;
                    <span data-bind="text: badge().description"></span>
                </div>

                <div class="dnnClear completed-by" data-bind="visible: completedByVisibleMobile">
                    <ul>
                        <li>
                            <label><%= LocalizeString("CompletedBy") %></label>
                        </li>
                        <!-- ko foreach: userBadges -->
                        <li>
                            <a data-bind="attr: { href: profileUrl }">
                                <em>
                                    <img data-bind="attr: { src: avatarUrl, alt: displayName, title: displayName }" alt=""/>
                                </em>
                            </a>
                        </li>
                        <!-- /ko -->
                    </ul>
                </div>
                <!-- /ko -->
            </div>
        </li>
        <!-- /ko -->
        <!-- /ko -->
    </ul>
    <div class="view-more-badges-container">
        <a href="#" data-bind="style: { display: isMore() ? 'block' : 'none' }, click: getMore" class="dnnPrimaryAction"><%= LocalizeString("ViewMore") %></a>
    </div>
    <!-- /ko -->

</asp:Panel>

<script type='text/javascript'>
    function badgesListInit(settings) {
        try {
            settings.moduleScope = $(settings.moduleScope)[0];
            if (!settings.moduleScope) {
                return;
            }

            var getTooltip = function(element) {
                var $tooltipContent = $(".badge-tooltip-content.hidden").clone().removeClass("hidden");
                var viewModel = new dnn.activities.BadgeCardView($, window.ko, settings, element);
                var badgeId = window.ko.dataFor(element).badgeId();
                viewModel.loadDetails(badgeId);
                window.ko.applyBindings(viewModel, $tooltipContent[0]);
                return $tooltipContent;
            };
            window.ko.bindingHandlers.attachTooltips = {
                init: function(element) {
                    var $element = $(element);
                    $element.tooltip({
                        getTooltipMarkup: getTooltip,
                        closeButtonSelector: ".tooltip-close-button",
                        cssClass: "badge-tooltip",
                        placement: 'top',
                        closeOnMouseLeave: false,
                        singleDisplay: true,
                        container: $element
                    });
                }
            };
            dnn.social.applyBindings(new dnn.activities.UserBadgesView($, window.ko, settings), settings.moduleScope);
        } catch(ex) {
            dnn.social.topLevelExceptionHandler(settings, ex);
        }
    }
</script>
