<%@ WebService Language="C#" Class="WebService" %>

using System;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Collections.Generic;

[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
[System.Web.Script.Services.ScriptService]
public class WebService : System.Web.Services.WebService {

    [WebMethod]
    public string HelloWorld() {
        return "Hello World";
    }

    //[WebMethod]
    //public List<Member> GetMembers() {
    //    List<Member> myList = new List<Member>() {
    //        new Member(1 , "tony"),
    //        new Member(2 , "mary"),
    //        new Member(3 , "tim")
    //    };

    //    return myList;
    //}

    [WebMethod]
    public List<Product> GetAllProd() {

        ProdUtility pu = new ProdUtility();
        return pu.GetAllProd();
    }

}

