<%@ Page Title="" Language="C#" MasterPageFile="~/Account/MasterPages/SecureOrganization.master" AutoEventWireup="true" CodeFile="ReliefStream.aspx.cs" Inherits="Account_Organization_ReliefStream" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContentPlaceHolder" Runat="Server">
	<script src="/Scripts/vendor/jquery-ui/jquery-ui.min.js"></script>
	<script src="/Scripts/vendor/iCheck/icheck.min.js"></script>
	<script src="/Scripts/vendor/chartjs/Chart.min.js"></script>
	<script src="/Scripts/vendor/sparkline/index.js"></script>
	<script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDQTpXj82d8UpCi97wzo_nKXL7nYrd4G70"></script>
	<style>
		
		.post-logo
		{
			width:50px;
			float:left;
		}
	</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyContentPlaceHolder1" Runat="Server">
<div id="wrapper">
	<div class="content animate-panel" data-child="hpanel">
		<div class="content">
			<div class="row">
				<div class="hpanel col-sm-1 col-md-1 col-lg-3"></div>
				<div class="hpanel col-xs-12 col-sm-10 col-md-9 col-lg-5">

					<div class="hpanel">
						<div class="panel-body">

							<h2 class="font-light m-b-xs">
								Rebuild Feed
							</h2>
							<small>Latest Information from the Rebuild Community.</small>
						</div>
					</div>

					<div class="panel-body no-padding">
						<div class="chat-discussion" style="height: auto">
							<asp:Repeater ID="rptPosts" runat="server">
								<ItemTemplate>
									<div class="chat-message">
										<img class="post-logo" src='<%# DataBinder.Eval(Container.DataItem, "Logo") %>'>
										<div class="message">
											<a class="message-author" href='/Account/User/Profile.aspx?id=<%# DataBinder.Eval(Container.DataItem, "ProfileId") %>'> <%# DataBinder.Eval(Container.DataItem, "fullname") %> </a>
											<span class="message-date"> <%# DataBinder.Eval(Container.DataItem, "createdon", "{0:M/d/yyyy HH:mm:ss}") %> </span>
											<span class="message-content">
											<%# DataBinder.Eval(Container.DataItem, "Post") %>
											</span>
										</div>
									</div>
								</ItemTemplate>
							</asp:Repeater>
						</div>
					</div>
				</div>
				<div class="hpanel col-sm-1 col-md-2 col-lg-4"></div>
			</div>
		</div>
	</div>
</div>
</asp:Content>