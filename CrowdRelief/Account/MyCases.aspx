<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="MyCases.aspx.cs" Inherits="CrowdRelief.Account_MyCases" %>
<%@ MasterType VirtualPath="~/MasterPage.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
	<script>
		$(document).ready(function(){
			$('[data-toggle="tooltip"]').tooltip();   
		});
	</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
	<div class="container">
		<div class="row">
			<div class="col-xs-2"></div>
			<div class="col-xs-8">
				<div class="container-fluid">
				<h1>My Cases</h1>
				<asp:DataList OnItemDataBound="dlSurveys_ItemDataBound" ID="dlSurveys" runat="server">
					<ItemTemplate>
						<div style="margin-top:20px;" class="well">
							<a href='/Account/BasicNeedsSurveyView.aspx?surveyId=<%# DataBinder.Eval(Container.DataItem, "SurveyId") %>'> <%# DataBinder.Eval(Container.DataItem, "Firstname") %>
							<%# DataBinder.Eval(Container.DataItem, "Lastname") %> - <%# DataBinder.Eval(Container.DataItem, "SurveyNumber") %></a>
							<br />
							<asp:Label ID="lblCaseStatus" runat="server"></asp:Label>
							<asp:Label ID="lblNextVisit" runat="server"></asp:Label>
							<asp:Label ID="lblLastNote" runat="server"></asp:Label>
							<asp:Label ID="lblUnmetBasicNeedsCost" runat="server"></asp:Label>
							<br />
							<%# DataBinder.Eval(Container.DataItem, "HomeLossAddress") %>
							<%# DataBinder.Eval(Container.DataItem, "HomeLossCity") %>
							<%# DataBinder.Eval(Container.DataItem, "HomeLossParishCounty") %>
							<%# DataBinder.Eval(Container.DataItem, "HomeLossState") %>
							<%# DataBinder.Eval(Container.DataItem, "HomeLossZipCode") %>
							<span class="glyphicon glyphicon-alert" runat="server" id="spanAlert" data-toggle="tooltip" title="Urgent - Immediate Housing Needed!"></span>
							<br />
							<small><asp:Literal ID="litAddedTimeSpan" runat="server"></asp:Literal> <asp:Literal ID="litUpdatedTimeSpan" runat="server"></asp:Literal></small>
							<p>
								<asp:Literal ID="litCaseWorkers" runat="server"></asp:Literal>
							</p>
						</div>
					</ItemTemplate>
				</asp:DataList>
				</div>
			</div>
			<div class="col-xs-2"></div>
		</div>
	</div>
</asp:Content>