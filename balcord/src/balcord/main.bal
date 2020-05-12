public function main() {
    HttpClient httpClient = new("TOKEN");

    var result = httpClient.startPrivateMessage("USER_ID");
    if (result is DMChannel)
    {
        string 'targetChannel = result.id;
        string user = result.recipients[0].username;
        httpClient.sendMessage(<@untainted> targetChannel, <@untainted> { content: "Hi, " + user, embed: null });
    }
}
