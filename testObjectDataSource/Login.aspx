<%@ Page Language="C#" %>

<!DOCTYPE html>

<script runat="server">

    protected void Button1_Click(object sender, EventArgs e) {
        string id = TextBox1.Text;
        string pw = TextBox2.Text;

        MemberUtility mu = new MemberUtility();
        List<Member> mul = mu.GetAllMembers();

        if (mu.CheckMember(id, pw)) {
            Session["UserName"] = this.TextBox1.Text;
            Response.Redirect("~/Home.aspx");
        } else {
            Label1.Text = "請輸入正確的帳號密碼";
        }
    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <style>
        body {
            font-family: Arial, Helvetica, sans-serif;
        }

        .loginOutter {
            max-width: 500px;
            width: 100%;
            margin: 0 auto;
        }

        form {
            border: 3px solid #f1f1f1;
        }

        input[type=text], input[type=password] {
            width: 100%;
            padding: 12px 20px;
            margin: 8px 0;
            display: inline-block;
            border: 1px solid #ccc;
            box-sizing: border-box;
        }

        button, #Button1 {
            background-color: #4CAF50;
            color: white;
            padding: 14px 20px;
            margin: 8px 0;
            border: none;
            cursor: pointer;
            width: 100%;
        }

            button:hover {
                opacity: 0.8;
            }

        .cancelbtn {
            width: auto;
            padding: 10px 18px;
            background-color: #f44336;
        }

        .imgcontainer {
            text-align: center;
            margin: 24px 0 12px 0;
        }

        img.avatar {
            width: 40%;
            border-radius: 50%;
        }

        .container {
            padding: 16px;
        }

        span.psw {
            float: right;
            padding-top: 16px;
        }

        .flexRoeBetween {
            display: flex;
            flex-direction: row;
            justify-content: space-between;
        }

        /* Change styles for span and cancel button on extra small screens */
        @media screen and (max-width: 300px) {
            span.psw {
                display: block;
                float: none;
            }

            .cancelbtn {
                width: 100%;
            }

            .flexRoeBetween {
                display: flex;
                flex-direction: column;
                justify-content: flex-start;
            }

            #Label1 {
                margin: 8px 0;
            }
        }
    </style>
</head>
<body>
    <div class="loginOutter">
        <h2>Login Form</h2>
        <form id="form1" runat="server">
            <div class="imgcontainer">
                <img src="img/img_avatar2.png" alt="Avatar" class="avatar">
            </div>

            <div class="container">
                <label for="uname"><b>Username</b></label>
                <asp:TextBox ID="TextBox1" runat="server" placeholder="Enter Username"></asp:TextBox>
                <%--<input type="text" placeholder="Enter Username" name="uname" required>--%>

                <label for="psw"><b>Password</b></label>
                <asp:TextBox ID="TextBox2" runat="server" placeholder="Enter Password"></asp:TextBox>
                <%--<input type="password" placeholder="Enter Password" name="psw" required>--%>

                <asp:Button ID="Button1" runat="server" Text="Login" OnClick="Button1_Click" />
                <%--<button type="submit">Login</button>--%>
                <div class="flexRoeBetween">
                    <label>
                        <input type="checkbox" checked="checked" name="remember">
                        Remember me
                    </label>
                    <asp:Label ID="Label1" runat="server" Text="" ForeColor="Red"></asp:Label>
                </div>
            </div>

            <div class="container" style="background-color: #f1f1f1">
                <button type="button" class="cancelbtn">Cancel</button>
                <span class="psw">Forgot <a href="#">password?</a></span>
            </div>
        </form>
    </div>
</body>
</html>
