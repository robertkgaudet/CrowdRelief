<%@ Page Title="" Language="C#" MasterPageFile="~/Account/MasterPages/SecureOrganization.master" AutoEventWireup="true" CodeFile="RebuildProgressUpdates.aspx.cs" Inherits="Account_Organization_RebuildProgressUpdates" %>

<asp:Content ID="Content1" ContentPlaceholderID="HeadContentPlaceHolder" Runat="Server">
	<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-slider/9.8.0/bootstrap-slider.min.js"></script>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-slider/9.8.0/css/bootstrap-slider.min.css" />
	<script type="text/javascript">
		$(document).ready(function ()
		{

			<%=javascriptSliderCode%>

			function updateRebuildProgressSlider(tickValue, sliderId, survivorId, userId) {
				//sending commentId will cause a delete.

				$.ajax(
				{
					type: "GET",
					url: "/Account/Handlers/RebuildProgressSliderUpdate.ashx",
					data: "tickValue=" + tickValue + "&sliderId=" + sliderId + "&survivorId=" + survivorId + "&userId=" + userId,
					contentType: "text/plain; charset=utf-8",
					dataType: "html",
					success: function (data) {
						if (data != "") {
						}
					},
					error: function (request, status, error) {
						request.statusText + ' - ' + error + ' - ' + status;
					}
				});
			}

		});
	</script>
	<style>
		.slider.slider-horizontal {
			width:100%;
			font-size:smaller;
  }
	</style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceholderID="BodyContentPlaceHolder1" Runat="Server">
<div id="wrapper">
<div class="content animate-panel" data-child="hpanel">
	<div class="content">
			<div class="hpanel">
				<div class="panel-body">
					<div id="hbreadcrumb" class="pull-right m-t-lg">
						<ol class="hbreadcrumb breadcrumb">
							<li><a href="Default.aspx">Disasters</a></li>
							<li><a href="Rebuilds.aspx">Louisiana Flooding Home Rebuilds, August 2016</a></li>
							<li class="active">Mrs Etta Daughdrill</li>
						</ol>
					</div>
					<h2 class="font-light m-b-xs">
						Recovery Updates
					</h2>
					<small>Use the tools on this page to update information about your recovery progress.</small>
				</div>
			</div>
	
			<div class="hpanel">
				<div class="panel-heading">
					Update My Progress
				</div>
				<div class="panel-body">

					<div class="center-block p-l m-md m-b-xl">
						<div class="m-b-lg">
							<h3>Rebuild Progress</h3>
							The progress slider below can help you keep track of where you are in the rebuild process. Track major progress on your home. Update the slider each time you complete a step.
						</div>
						<input id="RebuildProgressSlider" type="text" class="RebuildProgressSlider" />
					</div>
				
					<div class="center-block p-l m-sm m-b-xl">
						<div class="m-b-lg">
							<h3>Overall Progress (Estimate)</h3>
							Estimate where you feel you are in the rebuild process. Update as frequently as you like.
						</div>
						<input id="EstimatedRebuildProgressSlider" type="text" class="EstimatedRebuildProgressSlider" />
					</div>
				
					<div class="m-t-lg pull-right">
						<asp:HyperLink ID="hypRebuildProgressUpdates" CssClass="btn w-xs btn-info" runat="server" Text="Update Complete"></asp:HyperLink>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
</asp:Content>

