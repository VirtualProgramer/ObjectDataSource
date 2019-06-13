using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Web.UI.WebControls;
using System.Web.UI;

//public class Prod {
//    public int id { get; set; }

//    public string name { get; set; }

//    public int price { get; set; }

//    public int count { get; set; }

//    public string img { get; set; }

//    public string prodInfo() {

//        if (img == "") {
//            return $"產品名稱：{name}，價格：{price}，數量：{count}";
//        } else {
//            return $"產品名稱：{name}，價格：{price}，數量：{count}，圖檔名：{img}";
//        }
//    }

//}

public class ProdUtility {

    private string ConnectionString;
    private MyDBEntities DB;

    public ProdUtility() {
        ConnectionString = WebConfigurationManager.ConnectionStrings["MyDBConnectionString1"].ConnectionString;
        DB = new MyDBEntities();
    }

    public List<Product> GetAllProd() {
        return this.DB.Products.ToList();
    }

    public Product GetProduct(int id) {
        return this.DB.Products.SingleOrDefault(m => m.Id == id);
    }

    public bool CheckProd(string prodName) {

        Product product =
            this.DB.Products.SingleOrDefault(p => p.Name == prodName);

        return product != null;

        //SqlDataAdapter da = new SqlDataAdapter("select * from Products where Name=@prodName", this.ConnectionString);
        //da.SelectCommand.Parameters.AddWithValue("@prodName", prodName);

        //DataTable dt = new DataTable();
        //da.Fill(dt);

        //return dt.Rows.Count == 1;
    }

    public void IsertProd(string name, string price, string amount, FileUpload image) {

        using (SqlConnection cn = new SqlConnection(ConnectionString)) {

            SqlCommand cm = new SqlCommand(
                "insert into Products values(@name, @price, @amount, @image)", cn);

            cm.Parameters.AddWithValue("@name", name);
            cm.Parameters.AddWithValue("@price", price);
            cm.Parameters.AddWithValue("@amount", amount);

            string imgURL = image.FileName;

            if (imgURL == "") {
                cm.Parameters.AddWithValue("@image", DBNull.Value);
            } else {

                string ext = Path.GetExtension(imgURL);
                string fileName = DateTime.Now.ToString("yyMMdd_HHmmss_ffff") + ext;

                string str = System.Web.HttpContext.Current.Server.MapPath("img/" + fileName);
                image.SaveAs(str);

                cm.Parameters.AddWithValue("@image", fileName);
            }

            cn.Open();
            cm.ExecuteNonQuery();
        }
    }

    public void UpdateProduct(Product p) {
        this.DB.Entry(p).State = System.Data.Entity.EntityState.Modified;

        this.DB.SaveChanges();
    }

    public Product QueryProduct(string name) {
        SqlDataAdapter da = new SqlDataAdapter(
            "select * from Products where Name=@name", this.ConnectionString);

        da.SelectCommand.Parameters.AddWithValue("@name", name);

        DataTable dt = new DataTable();

        da.Fill(dt);

        if (dt.Rows.Count == 0) {
            return null;
        } else {
            return new Product() {
                Id = Convert.ToInt32(dt.Rows[0]["ID"]),
                Name = dt.Rows[0]["Name"].ToString(),
                Price = Convert.ToInt32(dt.Rows[0]["Price"]),
                Amount = Convert.ToInt32(dt.Rows[0]["Amount"]),
                ImageFileName = dt.Rows[0]["ImageFileName"] is DBNull ? "" : dt.Rows[0]["ImageFileName"].ToString()
            };
        }
    }

    public List<Product> GetProductsByIDs(string idString) {
        string[] idAry = idString.Split(',');

        var query = from id in idAry
                    select int.Parse(id);

        List<int> idList = query.ToList();

        List<Product> prodList = this.DB.Products.Where(p => idList.Contains(p.Id)).ToList();

        return prodList;
    }

}
