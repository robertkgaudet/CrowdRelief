using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CrowdRelief
{ 
	public partial class Administration_Default : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{
			Master.ShowNeedsButton = false;
			Master.HideTimeControls = true;

			CrowdReliefDBDataContext dc = new CrowdReliefDBDataContext();

			var surveyCount = (from s in dc.BasicNeedsSurveys
							   where s.Hidden == false || s.Hidden == null
							   select s).Count();

			lblSurveyCount.Text = "<h1 class='no-margin'>" + surveyCount.ToString() + "</h1> surveys completed";
			lblTotalUnmetNeeds.Text = String.Format("<h1 class='no-margin'>{0:C}</h1> in unmet costs", Tools.GetTotalUnmetCosts());
			lblTotalItemsNeeded.Text = "<h1 class='no-margin'>" + Tools.GetAllSurveyItemCount().ToString() + "</h1> total items needed";
		}

		protected void btnSearch_Click(object sender, EventArgs e)
		{
			Response.Redirect("Surveys.aspx?term=" + txtTerm.Text);
		}
	}
}