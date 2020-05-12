public function main() {
    HttpClient httpClient = new("NTU2NDM1NTMwNjI4MzMzNTY4.XnIGqg.KImkFjag-zWR3JBqwrj6tzHeI0A");
    //Client.SendMessage ("555070259619561478", {Content: "Hello, World! Sent from Munchii's Ballerina Discord API Wrapper!", Embed: null});
    //Client.SendMessage ("165129131770511360", {Content: "a", Embed: null});
    //Client.SendTyping ("555070259619561478");
    //var Result = Client.StartPrivateMessage ("305058670428028930");
    //map<json> ResultData = <map<json>> Result;
    //json[] Recipients = <json[]> ResultData.recipients;
    //var ChannelID = ResultData.id.toString ();
    //var Name = Recipients[0].username.toString ();
    //Client.SendMessage (<@untained> ChannelID, {Content: "Hi, " + Name, Embed: null});

    var result = httpClient.startPrivateMessage("305058670428028930");
    if (result is DMChannel)
    {
        string 'targetChannel = result.id;
        string user = result.recipients[0].username;
        httpClient.sendMessage(<@untainted> targetChannel, <@untainted> { content: "Hi, " + user, embed: null });
    }
}