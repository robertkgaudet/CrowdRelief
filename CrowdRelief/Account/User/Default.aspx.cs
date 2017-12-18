using System;
using System.Configuration;
using System.Linq;
using System.Web.Security;

public partial class Account_RecoveryDashboard_Default : System.Web.UI.Page
{
	public string userId = Membership.GetUser().ProviderUserKey.ToString();

	public string yRebuildLabels = string.Empty;
	public string yOverallLabels = string.Empty;
	public string rebuildLabelCount = string.Empty;
	public string oveallLabelCount = string.Empty;

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
		BuildOveallProgressCharts();
		BuildRebuildProgressCharts();

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

	public void BuildRebuildProgressCharts()
	{
		CrowdReliefDBDataContext dc = new CrowdReliefDBDataContext();
		//BUILD THE USERS REBUILD VIEW
		var rebuildProgressUser = from ust in dc.UserSliderTicks
								  join st in dc.SliderTicks on ust.SliderTickId equals st.SliderTickId
								  where st.SliderId == new Guid(rebuildProgressSliderId)
								 && ust.UserId == new Guid(userId)
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
			rebuildProgressDataUser += rebuildProgressItem.tick.Tick + ",";
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

	public void BuildOveallProgressCharts()
	{
		CrowdReliefDBDataContext dc = new CrowdReliefDBDataContext();

		//BUILD THE USERS REBUILD VIEW
		var overallProgressUser = from ust in dc.UserSliderTicks
								  join st in dc.SliderTicks on ust.SliderTickId equals st.SliderTickId
								  where
								  st.SliderId == new Guid(progressEstimateSliderId)
								  && ust.UserId == new Guid(userId)
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

		foreach (var overallProgressItem in overallProgressUser)
		{
			overallProgressDataUser += overallProgressItem.tick.Tick + ",";
		}
		overallProgressDataUser = overallProgressDataUser.TrimEnd(',');






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
}