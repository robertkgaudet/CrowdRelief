using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

namespace CrowdRelief
{
	public partial class Account_BasicNeedsSurveyCampaign : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{
			this.Master.ShowNeedsButton = false;
			this.Master.HideTimeControls = true;
		}

		protected void btnSubmit_Click(object sender, EventArgs e)
		{
			Guid userId = new Guid(Membership.GetUser().ProviderUserKey.ToString());
			Guid surveyId = new Guid(Request.QueryString["surveyId"].ToString());

			BasicNeedsCampaign basicNeedsCampaign = new BasicNeedsCampaign();

			basicNeedsCampaign.BasicNeedsCampaignId = Guid.NewGuid();
			basicNeedsCampaign.BasicNeedsSurveyId = surveyId;
			basicNeedsCampaign.CreatedBy = userId;
			basicNeedsCampaign.CreatedOn = DateTime.Now;
			basicNeedsCampaign.Description = txtDescription.Text.Replace(System.Environment.NewLine, "<br>");
			basicNeedsCampaign.Hidden = false;
			basicNeedsCampaign.Title = txtTitle.Text;

			CrowdReliefDBDataContext dc = new CrowdReliefDBDataContext();
			dc.BasicNeedsCampaigns.InsertOnSubmit(basicNeedsCampaign);
			dc.SubmitChanges();

			//Go to the add photo page.

			Response.Redirect("/Account/BasicNeedsSurveyAddPhotos.aspx?surveyId=" + surveyId.ToString());

		}
	}
}