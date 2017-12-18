<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="UrgentNeedForHousing.aspx.cs" Inherits="CrowdRelief.Administration_UrgentNeedForHousing" %>
<%@ MasterType VirtualPath="~/MasterPage.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
		<script>
		$(document).ready(function(){
			$('[data-toggle="tooltip"]').tooltip();   
		});
	</script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
	<div class="container">
		<div class="row">
			<div class="col-xs-12">
				<div class="container-fluid">
				<h1>Surveys with a urgent need for housing</h1>
				<asp:DataList OnItemDataBound="dlSurveys_ItemDataBound" ID="dlSurveys" runat="server">
					<ItemTemplate>
						<div style="margin-top:20px;">
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
						</div>
					</ItemTemplate>
				</asp:DataList>
				</div>
			</div>
		</div>
	</div>
</asp:Content>