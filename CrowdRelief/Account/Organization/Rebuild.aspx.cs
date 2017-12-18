using System;
using System.Configuration;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web.Security;

public partial class Account_Organization_Rebuild : BaseOrganizationWebForm
{
	public string userId = Membership.GetUser().ProviderUserKey.ToString();
	public string rebuildPostId = string.Empty;
	public Guid rebuildId;
	public Guid survivorId;
	public Guid OrganizationId;
	public string statusClass = string.Empty;
	public string progressPercent = string.Empty;

	public string latidude;
	public string longitude;

	public string yRebuildLabels = string.Empty;
	public string yOverallLabels = string.Empty;
	public string oveallLabelCount = string.Empty;
	public string rebuildLabelCount = string.Empty;

	public string rebuildProgressSpan = string.Empty;
	public string rebuildProgressDataAvg = string.Empty;
	public string rebuildProgressDataUser = string.Empty;

	public string overallProgressSpan = string.Empty;
	public string overallProgressDataAvg = string.Empty;
	public string overallProgressDataUser = string.Empty;

	public string rebuildProgressSliderId = ConfigurationManager.AppSettings["rebuildProgressSliderId"].ToString();
	public string progressEstimateSliderId = ConfigurationManager.AppSettings["progressEstimateSliderId"].ToString();

	protected void Page_Load(object sender, EventArgs e)
	{
		rebuildPostId = Request.QueryString["rebuildPostId"];
		rebuildId = new Guid(Request.QueryString["rebuildId"]);
		CrowdReliefDBDataContext dc = new CrowdReliefDBDataContext();

		var rebuild = (from r in dc.Rebuilds
						join a in dc.Addresses on r.RebuildAddressId equals a.AddressId
						where r.RebuildId == rebuildId
						select new { r, a }).SingleOrDefault();

		divProgressBar.Visible = true;
		divNoGo.Visible = false;
		if (!rebuild.r.IsOnHold)
		{
			divProgressBar.Visible = false;
			divNoGo.Visible = true;
		}

		survivorId = rebuild.r.SurvivorId;
		hypRebuildProgressUpdates.NavigateUrl = "RebuildProgressUpdates.aspx?survivorId=" + survivorId.ToString();
		litAddress.Text = rebuild.a.Address1;
		litCityStatZip.Text = rebuild.a.City + ", " + rebuild.a.State + " " + rebuild.a.Zip;
		latidude = rebuild.a.Latitude;
		longitude = rebuild.a.Longitude;
		litDescription.Text = rebuild.r.RebuildDescription;

		progressPercent = GetPercent(survivorId, new Guid(rebuildProgressSliderId)).ToString();

		Profile profile = (from p in dc.Profiles
							where p.UserId == survivorId
							select p).SingleOrDefault();

		string age = string.Empty;
		if (profile.Age != null)
		{
			age = " (Age " + profile.Age + ")";
		}

		var rebuildSurvey = (from rs in dc.RebuildSurveys
							 where rs.AddressId == rebuild.r.RebuildAddressId
							 select new { rs.Bedrooms, rs.Bathrooms, rs.SquareFeet }).SingleOrDefault();

		var userOrganization = (from uo in dc.UserOrganizations
							   join o in dc.Organizations on uo.OrganizationId equals o.OrganizationId
								where uo.UserId == new Guid(userId) && uo.IsPrimary == true
							   select new { o.Name, Logo = ("/Images/Organizations/" + o.Logo) }).Take(1).SingleOrDefault();

		imgNewPostLogo.ImageUrl = userOrganization.Logo;

		litBaths.Text = rebuildSurvey.Bathrooms != null ? rebuildSurvey.Bathrooms.ToString() : "N/A";
		litBeds.Text = rebuildSurvey.Bedrooms != null ? rebuildSurvey.Bedrooms.ToString() : "N/A";
		litSquareFeet.Text = rebuildSurvey.SquareFeet != null ? rebuildSurvey.SquareFeet.ToString() : "N/A";

		litSurvivorNameHeader.Text = profile.Firstname + " " + profile.Lastname;
		litSurvivorNameBreadcrumb.Text = profile.Firstname + " " + profile.Lastname;
		litSurvivorNameProfile.Text = profile.Firstname + " " + profile.Lastname + age;
		litPhoneNumber.Text = Regex.Replace(profile.PhoneNumber, @"(\d{3})(\d{3})(\d{4})", "$1-$2-$3");
		litEmail.Text = Membership.GetUser(profile.UserId).Email;

		GetLatestProgressTick(survivorId);
		LoadPosts();
		LoadCollaboratingOrganizations(rebuildId);
		BuildOveallProgressCharts(survivorId);
		BuildRebuildProgressCharts(survivorId);
		BuildChartInfo();
		LoadDifficulty(rebuild.r.Difficulty);
		LoadQualifiers(rebuildId);
		LoadStage(rebuildId);
	}

	protected void LoadStage(Guid rebuildId)
	{
		CrowdReliefDBDataContext dc = new CrowdReliefDBDataContext();

		var rebuildStage = (from rrs in dc.RebuildRebuildStatus
						   join rs in dc.RebuildStatus on rrs.RebuildStatusId equals rs.RebuildStatusId
						   where rrs.RebuildId == rebuildId
						   orderby rrs.CreatedOn descending
						   select new { rs.Status }).Take(1).SingleOrDefault();

		string statusLabel = "n/a";
		if (rebuildStage != null)
		{ statusLabel = rebuildStage.Status;

			switch(rebuildStage.Status)
			{
				case "IceBox":
					{
						statusClass = "StatusClassIceBlue";
						break;
					}
				case "On Deck":
					{
						statusClass = "StatusClassOnDeckYellow";
						break;
					}
				case "Active":
					{
						statusClass = "StatusClassActiveGreen";
						break;
					}
				case "Complete":
					{
						statusClass = "StatusClassComplete";
						break;
					}
				default:
					{
						statusClass = "StatusClassIceBlue";
						break;
					}
			}
		}


		litStage.Text = statusLabel;
	}

	protected void GetLatestProgressTick(Guid survivorId)
	{
		CrowdReliefDBDataContext dc = new CrowdReliefDBDataContext();

		var sliderProgress = (from ust in dc.UserSliderTicks
							  join st in dc.SliderTicks on ust.SliderTickId equals st.SliderTickId
							  where ust.UserId == survivorId
							  && ust.SliderId == new Guid(rebuildProgressSliderId)
							  && st.IsActive == true
							  orderby ust.CreatedOn descending
							  select new { st.Tick, st.Lable }).Take(1).SingleOrDefault();

		string progressLabel = "n/a";
		if(sliderProgress != null)
		{ progressLabel = sliderProgress.Lable; }

		litStageDetail.Text = progressLabel;
	}

	protected void LoadQualifiers(Guid rebuildId)
	{
		CrowdReliefDBDataContext dc = new CrowdReliefDBDataContext();

		var qualifiers = from rq in dc.RebuildQualifiers
						 join rs in dc.RebuildStatus on rq.QualifierId equals rs.RebuildStatusId
						 where rs.StatusType == 2
						 && rq.RebuildId == rebuildId
						 select new { rs.Status } ;

		rpQualifiers.DataSource = qualifiers;
		rpQualifiers.DataBind();
	}

	protected void LoadDifficulty(int? difficulty)
	{
		string difficultyHTML = string.Empty;
		string difficultyHTMLInfo = string.Empty;
		if(difficulty != null)
		{
			switch(difficulty)
			{
				case 0:
					{
						difficultyHTML = "<div style=\"display:block; overflow:auto;\"> " + difficulty + " Points</div>";
						difficultyHTMLInfo = "<small>(Less than 1 day with 1 person)</small>";
						break;
					}
				case 1:
					{ 
						difficultyHTML = "<div style=\"display:block; overflow:auto;\"> " + difficulty + " Point <div id=\"base\"></div></div> ";
						difficultyHTMLInfo = "<small>(Couple of days with minimal volunteers)</small>";
						break;
					}
				case 2:
					{
						difficultyHTML = "<div style=\"display:block; overflow:auto;\"> " + difficulty + " Points <div id=\"base\"></div><div id=\"base\"></div></div>";
						difficultyHTMLInfo = "<small>(Can take many weeks & requires a team with some professional skillsets)</small>";
						break;
					}
				case 3:
					{
						difficultyHTML = "<div style=\"display:block; overflow:auto;\"> " + difficulty + " Points <div id=\"base\"></div> <div id=\"base\"></div><div id=\"base\"></div></div>";
						difficultyHTMLInfo = "<small>(Can require months of planning and work and requires multiple professional skillsets.)</small>";
						break;
					}
				default:
					{
						difficultyHTML = "N/A";
						break;
					}
				}
			}

		litDifficulty.Text = difficultyHTML + difficultyHTMLInfo;
		litVolunteersDifficulty.Text = difficultyHTML;
		litVolunteers.Text = CalculateVolunteersNeeded(int.Parse(difficulty.ToString()), false);
	}

	public void LoadPosts()
	{
		CrowdReliefDBDataContext dc = new CrowdReliefDBDataContext();

		var posts = from rp in dc.RebuildPosts
					join p in dc.Profiles on rp.UserId equals p.UserId
					join uo in dc.UserOrganizations on p.UserId equals uo.UserId
					join o in dc.Organizations on uo.OrganizationId equals o.OrganizationId
					where rp.RebuildId == rebuildId
					&& uo.IsPrimary == true
					orderby rp.CreatedOn descending
					select new { o.Name, Logo = ("/Images/Organizations/" + o.Logo), p.ProfileId, rp.Post, rp.CreatedOn, fullname = p.Firstname + " " + p.Lastname, ProfilePhoto = (p.Photo == null ? "Avatar.png" : p.Photo) };

		rptPosts.DataSource = posts;
		rptPosts.DataBind();
	}

	protected void LoadCollaboratingOrganizations(Guid rebuildId)
	{
		CrowdReliefDBDataContext dc = new CrowdReliefDBDataContext();

		var collaboratingOrganizations = from ro in dc.OrganizationRebuilds
										 join o in dc.Organizations on ro.OrganizationId equals o.OrganizationId
										 where ro.RebuildId == rebuildId
										 orderby ro.IsPrimaryOrganization descending
										 select new { o.Name, o.Logo, o.OrganizationId };

		rptCollaborators.DataSource = collaboratingOrganizations;
		rptCollaborators.DataBind();
	}

	protected void BuildChartInfo()
	{
		CrowdReliefDBDataContext dc = new CrowdReliefDBDataContext();

		var rebuildSliderLables = from st in dc.SliderTicks
								  where st.SliderId == new Guid(rebuildProgressSliderId)
								  && st.IsActive == true
								  orderby st.Tick
								  select new { st.Lable, st.Tick };

		rebuildLabelCount = rebuildSliderLables.Count().ToString();
		foreach (var rebuildProgressItem in rebuildSliderLables)
		{
			yRebuildLabels += rebuildProgressItem.Tick + ":'" + rebuildProgressItem.Lable + "',";
		}
		yRebuildLabels = yRebuildLabels.TrimEnd(',');


		var overallSliderLables = from st in dc.SliderTicks
								  where st.SliderId == new Guid(progressEstimateSliderId)
								  && st.IsActive == true
								  orderby st.Tick
								  select new { st.Lable, st.Tick };

		oveallLabelCount = overallSliderLables.Count().ToString();
		foreach (var overallProgressItem in overallSliderLables)
		{
			yOverallLabels += overallProgressItem.Tick + ":'" + overallProgressItem.Lable + "',";
		}
		yOverallLabels = yOverallLabels.TrimEnd(',');
	}

	protected void BuildRebuildProgressCharts(Guid survivorId)
	{
		CrowdReliefDBDataContext dc = new CrowdReliefDBDataContext();
		//BUILD THE USERS REBUILD VIEW
		var rebuildProgressUser = from ust in dc.UserSliderTicks
								  join st in dc.SliderTicks on ust.SliderTickId equals st.SliderTickId
								  where st.SliderId == new Guid(rebuildProgressSliderId)
								 && ust.UserId == survivorId
								  group ust by new { year = ust.CreatedOn.Year, month = ust.CreatedOn.Month } into g
								  orderby g.Key.year, g.Key.month
								  select new
								  {
									  tick = (
											  from xst in dc.SliderTicks
											  join xust in dc.UserSliderTicks on xst.SliderTickId equals xust.SliderTickId
											  where xust.CreatedOn.Month == g.Key.month
											  && xust.CreatedOn.Year == g.Key.year
											  && xst.SliderId == new Guid(rebuildProgressSliderId)
											 && xust.UserId == new Guid(userId)
											  orderby xust.CreatedOn descending
											  select new { xst.Tick }).Take(1).SingleOrDefault()
								  };

		foreach (var rebuildProgressItem in rebuildProgressUser)
		{
			if (rebuildProgressItem.tick != null)
			{
				rebuildProgressDataUser += rebuildProgressItem.tick.Tick + ",";
			}
		}
		rebuildProgressDataUser = rebuildProgressDataUser.TrimEnd(',');

		
		//BUILD THE AVERAGE REBUILD VIEW
		var rebuildProgressAverage = from ust in dc.UserSliderTicks
									 join st in dc.SliderTicks on ust.SliderTickId equals st.SliderTickId
									 where st.SliderId == new Guid(rebuildProgressSliderId)
									 group ust by new { year = ust.CreatedOn.Year, month = ust.CreatedOn.Month } into g
									 orderby g.Key.year, g.Key.month
									 select new
									 {
										 MonthUpdateDate = g.Max(x => x.CreatedOn),
										 tick = (
												 from xst in dc.SliderTicks
												 join xust in dc.UserSliderTicks on xst.SliderTickId equals xust.SliderTickId
												 where xust.CreatedOn.Month == g.Key.month
												 && xust.CreatedOn.Year == g.Key.year
												 && xst.SliderId == new Guid(rebuildProgressSliderId)
												 orderby xust.CreatedOn descending
												 select new { xst.Tick }).Average(x => x.Tick)
									 };

		foreach (var rebuildProgressItem in rebuildProgressAverage)
		{
			rebuildProgressSpan += "\"" + rebuildProgressItem.MonthUpdateDate.ToString("MMM yyyy") + "\","; //.ToString("MMM yyyy")
			rebuildProgressDataAvg += rebuildProgressItem.tick + ",";
		}

		rebuildProgressSpan = rebuildProgressSpan.TrimEnd(',');
		rebuildProgressDataAvg = rebuildProgressDataAvg.TrimEnd(',');
	}

	protected void BuildOveallProgressCharts(Guid survivorId)
	{
		CrowdReliefDBDataContext dc = new CrowdReliefDBDataContext();

		//BUILD THE USERS REBUILD VIEW
		var overallProgressUser = from ust in dc.UserSliderTicks
								  join st in dc.SliderTicks on ust.SliderTickId equals st.SliderTickId
								  where
								  st.SliderId == new Guid(progressEstimateSliderId)
								  && ust.UserId == survivorId
								  group ust by new { year = ust.CreatedOn.Year, month = ust.CreatedOn.Month } into g
								  orderby g.Key.year, g.Key.month
								  select new
								  {
									  tick = (
											  from xst in dc.SliderTicks
											  join xust in dc.UserSliderTicks on xst.SliderTickId equals xust.SliderTickId
											  where
											  xust.CreatedOn.Month == g.Key.month
											  && xust.CreatedOn.Year == g.Key.year
											  && xst.SliderId == new Guid(progressEstimateSliderId)
											  && xust.UserId == new Guid(userId)
											  orderby xust.CreatedOn descending
											  select new { xst.Tick }).Take(1).SingleOrDefault()
								  };

		if(overallProgressUser.Count() > 0)
		{ 
			foreach (var overallProgressItem in overallProgressUser)
			{
				if(overallProgressItem.tick != null)
				{ 
					overallProgressDataUser += overallProgressItem.tick.Tick + ",";
				}
			}

			overallProgressDataUser = overallProgressDataUser.TrimEnd(',');
		}

		//BUILD THE AVERAGE REBUILD VIEW
		var overallProgressAverage = from ust in dc.UserSliderTicks
									 join st in dc.SliderTicks on ust.SliderTickId equals st.SliderTickId
									 where st.SliderId == new Guid(rebuildProgressSliderId)
									 group ust by new { year = ust.CreatedOn.Year, month = ust.CreatedOn.Month } into g
									 orderby g.Key.year, g.Key.month
									 select new
									 {
										 MonthUpdateDate = g.Max(x => x.CreatedOn),
										 tick = (
												 from xst in dc.SliderTicks
												 join xust in dc.UserSliderTicks on xst.SliderTickId equals xust.SliderTickId
												 where xust.CreatedOn.Month == g.Key.month
												 && xust.CreatedOn.Year == g.Key.year
												 && xst.SliderId == new Guid(rebuildProgressSliderId)
												 orderby xust.CreatedOn descending
												 select new { xst.Tick }).Average(x => x.Tick)
									 };

		foreach (var overallProgressItem in overallProgressAverage)
		{
			overallProgressSpan += "\"" + overallProgressItem.MonthUpdateDate.ToString("MMM yyyy") + "\","; //.ToString("MMM yyyy")
			overallProgressDataAvg += overallProgressItem.tick + ",";
		}

		overallProgressSpan = overallProgressSpan.TrimEnd(',');
		overallProgressDataAvg = overallProgressDataAvg.TrimEnd(',');
	}

	protected void btnRebuildPost_Click(object sender, EventArgs e)
	{
		string post = txtPost.Text;
		if(!string.IsNullOrEmpty(post))
		{
			UpdatePost(post, new Guid(userId), rebuildId);
			LoadPosts();
		}
	}
}