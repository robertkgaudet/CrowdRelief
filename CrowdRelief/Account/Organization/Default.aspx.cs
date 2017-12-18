using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using System.Net;
using System.Xml.Linq;

public partial class Account_Organization_Default : BaseOrganizationWebForm
{
	public string progressPercent = string.Empty;
	public string progressPercentIrma = "0";
	public string progressPercentHarvey = "0";
	public string totalVolunteersNeeded = string.Empty;

	protected void Page_Load(object sender, EventArgs e)
	{
		CrowdReliefDBDataContext dc = new CrowdReliefDBDataContext();
		LoadCollaboratingOrganizations();
		totalVolunteersNeeded = CalculateVolunteersNeeded(0, true);
	}

	public void LoadCollaboratingOrganizations()
	{
		CrowdReliefDBDataContext dc = new CrowdReliefDBDataContext();
		var collaboratingOrganizations = from o in dc.Organizations
										 select new { o.Name, o.Logo, o.OrganizationId };

		rptCollaborators.DataSource = collaboratingOrganizations;
		rptCollaborators.DataBind();


		var activeRebuilds = (from r in dc.Rebuilds
							  join rrs in dc.RebuildRebuildStatus on r.RebuildId equals rrs.RebuildId
							  join rs in dc.RebuildStatus on rrs.RebuildStatusId equals rs.RebuildStatusId
							  where rs.Status == "Active"
							  select new { r.RebuildId }).Count();

		var iceboxRebuilds = (from r in dc.Rebuilds
							  join rrs in dc.RebuildRebuildStatus on r.RebuildId equals rrs.RebuildId
							  join rs in dc.RebuildStatus on rrs.RebuildStatusId equals rs.RebuildStatusId
							  where rs.Status == "IceBox"
							  select new { r.RebuildId }).Count();

		var ondeckRebuilds = (from r in dc.Rebuilds
							  join rrs in dc.RebuildRebuildStatus on r.RebuildId equals rrs.RebuildId
							  join rs in dc.RebuildStatus on rrs.RebuildStatusId equals rs.RebuildStatusId
							  where rs.Status == "On Deck"
							  select new { r.RebuildId }).Count();

		var completeRebuilds = (from r in dc.Rebuilds
							  join rrs in dc.RebuildRebuildStatus on r.RebuildId equals rrs.RebuildId
							  join rs in dc.RebuildStatus on rrs.RebuildStatusId equals rs.RebuildStatusId
							  where rs.Status == "Complete"
							  select new { r.RebuildId }).Count();

		var totalRebuilds = (from r in dc.Rebuilds
							join rrs in dc.RebuildRebuildStatus on r.RebuildId equals rrs.RebuildId
							join rs in dc.RebuildStatus on rrs.RebuildStatusId equals rs.RebuildStatusId
							select new { r.RebuildId }).Count();

		litActive.Text = activeRebuilds.ToString();
		litComplete.Text = completeRebuilds.ToString();
		litOnDeck.Text = ondeckRebuilds.ToString();
		litIceBox.Text = iceboxRebuilds.ToString();
		litTotal.Text = totalRebuilds.ToString();

		litCollaboratingOrganizations.Text = GetCollaboratingOrganizationCount().ToString() + " Collaborators";

		decimal tickPercent = (int)Math.Round((double)(100 * completeRebuilds) / totalRebuilds);

		if(tickPercent > 0)
		{
			progressPercent = tickPercent.ToString();
		}
		else
		{
			progressPercent = "0";
		}
	}
}