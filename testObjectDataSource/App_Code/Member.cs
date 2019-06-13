using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;

/// <summary>
/// Summary description for Member
/// </summary>

//public class Member {
//    public int id { get; set; }
//    public string account { get; set; }
//    public string password { get; set; }

//}

public class MemberUtility {

    private string ConnectionString;

    public MemberUtility() {
        ConnectionString = WebConfigurationManager.ConnectionStrings["MyDBConnectionString1"].ConnectionString;
    }

    public List<Member> GetAllMembers() {

        SqlDataAdapter da = new SqlDataAdapter("select * from members", this.ConnectionString);
        DataTable dt = new DataTable();
        da.Fill(dt);

        var query = from row in dt.AsEnumerable()
                    select new Member() {   UserName = row["UserName"].ToString(),  Password = row["Password"].ToString(),  Id = Convert.ToInt32(row["ID"]) };

        return query.ToList();
    }

    public Member GetMember(int id) {
        SqlDataAdapter da = new SqlDataAdapter(
            "select * from members where Id=@Id", this.ConnectionString);

        da.SelectCommand.Parameters.AddWithValue("@Id", id);

        DataTable dt = new DataTable();

        da.Fill(dt);

        DataRow row = dt.Rows[0];

        Member m = new Member() {
             Id = Convert.ToInt32(row["ID"]),
             UserName = row["UserName"].ToString(),
             Password = row["Password"].ToString()
        };

        return m;
    }

    public bool CheckMember(string userName, string password) {

        SqlDataAdapter da = new SqlDataAdapter("select * from members where UserName=@username and Password=@password", this.ConnectionString);
        da.SelectCommand.Parameters.AddWithValue("@username", userName);
        da.SelectCommand.Parameters.AddWithValue("@password", password);

        DataTable dt = new DataTable();
        da.Fill(dt);

        return dt.Rows.Count == 1;
    }

    public void UpdateMember(Member member) {
        using (SqlConnection cn = new SqlConnection(this.ConnectionString)) {
            SqlCommand cmd = new SqlCommand(
                "update Members set UserName = @username , Password = @password where ID = @id",
                cn);

            cmd.Parameters.AddWithValue("@username", member.UserName);
            cmd.Parameters.AddWithValue("@password", member.Password);
            cmd.Parameters.AddWithValue("@id", member.Id);

            cn.Open();
            cmd.ExecuteNonQuery();
        }
    }

    public void DeleteMember(int id) {
        using (SqlConnection cn = new SqlConnection(this.ConnectionString)) {
            SqlCommand cmd = new SqlCommand(
                "delete Members where ID = @id",
                cn);

            cmd.Parameters.AddWithValue("@id", id);

            cn.Open();
            cmd.ExecuteNonQuery();
        }
    }

}

