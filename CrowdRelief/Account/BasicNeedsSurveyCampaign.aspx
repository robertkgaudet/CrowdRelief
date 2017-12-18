<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="BasicNeedsSurveyCampaign.aspx.cs" Inherits="CrowdRelief.Account_BasicNeedsSurveyCampaign" %>
<%@ MasterType VirtualPath="~/MasterPage.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

	
				<div class="container help-1" id="divFormFields" runat="server">
					<div class="row">
						<div class="col-xs-1 col-sm-2"></div>
						<div class="col-xs-10 col-sm-8 bg-5"> 
							<div class="form-horizontal input-group input-group-lg">
								<!-- Form Name -->
								<legend><h1>Create a Campaign</h1></legend>
								<small>
									Create a campaign to raise funds to help this individual. Once a campaign is started, the person's needs can no longer be edited.
								</small>
									<br /><br />
										<table>
											<tr>
												<td>
													<b>Title</b> <span class="glyphicon glyphicon-info-sign" data-toggle="tooltip" title="EXAMPLE: Help Mrs Etta Recover From the 2016 Louisiana Flood"></span>
												</td>
											</tr>
											<tr>
												<td>	 
													<asp:TextBox ID="txtTitle" name="txtTitle" runat="server" placeholder="Create a Title for this Campaign" class="form-control input-md" required=""></asp:TextBox>
												</td>
											</tr>
											<tr>
												<td><br /><br />
													<b>Campaign Description</b>
													Why should people give to help meet this flood victims needs?
													<br /><br />
												</td>
											</tr>
											<tr>
												<td>
													<asp:TextBox ID="txtDescription" class="form-control" runat="server" TextMode="MultiLine" Rows="10" required=""></asp:TextBox>
												</td>
											</tr>
											<tr>
												<td>
												<!-- Button -->
												</td>
											</tr>
										</table>
								<br /><br />
								<label class="col-md-4 control-label" for="btnSubmit"></label>
								<div class="col-md-4">
								<asp:Button	 id="btnSubmit" runat="server" name="btnSubmit" OnClick="btnSubmit_Click" Text="Create Campaign" class="btn btn-primary"></asp:Button>
								</div>
							</div>
						</div>
						<div class="col-xs-1 col-sm-2"></div>
					</div>
				</div>

				<div class="divRegisterFormOuter">
				</div>

</asp:Content>

