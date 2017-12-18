using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Configuration;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Text.RegularExpressions;

public partial class Account_Organization_Rebuilds : BaseOrganizationWebForm
{
	public string progressPercent = string.Empty;
	public string totalVolunteersNeeded = string.Empty;
	protected void Page_Load(object sender, EventArgs e)
	{
		CrowdReliefDBDataContext dc = new CrowdReliefDBDataContext();
		var rebuilds = from r in dc.Rebuilds
					   join or in dc.OrganizationRebuilds on r.RebuildId equals or.RebuildId
					   join a in dc.Addresses on r.RebuildAddressId equals a.AddressId
					   join p in dc.Profiles on r.SurvivorId equals p.UserId
					   join rrs in dc.RebuildRebuildStatus on r.RebuildId equals rrs.RebuildId
					   join rs in dc.RebuildStatus on rrs.RebuildStatusId equals rs.RebuildStatusId
					   where r.IsHidden == false
					   //&& or.OrganizationId == organizationId
					   orderby r.CreatedOn descending
					   select new { r.RebuildId, r.RebuildStartDate, a.Address1, a.City, p.Firstname, p.Lastname, p.PhoneNumber, p.Age, p.UserId, r.Difficulty, StatusClass = (rs.Status == "IceBox" ? "StatusClassIceBlue" : rs.Status == "On Deck" ? "StatusClassOnDeckYellow" : rs.Status == "Active" ? "StatusClassActiveGreen" : rs.Status == "Complete" ? "StatusClassComplete" : "StatusClassComplete"), OnHoldClass = (r.IsOnHold == false ? "enableRebuildNoGoRed" : "enableRebuildActiveGreen"), OnHold = (r.IsOnHold == false ? "Hold" : "Clear"), rs.Status };

		dlRebuildTable.DataSource = rebuilds.Distinct();
		dlRebuildTable.DataBind();
		
		var completeRebuilds = (from r in dc.Rebuilds
								join rrs in dc.RebuildRebuildStatus on r.RebuildId equals rrs.RebuildId
								join rs in dc.RebuildStatus on rrs.RebuildStatusId equals rs.RebuildStatusId
								where rs.Status == "Complete"
								select new { r.RebuildId }).Count();

		var totalRebuilds = (from r in dc.Rebuilds
							 join rrs in dc.RebuildRebuildStatus on r.RebuildId equals rrs.RebuildId
							 join rs in dc.RebuildStatus on rrs.RebuildStatusId equals rs.RebuildStatusId
							 select new { r.RebuildId }).Count();

		decimal tickPercent = (int)Math.Round((double)(100 * completeRebuilds) / totalRebuilds);

		if (tickPercent > 0)
		{
			progressPercent = tickPercent.ToString();
		}
		else
		{
			progressPercent = "0";
		}

		litVolunteers.Text = CalculateVolunteersNeeded(0, true);

	}

	protected void dlRebuildTable_ItemDataBound(object sender, RepeaterItemEventArgs e)
	{
		if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
		{
			RepeaterItem dataItem = (RepeaterItem)e.Item;
			Literal litProgress = (Literal)e.Item.FindControl("litProgress"); 
			Literal litVolunteersNeeded = (Literal)e.Item.FindControl("litVolunteersNeeded"); 
			HyperLink hypPhone = (HyperLink)e.Item.FindControl("hypPhone");

			Guid survivorId = (Guid)DataBinder.Eval(dataItem.DataItem, "UserId");
			int? difficulty = (int?)DataBinder.Eval(dataItem.DataItem, "Difficulty");
			String phonenumber = (String)DataBinder.Eval(dataItem.DataItem, "PhoneNumber");
			//Regex.Replace(profile.PhoneNumber, @"(\d{3})(\d{3})(\d{4})", "$1-$2-$3");
			string rebuildProgressSliderId = ConfigurationManager.AppSettings["rebuildProgressSliderId"].ToString();
			string progressPercent = GetPercent(survivorId, new Guid(rebuildProgressSliderId)).ToString();

			if(difficulty != null)
			{
				litVolunteersNeeded.Text = CalculateVolunteersNeeded(int.Parse(difficulty.ToString()), false);
			}
			
			hypPhone.NavigateUrl = "tel:" + phonenumber;
			hypPhone.Text = Regex.Replace(phonenumber, @"(\d{3})(\d{3})(\d{4})", "$1-$2-$3");
			hypPhone.Font.Underline = true;

			string progressHTML = "<div class=\"progress m-t-xs full progress-small\">" +
										"<div style=\"width:" + progressPercent + "%\" aria-valuemax=\"100\" aria-valuemin=\"0\" aria-valuenow=\"" + progressPercent + "\" role=\"progressbar\" class=\"progress-bar progress-bar-success\">" +
											"<span class=\"sr-only\">" + progressPercent + "% Complete(success)</span>" +
										"</div>" +
									"</div>";

			litProgress.Text = progressHTML;
		}
	}
}