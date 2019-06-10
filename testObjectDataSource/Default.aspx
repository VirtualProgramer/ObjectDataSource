<%@ Page Language="C#" %>

<!DOCTYPE html>

<script runat="server">

    protected void RadioButtonList1_SelectedIndexChanged(object sender, EventArgs e) {

    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <asp:RadioButton Style="float: left" class="single-element-widget mt-30" ID="RadioButton1" runat="server" />
        <asp:RadioButton Style="float: left" class="single-element-widget mt-30" ID="RadioButton2" runat="server" />
        <asp:RadioButton Style="float: left" class="single-element-widget mt-30" ID="RadioButton3" runat="server" />
        <asp:RadioButton Style="float: left" class="single-element-widget mt-30" ID="RadioButton4" runat="server" />
        <div>
            <asp:RadioButtonList ID="RadioButtonList1" runat="server" OnSelectedIndexChanged="RadioButtonList1_SelectedIndexChanged">
                <asp:ListItem>11111</asp:ListItem>
                <asp:ListItem>22222</asp:ListItem>
                <asp:ListItem>33333</asp:ListItem>
                <asp:ListItem>44444</asp:ListItem>
                <asp:ListItem>55555</asp:ListItem>
            </asp:RadioButtonList>
        </div>
    </form>
</body>
</html>
