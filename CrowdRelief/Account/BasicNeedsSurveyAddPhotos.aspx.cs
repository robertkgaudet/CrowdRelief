using System;
using System.Web.UI.WebControls;
using System.IO;
using System.Web.Security;
using System.Linq;
using System.Web.UI;
using System.Drawing;
using System.Drawing.Imaging;

namespace CrowdRelief
{ 
	public partial class Account_BasicNeedsSurveyAddPhotos : BaseWebForm
	{
		protected void Page_Load(object sender, EventArgs e)
		{
			CrowdReliefDBDataContext dc = new CrowdReliefDBDataContext();
			Guid surveyId = new Guid(Request.QueryString["surveyId"].ToString());
			btnGoToSurvey.NavigateUrl = "~/Account/BasicNeedsSurveyView.aspx?surveyId=" + surveyId;

			var campaign = (from c in dc.BasicNeedsCampaigns
						   where c.BasicNeedsSurveyId == surveyId
						   select c).SingleOrDefault();

			if(campaign != null)
			{
				btnGoToCampaign.NavigateUrl = "~/Campaign.aspx?campaignId=" + campaign.BasicNeedsCampaignId;
				btnGoToCampaign.Visible = true;
			}


			this.Master.ShowNeedsButton = false;
			this.Master.HideTimeControls = true;

			if(Request.QueryString["photoId"] != null)
			{
				string action = Request.QueryString["action"];
				bool newValue = false;
				if (Request.QueryString["newValue"] != null)
				{
					newValue = Convert.ToBoolean(Request.QueryString["newValue"]);
				}
				Guid photoId = new Guid(Request.QueryString["photoId"]);

				var photo = (from sp in dc.SurveyPhotos
							 where sp.PhotoId == photoId
							 select sp).SingleOrDefault();
							

				switch (action)
				{
					case "hidden":
						{
							if (newValue)
							{
								//Change to visible
								photo.Hidden = false;
								dc.SubmitChanges();
							}
							else
							{
								//Change to hidden
								photo.Hidden = true;
								dc.SubmitChanges();
							}
						}
						break;
					case "campaign":
						{
							if (newValue)
							{
								//Show on campaign
								photo.UseInCampaign = true;
								dc.SubmitChanges();
							}
							else
							{
								//Remove from campaign
								photo.UseInCampaign = false;
								dc.SubmitChanges();
							}
						}
						break;
					case "primary":
						{
							//Change to primary remove primary from all other values.

							//Remove all other primary flags

							CrowdReliefDBDataContext dc2 = new CrowdReliefDBDataContext();
							var photos = from sp in dc2.SurveyPhotos
											where sp.SurveyId == surveyId
											select sp;

							foreach(var item in photos)
							{
								item.PrimaryCampaignImage = false;
								dc2.SubmitChanges();
							}

							photo.PrimaryCampaignImage = true;
							dc.SubmitChanges();
						}
						break;

				}

				Response.Redirect("/Account/BasicNeedsSurveyAddPhotos.aspx?surveyId=" + surveyId);
			}

			LoadPhotos(surveyId);
		}

		protected void btnPost_Click(object sender, CommandEventArgs e)
		{
			string campaignImageFolder = System.Configuration.ConfigurationManager.AppSettings["CampaignImageFolder"].ToString();
			string campaignImageIconWidth = System.Configuration.ConfigurationManager.AppSettings["CampaignImageIconWidth"].ToString();
			string campaignImageDisplayWidth = System.Configuration.ConfigurationManager.AppSettings["CampaignImageDisplayWidth"].ToString();

			Guid surveyId = new Guid(Request.QueryString["surveyId"].ToString());

			try
			{
				if (FileUploadControl.HasFile)
				{
					try
					{
						if (FileUploadControl.PostedFile.ContentType == "image/jpeg" || FileUploadControl.PostedFile.ContentType == "image/png")
						{
							if (FileUploadControl.PostedFile.ContentLength < 5242880)
							{
								string imageName = Guid.NewGuid().ToString() + Path.GetExtension(FileUploadControl.FileName);
								string filePathName = Path.Combine(Server.MapPath(campaignImageFolder), imageName);

								//string filename = Path.GetFileName(FileUploadControl.FileName);
								FileUploadControl.SaveAs(filePathName);

								CrowdReliefDBDataContext dc = new CrowdReliefDBDataContext();

								//Insert the image.
								Guid photoId = Guid.NewGuid();
								Photo photo = new Photo();
								photo.Filename = imageName;
								photo.Title = txtImageName.Text;
								photo.Description = txtDescription.Text;
								photo.PhotoId = photoId;
								photo.Hidden = false;
								photo.CreatedOn = DateTime.Now;
								photo.CreatedBy = new Guid(Membership.GetUser().ProviderUserKey.ToString());
								dc.Photos.InsertOnSubmit(photo);
								dc.SubmitChanges();

								SurveyPhoto surveyPhoto = new SurveyPhoto();
								surveyPhoto.PhotoId = photoId;
								surveyPhoto.SurveyId = surveyId;
								surveyPhoto.SurveyPhotoId = Guid.NewGuid();
								surveyPhoto.Hidden = false;
								surveyPhoto.PrimaryCampaignImage = false;
								surveyPhoto.UseInCampaign = true;
								dc.SurveyPhotos.InsertOnSubmit(surveyPhoto);
								dc.SubmitChanges();
							}
						}
					}
					catch (Exception ex)
					{
					}
				}

				if(e.CommandName == "Finish")
				{
					Response.Redirect("~/Campaign.aspx?surveyId=" + surveyId.ToString());
				}
				else if(e.CommandName == "AddAnother")
				{
					Response.Redirect("~/Account/BasicNeedsSurveyAddPhotos.aspx?surveyId=" + surveyId);
				}

				//Where to now?
			}
			catch (Exception ex)
			{
			}
		}

		protected void btnCancel_Click(object sender, EventArgs e)
		{
			Guid surveyId = new Guid(Request.QueryString["surveyId"].ToString());
			Response.Redirect("~/Campaign.aspx?surveyId=" + surveyId.ToString());
		}

		protected void ResizeAndSaveImage(string imageName, string imagePath, int maxWidth, int maxHeight)
		{
			string fileId = imageName.Replace(".jpg", "_s.jpg"); //Add the prefix to the existing filename.

			//Get an image object of the newly uploaded file.
			System.Drawing.Image image = System.Drawing.Image.FromFile(Path.Combine(Server.MapPath(imagePath), imageName));

			//Check the current sizes and see if the image needs to be resized.
			var ratioX = (double)maxWidth / image.Width;
			var ratioY = (double)maxHeight / image.Height;
			var ratio = Math.Min(ratioX, ratioY);
			var newWidth = (int)(image.Width * ratio);
			var newHeight = (int)(image.Height * ratio);

			//Create a copy of the image with 
			var newImage = new Bitmap(newWidth, newHeight);

			//Size the image down.
			//Create a new resized image.
			Graphics.FromImage(newImage).DrawImage(image, 0, 0, newWidth, newHeight);

			//Convert to a bitmap
			Bitmap bitmapImage = new Bitmap(newImage);

			//Save the new image
			bitmapImage.Save(Path.Combine(Server.MapPath(imagePath), fileId), ImageFormat.Jpeg);
		}

		protected void LoadPhotos(Guid surveyId)
		{
			CrowdReliefDBDataContext dc = new CrowdReliefDBDataContext();

			var photos = from p in dc.Photos
						   join sp in dc.SurveyPhotos on p.PhotoId equals sp.PhotoId
						   where sp.SurveyId == surveyId
						 select new { p.Filename, p.Title, p.Description, sp.Hidden, sp.UseInCampaign, sp.PrimaryCampaignImage, p.PhotoId };

			dlPhotos.DataSource = photos;
			dlPhotos.DataBind();
		}

		protected void dlPhotos_ItemDataBound(object sender, DataListItemEventArgs e)
		{
			if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
			{
				string surveyId = Request.QueryString["surveyId"].ToString();
				string campaignImageFolder = System.Configuration.ConfigurationManager.AppSettings["CampaignImageFolder"].ToString();
				string campaignImageIconWidth = System.Configuration.ConfigurationManager.AppSettings["CampaignImageIconWidth"].ToString();
				string campaignImageDisplayWidth = System.Configuration.ConfigurationManager.AppSettings["CampaignImageDisplayWidth"].ToString();

				DataListItem dataItem = (DataListItem)e.Item;
				System.Web.UI.WebControls.Image imgPhoto = (System.Web.UI.WebControls.Image)e.Item.FindControl("imgPhoto");
				Label lblTitle = (Label)e.Item.FindControl("lblTitle");
				Label lblDescription = (Label)e.Item.FindControl("lblDescription");
				HyperLink hypPhoto = (HyperLink)e.Item.FindControl("hypPhoto"); 
				HyperLink hypHidden = (HyperLink)e.Item.FindControl("hypHidden"); 
				HyperLink hypPrimary = (HyperLink)e.Item.FindControl("hypPrimary"); 
				HyperLink hypCampaign = (HyperLink)e.Item.FindControl("hypCampaign"); 
				Literal litHidden = (Literal)e.Item.FindControl("litHidden");
				Literal litPrimary = (Literal)e.Item.FindControl("litPrimary");
				Literal litCampaign = (Literal)e.Item.FindControl("litCampaign");

				Guid photoId = (Guid)DataBinder.Eval(dataItem.DataItem, "photoId");
				string filename = (string)DataBinder.Eval(dataItem.DataItem, "Filename");
				string title = (string)DataBinder.Eval(dataItem.DataItem, "Title");
				string description = (string)DataBinder.Eval(dataItem.DataItem, "Description");
				litHidden.Text = "<span class=\"glyphicon glyphicon-ok\"></span> Visible";
				litPrimary.Text = "<span class=\"glyphicon glyphicon-ok\"></span> Primary Image";
				litCampaign.Text = "<span class=\"glyphicon glyphicon-ok\"></span> On Campaign";

				string manageImageURL = "~/Account/BasicNeedsSurveyAddPhotos.aspx?surveyId=" + surveyId + "&photoId=" + photoId;

				litHidden.Text = "<span class=\"glyphicon glyphicon-remove\"></span> Visible";
				hypHidden.NavigateUrl = manageImageURL + "&action=hidden&newValue=true";

				litPrimary.Text = "<span class=\"glyphicon glyphicon-ok\"></span> Primary Image";
				hypPrimary.NavigateUrl = manageImageURL + "&action=primary";

				litCampaign.Text = "<span class=\"glyphicon glyphicon-remove\"></span> On Campaign";
				hypCampaign.NavigateUrl = manageImageURL + "&action=campaign&newValue=true";

				if (DataBinder.Eval(dataItem.DataItem, "Hidden") != null)
				{
					bool hidden = (bool)DataBinder.Eval(dataItem.DataItem, "Hidden");
					if(hidden)
					{
						litHidden.Text = "<span class=\"glyphicon glyphicon-remove\"></span> Show";
						hypHidden.NavigateUrl = manageImageURL + "&action=hidden&newValue=true";
					}
					else
					{
						litHidden.Text = "<span class=\"glyphicon glyphicon-ok\"></span> Hide";
						hypHidden.NavigateUrl = manageImageURL + "&action=hidden&newValue=false";
					}
				}
				if (DataBinder.Eval(dataItem.DataItem, "UseInCampaign") != null)
				{
					bool useInCampaign = (bool)DataBinder.Eval(dataItem.DataItem, "UseInCampaign");
					if (useInCampaign)
					{
						litCampaign.Text = "<span class=\"glyphicon glyphicon-ok\"></span> Remove from Campaign";
						hypCampaign.NavigateUrl = manageImageURL + "&action=campaign&newValue=false";
					}
					else
					{
						litCampaign.Text = "<span class=\"glyphicon glyphicon-remove\"></span> Use On Campaign";
						hypCampaign.NavigateUrl = manageImageURL + "&action=campaign&newValue=true";
					}
				}
				if (DataBinder.Eval(dataItem.DataItem, "PrimaryCampaignImage") != null)
				{
					bool primaryCampaignImage = (bool)DataBinder.Eval(dataItem.DataItem, "PrimaryCampaignImage");
					if (primaryCampaignImage)
					{
						litPrimary.Text = "<span class=\"glyphicon glyphicon-ok\"></span> Primary Image";
						//Should not be able to unmake the image as primary, only choose a new one.
						//hypPrimary.NavigateUrl = manageImageURL + "&action=primary&newValue=true";
					}
					else
					{
						litPrimary.Text = "<span class=\"glyphicon glyphicon-remove\"></span> Set Primary Image";
						hypPrimary.NavigateUrl = manageImageURL + "&action=primary";
					}
				}

				hypPhoto.NavigateUrl = campaignImageFolder + filename;
				imgPhoto.ImageUrl = campaignImageFolder + filename;
				lblTitle.Text = title;
				lblDescription.Text = description;
				//imgPhoto.Width = new Unit(campaignImageIconWidth);
			}
		}
	}
}