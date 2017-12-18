using System;
using System.Web;
using System.Configuration;
using System.Web.SessionState;

/// <summary>
/// Summary description for BaseWebForm33
/// </summary>

public class BaseWebForm : System.Web.UI.Page, IRequiresSessionState
{
	public BaseWebForm() { }
	private string m_fburl = string.Empty;
	private string m_fbimage = string.Empty;
	private string m_fbtitle = string.Empty;
	private bool isFacebookMetaTagProcessed = false;

	public string pageURL = HttpContext.Current.Request.Url.AbsoluteUri;

	private string m_username = string.Empty;
	private Guid m_userId;
	private Guid m_organizationId;
	private string m_fullname = string.Empty;
	private string m_userLink = string.Empty;
	private string m_activePageTitle = string.Empty;

	//public Guid regionId;
	public string fbimage
	{
		get
		{ return m_fbimage; }
		set
		{ m_fbimage = value; }
	}

	public string fbtitle
	{
		get
		{ return m_fbtitle; }
		set
		{ m_fbtitle = value; }
	}

	public string ActivePageTitle
	{
		get
		{ return m_activePageTitle; }
		set
		{ m_activePageTitle = value; }
	}

	protected override void OnLoad(EventArgs e)
	{
		string defaultPageTitle = ConfigurationManager.AppSettings["Title"].ToString();
		Page.Title = (!String.IsNullOrEmpty(ActivePageTitle) ? ActivePageTitle + " | " + defaultPageTitle : defaultPageTitle);

		if (!isFacebookMetaTagProcessed)
		{
			SetFacebookMetaTags(string.Empty, Request.RawUrl, string.Empty);
		}

		base.OnLoad(e);
	}

	public void SetFacebookMetaTags(string fbimage, string fburl, string fbtitle)
	{
		string domain = System.Configuration.ConfigurationManager.AppSettings["Domain"].ToString();
		string campaignImageFolder = System.Configuration.ConfigurationManager.AppSettings["CampaignImageFolder"].ToString();
		
		System.Web.UI.HtmlControls.HtmlMeta fbtitleMeta = (System.Web.UI.HtmlControls.HtmlMeta)Page.Master.FindControl("fbtitle");
		System.Web.UI.HtmlControls.HtmlMeta fbimageMeta = (System.Web.UI.HtmlControls.HtmlMeta)Page.Master.FindControl("fbimage");
		System.Web.UI.HtmlControls.HtmlMeta fburlMeta = (System.Web.UI.HtmlControls.HtmlMeta)Page.Master.FindControl("fburl");

		string defaultPageTitle = ConfigurationManager.AppSettings["Title"].ToString();

		m_fbtitle = String.IsNullOrEmpty(fbtitle) ? defaultPageTitle : fbtitle;
		m_fbimage = String.IsNullOrEmpty(fbimage) ? domain + "/Images/defaultImage.jpg" : domain + campaignImageFolder + fbimage;
		m_fburl = String.IsNullOrEmpty(fburl) ? domain : fburl;

		fbtitleMeta.Attributes.Add("content", m_fbtitle);
		fbimageMeta.Attributes.Add("content", m_fbimage);
		fburlMeta.Attributes.Add("content", m_fburl);

		isFacebookMetaTagProcessed = true;
	}

	public string GetElapsedTime(DateTime time)
	{
		string elapsedTime = "0";
		DateTime rightNow = DateTime.Now;

		TimeSpan interval = rightNow - time;

		if (interval.TotalSeconds < 60)
		{
			//Less than 60 minutes then show the interval in minutes.
			elapsedTime = interval.Seconds.ToString() + " " + (interval.Seconds == 1 || interval.Seconds == 0 ? "second ago" : "seconds ago");
		}
		else if (interval.TotalMinutes < 60)
		{
			//Less than 60 minutes then show the interval in minutes.
			elapsedTime = interval.Minutes.ToString() + " " + (interval.Minutes > 1 ? "minutes ago" : "minute ago");
		}
		else if (interval.TotalHours < 24)
		{
			//Less than 24 hours show hours passed.
			elapsedTime = interval.Hours.ToString() + " " + (interval.Hours > 1 ? "hours ago" : "hour ago");
		}
		else if (interval.TotalDays < 7)
		{
			//More than 24 hours show hours passed.
			elapsedTime = time.Date.DayOfWeek + " at " + time.ToShortTimeString();
		}
		else
		{
			elapsedTime = time.ToLongDateString();
		}

		return elapsedTime;
	}
}