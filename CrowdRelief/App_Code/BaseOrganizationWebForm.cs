using System;
using System.Web.Security;
using System.Configuration;
using System.Web.SessionState;
using System.Linq;

/// <summary>
/// Summary description for BaseOrganizationWebForm
/// </summary>
public class BaseOrganizationWebForm : System.Web.UI.Page, IRequiresSessionState
{
	private Guid m_userId;
	private Guid m_organizationId;
	private string m_organizationName;
	private string m_organizationLogo;
	private string m_userFirstname;
	private string m_userLastname;
	private string m_userFullname;
	private string m_userPhonenumber;
	private string m_userEmail;
	private string m_userUsername;
	private string m_progress;

	public BaseOrganizationWebForm()
	{
		if (User.Identity.IsAuthenticated)
		{
			m_userId = new Guid(Membership.GetUser().ProviderUserKey.ToString());

			CrowdReliefDBDataContext dc = new CrowdReliefDBDataContext();

			var userOrganization = (from uo in dc.UserOrganizations
									join o in dc.Organizations on uo.OrganizationId equals o.OrganizationId
									join p in dc.Profiles on uo.UserId equals p.UserId
									join m in dc.aspnet_Memberships on uo.UserId equals m.UserId
									join u in dc.aspnet_Users on uo.UserId equals u.UserId
									where uo.UserId == m_userId
									&& uo.IsPrimary == true
									select new { o.Name, o.OrganizationId, o.Logo, p.Firstname, p.Lastname, p.Photo, fullname = (p.Firstname + " " + p.Lastname), p.PhoneNumber, m.Email, u.UserName }).SingleOrDefault();

			if (userOrganization != null)
			{
				m_organizationId = userOrganization.OrganizationId;
				m_organizationName = userOrganization.Name;
				m_organizationLogo = userOrganization.Logo;
				m_userFirstname = userOrganization.Firstname;
				m_userLastname = userOrganization.Lastname;
				m_userFullname = userOrganization.fullname;
				m_userPhonenumber = userOrganization.PhoneNumber;
				m_userEmail = userOrganization.Email;
				m_userUsername = userOrganization.UserName;
			}
		}
	}

	protected int GetCollaboratingOrganizationCount()
	{

		CrowdReliefDBDataContext dc = new CrowdReliefDBDataContext();

		var allOrganizations = (from o in dc.Organizations
								select new { o.OrganizationId }).Count();

		return allOrganizations;
	}

	protected void UpdatePost(string post, Guid userId, Guid rebuildId)
	{
		if (!string.IsNullOrEmpty(post))
		{
			RebuildPost rebuildPost = new RebuildPost();
			rebuildPost.CreatedOn = DateTime.Now;
			rebuildPost.IsVisible = true;
			rebuildPost.Post = post;
			rebuildPost.RebuildPostId = Guid.NewGuid();
			rebuildPost.UserId = userId;
			rebuildPost.RebuildId = rebuildId;

			CrowdReliefDBDataContext dc = new CrowdReliefDBDataContext();
			dc.RebuildPosts.InsertOnSubmit(rebuildPost);
			dc.SubmitChanges();
		}
	}


	protected decimal GetPercent(Guid survivorId, Guid sliderId)
	{
		CrowdReliefDBDataContext dc = new CrowdReliefDBDataContext();

		//Get the total number of SliderTicks for this tickId
		var tickTotalCount = (from st in dc.SliderTicks
							 where st.SliderId == sliderId
							  select new { st.SliderTickId }).Count();

		var myDistinctTickCount = (from st in dc.SliderTicks
								   join ust in dc.UserSliderTicks on st.SliderTickId equals ust.SliderTickId
								   where st.SliderId == sliderId
								   && ust.UserId == survivorId
								   select new { st.SliderTickId }).Distinct().Count();

		//(myDistinctTickCount / tickTotalCount) * 100;
		decimal tickPercent = (int)Math.Round((double)(100 * myDistinctTickCount) / tickTotalCount);

		return tickPercent;
	}

	protected string CalculateVolunteersNeeded(int points, bool returnAllNeededVolunteers)
	{
		return CrowdRelief.Tools.CalculateVolunteersNeeded(points, returnAllNeededVolunteers);
	}

	public Guid userId
	{
		get
		{ return m_userId; }
		set
		{ m_userId = value; }
	}
	public Guid organizationId
	{
		get
		{ return m_organizationId; }
		set
		{ m_organizationId = value; }
	}
	public string organizationName
	{
		get
		{ return m_organizationName; }
		set
		{ m_organizationName = value; }
	}
	public string organizationLogo
	{
		get
		{ return m_organizationLogo; }
		set
		{ m_organizationLogo = value; }
	}
	public string userFirstname
	{
		get
		{ return m_userFirstname; }
		set
		{ m_userFirstname = value; }
	}
	public string userLastname
	{
		get
		{ return m_userLastname; }
		set
		{ m_userLastname = value; }
	}
	public string userFullname
	{
		get
		{ return m_userFullname; }
		set
		{ m_userFullname = value; }
	}
	public string userPhonenumber
	{
		get
		{ return m_userPhonenumber; }
		set
		{ m_userPhonenumber = value; }
	}
	public string userEmail
	{
		get
		{ return m_userEmail; }
		set
		{ m_userEmail = value; }
	}
	public string userUsername
	{
		get
		{ return m_userUsername; }
		set
		{ m_userUsername = value; }
	}
}