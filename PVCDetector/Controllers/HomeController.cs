using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using MathWorks.MATLAB.NET.Arrays;
using MathWorks.MATLAB.NET.Utility;
using TestQRS;
using GetPVCLocations;


namespace PVCDetector.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult About()
        {
            ViewBag.Message = "Your application description page.";

            return View();
        }

        public JsonResult Upload(HttpPostedFileBase[] files, double fs)
        {
            string path = string.Empty;
            IList<FileOutput> fos = new List<FileOutput>();
            foreach (var file in files)
            {
                var fileName = Path.GetFileName(file.FileName);
                path = Path.Combine(Server.MapPath("~/App_Data/"), fileName);
                file.SaveAs(path);
                IList<double> indices = GetPVCLocations(path, fs);
                FileOutput fo = new FileOutput() {FileName = file.FileName, PvcLocations = indices};
                fos.Add(fo);
            }
            
            return Json(fos, JsonRequestBehavior.AllowGet);
        }

        private IList<double> GetPVCLocations(string path, double fs)
        {
            GetPVCLocations.PVC obj = null;
            MWCharArray input = null;
            MWNumericArray output = null;

            try
            {
                //obj = new TestQRS.Class1();
                obj = new GetPVCLocations.PVC();

                input = path;
                var result1 = (MWNumericArray) obj.GetPVCLocations(input, fs);
                var result = result1.ToArray();// ToScalarInteger();
                // var result = ((MWNumericArray)obj2.Untitled2(input)).ToScalarInteger();
                return result.Cast<double>().ToList();
            }
            catch (Exception)
            {

                throw;
            }

        }

        public ActionResult Contact()
        {
            ViewBag.Message = "Your contact page.";

            return View();
        }
    }

    public class FileOutput
    {
        public string FileName { get; set; }
        public IList<double> PvcLocations { get; set; }
    }
}