<%@ control language="C#" inherits="EasyDNN.Modules.EasyDNNGallery.CrossPortalSharing, App_Web_crossportalsharing.ascx.af09375b" autoeventwireup="true" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Register TagPrefix="dnn" TagName="Audit" Src="~/controls/ModuleAuditControl.ascx" %>

<script type="text/javascript">

	//<![CDATA[
	if ('<%=jQuery%>' == 'jQuery') {
		jQuery.noConflict();
	}
	var edn_all_categories = <%=GetAllPortalsObject()%>;

	var generate_category_list_items = function (selected_categories, items, exclude_id) {
		var all_categories = jQuery.extend(true, {}, items),
			selected_categories_ids,
			category_list = '';

		if (selected_categories) {
			selected_categories_ids = selected_categories.split(',');

			for (i in selected_categories_ids) {
				if (typeof all_categories[selected_categories_ids[i]] == 'object') {
					all_categories[selected_categories_ids[i]].selected = true;
				}
			}
		}

		for (cat in all_categories)
			if (cat != exclude_id)
				category_list += '<li style="margin-left: ' + (all_categories[cat].level * 15) + 'px; list-style: none"><label><input type="checkbox"' + (all_categories[cat].selected ? ' checked="checked"' : '') + ' name="edn_permission_for_category_' + cat + '" value="' + cat + '" /><span>' + all_categories[cat].name + '</span></label></li>'

		return category_list;
	}

	jQuery().ready(function ($) {
		var $permissions_show_all_items = $('.permissions_show_all_items > input'),
			$permissions_show_manual_item_selection = $('.permissions_show_manual_item_selection > input'),
			$permissions_show_no_items = $('.permissions_show_no_items > input'),
			$edn_portal_selection_dialog = $('.portal_selection_dialog'),
			$permission_list_items = $edn_portal_selection_dialog.find('> ul'),
			$permissions_show_selection_dialog = $('a.permissions_show_selection_dialog');

		$edn_portal_selection_dialog
			.dialog({
				autoOpen: false,
				buttons: { '<%=strClose%>': function () { $(this).dialog('close'); } },
				resizable: false,
				width: 'auto'
			});

		$permissions_show_all_items.change(function () {
			var $this = $(this),
				$permissions_manual_item_selection = $this.parent().siblings('.permissions_manual_item_selection');

			$permissions_manual_item_selection
				.hide(200)
				.children('input[type="hidden"]').val('');

			$edn_portal_selection_dialog.dialog('close');
		});

		$permissions_show_manual_item_selection.change(function () {
			var $this = $(this),
				$permissions_manual_item_selection = $this.parent().siblings('.permissions_manual_item_selection');

			$permissions_manual_item_selection.show(200);
			$edn_portal_selection_dialog.dialog('close');
		});

		$permissions_show_no_items.change(function () {
			var $this = $(this),
				$permissions_manual_item_selection = $this.parent().siblings('.permissions_manual_item_selection');

			$permissions_manual_item_selection.find('> input[type="hidden"]').val('');
			$permissions_manual_item_selection.find('> .selected_categories').html('');

			$permissions_manual_item_selection.hide(200);

			$edn_portal_selection_dialog.dialog('close');
		});

		$permissions_show_selection_dialog.click(function () {
			var $clicked = $(this),
				$selected_categories_field = $clicked.parent().siblings('input[type="hidden"]'),
				$selected_categories_text = $clicked.parent().siblings('p.selected_categories'),
				parent_portal_id = parseInt($clicked.parent().parent().siblings('input[type="hidden"]').val());

			$permission_list_items
				.html(generate_category_list_items($selected_categories_field.attr('value'), edn_all_categories, parent_portal_id))
				.find('input[type="checkbox"]')
					.change(function () {
						var $selected_categories = $permission_list_items.find('input[type="checkbox"]:checked'),
							selected_ids = '',
							selected_categories_names = '';

						if ($selected_categories.length) {
							$selected_categories.each(function () {
								var $this = $(this);

								selected_ids += $this.val() + ',';
								selected_categories_names += $this.siblings('span:first').html() + ', ';
							});
							$selected_categories_field.attr('value', selected_ids.substring(0, selected_ids.length - 1));
							$selected_categories_text.html(selected_categories_names.substring(0, selected_categories_names.length - 2));
						} else {
							$selected_categories_field.attr('value', '');
							$selected_categories_text.html('');
						}
					});

			$edn_portal_selection_dialog
				.dialog('open');

			return false;
		});
	});
		//]]>
</script>
<div id="EDGAdminContent">
	<div class="topBarWrapper">
		<div class="wrapper">
			<ul class="links">
				<li>
					<asp:Label ID="lblPortalSharingTopTitle" runat="server" Text="Cross portal sharing" resourcekey="lblPortalSharing"></asp:Label>
				</li>
			</ul>
			<ul class="actions">
				<li class="dashboardBtn">
					<asp:HyperLink ID="hlDasboard" runat="server">Dasboard</asp:HyperLink>
				</li>
				<li class="close">
					<asp:HyperLink ID="hlPowerOff" runat="server" ToolTip="Close" resourcekey="lbPowerOffResource1">Exit</asp:HyperLink>
				</li>
			</ul>
		</div>
	</div>
	<div class="mainContentWrapper">
		<div class="contentSectionWrapper color1">
			<div class="clearfix"></div>
			<div class="listItems">
				<div class="portal_selection_dialog" title="<%=strSelectportals%>">
					<ul>
					</ul>
				</div>
				<asp:GridView ID="gvPortalSharing" runat="server" AutoGenerateColumns="False" GridLines="None" CssClass="listItemsTable" resourcekey="gvPortalSharingResource1" OnRowDataBound="gvPortalSharing_RowDataBound">
					<Columns>
						<asp:TemplateField HeaderText="Portal">
							<ItemTemplate>
								<asp:Label ID="Label1" runat="server" Text='<%# Bind("PortalName") %>' resourcekey="Label1Resource1"></asp:Label>
							</ItemTemplate>
							<HeaderStyle></HeaderStyle>
							<ItemStyle CssClass="textTop"></ItemStyle>
						</asp:TemplateField>
						<asp:TemplateField HeaderText="Shared on portals" HeaderStyle-CssClass="right_side" ItemStyle-CssClass="right_side">
							<ItemTemplate>
								<asp:HiddenField ID="hfPortalID" runat="server" Value='<%# Eval("PortalID") %>' />
								<asp:RadioButton ID="rbPortalsSelect" runat="server" CssClass="permissions_show_manual_item_selection" GroupName="portalsShareSelection" Text="Select portals" resourcekey="rbPortalsSelectResource1" />
								<asp:RadioButton ID="rbPortalsNone" runat="server" Checked='True' CssClass="permissions_show_no_items" GroupName="portalsShareSelection" Text="None" resourcekey="rbPortalsNoneResource1" />
								<asp:Panel runat="server" ID="pnlAddToCatsManualSelection" Style="display: none;" CssClass="permissions_manual_item_selection" resourcekey="pnlAddToCatsManualSelectionResource1">
									<asp:HiddenField ID="hfPortalsToShareTo" runat="server" />
									<p class="itemActions itemEditActions paddingTop">
										<asp:LinkButton ID="lbPortalsToShareTo" runat="server" CssClass="permissions_show_selection_dialog itemEditAdd" Text="Select portals" resourcekey="lbPortalsToShareToResource1" />
									</p>
									<p id="ptagSelectedPortalNames" runat="server" class="selected_categories">
									</p>
								</asp:Panel>
							</ItemTemplate>
							<HeaderStyle CssClass="itemsListheader"></HeaderStyle>
							<ItemStyle></ItemStyle>
						</asp:TemplateField>
					</Columns>
					<RowStyle CssClass="edgrow" />
					<AlternatingRowStyle CssClass="second edgrow" />
				</asp:GridView>
			</div>
			<asp:Label ID="lblPortalSharingMessage" runat="server" Visible="False" resourcekey="lblPortalSharingMessageResource1" CssClass="infoMessages info">Settings saved.</asp:Label>
			<div class="mainActions">
				<asp:LinkButton ID="btnSaveSettings" runat="server" OnClick="btnSaveSettings_Click" Text="Save" resourcekey="btnSaveSettingsResource1" CssClass="downSave" />
				<asp:LinkButton ID="btnSaveClose" runat="server" OnClick="btnSaveClose_Click" Text="Save &amp; Close" resourcekey="btnSaveCloseResource1" CssClass="downSaveClose" />
				<asp:LinkButton ID="btnClose" resourcekey="btnClose" runat="server" Text="Close" OnClick="btnClose_Click" CssClass="downClose" />
			</div>
		</div>
	</div>
</div>
