using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

namespace CrowdRelief
{ 
	public partial class Account_BasicNeedsSurveyCaseNotes : System.Web.UI.Page
	{
		public string surveyId = string.Empty;
		protected void Page_Load(object sender, EventArgs e)
		{
			this.Master.ShowNeedsButton = false;

			if (!IsPostBack)
			{
				string surveyId = Request["surveyId"];

				if (!String.IsNullOrEmpty(surveyId))
				{
					hypAddCaseNotes.Visible = false;
					if (User.IsInRole("Administrator"))
					{
						hypAddCaseNotes.Visible = true;
					}
					if (User.IsInRole("CaseWorker"))
					{
						hypAddCaseNotes.Visible = true;
					}

					CrowdReliefDBDataContext dc = new CrowdReliefDBDataContext();

					var survey = (from s in dc.BasicNeedsSurveys
								  where s.SurveyId == new Guid(surveyId)
								  select s).SingleOrDefault();

					var organization = (from o in dc.Organizations
										where o.OrganizationId == survey.OrganizationId
										select o).SingleOrDefault();

					imgOrganization.ImageUrl = "~/Images/Organizations/" + organization.Logo;

					hypCaseNotes.Visible = false;
					var caseWorker = (from p in dc.Profiles
									  join m in dc.aspnet_Memberships on p.UserId equals m.UserId
									  join cw in dc.SurveyCaseWorkers on p.UserId equals cw.UserId
									  where cw.SurveyId == new Guid(surveyId)
									  && cw.IsPrimary == true
									  select new { p.Firstname, p.Lastname, p.PhoneNumber, m.Email }).SingleOrDefault();
					if (caseWorker != null)
					{
						lblCaseManager.Text = caseWorker.Firstname + " " + caseWorker.Lastname + "<br>";
						lblCaseManagerPhone.Text = "<a href=\"tel:" + caseWorker.PhoneNumber + "\">" + caseWorker.PhoneNumber + "</a>";
						hypCaseManagerEmail.Text = caseWorker.Email;
						hypCaseManagerEmail.NavigateUrl = "mailto:" + caseWorker.Email;
					}

					lblName.Text = survey.FirstName + " " + survey.LastName;
					lblAddress.Text = survey.HomeLossAddress;
					lblCity.Text = survey.HomeLossCity;
					lblParish.Text = survey.HomeLossParishCounty;
					lblState.Text = survey.HomeLossState;
					lblZip.Text = survey.HomeLossZipCode;
					hypSurveyNumber.Text = "Survey number - " + survey.SurveyNumber.ToString();
					hypSurveyNumber.NavigateUrl = "BasicNeedsSurveyView.aspx?surveyId=" + surveyId;
					hypAddCaseNotes.NavigateUrl = "BasicNeedsSurveyCaseNote.aspx?surveyId=" + surveyId;
					lblPhoneNumber.Text = "<a href=\"tel:" + survey.PhoneNumber + "\">" + survey.PhoneNumber + "</a>";
					lblEmailAddress.Text = survey.EmailAddress;

					if (!String.IsNullOrEmpty(survey.FEMANumber))
					{
						lblFemaNumber.Text = "FEMA Number - " + survey.FEMANumber;
					}

					var basicNeedsStatus = from bns in dc.BasicNeedsStatus
										   orderby bns.OrderBy
										   select bns;

					var basicNeedsCaseNotes = from bncs in dc.BasicNeedsCaseNotes
											  join bns in dc.BasicNeedsStatus
											  on bncs.BasicNeedsStatusId equals bns.BasicNeedsStatusId
											  where bncs.SurveyId == new Guid(surveyId)
											  orderby bncs.CreatedOn descending
											  select new { bncs.CreatedOn, bncs.FamilyConditionNote, bncs.FollowUpDate, bncs.FollowUpNote, bncs.HouseConditionNote, bncs.TotalMoneySpent, bncs.UrgentAttentionNeeded, basicNeedsStatus = bns.Name };

					dlCaseNotes.DataSource = basicNeedsCaseNotes;
					dlCaseNotes.DataBind();

				}
			}
		}

		protected void dlCaseNotes_ItemDataBound(object sender, DataListItemEventArgs e)
		{
			DataListItem dataItem = (DataListItem)e.Item;
			Literal litCaseStatus = (Literal)e.Item.FindControl("litCaseStatus");
			Label lblUrgent = (Label)e.Item.FindControl("lblUrgent");
			Label lblCaseNotes = (Label)e.Item.FindControl("lblCaseNotes");
			Label lblHomeCondition = (Label)e.Item.FindControl("lblHomeCondition");
			Label lblClothing = (Label)e.Item.FindControl("lblClothing"); 
			Label lblFollowUpdateDate = (Label)e.Item.FindControl("lblFollowUpdateDate"); 
			Label lblDateAdded = (Label)e.Item.FindControl("lblDateAdded");
			Label lblMoneySpent = (Label)e.Item.FindControl("lblMoneySpent");
			HtmlGenericControl spanAlert = (HtmlGenericControl)e.Item.FindControl("spanAlert");

			DateTime createdOn = (DateTime)DataBinder.Eval(dataItem.DataItem, "CreatedOn");
			String houseConditionNote = (String)DataBinder.Eval(dataItem.DataItem, "HouseConditionNote");
			String familyConditionNote = (String)DataBinder.Eval(dataItem.DataItem, "FamilyConditionNote");
			String followUpNote = (String)DataBinder.Eval(dataItem.DataItem, "FollowUpNote");
			if (DataBinder.Eval(dataItem.DataItem, "FollowUpDate") != null)
			{
				DateTime followUpDate = (DateTime)DataBinder.Eval(dataItem.DataItem, "FollowUpDate");
				if (followUpDate != null)
				{
					lblFollowUpdateDate.Text = "Next follow-up scheduled for " + followUpDate.ToLongDateString() + "</br>";
				}
				else
				{
					lblFollowUpdateDate.Text = "No follow-up scheduled.";
				}
			}

			if(DataBinder.Eval(dataItem.DataItem, "TotalMoneySpent") != null)
			{ 
				Decimal totalMoneySpent = (Decimal)DataBinder.Eval(dataItem.DataItem, "TotalMoneySpent");

				if (totalMoneySpent != null && totalMoneySpent > 0)
				{
					lblMoneySpent.Text = String.Format("<br>Money Spent: ${0:C}", totalMoneySpent.ToString());
				}
			}

			bool urgentAttentionNeeded = (bool)DataBinder.Eval(dataItem.DataItem, "UrgentAttentionNeeded");
			String basicNeedsStatus = (String)DataBinder.Eval(dataItem.DataItem, "basicNeedsStatus");

			litCaseStatus.Text = "Status: " + basicNeedsStatus;
			lblCaseNotes.Text = followUpNote;
			lblHomeCondition.Text = houseConditionNote;
			lblClothing.Text = familyConditionNote;
			lblDateAdded.Text = "Date Added: " +  Tools.GetElapsedTime(createdOn);


			spanAlert.Visible = false;
			if (urgentAttentionNeeded)
			{
				lblUrgent.Text = "Urgent attention needed, see case worker.</br>";
				spanAlert.Visible = true;
			}
		}
	}
}