using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Drawing;
using System.Drawing.Imaging;
using System.Web.Security;

namespace CrowdRelief
{
	public partial class Account_BasicNeedsSurveyCampaignPhoto : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{
			this.Master.ShowNeedsButton = false;
			this.Master.HideTimeControls = true;
			
		}
		//protected void RadAsyncUpload1_FileUploaded(object sender, FileUploadedEventArgs e)
		//{

		//	//Save the inital image to the file system
		//	string filePathName = Path.Combine(Server.MapPath(RadAsyncUpload1.TargetFolder), imageName);

		//	e.File.SaveAs(filePathName);

		//	//Create two different sized copies of it.
		//	//ResizeAndSaveImage(e.File, imageName, RadAsyncUpload1.TargetFolder, int.Parse(campaignImageIconWidth), int.Parse(campaignImageIconWidth));
		//	//ResizeAndSaveImage(e.File, imageName, RadAsyncUpload1.TargetFolder, int.Parse(campaignImageDisplayWidth), int.Parse(campaignImageDisplayWidth));

		//	//Show image icon on the page.
		//}

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

								//Insert the tags
								Unit unitWidth = new Unit(campaignImageIconWidth);
								imgThumbnail.Width = unitWidth;
								imgThumbnail.ImageUrl = campaignImageFolder + imageName;   //.Replace(".jpg", "_s.jpg");

								divPhoto.Visible = false;
								tableForm.Visible = true;
								hidImageName.Value = imageName;
								
								CrowdReliefDBDataContext dc = new CrowdReliefDBDataContext();

								//Insert the image.
								Guid photoId = Guid.NewGuid();
								Photo photo = new Photo();
								photo.Filename = hidImageName.Value;
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
								surveyPhoto.PrimaryCampaignImage = true;
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

				if (e.CommandName == "Finish")
				{
					Response.Redirect("~/Campaign.aspx?surveyId=" + surveyId.ToString());
				}
				else if (e.CommandName == "AddAnother")
				{
					Response.Redirect("~/Account/BasicNeedsSurveyAddPhotos.aspx?surveyId=" + surveyId);
				}
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

		protected void btnSave_Click(object sender, EventArgs e)
		{ }

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
	}
}