using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

namespace CrowdRelief
{
	public partial class Account_BasicNeedsSurveyCaseNote : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{
			this.Master.ShowNeedsButton = false;

			if(!IsPostBack)
			{
				string surveyId = Request["surveyId"];

				if(!String.IsNullOrEmpty(surveyId))
				{ 
					CrowdReliefDBDataContext dc = new CrowdReliefDBDataContext();

					var survey = (from s in dc.BasicNeedsSurveys
								 where s.SurveyId == new Guid(surveyId)
								 select s).SingleOrDefault();

					lblName.Text = survey.FirstName + " " + survey.LastName;
					lblAddress.Text = survey.HomeLossAddress;
					lblCity.Text = survey.HomeLossCity;
					lblParish.Text = survey.HomeLossParishCounty;
					lblState.Text = survey.HomeLossState;
					lblZip.Text = survey.HomeLossZipCode;
					hypSurveyNumber.Text = "Survey number - " + survey.SurveyNumber.ToString();
					hypSurveyNumber.NavigateUrl = "BasicNeedsSurveyView.aspx?surveyId=" + surveyId;
					lblPhoneNumber.Text = "<a href=\"tel:" + survey.PhoneNumber + "\">" + survey.PhoneNumber + "</a>";
					lblEmailAddress.Text = survey.EmailAddress;

					if (!String.IsNullOrEmpty(survey.FEMANumber))
					{
						lblFemaNumber.Text = "FEMA Number - " + survey.FEMANumber;
					}

					var basicNeedsStatus = from bns in dc.BasicNeedsStatus
										   orderby bns.OrderBy
										   select bns;

					ddlBasicNeedsStatus.DataSource = basicNeedsStatus;
					ddlBasicNeedsStatus.DataBind();
					ddlBasicNeedsStatus.Items.Insert(0, new ListItem("-- Select --", "-- Select --"));
				}
			}
		}

		protected void btnSubmit_Click(object sender, EventArgs e)
		{
			BasicNeedsCaseNote basicNeedsCaseNote = new BasicNeedsCaseNote();

			Guid basicNeedsStatusId = new Guid(ddlBasicNeedsStatus.SelectedValue);
			Guid userId = new Guid(Membership.GetUser().ProviderUserKey.ToString());

			Guid surveyGuid = new Guid(Request["surveyId"]);

			basicNeedsCaseNote.BasicNeedsCaseNoteId = Guid.NewGuid();
			basicNeedsCaseNote.BasicNeedsStatusId = basicNeedsStatusId;
			basicNeedsCaseNote.CreatedOn = DateTime.Now;
			if(!string.IsNullOrEmpty(txtFamilyConditionNote.Text))
			{ 
				basicNeedsCaseNote.FamilyConditionNote = txtFamilyConditionNote.Text.Replace(System.Environment.NewLine, "<br>");
			}
			if (!string.IsNullOrEmpty(txtFollowUpNote.Text))
			{
				basicNeedsCaseNote.FollowUpNote = txtFollowUpNote.Text.Replace(System.Environment.NewLine, "<br>");
			}
			if (!string.IsNullOrEmpty(txtHouseConditionNote.Text))
			{
				basicNeedsCaseNote.HouseConditionNote = txtHouseConditionNote.Text.Replace(System.Environment.NewLine, "<br>");
			}
			if (!string.IsNullOrEmpty(txtDatePicker.Text))
			{
				DateTime datePicker = DateTime.Parse(txtDatePicker.Text);
				basicNeedsCaseNote.FollowUpDate = datePicker;
			}

			if (!string.IsNullOrEmpty(txtMoneySpent.Text))
			{
				Decimal moneySpent = Decimal.Parse(txtMoneySpent.Text);
				basicNeedsCaseNote.TotalMoneySpent = moneySpent;
			}
			
			basicNeedsCaseNote.UrgentAttentionNeeded = chkUrgentAttentionRequired.Checked;
			basicNeedsCaseNote.UserId = userId;
			basicNeedsCaseNote.SurveyId = surveyGuid;

			CrowdReliefDBDataContext dc = new CrowdReliefDBDataContext();

			dc.BasicNeedsCaseNotes.InsertOnSubmit(basicNeedsCaseNote);
			dc.SubmitChanges();

			string surveyId = Request["surveyId"];
			Response.Redirect("~/Account/BasicNeedsSurveyCaseNotes.aspx?surveyId=" + surveyId);
		}
	}
}