<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="BasicNeedsSurveyCampaignPhoto.aspx.cs" Inherits="CrowdRelief.Account_BasicNeedsSurveyCampaignPhoto" %>
<%@ MasterType VirtualPath="~/MasterPage.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
	<div class="container" id="divFormFields" runat="server">
			<div class="row">
				<div class="col-xs-1 col-sm-2"></div>
				<div class="col-xs-10 col-sm-8 bg-5"> 
					<div  class="form-horizontal">
						<fieldset>

							<!-- Form Name -->
							<legend><h1>Add A Photo</h1></legend>
							<small>
								Take the time to compose great photos, they help donors connect to the recipient and will help your campaign raise more money. A photo is required.
							</small>
								<br /><br />
							<!-- Form -->


									<div class="narrowBodyContent">
										<div class="contentBorder">
											<table cellpadding="5">
												<tr>
													<td></td>
													<td>
														<div id="divPhoto" class="divPhoto" runat="server">
															<asp:Label ID="lblMessage" runat="server">5 megabyte maximum file size</asp:Label><br /><br />
															<div id="thumbnail"></div>
															<asp:FileUpload id="FileUploadControl" runat="server" />
															<br />
															<asp:Button ID="Button1" runat="server" CssClass="btn btn-success" Text=" Upload and Add Another " CausesValidation="false" CommandName="AddAnother" OnCommand="btnPost_Click" />
															<asp:Button ID="btnUpdate" runat="server" CssClass="btn btn-success" Text=" Upload and Finish > " CausesValidation="false" CommandName="Finish" OnCommand="btnPost_Click" />
														</div>
													</td>
												</tr>
											</table>
											<table cellpadding="5" runat="server" id="tableForm" visible="false">
												<tr>	
													<td>
														<div style="padding:20px;">
															<asp:Image ID="imgThumbnail" runat="server" />
															<asp:HiddenField ID="hidImageName" runat="server" />
														</div>
													</td>
												</tr>
												<tr>
													<td>
														<div style="padding:10px;">
															Image Name:
															<br />
															<asp:TextBox ID="txtImageName" Width="300" MaxLength="155" runat="server"></asp:TextBox>
														</div>
													</td>
												</tr>
												<tr>
													<td>
														<div style="padding:10px;">
															Description:
															<br />
															<asp:TextBox TextMode="MultiLine" Width="300" Height="200" ID="txtDescription" runat="server"></asp:TextBox>
														</div>
													</td>
												</tr>
												<tr>
													<td align="right">
														<div style="padding:10px;">
															<asp:Button ID="btnCancel" CssClass="btn btn-warning" runat="server" Text="Cancel" OnCommand="btnCancel_Click" />
															<asp:Button ID="btnPost" CssClass="btn btn-success" runat="server" Text="Save Photo" OnCommand="btnPost_Click" />
														</div>
													</td>
												</tr>
											</table>
										</div>
									</div>


							<!-- Button -->
							<div class="form-group">
								<label class="col-md-4 control-label" for="btnSubmit"></label>
								<div class="col-md-4">
								<asp:Button	 id="btnSubmit" runat="server" name="btnSubmit" Text="Add Photo" Visible="false" class="btn btn-primary"></asp:Button>
								</div>
							</div>

						</fieldset>
					</div>
				</div>
				<div class="col-xs-1 col-sm-2"></div>
			</div>
		</div>

		<div class="divRegisterFormOuter">
		</div>
</asp:Content>