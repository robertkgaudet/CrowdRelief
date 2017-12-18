using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace CrowdRelief
{
	public partial class _Default : System.Web.UI.Page
	{
		int gaugeCount = 0;
		public string gaugeScript = string.Empty;
		protected void Page_Load(object sender, EventArgs e)
		{
			//LoadCampaigns();
			this.Master.ShowNeedsButton = false;
			this.Master.HideTimeControls = true;
		}

		protected void LoadCampaigns()
		{
			//CrowdReliefDBDataContext dc = new CrowdReliefDBDataContext();
			//var recentCampaigns = from c in dc.BasicNeedsCampaigns
			//					  join s in dc.BasicNeedsSurveys on c.BasicNeedsSurveyId equals s.SurveyId
			//					  join sp in dc.SurveyPhotos on s.SurveyId equals sp.SurveyId
			//					  join p in dc.Photos on sp.PhotoId equals p.PhotoId
			//					  where c.Hidden == false && sp.PrimaryCampaignImage == true
			//					  orderby c.CreatedOn descending
			//					  select new { s.SurveyId, CampaignId = c.BasicNeedsCampaignId, campaignTitle = c.Title, campaignDescription = c.Description, s.Story, s.HelpDetails, campaignPhotoFilename = p.Filename, photoDescription = p.Description, photoTitle = p.Title };


			//dlCampaigns.DataSource = recentCampaigns;
			//dlCampaigns.DataBind();
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
				Literal litGaugeSVG = (Literal)e.Item.FindControl("litGaugeSVG");
				Label lblCost = (Label)e.Item.FindControl("lblCost");

				//Total count of items and total cost.
				String campaignPhotoFilename = (String)DataBinder.Eval(dataItem.DataItem, "campaignPhotoFilename");
				String campaignDescription = (String)DataBinder.Eval(dataItem.DataItem, "campaignDescription");
				String campaignTitle = (String)DataBinder.Eval(dataItem.DataItem, "campaignTitle");
				Guid surveyId = (Guid)DataBinder.Eval(dataItem.DataItem, "SurveyId");
				Guid campaignId = (Guid)DataBinder.Eval(dataItem.DataItem, "CampaignId");

				decimal? unmetItemsCosts = Tools.GetUnmetCosts(surveyId);

				divGridItemPhoto.Attributes.Add("style", "background: transparent url(\"" + campaignImageFolder + campaignPhotoFilename + "\") no-repeat center; border-radius:5px; background-size: cover; height:250px; width:100%;");
				divGridClick.Attributes.Add("campaignId", campaignId.ToString());

				lblCampaignDescription.Text = campaignDescription;
				lblCampaignTitle.Text = campaignTitle;
				lblCount.Text = Tools.GetSurveyItemCount(surveyId).ToString() + " items needed";
				lblCost.Text = String.Format("{0:C0}", unmetItemsCosts) + " in unmet needs";

				decimal gaugePercent = decimal.Zero;
				decimal? donatedAmount = Tools.GetDonationAmount(surveyId);
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

				string gaugeSVG = "<div class=\"GaugeMeter\" data-color=\"#00FF00\" data-back=\"#99CC99\" data-label_color=\"#00FF00\" data-size=\"60\" data-width=\"10\" data-animate_gauge_colors=\"0\" data-animate_text_colors=\"0\" data-animate_gauge_colors=\"1\"  data-stripe=\"1\" data-percent=\"" + gaugePercent.ToString() + "\" data-label=\"PERCENT\"></div>";

				//string gaugeSVG = "<svg id=\"fillgauge" + gaugeCount + "\" width=\"80%\" height=\"90\"></svg>";
				litGaugeSVG.Text = gaugeSVG;



				//gaugeScript += "var gauge" + gaugeCount + " = loadLiquidFillGauge(\"fillgauge" + gaugeCount + "\", " + gaugePercent.ToString() + ", gaugeConfig);\r\n";
			}
		}
		
	}
}