<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="BasicNeedsSurveyView.aspx.cs" Inherits="CrowdRelief.Account_BasicNeedsSurveyView" %>
<%@ MasterType VirtualPath="~/MasterPage.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
	<script>
		$(document).ready(function(){
			$('[data-toggle="tooltip"]').tooltip();

			$(".btnEdit").click(function () {
				location.href = "/Account/BasicNeedsSurveyEdit.aspx?surveyId=<%=surveyId%>";
			});
			$(".btnCampaign").click(function () {
				location.href = "/Account/BasicNeedsSurveyCampaign.aspx?surveyId=<%=surveyId%>";
			}); 
			$(".btnViewCampaign").click(function () {
				location.href = "/Campaign.aspx?campaignId=<%=campaignId%>";
			});

			

		
		$("#<%=btnAssignCaseManager.ClientID%>").attr("disabled", "disabled");
		$("#<%=btnAssignCaseManager.ClientID%>").bind('click', function (e) {
			e.preventDefault();
		})
		$("#<%=rblCaseManager.ClientID%>").change(
		function () {
			$("#<%=btnAssignCaseManager.ClientID%>").removeAttr('disabled');
			$("#<%=btnAssignCaseManager.ClientID%>").unbind('click')
		});






		});
	</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div class="container-fluid">
  <div class="row content">

    <div class="col-sm-1 col-md-1 col-lg-2">
    </div>
    
    <div class="col-xs-12 col-sm-10 col-md-10 col-lg-8">
		<div class="row">
			<div class="col-sm-12">
				<div class="pull-right" style="margin-left:10px;">
					<asp:Literal ID="litAmountNeeded" runat="server"></asp:Literal>
					<button type="button" class="btn btn-success btnCampaign" runat="server" id="btnCreateCampaign" data-toggle="tooltip" title="Important! Once a campaign is created, this survey will no longer be editable.">Create a Campaign</button>
					<button type="button" class="btn btn-primary btnEdit" runat="server" id="btnHelpNavigation">EDIT</button>
					<button type="button" class="btn btn-link btnViewCampaign" runat="server" id="btnViewCampaign">View Campaign</button>
				</div>
				<asp:Image runat="server" id="imgOrganization" width="100" CssClass="img-responsive pull-left"></asp:Image><h1 class="margin">Basic Needs Dashboard <span class="glyphicon glyphicon-alert" runat="server" id="spanAlert" data-toggle="tooltip" title="Urgent - Immediate Housing Needed!"></span></h1>
				<asp:HyperLink ID="hypOrganization" Target="_blank" runat="server" CssClass="pull-left"></asp:HyperLink>
				
			</div>
		</div>
		<div class="row">
			<div class="col-sm-3">
			  <div class="well">
				<p>
					<asp:Label ID="lblName" runat="server"></asp:Label>
					<br />
					<asp:Label ID="lblSurveyNumber" runat="server"></asp:Label>
					<br />
					<asp:Label ID="lblFemaNumber" runat="server"></asp:Label>
					<br />
					<small><asp:Label ID="lblTimeSpan" runat="server"></asp:Label></small>
				</p>
				<h4>LOSS ADDRESS</h4>
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
			</div>
			<div class="col-sm-3">
				<div class="well">
					<h4>LOSS INFORMATION</h4>
					<p>
						<asp:Label ID="lblImmediateHousingNeeded" runat="server"></asp:Label>
						<br />
						<asp:Label ID="lblRebuildRepairNeeded" runat="server"></asp:Label>
						<br />
						<asp:Label ID="lblSupportBeingProvided" runat="server"></asp:Label>
						<br />
						<br />
						<asp:Label ID="lblInHomeDuringDisaster" runat="server"></asp:Label>
					</p>
				</div>
			</div>
			<div class="col-sm-3">
				<div class="well">
					<h4>BUILDING MATERIALS</h4>
					<p>
						<asp:Label ID="lblNumberOfBedrooms" runat="server"></asp:Label>
						<br />
						<asp:Label ID="lblNumberOfBathrooms" runat="server"></asp:Label>
						
						<asp:DataList ID="dlBuildingMaterials" runat="server">
							<ItemTemplate>
								<%# Container.DataItem.ToString() %>
							</ItemTemplate>
						</asp:DataList>
					</p> 
				</div>
			</div>
			<div class="col-sm-3">
				<div class="well">
					<h4>CASE MANAGER</h4>
					<div id="divCaseManagementSelect" runat="server">
						<asp:RadioButtonList ID="rblCaseManager" runat="server" DataTextField="fullName" DataValueField="userId"></asp:RadioButtonList>
						<asp:Button ID="btnAssignCaseManager" class="btn btn-success btnCampaign" OnClick="btnAssignCaseManager_Click" runat="server" Text="Assign Case Manager" />
					</div>
					<asp:Label ID="lblCaseManager" runat="server"></asp:Label><br />
					<asp:Label ID="lblCaseManagerPhone" runat="server"></asp:Label><br />
					<asp:HyperLink ID="hypCaseManagerEmail" runat="server"></asp:HyperLink><br />
					<asp:HyperLink ID="hypManagePhotos" runat="server"></asp:HyperLink><br />
					<asp:HyperLink ID="hypEmbedVideo" runat="server"></asp:HyperLink><br />
					<asp:HyperLink ID="hypAddCaseNote" runat="server"></asp:HyperLink><br />
					<asp:HyperLink ID="hypCaseNotes" runat="server"></asp:HyperLink><br />
				</div>
			</div>
		</div>
		
      <div class="row">
        <div class="col-sm-12">
			<div class="pull-right" style="margin-left:10px;">
			</div>
            <h2>NEEDED ITEMS</h2>
		</div>
	</div>
      <div class="row">
        <div class="col-sm-3">
          <div class="well">
            <h4>CLOTHING, LINEN & WINDOW TREATMENTS</h4>
            <p>
				<asp:DataList ID="dlClothingLinen" runat="server">
					<ItemTemplate>
						<%# Container.DataItem.ToString() %>
					</ItemTemplate>
				</asp:DataList>
            </p> 
          </div>
        </div>
        <div class="col-sm-3">
          <div class="well">
            <h4>LIVING ROOM/BEDROOM</h4>
            <p>
				<asp:DataList ID="dlLivingRoomBedroom" runat="server">
					<ItemTemplate>
						<%# Container.DataItem.ToString() %>
					</ItemTemplate>
				</asp:DataList>
            </p> 
          </div>
        </div>
        <div class="col-sm-3">
          <div class="well">
            <h4>APPLIANCES</h4>
            <p>
				<asp:DataList ID="dlAppliances" runat="server">
					<ItemTemplate>
						<%# Container.DataItem.ToString() %>
					</ItemTemplate>
				</asp:DataList>
            </p> 
          </div>
        </div>
        <div class="col-sm-3">
          <div class="well">
            <h4>POTS, PANS & DISHES</h4>
            <p>
				<asp:DataList ID="dlPotsAndPans" runat="server">
					<ItemTemplate>
						<%# Container.DataItem.ToString() %>
					</ItemTemplate>
				</asp:DataList>
            </p> 
          </div>
        </div>
      </div>
		
      <div class="row">
        <div class="col-sm-6">
          <div class="well">
            <h4>DESCRIPTION OF NEEDS</h4>
            <p>
				<asp:Label ID="lblDescriptionOfNeeds" runat="server"></asp:Label>
			</p> 
          </div>
        </div>
        <div class="col-sm-6">
          <div class="well">
            <h4>STORY</h4>
            <p>
				<asp:Label ID="lblStory" runat="server"></asp:Label>
            </p> 
          </div>
        </div>
      </div>
    </div>
    <div class="col-sm-1 col-md-1 col-lg-2">
    </div>
  </div>
</div>
</asp:Content>