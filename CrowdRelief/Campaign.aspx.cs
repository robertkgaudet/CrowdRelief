using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace CrowdRelief
{
	public partial class Campaign : BaseWebForm
	{
		public string surveyId = string.Empty;
		public string campaignId = string.Empty;
		protected void Page_Load(object sender, EventArgs e)
		{
			//Guid userId = new Guid(Membership.GetUser().ProviderUserKey.ToString());
			divAdminPanel.Visible = false;

			string campaignImageFolder = System.Configuration.ConfigurationManager.AppSettings["CampaignImageFolder"].ToString();
			this.Master.ShowNeedsButton = false;
			this.Master.HideTimeControls = true;
			CrowdReliefDBDataContext dc = new CrowdReliefDBDataContext();

			//Make sure there is not already a campaign for this.
			Guid campaignGuid = Guid.Empty;
			Guid surveyGuid = Guid.Empty;
			campaignId = Request.QueryString["campaignId"];
			surveyId = Request.QueryString["surveyId"];

			if (campaignId == "a500724f-d326-4607-91c0-a7709a72cb71")
			{
				Response.Redirect("https://www.crowdrelief.net/Campaign.aspx?campaignId=df12308f-d5da-481a-be92-af707b82e977");
			}


			if (String.IsNullOrEmpty(campaignId) && !String.IsNullOrEmpty(surveyId))
			{
				surveyGuid = new Guid(surveyId);
				campaignGuid = Tools.GetBasicNeedsCampaignId(surveyGuid);
				campaignId = campaignGuid.ToString();
			}

			if (!String.IsNullOrEmpty(campaignId) && String.IsNullOrEmpty(surveyId))
			{
				campaignGuid = new Guid(campaignId);
				surveyGuid = Tools.GetBasicNeedsSurveyIdFromCampaignId(campaignGuid);
				surveyId = surveyGuid.ToString();
			}

			LoadPhotos(surveyGuid);

			var surveyItems = (from si in dc.BasicNeedsSurveyItems
								join i in dc.Items on si.ItemId equals i.ItemId
								join it in dc.ItemTypes on i.ItemTypeId equals it.ItemTypeId
								where si.SurveyId == surveyGuid && i.Name != "Don't Need" && i.Name	!= "No Clothing"
							   orderby it.Name
								select new { Count = si.Count, ItemName = i.Name, BasicSurveyItemId = si.BasicSurveyItemId, Cost = i.Cost, ItemTypeName = it.Name });

			dlItemsNeeded.DataSource = surveyItems;
			dlItemsNeeded.DataBind();

			var campaign = (from c in dc.BasicNeedsCampaigns
						   where c.BasicNeedsCampaignId == campaignGuid
						   select c).SingleOrDefault();

			litCampaignName.Text = campaign.Title;
			lblCampaignDescription.Text = campaign.Description;


			//Get the campaign image.
			var campaignPhoto = (from p in dc.Photos
								join sp in dc.SurveyPhotos on p.PhotoId equals sp.PhotoId
								where sp.SurveyId == surveyGuid && sp.PrimaryCampaignImage == true
								select p).Take(1).SingleOrDefault();

			var profile = (from p in dc.Profiles
						   join s in dc.BasicNeedsSurveys on p.UserId equals s.CreatedBy
						  where s.SurveyId == surveyGuid
						  select p).SingleOrDefault();


			var survey = (from s in dc.BasicNeedsSurveys
							where s.SurveyId == surveyGuid
							select s).SingleOrDefault();


			Page.Title = campaign.Title;
			if (campaignPhoto != null)
			{
				imgCampaignPhoto.ImageUrl = campaignImageFolder + campaignPhoto.Filename;
				SetFacebookMetaTags(campaignPhoto.Filename, pageURL, campaign.Title);
			}
			else
			{
				imgCampaignPhoto.Visible = false;
				divCampaignImageButton.Visible = true;	
				btnAddImage.Visible = true;
				lblAddImage.Visible = true;
			}



			var video = (from v in dc.Videos
							  join sv in dc.SurveyVideos on v.VideoId equals sv.VideoId
							  where sv.SurveyId == surveyGuid
							  select new { v.EmbedCode }).SingleOrDefault();

			divVideoEmbed.Visible = false;
			if (video != null)
			{
				divVideoEmbed.Visible = true;
				litVideoEmbed.Text = video.EmbedCode;
			}

				if (User.Identity.IsAuthenticated)
			{
				if (User.IsInRole("Administrator") || User.IsInRole("Survey") || User.IsInRole("CaseWorker"))
				{
					divAdminPanel.Visible = true;
					hypAddImages.NavigateUrl = "~/Account/BasicNeedsSurveyAddPhotos.aspx?surveyId=" + surveyId;
					hypViewSurvey.NavigateUrl = "~/Account/BasicNeedsSurveyView.aspx?surveyId=" + surveyId;
					hypEmbedVideo.NavigateUrl = "~/Account/BasicNeedsSurveyVideo.aspx?surveyId=" + surveyId;
				}
			}


			var organization = (from o in dc.Organizations
								where o.OrganizationId == survey.OrganizationId
								select o).SingleOrDefault();

			imgOrganization.ImageUrl = "~/Images/Organizations/" + organization.Logo;
			hypOrganization.NavigateUrl = "http://" + organization.YouTubeURL;
			hypOrganization.Text = organization.Name;
			hypImageOrganization.NavigateUrl = "http://" + organization.YouTubeURL;

			decimal? totalNeeded = Tools.GetUnmetCosts(surveyGuid);			// Amount neeeded
			decimal? donatedAmount = Tools.GetDonationAmount(surveyGuid);	// How much has been donated
			decimal? unmetCosts = totalNeeded;

			if (donatedAmount != decimal.Zero)
			{
				litDonatedAmount.Text = "<div style='text-align:center; display:block;'><small>" + String.Format("{0:C0}", donatedAmount) + " has been donated.</small></div>";
				unmetCosts = totalNeeded - donatedAmount;
			}

			decimal gaugePercent = decimal.Zero;
			if (totalNeeded > 0)
			{
				if (donatedAmount > 0)
				{
					decimal donated = Convert.ToInt32(donatedAmount);
					decimal needed = Convert.ToInt32(totalNeeded);
					decimal firstNumber = donated / needed;
					gaugePercent = Math.Round(firstNumber * 100, 0); ;
				}
			}

			litGauge.Text = "<div class=\"GaugeMeter\" data-back=\"#E3E3E3\" data-color=\"#66CC66\" data-label_color=\"#66CC66\" data-size=\"120\" data-width=\"20\" data-animate_gauge_colors=\"0\" data-animate_text_colors=\"1\" data-stripe=\"1\" data-percent=\"" + gaugePercent.ToString() + "\" data-label=\"% Complete\"></div>";

			litTotalNeeded.Text = "<strong> of " + String.Format("{0:C0}", totalNeeded) + "</strong>";
			lblAmountNeeded.Text = String.Format("{0:C0}", unmetCosts);

			hypCreatorName.Text = profile.Firstname + " " + profile.Lastname;
			hypCreatorName.NavigateUrl = "/Campaigns.aspx?giverId=" + profile.UserId.ToString();
			lblLocation.Text = profile.City + ", " + profile.State;

			//spanAlert.Visible = false;
			//if (survey.ImmediateHousingNeeded)
			//{
			//	spanAlert.Visible = true;
			//}

			lblTimeSpan.Text = "Created " + Tools.GetElapsedTime(survey.CreatedOn);

			lblName.Text = "<strong>" + survey.FirstName + "'s open needs</strong>";// + " " + survey.LastName;
			lblAddress.Text = survey.HomeLossAddress;
			lblCity.Text = survey.HomeLossCity;
			lblParish.Text = "(" + survey.HomeLossParishCounty + " Parish)";
			lblState.Text = survey.HomeLossState;
			lblZip.Text = survey.HomeLossZipCode;
			lblSurveyNumber.Text = "Survey number - " + survey.SurveyNumber.ToString();
			lblPhoneNumber.Text = "<a href=\"tel:" + survey.PhoneNumber + "\">" + survey.PhoneNumber + "</a>"; ;
			lblEmailAddress.Text = survey.EmailAddress;
			lblStory.Text = survey.Story;

			if (!String.IsNullOrEmpty(survey.FEMANumber))
			{
				lblFemaNumber.Text = "FEMA Number - " + survey.FEMANumber;
			}

			lblInHomeDuringDisaster.Text = survey.NumberOfPeopleAffected.ToString() + " people were living in this home during the disaster.";
			//lblNumberOfBedrooms.Text = survey.NumberOfBedrooms.ToString() + " bedrooms";
			//lblNumberOfBathrooms.Text = survey.NumberOfBathrooms.ToString() + " bathrooms";
			if (survey.RebuildRepairNeeded)
			{
				lblRebuildRepairNeeded.Text = "Major Rebuild/Repair is needed.";
			}
			if (survey.ImmediateHousingNeeded)
			{
				lblImmediateHousingNeeded.Text = "<span class=\"glyphicon glyphicon-alert\" runat=\"server\" id=\"spanAlert\" data-toggle=\"tooltip\" title=\"Urgent - Immediate Housing Needed!\"></span> <b>Immediate housing is needed.</b>";
			}
			if (survey.SupportAlreadyBeingProvided)
			{
				lblSupportBeingProvided.Text = "Outside support is being provided to this family.";
			}
			else
			{
				lblSupportBeingProvided.Text = "<span class=\"glyphicon glyphicon-alert\" runat=\"server\" id=\"spanAlert\" data-toggle=\"tooltip\" title=\"No support is being provided to this family.\"></span> No outside help or support is being provided to this family.";
			}

		}

		protected void LoadPhotos(Guid surveyId)
		{
			CrowdReliefDBDataContext dc = new CrowdReliefDBDataContext();

			var photos = from p in dc.Photos
						 join sp in dc.SurveyPhotos on p.PhotoId equals sp.PhotoId
						 where sp.SurveyId == surveyId && sp.UseInCampaign == true && sp.Hidden == false
						 select new { p.Filename, p.Title, p.Description, sp.Hidden, sp.UseInCampaign, sp.PrimaryCampaignImage, p.PhotoId };

			if(photos.Count() > 1)
			{
				dlPhotos.DataSource = photos;
				dlPhotos.DataBind();

				dlPhotosfor.DataSource = photos;
				dlPhotosfor.DataBind();

				imgCampaignPhoto.Visible = false;
			}
			else
			{
				divSlidersCarosell.Visible = false;
				divSlidersFor.Visible = false;
				dlPhotos.Visible = false;
				dlPhotosfor.Visible = false;
				imgCampaignPhoto.Visible = true;
			}

			
		}

		protected void dlPhotos_ItemDataBound(object sender, RepeaterItemEventArgs e)
		{
			if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
			{
				string campaignImageFolder = System.Configuration.ConfigurationManager.AppSettings["CampaignImageFolder"].ToString();
				string campaignImageIconWidth = System.Configuration.ConfigurationManager.AppSettings["CampaignImageIconWidth"].ToString();
				string campaignImageDisplayWidth = System.Configuration.ConfigurationManager.AppSettings["CampaignImageDisplayWidth"].ToString();

				RepeaterItem dataItem = (RepeaterItem)e.Item;
				System.Web.UI.WebControls.Image imgPhoto = (System.Web.UI.WebControls.Image)e.Item.FindControl("imgPhoto");
				Label lblTitle = (Label)e.Item.FindControl("lblTitle");
				Label lblDescription = (Label)e.Item.FindControl("lblDescription");

				Guid photoId = (Guid)DataBinder.Eval(dataItem.DataItem, "photoId");
				string filename = (string)DataBinder.Eval(dataItem.DataItem, "Filename");
				string title = (string)DataBinder.Eval(dataItem.DataItem, "Title");
				string description = (string)DataBinder.Eval(dataItem.DataItem, "Description");
				
				imgPhoto.ImageUrl = campaignImageFolder + filename;
				lblTitle.Text = title;
				lblDescription.Text = description;
				//imgPhoto.Width = new Unit(campaignImageIconWidth);
			}
		}


		protected void dlItemsNeeded_ItemDataBound(object sender, DataListItemEventArgs e)
		{
			if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
			{
				DataListItem dataItem = (DataListItem)e.Item;
				Label lblItem = (Label)e.Item.FindControl("lblItem");
				Label lblCost = (Label)e.Item.FindControl("lblCost");
				Literal litCount = (Literal)e.Item.FindControl("litCount"); 
				Button btnDonate = (Button)e.Item.FindControl("btnDonate");
				HtmlGenericControl rowDonate = (HtmlGenericControl)e.Item.FindControl("rowDonate");

				String itemTypeName = (String)DataBinder.Eval(dataItem.DataItem, "ItemTypeName");
				String itemName = (String)DataBinder.Eval(dataItem.DataItem, "ItemName");
				Guid basicSurveyItemId = (Guid)DataBinder.Eval(dataItem.DataItem, "BasicSurveyItemId");
				int itemCount = (int)DataBinder.Eval(dataItem.DataItem, "Count");
				decimal? cost = (decimal?)DataBinder.Eval(dataItem.DataItem, "Cost");

				string individualItemCost = string.Empty;
				string badge = string.Empty;

				CrowdReliefDBDataContext dc = new CrowdReliefDBDataContext();

				//Find out if item has been donated, if so, turn off the button.
				var basicSurveyItem = from bnsi in dc.Donations
									  where bnsi.BasicNeedsSurveyItemId == basicSurveyItemId
									  select bnsi;

				var campaignId = (from c in dc.BasicNeedsCampaigns
								  where c.BasicNeedsSurveyId == new Guid(surveyId)
								  select new { c.BasicNeedsCampaignId }).SingleOrDefault();

				if(basicSurveyItem.Count() > 0)
				{
					//Item was donated.
					rowDonate.Attributes.Add("class", "row donatedRow");
					btnDonate.Enabled = false;
					btnDonate.Text = "Donated!";
					btnDonate.Attributes.Add("class", "btn btn-info btn-xs");
				}
				else
				{
					rowDonate.Attributes.Add("class", "row");
					btnDonate.Attributes.Add("basicSurveyItemId", basicSurveyItemId.ToString());
					btnDonate.Attributes.Add("campaignId", campaignId.ToString());
					btnDonate.Attributes.Add("class", "btn btn-primary btn-xs");
				}

				if (itemCount > 1 || itemTypeName == "Bedroom")
				{
					individualItemCost = " (" + String.Format("{0:C0}", cost) + " each) ";
					badge = " <div class=\"badge\" data-toggle=\"tooltip\" title=\"" + individualItemCost + "\">" + itemCount.ToString() + "</div>";
					cost = cost * itemCount;
				}
				
				lblCost.Text = String.Format("{0:C0}", cost);
				lblItem.Text = itemName + badge;
			}
		}

		protected void btnDonate_Click(object sender, EventArgs e)
		{
			Button btnSent = (Button) sender;
			string basicSurveyItemId = btnSent.Attributes["basicSurveyItemId"];
			Response.Redirect("/Secure/Donate.aspx?campaignId=" + campaignId + "&basicSurveyItemId=" + basicSurveyItemId);
		}
	}
}