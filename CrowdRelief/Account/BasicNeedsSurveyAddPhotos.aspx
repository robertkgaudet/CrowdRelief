<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="BasicNeedsSurveyAddPhotos.aspx.cs" Inherits="CrowdRelief.Account_BasicNeedsSurveyAddPhotos" %>
<%@ MasterType VirtualPath="~/MasterPage.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
	<div class="container" id="divFormFields" runat="server">
			<div class="row">
				<div class="col-xs-1 col-sm-2"></div>
				<div class="col-xs-10 col-sm-8 bg-5"> 
					<div class="form-horizontal">
						<legend><h1>Manage Photos</h1></legend>
						Take the time to compose great photos, they help donors connect to the recipient and will help your campaign raise more money.
						<br /><br />
						<!-- Form -->
						<div id="divPhoto" class="divPhoto" runat="server">
							<div class="col-md-12 well">
								<div class="form-group">
									<label class="col-md-3 control-label pull-left">Browse System*</label>
									<div class="col-md-8">
										<asp:FileUpload id="FileUploadControl" runat="server" /><small>5 megabyte maximum file size</small>
									</div>
								</div>
								<div class="form-group">
									<label class="col-md-3 control-label pull-left">Image Title*</label>
									<div class="col-md-8">
										<asp:TextBox ID="txtImageName" runat="server" CssClass="form-control" required=""></asp:TextBox>
									</div>
								</div>
								<br />
									<label class="col-md-3 control-label pull-left">Description*</label>
									<div class="col-md-8">
										<asp:TextBox ID="txtDescription" TextMode="MultiLine" runat="server" Rows="3" CssClass="form-control" required=""></asp:TextBox>
									</div>
							</div>
							<div class="form-group margin pull-right" style="margin-right:40px;">
								<asp:Button ID="Button1" runat="server" CssClass="btn btn-success" Text=" Upload and Add Another " CausesValidation="false" CommandName="AddAnother" OnCommand="btnPost_Click" />
								<asp:Button ID="btnUpdate" runat="server" CssClass="btn btn-success" Text=" Upload and Finish " CausesValidation="false" CommandName="Finish" OnCommand="btnPost_Click" />
							</div>
						</div>

						<div class="form-group">
							<label class="col-md-4 control-label" for="btnSubmit"></label>
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
					<asp:DataList ID="dlPhotos" runat="server" RepeatLayout="Flow" RepeatDirection="Horizontal" OnItemDataBound="dlPhotos_ItemDataBound">
						<ItemTemplate>
							<div class="well col-md-4" style="height:600px;">
								<div class="thumbnail">
									<asp:HyperLink runat="server" ID="hypPhoto" target="_blank">
										<asp:Image ID="imgPhoto" runat="server" CssClass="img-responsive" />
										<div class="caption">
											<strong><asp:Label ID="lblTitle" runat="server"></asp:Label></strong>
											<p><asp:Label ID="lblDescription" runat="server"></asp:Label> </p>
										</div>
									</asp:HyperLink>
								</div>
								<div class="well col-md-12">
									<p><strong>Manage Image</strong></p>
									<p>
										<asp:HyperLink ID="hypCampaign" runat="server" CssClass="small">
											<asp:Literal ID="litCampaign" runat="server"></asp:Literal>
										</asp:HyperLink>
									</p>
									<p>
										<asp:HyperLink ID="hypPrimary" runat="server" CssClass="small">
											<asp:Literal ID="litPrimary" runat="server"></asp:Literal>
										</asp:HyperLink>
									</p>
									<p>
										<asp:HyperLink ID="hypHidden" runat="server" CssClass="small">
											<asp:Literal ID="litHidden" runat="server"></asp:Literal>
										</asp:HyperLink>
									</p>
								</div>
							</div>
						</ItemTemplate>
					</asp:DataList>
				</div>
				<div class="col-xs-1 col-sm-2"></div>
			</div>
		</div>
</asp:Content>