<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="BasicNeedsSurveyCaseNotes.aspx.cs" Inherits="CrowdRelief.Account_BasicNeedsSurveyCaseNotes" %>
<%@ MasterType VirtualPath="~/MasterPage.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
	<div class="container-fluid">
		<div class="row">
			<div class="col-sm-2"></div>
			<div class="col-xs-12 col-sm-8">
				<asp:Image runat="server" id="imgOrganization" width="100" CssClass="img-responsive pull-left"></asp:Image><h1 class="margin">Case Management Notes</h1>
				<div class="row">
					<div class="col-xs-12 col-sm-4">
						<div class="well">
							<p>
								<b>Client Information</b>
							</p>
							<p>
								<asp:Label ID="lblName" runat="server" Font-Bold="true"></asp:Label>
								<br />
								<asp:HyperLink ID="hypSurveyNumber" runat="server"></asp:HyperLink>
								<br />
								<asp:Label ID="lblFemaNumber" runat="server"></asp:Label>
								<br />
								<small><asp:Label ID="lblTimeSpan" runat="server"></asp:Label></small>
							</p>
							<h5>LOSS ADDRESS</h5>
							<p>
								<asp:Label ID="lblAddress" runat="server"></asp:Label>
								<br />
								<asp:Label ID="lblCity" runat="server"></asp:Label>,
								<asp:Label ID="lblState" runat="server"></asp:Label>
								<asp:Label ID="lblZip" runat="server"></asp:Label>
								<br />
								<asp:Label ID="lblParish" runat="server"></asp:Label>
								<br /><br />
							</p>
							<div style="visibility:hidden">
								<h5>CONTACT INFORMATION</h5>
								<p>
									<asp:Label ID="lblPhoneNumber" runat="server"></asp:Label>
									<br />
									<asp:Label ID="lblEmailAddress" runat="server"></asp:Label>
									<br />
								</p>
							</div>
						</div>
						<div class="well">
							<p>
								<b>Case Manager</b>
							</p>
							<p>
								<asp:Label ID="lblCaseManager" runat="server"></asp:Label>
								<asp:Label ID="lblCaseManagerPhone" runat="server"></asp:Label><br />
								<asp:HyperLink ID="hypCaseManagerEmail" runat="server"></asp:HyperLink><br />
								<asp:HyperLink ID="hypCaseNotes" runat="server"></asp:HyperLink><br />
								<asp:HyperLink ID="hypAddCaseNotes" runat="server" Text="New Case Note"></asp:HyperLink>
							</p>
						</div>
					</div>
					<div class="col-xs-12 col-sm-8">
						<asp:DataList ID="dlCaseNotes" runat="server" OnItemDataBound="dlCaseNotes_ItemDataBound">
							<ItemTemplate>
								<div class="well">
									<h3> <asp:Literal ID="litCaseStatus" runat="server"></asp:Literal> </h3>
									<div class="margin">
										<small>
										<asp:Label ID="lblDateAdded" runat="server"></asp:Label>	
										<asp:Label ID="lblMoneySpent" runat="server"></asp:Label>
										</small>
									</div>
									<div class="panel panel-danger margin">
										<div class="panel-heading">ACTION REQUIRED</div>
										<div class="panel-body">
										<strong>
											<asp:Label ID="lblFollowUpdateDate" runat="server"></asp:Label>
											<span class="glyphicon glyphicon-alert" runat="server" id="spanAlert" data-toggle="tooltip" title="Urgent - Immediate Attention Needed!"></span>
											<asp:Label ID="lblUrgent" runat="server"></asp:Label>
										</strong>
										</div>
									</div>
									<div class="panel panel-info">
										<div class="panel-heading">Case Notes/Follow-Up Notes</div>
										<div class="panel-body">
											<asp:Label ID="lblCaseNotes" runat="server"></asp:Label>
										</div>
									</div>
									<div class="panel panel-info">
										<div class="panel-heading">Home/Living Condition</div>
										<div class="panel-body">
											<asp:Label ID="lblHomeCondition" runat="server"></asp:Label>
										</div>
									</div>
									<div class="panel panel-info">
										<div class="panel-heading">Needs - Clothing, Food and Medical</div>
										<div class="panel-body">
											<asp:Label ID="lblClothing" runat="server"></asp:Label>
										</div>
									</div>
								</div>
							</ItemTemplate>
						</asp:DataList>
					</div>
				</div>
			</div>
			<div class="col-sm-2"></div>
		</div>
	</div>
</asp:Content>

