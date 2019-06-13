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
    
    private MyDBEntities DB;

    public MemberUtility() {
         DB = new MyDBEntities();
    }

    public List<Member> GetAllMembers() {
        return this.DB.Members.ToList();
    }

    public Member GetMember(int id) {
        return this.DB.Members.SingleOrDefault(m => m.Id == id);
    }

    public bool CheckMember(string userName, string password) {

        Member member =
            this.DB.Members.SingleOrDefault(m => m.UserName == userName && m.Password == password);

        return member != null;
    }

    public void UpdateMember(Member member) {
        this.DB.Entry(member).State = System.Data.Entity.EntityState.Modified;

        this.DB.SaveChanges();
    }

    public void DeleteMember(int id) {
        Member member =
            this.DB.Members.SingleOrDefault(m => m.Id == id);

        this.DB.Members.Remove(member);

        this.DB.SaveChanges();
    }

}

