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

    public ProdUtility() {
        ConnectionString = WebConfigurationManager.ConnectionStrings["MyDBConnectionString1"].ConnectionString;
    }

    public List<Product> GetAllProd() {

        SqlDataAdapter da = new SqlDataAdapter("select * from Products", this.ConnectionString);
        DataTable dt = new DataTable();

        da.Fill(dt);

        var query = from row in dt.AsEnumerable()
                    select new Product {
                         Id = Convert.ToInt32(row["id"]),
                         Name = row["Name"].ToString(),
                         Price = int.Parse(row["Price"].ToString()),
                         Amount = int.Parse(row["Amount"].ToString()),
                         ImageFileName = row["ImageFileName"].ToString()
                    };

        return query.ToList();

    }

    public Product GetProduct(int id) {

        SqlDataAdapter da = new SqlDataAdapter(
            "select * from Products where id=@id", this.ConnectionString);

        da.SelectCommand.Parameters.AddWithValue("@id", id);

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

    public bool CheckProd(string prodName) {

        SqlDataAdapter da = new SqlDataAdapter("select * from Products where Name=@prodName", this.ConnectionString);
        da.SelectCommand.Parameters.AddWithValue("@prodName", prodName);

        DataTable dt = new DataTable();
        da.Fill(dt);

        return dt.Rows.Count == 1;
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
        using (SqlConnection cn = new SqlConnection(this.ConnectionString)) {
            SqlCommand cmd = new SqlCommand(
                "UPDATE[Products] SET[Name] = @Name, [Price] = @Price, [Amount] = @Amount, [ImageFileName] = @image WHERE[Id] = @Id",
                cn);

            cmd.Parameters.AddWithValue("@Id", p.Id);
            cmd.Parameters.AddWithValue("@Name", p.Name);
            cmd.Parameters.AddWithValue("@Price", p.Price);
            cmd.Parameters.AddWithValue("@Amount", p.Amount);
            cmd.Parameters.AddWithValue("@image", p.ImageFileName);

            cn.Open();
            cmd.ExecuteNonQuery();
        }
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
        SqlDataAdapter da = new SqlDataAdapter(
             $"select * from Products where id in ({idString})",
             this.ConnectionString);

        DataTable dt = new DataTable();

        da.Fill(dt);

        var query = from row in dt.AsEnumerable()
                    select new Product() {
                          Id = Convert.ToInt32(row["ID"]),
                          Name = row["Name"].ToString(),
                          Price = Convert.ToInt32(row["Price"]),
                          Amount = Convert.ToInt32(row["Amount"]),
                          ImageFileName = row["ImageFileName"] is DBNull ? "" : row["ImageFileName"].ToString()
                    };

        return query.ToList();
    }

}
