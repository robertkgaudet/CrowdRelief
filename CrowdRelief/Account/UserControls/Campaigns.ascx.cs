using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

namespace CrowdRelief
{
	public partial class Account_UserControls_Campaigns : System.Web.UI.UserControl
	{
		int gaugeCount = 0;
		Guid organizationIdGuid = Guid.Empty;
		public string gaugeScript = string.Empty;

		protected void Page_Load(object sender, EventArgs e)
		{
			LoadCampaigns();
			LoadOrganizations();
		}

		protected void LoadOrganizations()
		{
			CrowdReliefDBDataContext dc = new CrowdReliefDBDataContext();

			var partnerOrganizations = from o in dc.Organizations
									   join bns in dc.BasicNeedsSurveys on o.OrganizationId equals bns.OrganizationId
									   join bnc in dc.BasicNeedsCampaigns on bns.SurveyId equals bnc.BasicNeedsSurveyId
									   where o.IsActive == true && bnc.Hidden == false
									   orderby bnc.CreatedOn descending
									   select new { o.Logo, o.YouTubeURL, o.OrganizationId };

			dlPartners.DataSource = partnerOrganizations.Distinct();
			dlPartners.DataBind();
		}

		protected void dlPartners_ItemDataBound(object sender, DataListItemEventArgs e)
		{
			DataListItem dataItem = (DataListItem)e.Item;
			Image imgPartners = (Image)e.Item.FindControl("imgPartners");
			HyperLink hypPartners = (HyperLink)e.Item.FindControl("hypPartners");
			String logo = (String)DataBinder.Eval(dataItem.DataItem, "Logo");
			String website = (String)DataBinder.Eval(dataItem.DataItem, "YouTubeURL");
			Guid organizationId = (Guid)DataBinder.Eval(dataItem.DataItem, "OrganizationId");

			imgPartners.ImageUrl = "~/Images/Organizations/" + logo;
			hypPartners.NavigateUrl = "/NonProfitCampaigns.aspx?organizationId=" + organizationId.ToString();
		}
		
		protected void LoadCampaigns()
		{
			string userId = Request.QueryString["userId"];
			string organizationId = Request.QueryString["organizationId"];
			lblCurrentOrganization.Text = "All Organizations";

			CrowdReliefDBDataContext dc = new CrowdReliefDBDataContext();
			if (!String.IsNullOrEmpty(userId))
			{
				//Load a specific users campaigns.
				Guid userIdGuid = new Guid(userId);

				var recentCampaigns = from c in dc.BasicNeedsCampaigns
									  join s in dc.BasicNeedsSurveys on c.BasicNeedsSurveyId equals s.SurveyId
									  join sp in dc.SurveyPhotos on s.SurveyId equals sp.SurveyId
									  join p in dc.Photos on sp.PhotoId equals p.PhotoId
									  where c.Hidden == false && c.CreatedBy == userIdGuid && sp.PrimaryCampaignImage == true
									  orderby c.CreatedOn descending
									  select new { s.SurveyId, CampaignId = c.BasicNeedsCampaignId, campaignTitle = c.Title, campaignDescription = c.Description, s.Story, s.HelpDetails, campaignPhotoFilename = p.Filename, photoDescription = p.Description, photoTitle = p.Title };

				dlCampaigns.DataSource = recentCampaigns;
				dlCampaigns.DataBind();
			}
			else if (!String.IsNullOrEmpty(organizationId))
			{
				Guid organizationIdGuid = new Guid(organizationId);
				var recentCampaigns = from c in dc.BasicNeedsCampaigns
									  join s in dc.BasicNeedsSurveys on c.BasicNeedsSurveyId equals s.SurveyId
									  join sp in dc.SurveyPhotos on s.SurveyId equals sp.SurveyId
									  join p in dc.Photos on sp.PhotoId equals p.PhotoId
									  where c.Hidden == false && s.OrganizationId == organizationIdGuid && sp.PrimaryCampaignImage == true
									  orderby c.CreatedOn descending
									  select new { s.SurveyId, CampaignId = c.BasicNeedsCampaignId, campaignTitle = c.Title, campaignDescription = c.Description, s.Story, s.HelpDetails, campaignPhotoFilename = p.Filename, photoDescription = p.Description, photoTitle = p.Title };

				dlCampaigns.DataSource = recentCampaigns;
				dlCampaigns.DataBind();

				var organization = (from o in dc.Organizations
									where o.OrganizationId == organizationIdGuid
									select o).SingleOrDefault();

				imgOrganization.ImageUrl = "~/Images/Organizations/" + organization.Logo;
				hypOrganization.NavigateUrl = "http://" + organization.YouTubeURL;
				hypOrganization.Text = organization.Name;
				lblCurrentOrganization.Text = organization.Name;
				hypImageOrganization.NavigateUrl = "http://" + organization.YouTubeURL;

				divCampaignInfoPanel.Visible = true;
			}
			else
			{
				var recentCampaigns = from c in dc.BasicNeedsCampaigns
									  join s in dc.BasicNeedsSurveys on c.BasicNeedsSurveyId equals s.SurveyId
									  join sp in dc.SurveyPhotos on s.SurveyId equals sp.SurveyId
									  join p in dc.Photos on sp.PhotoId equals p.PhotoId
									  where c.Hidden == false && sp.PrimaryCampaignImage == true
									  orderby c.CreatedOn descending
									  select new { s.SurveyId, CampaignId = c.BasicNeedsCampaignId, campaignTitle = c.Title, campaignDescription = c.Description, s.Story, s.HelpDetails, campaignPhotoFilename = p.Filename, photoDescription = p.Description, photoTitle = p.Title };

				dlCampaigns.DataSource = recentCampaigns;
				dlCampaigns.DataBind();
			}
		}

		protected void dlCampaigns_ItemDataBound(object sender, RepeaterItemEventArgs e)
		{
			if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
			{
				string campaignImageFolder = System.Configuration.ConfigurationManager.AppSettings["CampaignImageFolder"].ToString();

				RepeaterItem dataItem = (RepeaterItem)e.Item;
				HtmlGenericControl divGridClick = (HtmlGenericControl)e.Item.FindControl("divGridClick");
				HtmlGenericControl divGridItemInner = (HtmlGenericControl)e.Item.FindControl("divGridItemInner");
				HtmlGenericControl divGridItemPhoto = (HtmlGenericControl)e.Item.FindControl("divGridItemPhoto");
				Label lblCampaignDescription = (Label)e.Item.FindControl("lblCampaignDescription");
				Label lblCampaignTitle = (Label)e.Item.FindControl("lblCampaignTitle");
				Label lblCount = (Label)e.Item.FindControl("lblCount");
				Label lblCost = (Label)e.Item.FindControl("lblCost");
				Literal litGaugeSVG = (Literal)e.Item.FindControl("litGaugeSVG");

				//Total count of items and total cost.
				String campaignPhotoFilename = (String)DataBinder.Eval(dataItem.DataItem, "campaignPhotoFilename");
				String campaignDescription = (String)DataBinder.Eval(dataItem.DataItem, "campaignDescription");
				String campaignTitle = (String)DataBinder.Eval(dataItem.DataItem, "campaignTitle");
				Guid surveyId = (Guid)DataBinder.Eval(dataItem.DataItem, "SurveyId");
				Guid campaignId = (Guid)DataBinder.Eval(dataItem.DataItem, "CampaignId");


				divGridItemPhoto.Attributes.Add("style", "background: transparent url(\"" + campaignImageFolder + campaignPhotoFilename + "\") no-repeat center; border-radius:5px; background-size: cover; height:250px; width:100%;");
				divGridClick.Attributes.Add("campaignId", campaignId.ToString());

				lblCampaignDescription.Text = campaignDescription;
				lblCampaignTitle.Text = campaignTitle;
				lblCount.Text = Tools.GetSurveyItemCount(surveyId).ToString() + " items needed";

				decimal gaugePercent = decimal.Zero;
				decimal? donatedAmount = Tools.GetDonationAmount(surveyId); // How much has been donated
				decimal? unmetItemsCosts = Tools.GetUnmetCosts(surveyId); // Amount neeeded
				lblCost.Text = String.Format("{0:C0}", unmetItemsCosts) + " in unmet needs";

				if (unmetItemsCosts > 0)
				{
					if (donatedAmount > 0)
					{
						decimal donated = Convert.ToInt32(donatedAmount);
						decimal needed = Convert.ToInt32(unmetItemsCosts);
						decimal firstNumber = donated / needed;
						gaugePercent = Math.Round(firstNumber * 100, 0); ;
					}
				}

				gaugeCount += 1;

				string gaugeSVG = "<div class=\"GaugeMeter\" style=\"color:white;\" data-color=\"#DA03BE\" data-back=\"#FFFFFF\" data-label_color=\"#DA03BE\" data-size=\"60\" data-width=\"10\" data-animate_gauge_colors=\"0\" data-animate_text_colors=\"0\" data-animate_gauge_colors=\"1\"  data-stripe=\"1\" data-percent=\"" + gaugePercent.ToString() + "\" data-label=\"PERCENT\"></div>";

				litGaugeSVG.Text = gaugeSVG;
			}
		}
	}
}