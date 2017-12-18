<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="FloodStories.aspx.cs" Inherits="CrowdRelief.Administration_FloodStories" %>
<%@ MasterType VirtualPath="~/MasterPage.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
		<script>
		$(document).ready(function(){
			$('[data-toggle="tooltip"]').tooltip();   
		});
	</script>
	<style>
		.well{
			margin-top:20px;
		}
	</style>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
	<div class="container">
		<div class="row">
			<div class="col-xs-12">
				<div class="container-fluid">
				<h1>Survey Stories and Needs</h1>
				<asp:DataList OnItemDataBound="dlSurveys_ItemDataBound" ID="dlSurveys" runat="server">
					<ItemTemplate>
						<div style="margin-top:20px; margin-bottom:70px;">
							<a href='/Account/BasicNeedsSurveyView.aspx?surveyId=<%# DataBinder.Eval(Container.DataItem, "SurveyId") %>'> <%# DataBinder.Eval(Container.DataItem, "Firstname") %>
							<%# DataBinder.Eval(Container.DataItem, "Lastname") %> - <%# DataBinder.Eval(Container.DataItem, "SurveyNumber") %></a>
							<br />
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
							<div class="well">
								<h3>STORY</h3>
								<asp:Literal ID="litStory" runat="server"></asp:Literal>
							</div>
							<div class="well">
								<h3>NEEDS DESCRIPTION</h3>
								<asp:Literal ID="litHelpNeeded" runat="server"></asp:Literal>
							</div>
						</div>
					</ItemTemplate>
				</asp:DataList>
				</div>
			</div>
		</div>
	</div>
</asp:Content>