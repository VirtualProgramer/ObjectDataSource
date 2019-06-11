<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" %>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e) {
        if (Session["ShoppingCart"] != null)
        {
            Dictionary<int, int> shoppingCart = Session["ShoppingCart"] as Dictionary<int, int>;

            string idString =string.Join(",", shoppingCart.Keys);
            ProdUtility pu = new ProdUtility();
            List<Prod> prodList = pu.GetProductsByIDs(idString);

            ShoppingCartUtility scu = new ShoppingCartUtility();
            List<ShoppingCart> sList = scu.GetShoppingCartList(shoppingCart, prodList);

            GridView1.DataSource = sList;
            GridView1.DataBind();
        }
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <asp:GridView ID="GridView1" runat="server"></asp:GridView>
</asp:Content>

