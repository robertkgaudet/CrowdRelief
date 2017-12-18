<%@ Page Title="" Language="C#" MasterPageFile="~/Account/MasterPages/SecureOrganization.master" AutoEventWireup="true" CodeFile="Rebuilds.aspx.cs" Inherits="Account_Organization_Rebuilds" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContentPlaceHolder" Runat="Server">
	
	<script src="/Scripts/vendor/fooTable/dist/footable.all.min.js"></script>
    <link rel="stylesheet" href="/Scripts/vendor/fooTable/css/footable.core.min.css" />
	<script>
	
		$(document).ready(function () {
			$(function () {

				// Initialize Example 2
				$('#rebuildsTable').footable();
			});
		});
	</script>
	<style>
		.enableRebuildActiveGreen {
			width: 7px;
			height: 7px;
			background: #5CB85C;
			-moz-border-radius: 7px;
			-webkit-border-radius: 7px;
			border-radius: 7px;
			}
		.enableRebuildNoGoRed {
			width: 7px;
			height: 7px;
			background: #D9534F;
			-moz-border-radius: 7px;
			-webkit-border-radius: 7px;
			border-radius: 7px;
			}
		.StatusClassIceBlue {
			width: 7px;
			height: 7px;
			background: #5BC0DE;
			-moz-border-radius: 7px;
			-webkit-border-radius: 7px;
			border-radius: 7px;
			}
		.StatusClassOnDeckYellow {
			width: 7px;
			height: 7px;
			background: #F0AD4E;
			-moz-border-radius: 7px;
			-webkit-border-radius: 7px;
			border-radius: 7px;
			}
		.StatusClassActiveGreen {
			width: 7px;
			height: 7px;
			background: #5CB85C;
			-moz-border-radius: 7px;
			-webkit-border-radius: 7px;
			border-radius: 7px;
			}
		.StatusClassComplete {
			width: 7px;
			height: 7px;
			background: #428BCA;
			-moz-border-radius: 7px;
			-webkit-border-radius: 7px;
			border-radius: 7px;
			}

	</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyContentPlaceHolder1" Runat="Server">
<div id="wrapper">
	<div class="content animate-panel" data-child="hpanel">
		<div class="normalheader ">
			<div class="row">
				<div class="col-md-6">
					<div class="hpanel">
						<div class="panel-body">
							<div class="progress m-t-xs full progress-small">
								<div style="width:<%=progressPercent%>%" aria-valuemax="100" aria-valuemin="0" aria-valuenow="<%=progressPercent%>" role="progressbar" class="progress-bar progress-bar-success">
									<span class="sr-only"><%=progressPercent%>% Complete (success)</span>
								</div>
							</div>
							<a class="small-header-action" href="">
								<div class="clip-header">
									<i class="fa fa-arrow-up"></i>
								</div>
							</a>

							<h2 class="font-light m-b-xs">
								Louisiana Flooding Home Rebuilds, August 2016
							</h2>
							<small>Rebuilding homes in South Louisiana after disasterous floods displaced hundreds of thousands of people.</small>
							<div class="m-t-sm">
								<a href="AddNewRebuild.aspx" class="btn w-xs btn-info">Add Rebuild</a>
							</div>
							<div id="hbreadcrumb" class="pull-right m-t-lg">
								<ol class="hbreadcrumb breadcrumb">
									<li><a href="Default.aspx">Disasters</a></li>
									<li class="active"><span>Louisiana Flooding Home Rebuilds, August 2016</span></li>
								</ol>
							</div>
						</div>
					</div>
				</div>
				<div class="col-md-3">
					<div class="hpanel hbggreen">
						<div class="panel-body">
							<div class="text-center">
								<h3>Progress</h3>
								<p class="text-big font-light">
									<%=progressPercent%>%
								</p>
							</div>
						</div>
					</div>
				</div>
				<div class="col-md-3">
					<div class="hpanel hbgyellow">
						<div class="panel-body">
							<div class="text-center">
								<h3>Volunteers Needed</h3>
								<p class="text-big font-light">
									<asp:Literal ID="litVolunteers" runat="server"></asp:Literal>
								</p>
								<div>
								<small>
									<asp:Literal ID="litVolunteersDifficulty" runat="server"></asp:Literal>
								</small>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="content">
			<div class="hpanel">
				<div class="panel-body">
					To filter, type a term. Statue: hold, clear Stage: icebox, on deck, active, complete
					<input type="text" class="form-control input-sm m-b-md" id="filter" placeholder="Search in table"/>

				
				<asp:Repeater ID="dlRebuildTable" runat="server" OnItemDataBound="dlRebuildTable_ItemDataBound">
					<HeaderTemplate>
						<table id="rebuildsTable" class="footable table table-bordered table-hover" data-page-size="20" data-filter="#filter">
							<thead>
								<tr>
									<th data-toggle="true">Name</th>
									<th data-toggle="true" data-hide="phone,tablet">Age</th>
									<th data-toggle="true" data-hide="phone,tablet">Volunteers Needed</th>
									<th data-toggle="true" data-hide="phone,tablet">Progress %</th>
									<th data-toggle="true" data-hide="phone,tablet">Status</th>
									<th data-toggle="true" data-hide="phone">Address</th>
									<th data-toggle="true">Contact</th>
								</tr>
							</thead>
							<tbody>
					</HeaderTemplate>
					<ItemTemplate>
							<tr>
								<td>
									<a href='Rebuild.aspx?rebuildId=<%# DataBinder.Eval(Container.DataItem, "RebuildId") %>'><%# DataBinder.Eval(Container.DataItem, "Firstname") %> <%# DataBinder.Eval(Container.DataItem, "Lastname") %></a>
								</td>
								<td><%# DataBinder.Eval(Container.DataItem, "Age") %></td>
								<td><asp:Literal ID="litVolunteersNeeded" runat="server"></asp:Literal></td>
								<td><asp:Literal ID="litProgress" runat="server"></asp:Literal></td>
								<td>
									<div>
										<small><%# DataBinder.Eval(Container.DataItem, "OnHold") %></small> <div style="height:15px;" class='pull-left m-r-xs <%# DataBinder.Eval(Container.DataItem, "OnHoldClass") %>'> </div>
									</div>
									<div>
										<small><%# DataBinder.Eval(Container.DataItem, "Status") %></small> <div style="height:15px;" class='pull-left m-r-xs <%# DataBinder.Eval(Container.DataItem, "StatusClass") %>'></div> 
									</div>
								</td>
								<td><%# DataBinder.Eval(Container.DataItem, "Address1") %> <%# DataBinder.Eval(Container.DataItem, "City") %></td>
								<td><asp:HyperLink ID="hypPhone" runat="server"></asp:HyperLink></td>
							</tr>
					</ItemTemplate>
					<FooterTemplate>
							</tbody>
							<tfoot>
								<tr>
									<td colspan="7">
										<ul class="pagination pull-right"></ul>
									</td>
								</tr>
							</tfoot>
						</table>
					</FooterTemplate>
				</asp:Repeater>

                

				</div>
			</div>
		</div>
	</div>
</div>
</asp:Content>

