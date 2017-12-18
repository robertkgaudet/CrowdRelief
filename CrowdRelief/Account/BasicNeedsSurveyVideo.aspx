<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" ValidateRequest="false" AutoEventWireup="true" CodeFile="BasicNeedsSurveyVideo.aspx.cs" Inherits="CrowdRelief.Account_BasicNeedsSurveyVideo" %>
<%@ MasterType VirtualPath="~/MasterPage.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
	<div class="container" id="divFormFields" runat="server">
			<div class="row">
				<div class="col-xs-1 col-sm-2"></div>
				<div class="col-xs-10 col-sm-8 bg-5"> 
					<div class="form-horizontal">
						<legend><h1>Embed a Video</h1></legend>
						Enter youtube or facebook embed code that includes the iframe.
						<br /><br />
						<!-- Form -->
						<div id="divPhoto" class="divPhoto" runat="server">
							<div class="col-md-12 well">
								<div class="form-group">
									<asp:TextBox ID="txtVideoEmbedCode" runat="server" CssClass="form-control"></asp:TextBox>
								</div>
							</div>
							<div class="form-group margin pull-right" style="margin-right:40px;">
								<asp:Button ID="btnUpdate" runat="server" CssClass="btn btn-success" Text=" Upload and Finish " CausesValidation="false" CommandName="Finish" OnCommand="btnPost_Click" />
							</div>
						</div>

						<div class="form-group">
							<div class="col-md-4">
								<asp:HyperLink id="btnGoToSurvey" runat="server" Text="Go to Survey" ></asp:HyperLink><br />
								<asp:HyperLink id="btnGoToCampaign" Visible="false" runat="server" Text="Go to Campaign"></asp:HyperLink>
							</div>
						</div>
					</div>
				</div>
				<div class="col-xs-1 col-sm-2"></div>
			</div>
		
			<div class="row">
				<div class="col-xs-1 col-sm-2"></div>
				<div class="col-xs-10 col-sm-8"> 
					<asp:Literal ID="litVideoEmbedCode" runat="server"></asp:Literal>
				</div>
				<div class="col-xs-1 col-sm-2"></div>
			</div>
		</div>
</asp:Content>