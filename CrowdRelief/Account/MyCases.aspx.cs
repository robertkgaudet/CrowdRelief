using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.Security;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

namespace CrowdRelief
{
	public partial class Account_MyCases : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{
			this.Master.ShowNeedsButton = false;

			Guid userId = new Guid(Membership.GetUser().ProviderUserKey.ToString());

			CrowdReliefDBDataContext dc = new CrowdReliefDBDataContext();

			var surveys = from s in dc.BasicNeedsSurveys
						  join scw in dc.SurveyCaseWorkers on s.SurveyId equals scw.SurveyId
						  where scw.UserId == userId
						  && s.Hidden == false
						  orderby s.CreatedOn descending
						  select s;

			dlSurveys.DataSource = surveys;
			dlSurveys.DataBind();
		}

		protected void dlSurveys_ItemDataBound(object sender, DataListItemEventArgs e)
		{
			DataListItem dataItem = (DataListItem)e.Item;
			Literal litAddedTimeSpan = (Literal)e.Item.FindControl("litAddedTimeSpan");
			Literal litUpdatedTimeSpan = (Literal)e.Item.FindControl("litUpdatedTimeSpan");
			Literal litCaseWorkers = (Literal)e.Item.FindControl("litCaseWorkers");
			Label lblUnmetBasicNeedsCost = (Label)e.Item.FindControl("lblUnmetBasicNeedsCost");
			Label lblLastNote = (Label)e.Item.FindControl("lblLastNote");
			Label lblNextVisit = (Label)e.Item.FindControl("lblNextVisit");
			Label lblCaseStatus = (Label)e.Item.FindControl("lblCaseStatus");
			HtmlGenericControl spanAlert = (HtmlGenericControl)e.Item.FindControl("spanAlert");

			DateTime createdOn = (DateTime)DataBinder.Eval(dataItem.DataItem, "CreatedOn");
			Guid surveyId = (Guid)DataBinder.Eval(dataItem.DataItem, "SurveyId");
			//Get the case workers.

			string caseWorkersString = string.Empty;

			CrowdReliefDBDataContext dc = new CrowdReliefDBDataContext();
			var caseWorkers = from cw in dc.SurveyCaseWorkers
							  join p in dc.Profiles on cw.UserId equals p.UserId
							  where cw.SurveyId == surveyId
							  select p;

			var caseNotes = (from cn in dc.BasicNeedsCaseNotes
							 join cns in dc.BasicNeedsStatus
							 on cn.BasicNeedsStatusId equals cns.BasicNeedsStatusId
							 orderby cn.CreatedOn descending
							 where cn.SurveyId == surveyId
							 select new { CurrentStatus = cns.Name, cn.FollowUpDate, cn.CreatedOn }).Take(1).SingleOrDefault();

			lblCaseStatus.Text = "No Case Updates</br>";
			if (caseNotes != null)
			{
				lblCaseStatus.Text = "Status: " + caseNotes.CurrentStatus + "</br>";
				lblCaseStatus.Font.Bold = true;

				lblLastNote.Text = "Last work done:" + caseNotes.CreatedOn.ToShortDateString() + "</br>";

				if (caseNotes.FollowUpDate != null)
				{
					lblNextVisit.Text = "Next scheduled visit: " + caseNotes.FollowUpDate.Value.ToShortDateString() + "</br>";
				}

			}


			if (caseWorkers.Count() > 0)
			{
				foreach (var item in caseWorkers)
				{
					caseWorkersString += caseWorkersString + "<strong>Case Managed by: " + item.Firstname + " " + item.Lastname + "</strong><br>";
				}
				litCaseWorkers.Text = caseWorkersString;
			}

			if (DataBinder.Eval(dataItem.DataItem, "UpdateOn") != null)
			{
				DateTime updatedOn = (DateTime)DataBinder.Eval(dataItem.DataItem, "UpdateOn");
				string updatedTimeSpan = string.Empty;
				if (updatedOn != null)
				{
					updatedTimeSpan = CrowdRelief.Tools.GetElapsedTime(updatedOn);
				}
				litUpdatedTimeSpan.Text = "Updated " + updatedTimeSpan;
			}

			bool immediateHousingNeeded = (bool)DataBinder.Eval(dataItem.DataItem, "ImmediateHousingNeeded");

			spanAlert.Visible = false;
			if (immediateHousingNeeded)
			{
				spanAlert.Visible = true;
			}



			lblUnmetBasicNeedsCost.Text = String.Format("OPEN NEEDS {0:C}", Tools.GetUnmetCosts(surveyId));
			litAddedTimeSpan.Text = "Added " + CrowdRelief.Tools.GetElapsedTime(createdOn);
		}
	}
}