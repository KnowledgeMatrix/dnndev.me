<%@ Control Language="C#" AutoEventWireup="false" CodeBehind="BlogList.ascx.cs" Inherits="DotNetNuke.Professional.Blogs.BlogList" %>
<asp:Panel runat="server" ID="ScopeWrapper">
<div class="blogRoster dnnClear">
    <div class="loading-container">
    <!-- ko with: $root.componentFactory.resolve('ListController') -->
        <ul class="tagCollections">
            <!-- ko foreach: results -->
            <li>
                <a data-bind="attr: { href: blogUrl }, text: rosterText, css: {'blog-selected': selected() }"></a>
                <!-- ko if: syndicated -->
                <a data-bind="attr: { href: syndicationUrl }" class="blog-social-rss"  title="<%= LocalizeString("RssIcon") %>"></a>
                <!-- /ko -->
            </li>
         <!-- /ko -->
        </ul>
    <!-- /ko -->
    </div>
    <asp:Label runat="server" ID="lblNoBlogs"></asp:Label>
    <div class="dnnRight">
        <!-- ko if: $root.pager().totalPages() > 1 -->
        <div class="dnnPagingButtons dnnRight">
            <a href="javascript:void(0)" data-bind="click: prev, attr: { 'class': 'pager-prev ' + prevClass() }"></a>
            <a href="javascript:void(0)" data-bind="click: next, attr: { 'class': 'pager-next ' + nextClass() }"></a>
        </div>
        <!-- /ko -->
    </div>
    <div class="dnnRight">
        <ul class="pager-ul" data-bind="html: pagingControl"></ul>
    </div>
</div>
</asp:Panel>
<script type='text/javascript'>
    dnn.social.loading('<%= ScopeWrapper.ClientID %>');
    function blogRosterListInit(settings) {
        settings.moduleScope = $(settings.moduleScope)[0];
        if (!settings.moduleScope) {
            return;
        }

        try {
            window.dnn.social.applyBindings(new window.dnn.blogs.roster.ListView(settings), settings.moduleScope);
        } catch (ex) {
            window.dnn.social.topLevelExceptionHandler(settings, ex);
        }
    }

</script>