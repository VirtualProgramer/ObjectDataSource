<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" %>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        int id = int.Parse(Request.QueryString["id"]);

        ProdUtility pu = new ProdUtility();

        Prod prod = pu.GetProduct(id);

        Image1.ImageUrl = $"~/img/{prod.img}";
        Label1.Text = prod.name;
        Label2.Text = prod.price.ToString();

    }

    protected void Button1_Click(object sender, EventArgs e) {

        if (Session["ShoppingCart"] == null)
        {
            Session["ShoppingCart"] = new Dictionary<int, int>();
        }

        Dictionary<int, int> shoppingCart = Session["ShoppingCart"] as Dictionary<int, int>;

        int id = int.Parse(Request.QueryString["id"]);
        int amount = int.Parse(TextBox1.Text);

        shoppingCart.Add(id, amount);
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <footer class="w3-padding-64 w3-light-grey " id="footer">
        <div class="w3-row-padding">
            <div class="w3-col s4">
                <asp:Image ID="Image1" runat="server" Style="width: 100%" />
            </div>

            <div class="w3-col s4">
                <h1>
                    <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
                </h1>
                <p class="price">
                    新台幣
                    <asp:Label ID="Label2" runat="server" Text="Label"></asp:Label>
                    元
                </p>
                <br />
                <h4>數量</h4>
                <p>
                    <asp:TextBox ID="TextBox1" runat="server" TextMode="Number" CssClass="w3-border"></asp:TextBox>
                </p>
                <p>
                                       <asp:Button OnClick="Button1_Click" ID="Button1" runat="server" Text="加入購物車" CssClass="w3-button w3-black "/>

                </p>

            </div>

            <div class="w3-col s4 w3-justify">
                <h4>Store</h4>
                <p><i class="fa fa-fw fa-map-marker"></i>Company Name</p>
                <p><i class="fa fa-fw fa-phone"></i>0044123123</p>
                <p><i class="fa fa-fw fa-envelope"></i>ex@mail.com</p>
                <h4>We accept</h4>
                <p><i class="fa fa-fw fa-cc-amex"></i>Amex</p>
                <p><i class="fa fa-fw fa-credit-card"></i>Credit Card</p>
                <br>
                <i class="fa fa-facebook-official w3-hover-opacity w3-large"></i>
                <i class="fa fa-instagram w3-hover-opacity w3-large"></i>
                <i class="fa fa-snapchat w3-hover-opacity w3-large"></i>
                <i class="fa fa-pinterest-p w3-hover-opacity w3-large"></i>
                <i class="fa fa-twitter w3-hover-opacity w3-large"></i>
                <i class="fa fa-linkedin w3-hover-opacity w3-large"></i>
            </div>
        </div>
    </footer>

</asp:Content>

