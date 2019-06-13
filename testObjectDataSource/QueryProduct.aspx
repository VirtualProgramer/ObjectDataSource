<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" %>

<script runat="server">

    protected void Button2_Click(object sender, EventArgs e) {

        BulletedList1.Items.Clear();
        ProdUtility pu = new ProdUtility();

        List<Product> pdList = pu.GetAllProd();
        if (TextBox1.Text != "") {
            foreach (Product s in pdList) {
                if (s.Name.ToUpper().Contains(TextBox1.Text.ToUpper())) {
                    BulletedList1.Items.Add("");
                }
            }
        }
    }

    protected void Button3_Click(object sender, EventArgs e) {

        BulletedList1.Items.Clear();
        ProdUtility pu = new ProdUtility();

        bool pbool = int.TryParse(TextBox2.Text, out int price);
        if (!pbool) {
            BulletedList1.Items.Add("不要搞事");
        } else {
            List<Product> pdList = pu.GetAllProd();
            foreach (Product s in pdList) {
                if (s.Price >= price) {
                    BulletedList1.Items.Add("");
                }
            }
        }
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="addForm">
        <div class="queryProduct flexColumnStart">
            <div class="flexRowStart">
                <div class="queryDiv">
                    <div class="queryButton">
                        <asp:Button ID="Button2" runat="server" Text="產品查詢" OnClick="Button2_Click" />
                    </div>
                    <div class="queryTextBox">
                        <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
                    </div>
                </div>
                <div class="queryDiv">
                    <div class="queryButton">
                        <asp:Button ID="Button3" runat="server" Text="價格大於" OnClick="Button3_Click" />
                    </div>
                    <div class="queryTextBox">
                        <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
                    </div>
                </div>
            </div>
            <div class="queryProductR">
                <asp:BulletedList ID="BulletedList1" runat="server"></asp:BulletedList>
            </div>
        </div>
    </div>

</asp:Content>

