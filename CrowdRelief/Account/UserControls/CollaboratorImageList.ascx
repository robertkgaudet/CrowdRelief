<%@ Control Language="C#" AutoEventWireup="true" CodeFile="CollaboratorImageList.ascx.cs" Inherits="Account_UserControls_CollaboratorImageList" %>

<style>	
.post-logo
	{
		width:60px;
		float:left;
	}
</style>
<asp:Repeater ID="rptCollaborators" runat="server">
	<ItemTemplate>
		<a href="OrganizationProfile.aspx?organizationId=<%# DataBinder.Eval(Container.DataItem, "OrganizationId") %>">
			<img alt='<%# DataBinder.Eval(Container.DataItem, "Name") %>' class="post-logo pull-left img-thumbnail" src='/Images/Organizations/<%# DataBinder.Eval(Container.DataItem, "Logo") %>' />
		</a>
	</ItemTemplate>
</asp:Repeater>