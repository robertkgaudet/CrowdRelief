using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

namespace CrowdRelief
{ 
	public partial class Account_BasicNeedsSurveyVideo : BaseWebForm
	{
		protected void Page_Load(object sender, EventArgs e)
		{
			this.Master.ShowNeedsButton = false;
			this.Master.HideTimeControls = true;

			CrowdReliefDBDataContext dc = new CrowdReliefDBDataContext();
			Guid surveyId = new Guid(Request.QueryString["surveyId"].ToString());
			btnGoToSurvey.NavigateUrl = "~/Account/BasicNeedsSurveyView.aspx?surveyId=" + surveyId;


			if(!IsPostBack)
			{
				var video = (from v in dc.Videos
							join sv in dc.SurveyVideos on v.VideoId equals sv.VideoId
							where sv.SurveyId == surveyId
							select new { v.EmbedCode }).SingleOrDefault();
				if(video != null)
				{ 
					txtVideoEmbedCode.Text = video.EmbedCode;
				}
			}
		}

		protected void btnPost_Click(object sender, CommandEventArgs e)
		{
			Guid surveyId = new Guid(Request.QueryString["surveyId"].ToString());
			Guid videoId = Guid.NewGuid();

			CrowdReliefDBDataContext dc = new CrowdReliefDBDataContext();

			var videoCheck = (from v in dc.Videos
							 join sv in dc.SurveyVideos on v.VideoId equals sv.VideoId
							 where sv.SurveyId == surveyId
							 select new { v.VideoId }).SingleOrDefault();

			if(videoCheck != null)
			{
				//Update
				var updateVideo = (from v in dc.Videos
								  where v.VideoId == videoCheck.VideoId
								  select v).SingleOrDefault();

				updateVideo.EmbedCode = txtVideoEmbedCode.Text;
				dc.SubmitChanges();
			}
			else
			{ 
				//insert
				Video video = new Video();
				video.EmbedCode = txtVideoEmbedCode.Text;
				video.VideoId = videoId;
				video.Hidden = false;
				video.CreatedOn = DateTime.Now;
				video.CreatedBy = new Guid(Membership.GetUser().ProviderUserKey.ToString());
				dc.Videos.InsertOnSubmit(video);
				dc.SubmitChanges();

				SurveyVideo surveyVideo = new SurveyVideo();
				surveyVideo.SurveyVideoId = Guid.NewGuid();
				surveyVideo.VideoId = videoId;
				surveyVideo.SurveyId = surveyId;
				dc.SurveyVideos.InsertOnSubmit(surveyVideo);
				dc.SubmitChanges();
			}
			Response.Redirect("~/Account/BasicNeedsSurveyView.aspx?surveyId=" + surveyId.ToString());
		}

		protected void btnCancel_Click(object sender, EventArgs e)
		{
			Guid surveyId = new Guid(Request.QueryString["surveyId"].ToString());
			Response.Redirect("~/Campaign.aspx?surveyId=" + surveyId.ToString());
		}

		protected void LoadVideo(Guid surveyId)
		{
			CrowdReliefDBDataContext dc = new CrowdReliefDBDataContext();

			var video = (from v in dc.Videos
						join sv in dc.SurveyVideos on v.VideoId equals sv.VideoId
						where sv.SurveyId == surveyId
						select new { v.EmbedCode }).SingleOrDefault();

			if(video != null)
			{
				litVideoEmbedCode.Text = video.EmbedCode;
			}
		}
	}
}