using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Account_UserControls_DisasterProjectProgressPanel : System.Web.UI.UserControl
{
	protected void Page_Load(object sender, EventArgs e)
	{
		litTotalVolunteersNeeded.Text = CrowdRelief.Tools.CalculateVolunteersNeeded(0, true);
	}

	public void LoadCollaboratingOrganizations()
	{
		CrowdReliefDBDataContext dc = new CrowdReliefDBDataContext();

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

		decimal tickPercent = (int)Math.Round((double)(100 * completeRebuilds) / totalRebuilds);

		if (tickPercent > 0)
		{
			litProgressPercent.Text = tickPercent.ToString();
		}
		else
		{
			litProgressPercent.Text = "0";
		}
	}
}