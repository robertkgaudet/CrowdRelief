using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.Security;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

namespace CrowdRelief
{
	public partial class Administration_UrgentNeedForHousing : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{
			this.Master.ShowNeedsButton = false;

			CrowdReliefDBDataContext dc = new CrowdReliefDBDataContext();

			var surveys = from s in dc.BasicNeedsSurveys
						  where s.ImmediateHousingNeeded == true
						  && s.Hidden == false
						  orderby s.CreatedOn descending
						  select s;

			dlSurveys.DataSource = surveys;
			dlSurveys.DataBind();
		}

		//protected decimal? GetUnmetCosts(Guid surveyId)
		//{
		//	CrowdReliefDBDataContext dc = new CrowdReliefDBDataContext();

		//	var totalCosts =	(from s in dc.BasicNeedsSurveyItems
		//						join si in dc.Items on s.ItemId equals si.ItemId
		//						where s.SurveyId == surveyId
		//						group si by new { s.SurveyId } into g
		//						select new
		//						{
		//							Cost = g.Sum(si => si.Cost)
		//						}).SingleOrDefault();

		//	decimal? totalCost = decimal.Zero;

		//	if(totalCosts != null)
		//	{
		//		totalCost = totalCosts.Cost;
		//	}

		//	return totalCost;
		//}

		protected void dlSurveys_ItemDataBound(object sender, DataListItemEventArgs e)
		{
			DataListItem dataItem = (DataListItem)e.Item;
			Literal litAddedTimeSpan = (Literal)e.Item.FindControl("litAddedTimeSpan");
			Literal litUpdatedTimeSpan = (Literal)e.Item.FindControl("litUpdatedTimeSpan");
			Label lblUnmetBasicNeedsCost = (Label)e.Item.FindControl("lblUnmetBasicNeedsCost");
			HtmlGenericControl spanAlert = (HtmlGenericControl)e.Item.FindControl("spanAlert");

			DateTime createdOn = (DateTime)DataBinder.Eval(dataItem.DataItem, "CreatedOn");
			Guid surveyId = (Guid)DataBinder.Eval(dataItem.DataItem, "SurveyId");

			if (DataBinder.Eval(dataItem.DataItem, "UpdateOn") != null)
			{
				DateTime updatedOn = (DateTime)DataBinder.Eval(dataItem.DataItem, "UpdateOn");
				string updatedTimeSpan = string.Empty;
				if (updatedOn != null)
				{
					updatedTimeSpan = CrowdRelief.Tools.GetElapsedTime(updatedOn);
				}
				litUpdatedTimeSpan.Text = "Updated " + updatedTimeSpan;
			}

			bool immediateHousingNeeded = (bool)DataBinder.Eval(dataItem.DataItem, "ImmediateHousingNeeded");

			spanAlert.Visible = false;
			if (immediateHousingNeeded)
			{
				spanAlert.Visible = true;
			}



			lblUnmetBasicNeedsCost.Text = String.Format("OPEN NEEDS {0:C}", Tools.GetUnmetCosts(surveyId));
			litAddedTimeSpan.Text = "Added " + CrowdRelief.Tools.GetElapsedTime(createdOn);
		}
	}
}