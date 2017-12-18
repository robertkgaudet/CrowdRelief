<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Register.aspx.cs" Inherits="CrowdRelief.Register" %>
<%@ MasterType VirtualPath="~/MasterPage.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
	<style>
		.well
		{
			max-width:600px;
		}
	</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    
	<div class="container-fluid" id="divFormFields" runat="server">
		<div class="row">
			<div class="col-xs-12">
				<div class="form-horizontal well center-block login-block">
					<h2>Register <asp:Literal ID="litType" runat="server"></asp:Literal> CrowdRelief</h2>
					Registration is required.
					<div id="divError" runat="server" visible="false" style="color:red; font-weight:bold; font-size:x-small;"><asp:Literal id="litError" runat="server"></asp:Literal> </div>
					 
					<!-- Text input-->
					<div class="form-group">
						<label class="col-md-4 control-label" for="txtFirstname">First Name</label>  
						<div class="col-md-6">
							<asp:TextBox ID="txtFirstName" name="txtFirstName" runat="server" placeholder="" class="form-control input-md" required=""></asp:TextBox>
						</div>
					</div>

					

					<!-- Text input-->
					<div class="form-group">
						<label class="col-md-4 control-label" for="txtFirstname">Last Name</label>  
						<div class="col-md-6">
							<asp:TextBox ID="txtLastName" name="txtLastName" runat="server" placeholder="" class="form-control input-md" required=""></asp:TextBox>
						</div>
					</div>

					
					<!-- Text input-->
					<div class="form-group">
						<label class="col-md-4 control-label" for="txtFirstname">Email Address</label>  
						<div class="col-md-6">
							<asp:TextBox ID="txtEmail" name="txtEmail" runat="server" placeholder="" class="form-control input-md" required=""></asp:TextBox>
						</div>
					</div>

					
					<!-- Text input-->
					<div class="form-group">
						<label class="col-md-4 control-label" for="txtFirstname">Phone Number</label>  
						<div class="col-md-6">
							<asp:TextBox ID="txtPhoneNumber" name="txtPhoneNumber" runat="server" placeholder="(xxx) xxx-xxxx" class="form-control input-md" required=""></asp:TextBox>
						</div>
					</div>
					

					
					<!-- Text input-->
					<div class="form-group">
						<label class="col-md-4 control-label" for="txtFirstname">Street Address</label>  
						<div class="col-md-6">
							<asp:TextBox ID="txtAddress" name="txtAddress" runat="server" placeholder="" class="form-control input-md" required=""></asp:TextBox>
						</div>
					</div>
					

					
					<!-- Text input-->
					<div class="form-group">
						<label class="col-md-4 control-label" for="txtFirstname">City</label>  
						<div class="col-md-6">
							<asp:TextBox ID="txtCity" name="txtCity" runat="server" placeholder="" class="form-control input-md" required=""></asp:TextBox>
						</div>
					</div>

					
					
					<!-- Text input-->
					<div class="form-group">
						<label class="col-md-4 control-label" for="txtFirstname">State (Abbreviation)</label>  
						<div class="col-md-6">
							<asp:TextBox ID="txtState" name="txtState" MaxLength="2" runat="server" placeholder="LA" class="form-control input-md" required=""></asp:TextBox>
						</div>
					</div>
					
					
					
					<!-- Text input-->
					<div class="form-group">
						<label class="col-md-4 control-label" for="txtFirstname">Zip Code</label>  
						<div class="col-md-6">
							<asp:TextBox ID="txtZipCode" name="txtZipCode" MaxLength="5" runat="server" placeholder="xxxxx" class="form-control input-md" required=""></asp:TextBox>
						</div>
					</div>

					
					<!-- Text input-->
					<div class="form-group">
						<label class="col-md-4 control-label" for="txtFirstname">Username</label>  
						<div class="col-md-6">
							<asp:TextBox ID="txtUsername" name="txtUsername" runat="server" placeholder="" class="form-control input-md" required=""></asp:TextBox>
						</div>
					</div>

					
					<!-- Text input-->
					<div class="form-group">
						<label class="col-md-4 control-label" for="txtFirstname">Password</label>  
						<div class="col-md-6">
							<asp:CompareValidator ID="CompareValidator2" runat="server" 
							ControlToValidate="txtPassword"
							ControlToCompare="txtConfirmPassword"
							Display="Dynamic"
							ForeColor="Red"
							ErrorMessage="Passwords do not match."/>
							<asp:TextBox ID="txtPassword" name="txtPassword" runat="server" TextMode="Password" placeholder="" class="form-control input-md" required=""></asp:TextBox>
						</div>
					</div>
					
					<!-- Text input-->
					<div class="form-group">
						<label class="col-md-4 control-label" for="txtFirstname">Confirm Password</label>  
						<div class="col-md-6">
							<asp:TextBox ID="txtConfirmPassword" name="txtConfirmPassword" TextMode="Password" runat="server" placeholder="" class="form-control input-md" required=""></asp:TextBox>
						</div>
					</div>
					
					<!-- Text input-->
					<div class="form-group"> 
						<div class="col-md-6"></div>
						<div class="col-md-6">
							<span style="font-size:14px;">*All registration fields are required.</span>
							<asp:Button ID="btnSubmit" runat="server" Text="Create Account" OnClick="btnSubmit_Click" CssClass="btn btn-primary btn-lg" />
						</div>
					</div>

				</div>
			</div>
		</div>
	</div>
</asp:Content>

