using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Web.Security;
using CrowdRelief;

public partial class Account_UserControls_PublicHeader : BaseUserControl
{
	protected void Page_Load(object sender, EventArgs e)
	{
		CrowdReliefDBDataContext dc = new CrowdReliefDBDataContext();

		if (Page.User.Identity.IsAuthenticated)
		{
			loginStatusLogin.Visible = false;
			if (Membership.GetUser().ProviderUserKey != null)
			{
				HtmlGenericControl liRebuildAdmin = (HtmlGenericControl)loginView.FindControl("liRebuildAdmin");
				HtmlGenericControl liMyTimesheet = (HtmlGenericControl)loginView.FindControl("liMyTimesheet");
				HtmlGenericControl liMyCases = (HtmlGenericControl)loginView.FindControl("liMyCases");
				HtmlGenericControl liMySurveys = (HtmlGenericControl)loginView.FindControl("liMySurveys");
				HtmlGenericControl liMyCampaigns = (HtmlGenericControl)loginView.FindControl("liMyCampaigns");
				HtmlGenericControl liTotalTime = (HtmlGenericControl)loginView.FindControl("liTotalTime");
				HtmlGenericControl liTotalNeedsCost = (HtmlGenericControl)loginView.FindControl("liTotalNeedsCost");

				if (HttpContext.Current.User.IsInRole("RebuildAdministrator"))
				{

					liRebuildAdmin.Visible = true;
					liTotalTime.Visible = true;
					//Send RebuildAdministrators to the rebuild pages.
					//Response.Redirect("/Account/Organization/Default.aspx");
				}

				if (HttpContext.Current.User.IsInRole("Administrator"))
				{
					HtmlGenericControl liAdmin = (HtmlGenericControl)loginView.FindControl("liAdmin");
					liMyTimesheet.Visible = true;
					liAdmin.Visible = true;
					liMyCases.Visible = true;
					liMySurveys.Visible = true;
					liMyCampaigns.Visible = true;
					liMyTimesheet.Visible = true;
					liTotalTime.Visible = true;
					liTotalNeedsCost.Visible = true;
				}

				if (HttpContext.Current.User.IsInRole("CaseWorker"))
				{
					liMyCases.Visible = true;
					liMySurveys.Visible = true;
					liMyCampaigns.Visible = true;
					liMyTimesheet.Visible = true;
					liTotalTime.Visible = true;
					liTotalNeedsCost.Visible = true;
				}

				//Literal hypMyTimesheet = (Literal)loginView.FindControl("lblFullName");
				//hypMyTimesheet.InnerHtml = String.Format("<b>{0} POINTS</b>", Tools.GetMyTimesheetPoints(id));

				var profile = (from p in dc.Profiles
							   where p.UserId == userId
							   select p).SingleOrDefault();

				if (profile != null)
				{
					if (loginView.LoggedInTemplate != null)
					{
						Literal lblFullName = (Literal)loginView.FindControl("lblFullName");
						lblFullName.Text = profile.Firstname + "'s Account";
						HyperLink hypMyTotalNeedsCost = (HyperLink)loginView.FindControl("hypMyTotalNeedsCost");
						hypMyTotalNeedsCost.Text = String.Format("<b>MY OPEN NEEDS {0:C}</b><br>", Tools.GetMyUnmetCosts());

					}
				}

				if (!String.IsNullOrEmpty(profile.DatesAvailable))
				{
					//User is registered as a volunteer.
					HyperLink hypRegisterAsVolunteer = (HyperLink)loginView.FindControl("hypRegisterAsVolunteer");
					hypRegisterAsVolunteer.NavigateUrl = string.Empty;
					hypRegisterAsVolunteer.Text = "Volunteer Registration Pending";
				}

				//Is this person registered as a volunteer? If so...

				//var registeredAsAVolunteer = from it in dc.InteractionTypes
				//							 join uit in dc.UserInteractionTypes on it.InteractionTypeId equals uit.InteractionTypeId
				//							 where uit.UserId == id && it.Name == "Volunteer"
				//							 select uit;
				//HyperLink hypRegisterAsVolunteer = (HyperLink)loginView.FindControl("hypRegisterAsVolunteer"); 
				//if (registeredAsAVolunteer.Count() > 0)
				//{
				//}
			}
		}
	}
}