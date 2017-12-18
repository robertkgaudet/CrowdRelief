using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Configuration;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Text.RegularExpressions;

public partial class Account_Organization_Volunteers : BaseOrganizationWebForm
{
	public string progressPercent = string.Empty;
	public string totalVolunteersNeeded = "500";
	protected void Page_Load(object sender, EventArgs e)
	{
		CrowdReliefDBDataContext dc = new CrowdReliefDBDataContext();

		var volunteers = from v in dc.Profiles
						 join m in dc.aspnet_Memberships on v.UserId equals m.UserId
						 join u in dc.aspnet_Users on v.UserId equals u.UserId
						 orderby m.CreateDate descending
						 select new { v.UserId, v.Firstname, m.CreateDate, v.Description, v.DatesAvailable, v.NumberOfDaysAvailable, v.PreviousVolunteerExperience, v.ProfileNumber, v.Lastname, v.PhoneNumber, v.Address, v.City, v.State, v.Zip, u.UserName, m.Email };

		litVolunteersNeeded.Text = totalVolunteersNeeded;
		litVolunteersAvailable.Text = volunteers.Count().ToString();
		dlVolunteersTable.DataSource = volunteers.Distinct();
		dlVolunteersTable.DataBind();
	}

	protected void dlVolunteersTable_ItemDataBound(object sender, RepeaterItemEventArgs e)
	{
		if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
		{
			RepeaterItem dataItem = (RepeaterItem)e.Item;
			HyperLink hypPhone = (HyperLink)e.Item.FindControl("hypPhone");
			HyperLink hypEmail = (HyperLink)e.Item.FindControl("hypEmail"); 
			HyperLink hypAddress = (HyperLink)e.Item.FindControl("hypAddress"); 
			HyperLink hypVolunteerLocation = (HyperLink)e.Item.FindControl("hypVolunteerLocation");
			Literal litSKills = (Literal)e.Item.FindControl("litSKills");
			Literal litCreateDate = (Literal)e.Item.FindControl("litCreateDate"); 
			Literal litProfileNumber = (Literal)e.Item.FindControl("litProfileNumber"); 

			int profileNumber = (int)DataBinder.Eval(dataItem.DataItem, "ProfileNumber");
			Guid userId = (Guid)DataBinder.Eval(dataItem.DataItem, "UserId");
			String phonenumber = (String)DataBinder.Eval(dataItem.DataItem, "PhoneNumber");
			String description = (String)DataBinder.Eval(dataItem.DataItem, "Description");
			String datesAvailable = (String)DataBinder.Eval(dataItem.DataItem, "DatesAvailable");
			String numberOfDaysAvailable = (String)DataBinder.Eval(dataItem.DataItem, "NumberOfDaysAvailable");
			String previousVolunteerExperience = (String)DataBinder.Eval(dataItem.DataItem, "PreviousVolunteerExperience");

			String skillsList = "<b>Description:</b> " + description + "<br /><b>Dates Available:</b> " + datesAvailable + "<br /><b>Number Of Days Available:</b> " + numberOfDaysAvailable + "<br /><b>Previous Volunteer Experience:</b> " + previousVolunteerExperience + "<br /><b>Skills:</b> ";

			String email = (String)DataBinder.Eval(dataItem.DataItem, "Email");
			DateTime createDate = (DateTime)DataBinder.Eval(dataItem.DataItem, "CreateDate");
			String address = (String)DataBinder.Eval(dataItem.DataItem, "Address") + " " + (String)DataBinder.Eval(dataItem.DataItem, "City") + ", " + (String)DataBinder.Eval(dataItem.DataItem, "State") + " " + (String)DataBinder.Eval(dataItem.DataItem, "Zip");

			litCreateDate.Text = createDate.ToShortDateString();

			hypEmail.Text = email;
			hypEmail.NavigateUrl = "mailto:" + email;
			hypAddress.Text = address;
			hypAddress.NavigateUrl = "http://www.google.com/maps/place/" + address;
			litProfileNumber.Text = profileNumber.ToString();

			//Regex.Replace(profile.PhoneNumber, @"(\d{3})(\d{3})(\d{4})", "$1-$2-$3");
			string rebuildProgressSliderId = ConfigurationManager.AppSettings["rebuildProgressSliderId"].ToString();
			if(!String.IsNullOrEmpty(phonenumber))
			{ 
				hypPhone.NavigateUrl = "tel:" + phonenumber;
				hypPhone.Text = Regex.Replace(phonenumber, @"(\d{3})(\d{3})(\d{4})", "$1-$2-$3");
				hypPhone.Font.Underline = true;
			}

			CrowdReliefDBDataContext dc = new CrowdReliefDBDataContext();

			var skills = from s in dc.Skills
						 join us in dc.UserSkills on s.SkillId equals us.SkillId
						 where us.UserId == userId
						 orderby s.Name 
						 select new { s.Name };

			if(skills.Count() > 0)
			{
				foreach(var skill in skills)
				{
					skillsList += skill.Name + ", ";
				}
			}
			litSKills.Text = skillsList;


		}
	}
}