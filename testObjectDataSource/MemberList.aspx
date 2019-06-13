<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" %>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e) {

    }

    protected void Button2_Click(object sender, EventArgs e) {
        Button b = sender as Button;
        int memId = int.Parse(b.CommandName);
        MemberUtility mu = new MemberUtility();
        mu.DeleteMember(memId);
        Repeater1.DataBind();
    }

    protected int MemberImgAvatar(object obj) {
        int mia = Convert.ToInt32(obj);
        return mia % 3 + 1;
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">


    <div class="addForm memberListForm flexColumnStart">

        <div class="refreshButtonBar">
            <asp:Button ID="Button1" class="refreshButton" runat="server" Text="Refresh" />
        </div>

        <asp:Repeater ID="Repeater1" runat="server" DataSourceID="ObjectDataSource1">

            <HeaderTemplate>
                <ul class="w3-ul w3-card-4 memberList">
            </HeaderTemplate>
            <ItemTemplate>

                <li class="w3-bar">
                    <img src='img/member/img_avatar<%# MemberImgAvatar(Eval("Id")) %>.png'
                        class="w3-bar-item w3-circle" style="width: 85px">
                    <div class="w3-bar-item">
                        <span class="w3-large"><%# Eval("UserName") %></span><br>
                        <span>Member ID - <%# Eval("Id") %></span>
                    </div>
                    <asp:HyperLink ID="HyperLink1" class="w3-bar-item w3-button w3-xlarge w3-right" runat="server"
                        NavigateUrl='<%# Eval("ID" , "~/MemberEdit.aspx?id={0}") %>'>Edit</asp:HyperLink>
                    <asp:Button ID="Button2" class="w3-bar-item w3-button w3-xlarge w3-right"
                        CommandName='<%# Eval("Id") %>' runat="server" OnClick="Button2_Click"
                        Text="Delete" OnClientClick="return confirm('delete?')" />
                </li>

            </ItemTemplate>
            <FooterTemplate>
                </ul>
            </FooterTemplate>

        </asp:Repeater>
        <asp:ObjectDataSource runat="server" ID="ObjectDataSource1" SelectMethod="GetAllMembers" TypeName="MemberUtility"></asp:ObjectDataSource>

    </div>
</asp:Content>

