<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="BasicNeedsSurveyCaseNote.aspx.cs" Inherits="CrowdRelief.Account_BasicNeedsSurveyCaseNote" %>
<%@ MasterType VirtualPath="~/MasterPage.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
	<style>
		.input-group
		{
			max-width:230px;
		}
		.text-datepicker
		{
			font-size:20px;
			min-height:40px;
		}
		.amount-field{
			font-size:20px;
			min-height:40px;
			text-align:right;
			font-weight:bold;
			background-color:#F3F9E4;
			color:#5E7F08;
		}
	</style>
	<script>
		$(function () {
			$("#<%=txtDatePicker.ClientID%>").datepicker();
		});

		function isNumberKey(evt) {
			var charCode = (evt.which) ? evt.which : evt.keyCode;
			if (charCode == 110 || charCode == 190 || charCode == 46)
				return true;

			if (charCode > 31 && (charCode < 48 || charCode > 57))
				return false;

			return true;
		}

	</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
	<div class="container-fluid">
		<div class="row">
			<div class="col-sm-2"></div>
			<div class="col-xs-12 col-sm-8">
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
							<h5>CONTACT INFORMATION</h5>
							<p>
								<asp:Label ID="lblPhoneNumber" runat="server"></asp:Label>
								<br />
								<asp:Label ID="lblEmailAddress" runat="server"></asp:Label>
								<br />
							</p>
						</div>
					</div>
					<div class="col-xs-12 col-sm-8">
						<div class="well">
							<div class="form-group">
								<label class="control-label" for="txtFemaNumber">Current Status*</label>
								<asp:DropDownList ID="ddlBasicNeedsStatus" runat="server" DataTextField="Name" CssClass="form-control" DataValueField="BasicNeedsStatusId"></asp:DropDownList>
								<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="ddlBasicNeedsStatus" ForeColor="Red" ErrorMessage="Please choose!" InitialValue="-- Select --"></asp:RequiredFieldValidator>
							</div>
							
							<div class="form-group has-feedback">
								<label class="control-label">Money Spent</label>
								<div class="input-group">
									<asp:TextBox ID="txtMoneySpent" onkeypress="return isNumberKey(event)" runat="server" class="form-control input-lg amount-field" name="number"></asp:TextBox>
									<span class="input-group-addon"><i class="glyphicon glyphicon-usd"></i></span>
								</div>
							</div>

							<div class="form-group has-feedback">
								<label class="control-label">Follow Up Date</label>
								<div class="input-group">
									<asp:TextBox ID="txtDatePicker" runat="server" class="form-control text-datepicker"></asp:TextBox>
									<span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
								</div>
							</div>

							<div class="form-group has-feedback">
								<label class="control-label">Urgent Need?</label> (Post details in case notes below.)
								<div class="input-group">
									<asp:CheckBox ID="chkUrgentAttentionRequired" runat="server" Text="Immediate Attention" />
								</div>
							</div>
									
							<div class="form-group">
								<label class="control-label" for="txtHouseConditionNote">Case Notes/Follow-up Notes*</label>
								<br />
								Reminder notes for the next visit.
								<asp:TextBox ID="txtFollowUpNote" TextMode="MultiLine" Rows="10" CssClass="form-control" runat="server" required=""></asp:TextBox>
							</div>
							<div class="form-group">
								<label class="control-label" for="txtHouseConditionNote">Home/Living Condition </label>
								<br />
								Please describe their homes current condition AND their current living situation.
								<asp:TextBox ID="txtHouseConditionNote" TextMode="MultiLine" Rows="10" CssClass="form-control" runat="server"></asp:TextBox>
							</div>
							<div class="form-group">
								<label class="control-label" for="txtHouseConditionNote">Human Needs - Clothing, Food and Medical</label>
								<br />
								<ul>
									<li>What did you deliver?</li>
									<li>What unmet needs did you observe?</li>
								</ul>
								<asp:TextBox ID="txtFamilyConditionNote" TextMode="MultiLine" Rows="10" CssClass="form-control" runat="server"></asp:TextBox>
							</div>

							<div class="form-group">
								<asp:Button	 id="btnSubmit" runat="server" name="btnSubmit" OnClick="btnSubmit_Click" Text="Add Case Note" class="btn btn-primary btn-block btn-lg"></asp:Button>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="col-sm-2"></div>
		</div>
	</div>
</asp:Content>