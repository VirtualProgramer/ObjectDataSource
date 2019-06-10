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

public class Prod {
    public int id { get; set; }

    public string name { get; set; }

    public int price { get; set; }

    public int count { get; set; }

    public string img { get; set; }

    public string prodInfo() {

        if (img == "") {
            return $"產品名稱：{name}，價格：{price}，數量：{count}";
        } else {
            return $"產品名稱：{name}，價格：{price}，數量：{count}，圖檔名：{img}";
        }
    }

}

public class ProdUtility {

    private string ConnectionString;

    public ProdUtility() {
        ConnectionString = WebConfigurationManager.ConnectionStrings["MyDBConnectionString1"].ConnectionString;
    }

    public List<Prod> GetAllProd() {

        SqlDataAdapter da = new SqlDataAdapter("select * from Products", this.ConnectionString);
        DataTable dt = new DataTable();

        da.Fill(dt);

        var query = from row in dt.AsEnumerable()
                    select new Prod {
                        id = Convert.ToInt32(row["id"]),
                        name = row["Name"].ToString(),
                        price = int.Parse(row["Price"].ToString()),
                        count = int.Parse(row["Amount"].ToString()),
                        img = row["ImageFileName"].ToString()
                    };

        return query.ToList();

    }

    public Prod GetProduct(int id) {

        SqlDataAdapter da = new SqlDataAdapter(
            "select * from Products where id=@id", this.ConnectionString);

        da.SelectCommand.Parameters.AddWithValue("@id", id);

        DataTable dt = new DataTable();

        da.Fill(dt);

        if (dt.Rows.Count == 0) {
            return null;
        } else {
            return new Prod() {
                id = Convert.ToInt32(dt.Rows[0]["ID"]),
                name = dt.Rows[0]["Name"].ToString(),
                price = Convert.ToInt32(dt.Rows[0]["Price"]),
                count = Convert.ToInt32(dt.Rows[0]["Amount"]),
                img = dt.Rows[0]["ImageFileName"] is DBNull ? "" : dt.Rows[0]["ImageFileName"].ToString()
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

    public void UpdateProduct(Prod p) {
        using (SqlConnection cn = new SqlConnection(this.ConnectionString)) {
            SqlCommand cmd = new SqlCommand(
                "UPDATE[Products] SET[Name] = @Name, [Price] = @Price, [Amount] = @Amount, [ImageFileName] = @image WHERE[Id] = @Id",
                cn);

            cmd.Parameters.AddWithValue("@Id", p.id);
            cmd.Parameters.AddWithValue("@Name", p.name);
            cmd.Parameters.AddWithValue("@Price", p.price);
            cmd.Parameters.AddWithValue("@Amount", p.count);
            cmd.Parameters.AddWithValue("@image", p.img);

            cn.Open();
            cmd.ExecuteNonQuery();
        }
    }

    public Prod QueryProduct(string name) {
        SqlDataAdapter da = new SqlDataAdapter(
            "select * from Products where Name=@name", this.ConnectionString);

        da.SelectCommand.Parameters.AddWithValue("@name", name);

        DataTable dt = new DataTable();

        da.Fill(dt);

        if (dt.Rows.Count == 0) {
            return null;
        } else {
            return new Prod() {
                id = Convert.ToInt32(dt.Rows[0]["ID"]),
                name = dt.Rows[0]["Name"].ToString(),
                price = Convert.ToInt32(dt.Rows[0]["Price"]),
                count = Convert.ToInt32(dt.Rows[0]["Amount"]),
                img = dt.Rows[0]["ImageFileName"] is DBNull ? "" : dt.Rows[0]["ImageFileName"].ToString()
            };
        }
    }
}
