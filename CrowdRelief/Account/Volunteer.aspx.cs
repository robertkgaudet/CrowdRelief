using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

namespace CrowdRelief
{ 

	public partial class Account_Volunteer : BaseWebForm
	{
		protected void Page_Load(object sender, EventArgs e)
		{
			if (!IsPostBack)
			{
				CrowdReliefDBDataContext dc = new CrowdReliefDBDataContext();

				Page.Title = "Volunteer for CrowdRelief - Case workers, photographers and writers needed to help Louisiana flood victims recover";

				Master.HideTimeControls = true;
				Master.ShowNeedsButton = false;

				var events = from c in dc.Events
							 where c.IsActive == true && c.IsDisaster == true
							 select c;

				chkBoxListDisasters.DataSource = events;
				chkBoxListDisasters.DataBind();

				var organizations = from c in dc.Organizations
									where c.IsActive == true
									orderby c.Name
									select c;

				chkBoxOrganizations.DataSource = organizations;
				chkBoxOrganizations.DataBind();

				var skills = from c in dc.Skills
							 orderby c.Name
									select c;

				chkBoxListSkills.DataSource = skills;
				chkBoxListSkills.DataBind();

			}
		}

		protected void btnSubmit_Click(object sender, EventArgs e)
		{
			if (User.Identity.IsAuthenticated)
			{
				CrowdReliefDBDataContext dc = new CrowdReliefDBDataContext();

				string description = txtDescription.Text;
				if (!String.IsNullOrEmpty(description))
				{
					description = description.Replace(System.Environment.NewLine, "<br>");
				}

				string previousExperience = txtPreviousExperience.Text;
				if (!String.IsNullOrEmpty(previousExperience))
				{
					previousExperience = previousExperience.Replace(System.Environment.NewLine, "<br>");
				}

				var profile = (from p in dc.Profiles
							   where p.UserId == new Guid(Membership.GetUser().ProviderUserKey.ToString())
							   select p).SingleOrDefault();

				if(profile != null)
				{

					string profileNumber = profile.ProfileNumber.ToString();
					profile.DatesAvailable = txtDatesAvailable.Text;
					profile.Description = description;
					profile.NumberOfDaysAvailable = txtDaysAvailable.Text;
					profile.PreviousVolunteerExperience = previousExperience;
					dc.SubmitChanges();

					foreach (ListItem item in chkBoxListDisasters.Items)
					{
						if (item.Selected)
						{
							var userCheck = from p in dc.UserEvents
									where p.UserId == new Guid(Membership.GetUser().ProviderUserKey.ToString())
									&& p.EventId == new Guid(item.Value)
									select p;

							if (userCheck.Count() == 0)
							{ 
								UserEvent userEvent = new UserEvent();
								userEvent.EventId = new Guid(item.Value);
								userEvent.UserId = new Guid(Membership.GetUser().ProviderUserKey.ToString());
								userEvent.UserEventId = Guid.NewGuid();
								dc.UserEvents.InsertOnSubmit(userEvent);
								dc.SubmitChanges();
							}
						}
					}

					foreach (ListItem item in chkBoxListSkills.Items)
					{
						if (item.Selected)
						{
							var userCheck = from p in dc.UserSkills
											where p.UserId == new Guid(Membership.GetUser().ProviderUserKey.ToString())
											&& p.SkillId == new Guid(item.Value)
											select p;

							if (userCheck.Count() == 0)
							{
								UserSkill userSkill = new UserSkill();
								userSkill.SkillId = new Guid(item.Value);
								userSkill.UserId = new Guid(Membership.GetUser().ProviderUserKey.ToString());
								userSkill.UserSkillId = Guid.NewGuid();
								dc.UserSkills.InsertOnSubmit(userSkill);
								dc.SubmitChanges();
							}
						}
					}

					foreach (ListItem item in chkBoxOrganizations.Items)
					{
						if (item.Selected)
						{
							var userCheck = from p in dc.UserOrganizations
											where p.UserId == new Guid(Membership.GetUser().ProviderUserKey.ToString())
											&& p.OrganizationId == new Guid(item.Value)
											select p;

							if (userCheck.Count() == 0)
							{
								UserOrganization userOrganization = new UserOrganization();
								userOrganization.OrganizationId = new Guid(item.Value);
								userOrganization.UserId = new Guid(Membership.GetUser().ProviderUserKey.ToString());
								userOrganization.UserOrganizationId = Guid.NewGuid();
								dc.UserOrganizations.InsertOnSubmit(userOrganization);
								dc.SubmitChanges();
							}
						}
					}

					divFormFields.Visible = false;
					divResults.Visible = true;

					lblNumber.Text = profileNumber;
					lblResults.Text = "Welcome aboard " + profile.Firstname + "! We will be in touch with you soon about your request to volunteer!";
				}
			}
		}
	}
}