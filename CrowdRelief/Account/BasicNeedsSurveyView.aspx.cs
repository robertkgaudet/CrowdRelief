using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CrowdRelief
{
	public partial class Account_BasicNeedsSurveyView : System.Web.UI.Page
	{
		public string surveyId = string.Empty;
		public string campaignId = string.Empty;
		protected void Page_Load(object sender, EventArgs e)
		{
			surveyId = Request.QueryString["surveyId"];
			this.Master.ShowNeedsButton = false;
			this.Master.HideTimeControls = true;
			if (!IsPostBack)
			{

				if (!string.IsNullOrEmpty(surveyId))
				{
					btnCreateCampaign.Visible = false;
					divCaseManagementSelect.Visible = false;
					hypAddCaseNote.Visible = false;
					if (User.IsInRole("Administrator"))
					{
						hypAddCaseNote.Visible = true;
						divCaseManagementSelect.Visible = true;
						btnCreateCampaign.Visible = true;
					}
					if(User.IsInRole("CaseWorker"))
					{
						hypAddCaseNote.Visible = true;
					}

					Guid surveyGuid = new Guid(surveyId);

					Guid campaignGuid = Tools.GetBasicNeedsCampaignId(surveyGuid);

					btnViewCampaign.Visible = false;

					if (campaignGuid != Guid.Empty)
					{
						//hide the create campaign and edit button
						//Add a view campaign button.

						campaignId = campaignGuid.ToString();

						btnViewCampaign.Visible = true;
						btnCreateCampaign.Visible = false;
						btnHelpNavigation.Visible = false;
					}

					litAmountNeeded.Text = String.Format("OPEN NEEDS {0:C}", Tools.GetUnmetCosts(new Guid(surveyId)));

					CrowdReliefDBDataContext dc = new CrowdReliefDBDataContext();

					var survey = (from s in dc.BasicNeedsSurveys
								  where s.SurveyId == surveyGuid
								  select s).SingleOrDefault();

					spanAlert.Visible = false;
					if (survey.ImmediateHousingNeeded)
					{
						spanAlert.Visible = true;
					}

					lblTimeSpan.Text = "Added " + Tools.GetElapsedTime(survey.CreatedOn);

					var organization = (from o in dc.Organizations
									   where o.OrganizationId == survey.OrganizationId
									   select o).SingleOrDefault();

					imgOrganization.ImageUrl = "~/Images/Organizations/" + organization.Logo;
					hypOrganization.NavigateUrl = "http://" + organization.YouTubeURL;
					hypOrganization.Text = organization.Name;

					lblName.Text = survey.FirstName + " " + survey.LastName;
					lblAddress.Text = survey.HomeLossAddress;
					lblCity.Text = survey.HomeLossCity;
					lblParish.Text = survey.HomeLossParishCounty;
					lblState.Text = survey.HomeLossState;
					lblZip.Text = survey.HomeLossZipCode;
					lblSurveyNumber.Text = "Survey number - " + survey.SurveyNumber.ToString();
					lblPhoneNumber.Text = "<a href=\"tel:" + survey.PhoneNumber + "\">" + survey.PhoneNumber + "</a>";
					lblEmailAddress.Text = survey.EmailAddress;
					lblDescriptionOfNeeds.Text = survey.HelpDetails;
					lblStory.Text = survey.Story;

					if (!String.IsNullOrEmpty(survey.FEMANumber))
					{
						lblFemaNumber.Text = "FEMA Number - " + survey.FEMANumber;
					}

					lblInHomeDuringDisaster.Text = survey.NumberOfPeopleAffected.ToString() + " people were living in this home during the disaster.";
					lblNumberOfBedrooms.Text = survey.NumberOfBedrooms.ToString() + " bedrooms";
					lblNumberOfBathrooms.Text = survey.NumberOfBathrooms.ToString() + " bathrooms";
					if (survey.RebuildRepairNeeded)
					{
						lblRebuildRepairNeeded.Text = "<br /> Major Rebuild/Repair is needed.";
					}
					if (survey.ImmediateHousingNeeded)
					{
						lblImmediateHousingNeeded.Text = "<b>Immediate housing is needed.</b> <span class=\"glyphicon glyphicon-alert\" runat=\"server\" id=\"spanAlert\" data-toggle=\"tooltip\" title=\"Urgent - Immediate Housing Needed!\"></span>";
					}
					if (survey.SupportAlreadyBeingProvided)
					{
						lblSupportBeingProvided.Text = "<br /> Outside support is being provided to this family.";
					}
					else
					{
						lblSupportBeingProvided.Text = "<br /> No outside help or support is being provided to this family. <span class=\"glyphicon glyphicon-alert\" runat=\"server\" id=\"spanAlert\" data-toggle=\"tooltip\" title=\"No support is being provided to this family.\"></span>";
					}

					var surveyItems = (from si in dc.BasicNeedsSurveyItems
									   join i in dc.Items on si.ItemId equals i.ItemId
									   join it in dc.ItemTypes on i.ItemTypeId equals it.ItemTypeId
									   where si.SurveyId == surveyGuid && i.Name != "Don't Need"
									   orderby it.Name
									   select new { Count = si.Count, ItemName = i.Name, Cost = i.Cost, ItemTypeName = it.Name });

					List<String> appliancesList				= new List<string>();
					List<String> dishesAndUtensilsList		= new List<string>();
					List<String> livingRoomBedroomList		= new List<string>();
					List<String> buildingMaterialsList		= new List<string>();
					List<String> clothingLinenList			= new List<string>();

					foreach (var item in surveyItems)
					{
						string itemCount = string.Empty;

						if (item.Count > 1 || item.ItemTypeName == "Bedroom")
						{
							itemCount = " <span class=\"badge\">" + item.Count + "</span>";
						}

						if (item.ItemTypeName == "Appliance")
						{
							appliancesList.Add(item.ItemName + itemCount);
						}
						if (item.ItemTypeName == "Dishes and Utensils")
						{
							dishesAndUtensilsList.Add(item.ItemName + itemCount);
						}
						if (item.ItemTypeName == "Bedroom" || item.ItemTypeName == "Furniture")
						{
							livingRoomBedroomList.Add(item.ItemName + itemCount);
						}
						if (item.ItemTypeName == "Building Materials")
						{
							buildingMaterialsList.Add(item.ItemName + itemCount);
						}
						if (item.ItemTypeName == "Linen" || item.ItemTypeName == "Clothing" || item.ItemTypeName == "Window Treatments")
						{
							clothingLinenList.Add(item.ItemName + itemCount);
						}
					}

					dlAppliances.DataSource = appliancesList;
					dlAppliances.DataBind();

					dlPotsAndPans.DataSource = dishesAndUtensilsList;
					dlPotsAndPans.DataBind();

					dlLivingRoomBedroom.DataSource = livingRoomBedroomList;
					dlLivingRoomBedroom.DataBind();

					dlBuildingMaterials.DataSource = buildingMaterialsList;
					dlBuildingMaterials.DataBind();

					dlClothingLinen.DataSource = clothingLinenList;
					dlClothingLinen.DataBind();

					dlPotsAndPans.DataSource = dishesAndUtensilsList;
					dlPotsAndPans.DataBind();

					//Load Case Management List
					var caseWorkers = from p in dc.Profiles
									  join op in dc.UserOrganizations on p.UserId equals op.UserId
									  join uir in dc.aspnet_UsersInRoles on p.UserId equals uir.UserId
									  join r in dc.aspnet_Roles on uir.RoleId equals r.RoleId
									  where op.OrganizationId == survey.OrganizationId
									  && r.LoweredRoleName == "caseworker"
									  select new { fullName = p.Firstname + " " + p.Lastname, p.UserId };

					rblCaseManager.DataSource = caseWorkers;
					rblCaseManager.DataBind();


					hypCaseNotes.Visible = false;
					var caseWorker = (from p in dc.Profiles
									  join m in dc.aspnet_Memberships on p.UserId equals m.UserId
									  join cw in dc.SurveyCaseWorkers on p.UserId equals cw.UserId
									  where cw.SurveyId == surveyGuid
									  && cw.IsPrimary == true
									  select new { p.Firstname, p.Lastname, p.PhoneNumber, m.Email }).SingleOrDefault();
					if (caseWorker != null)
					{
						rblCaseManager.Visible = false;
						divCaseManagementSelect.Visible = false;
						lblCaseManager.Text = caseWorker.Firstname + " " + caseWorker.Lastname + "<br>";
						lblCaseManagerPhone.Text = "<a href=\"tel:" + caseWorker.PhoneNumber + "\">" + caseWorker.PhoneNumber + "</a>";
						hypCaseManagerEmail.Text = caseWorker.Email;
						hypCaseManagerEmail.NavigateUrl = "mailto:" + caseWorker.Email;
					}

					hypCaseNotes.Visible = true;
					hypCaseNotes.Text = "View/Manage Case Notes";
					hypCaseNotes.NavigateUrl = "~/Account/BasicNeedsSurveyCaseNotes.aspx?surveyId=" + surveyId;

					hypAddCaseNote.Text = "New Case Note";
					hypAddCaseNote.NavigateUrl = "~/Account/BasicNeedsSurveyCaseNote.aspx?surveyId=" + surveyId;

					hypManagePhotos.Text = "Add/Manage Photos";
					hypManagePhotos.NavigateUrl = "~/Account/BasicNeedsSurveyAddPhotos.aspx?surveyId=" + surveyId;

					hypEmbedVideo.Text = "Embed Video";
					hypEmbedVideo.NavigateUrl = "~/Account/BasicNeedsSurveyVideo.aspx?surveyId=" + surveyId;

				}
			}
		}

		protected void btnAssignCaseManager_Click(object sender, EventArgs e)
		{
			string surveyId = Request["surveyId"];

			Guid surveyIdGuid = new Guid(surveyId);

			CrowdReliefDBDataContext dc = new CrowdReliefDBDataContext();

			Guid surveyCaseWorkerId = Guid.NewGuid();
			SurveyCaseWorker surveyCaseWorker = new SurveyCaseWorker();
			surveyCaseWorker.IsPrimary = true;
			surveyCaseWorker.SurveyCaseWorkerId = surveyCaseWorkerId;
			surveyCaseWorker.SurveyId = surveyIdGuid;
			surveyCaseWorker.UserId = new Guid(rblCaseManager.SelectedValue);
			dc.SurveyCaseWorkers.InsertOnSubmit(surveyCaseWorker);
			dc.SubmitChanges();

			rblCaseManager.Visible = false;
			divCaseManagementSelect.Visible = false;
			lblCaseManager.Text = rblCaseManager.SelectedItem.Text;
		}

		protected void UpdateRadioItems(string selectedItemValue, CrowdReliefDBDataContext dc, Guid basicNeedsSurveyId)
		{
			if (!string.IsNullOrEmpty(selectedItemValue))
			{
				//Update the db.
			}
		}
	}
}