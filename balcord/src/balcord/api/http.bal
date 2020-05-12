import ballerina/http;
import ballerina/io;

# The HTTP client object that will handle all the required functions of interacting with Discord through the bot
# 
# The client uses the bots token to send requests to the Discord REST API. Each request sends data specified by the call.
# A call wrapper function may either return nothing or an object.
# > **NOTE:** Some functions __ONLY__ returns nothing. This is due to them not recieving any useful result to pass to the user.
# 
# An example usage could be:
# 
# ```ballerina
#   HttpClient httpClient = new("TOKEN");
#   var result = httpClient.startPrivateMessage("USER_ID");
#   if (result is DMChannel)
#   {
#       string 'targetChannel = result.id;
#       string user = result.recipients[0].username;
#       httpClient.sendMessage(<@untainted> targetChannel, <@untainted> {content: "Hi, " + user, embed: null});
#   }
# ```
# 
# The above example will send `Hi, USER` to the user (where `USER` is replaced with the user's name)
public type HttpClient object {
    // The HTTP client that will do all the requests
    private http:Client _client;
    // The bots token
    private string _token;
    // The user agent used to send in the requests to Discord
    private string _userAgent;

    # Default constructor
    # 
    # + token - The bots token
    function __init(string token) {
        self._client = new(API_ENDPOINT);
        self._token = "Bot " + token;
        self._userAgent = "DiscordBot (xx 1.0) Ballerina/1.1";
    }

    # Performs a GET request to the specified endpoint with the specified data
    #
    # + endpoint - The endpoint the request should be done at
    # + data - The data to be sent with the request (defaults to `null`)
    # + return - The result data sent back from Discord. Can either be an object or an error
    private function get(string endpoint, json data = null) returns @tainted json? {
        return self.request("GET", endpoint, data);
    }


    # Performs a POST request to the specified endpoint with the specified data
    #
    # + endpoint - The endpoint the request should be done at
    # + data - The data to be sent with the request (defaults to `null`)
    # + return - The result data sent back from Discord. Can either be an object or an error
    private function post(string endpoint, json data = null) returns @tainted json? {
        return self.request("POST", endpoint, data);
    }


    # Performs a PUT request to the specified endpoint with the specified data
    #
    # + endpoint - The endpoint the request should be done at
    # + data - The data to be sent with the request (defaults to `null`)
    # + return - The result data sent back from Discord. Can either be an object or an error
    private function put(string endpoint, json data = null) returns @tainted json? {
        return self.request("PUT", endpoint, data);
    }


    # Performs a PATCH request to the specified endpoint with the specified data
    #
    # + endpoint - The endpoint the request should be done at
    # + data - The data to be sent with the request (defaults to `null`)
    # + return - The result data sent back from Discord. Can either be an object or an error
    private function patch(string endpoint, json data = null) returns @tainted json? {
        return self.request("PATCH", endpoint, data);
    }


    # Performs a DELETE request to the specified endpoint with the specified data
    #
    # + endpoint - The endpoint the request should be done at
    # + data - The data to be sent with the request (defaults to `null`)
    # + return - The result data sent back from Discord. Can either be an object or an error
    private function delete(string endpoint, json data = null) returns @tainted json? {
        return self.request("DELETE", endpoint, data);
    }


    # Performs a request
    #
    # + method - The request method to be used (`GET`, `POST`, `PUT`, `PATCH` or `DELETE`)
    # + endpoint - The endpoint the request should be done at
    # + data - The data to be sent with the request (defaults to `null`)
    # + return - The result data sent back from Discord. Can either be an object or an error
    private function request(string method, string endpoint, json data = null) returns @tainted json? {
        http:Request request = new;

        request.addHeader("Authorization", self._token);
        request.addHeader("User-Agent", self._userAgent);

        if (data != null) {
            request.setPayload(data);
        }

        if (method == "GET") {
            var response = self._client->get(endpoint, request);
            return self.handleResponse(response);
        } else if (method == "POST") {
            var response = self._client->post(endpoint, request);
            return self.handleResponse(response);
        } else if (method == "PUT") {
            var response = self._client->put(endpoint, request);
            return self.handleResponse(response);
        } else if (method == "PATCH") {
            var response = self._client->patch(endpoint, request);
            return self.handleResponse(response);
        } else if (method == "DELETE") {
            var response = self._client->delete(endpoint, request);
            return self.handleResponse(response);
        } else {
            io:println("Invalid method type: ", method);
        }
    }

    # Handles a http response
    #
    # + response - The response to be handled. Can either be of type `http:Response` or `error`
    # + return - Returns the response if it's not an error. Else it prints an error to the console and returns nothing
    private function handleResponse(http:Response|error response) returns @tainted json? {
        if (response is http:Response) {
            var msg = response.getJsonPayload();

            if (msg is json) {
                if (response.statusCode != 200) {
                    io:println("ERROR! " + msg.toJsonString());
                    return;
                }
                return msg;
            } else {
                io:println("Invalid payload recieved");
                return;
            }
        } else {
            io:println("Error when calling the backend: ", response.reason());
            return;
        }
    }

    # Sends a message to a channel
    # 
    # + channelId - The ID of the channel the message should be sent to
    # + data - The data to be sent. It should follow this format: `{ content: "", embed: e|null }`
    function sendMessage(string channelId, json data) returns @tainted json? {
        string route = "/channels/" + channelId + "/messages";

        json payload = {
            content: checkpanic data.content,
            embed: checkpanic data.embed
        };

        return self.post(route, payload);
    }

    # Sends a typing indicator to a channel
    # 
    # + channelId - The ID of the channel the indicator should be shown in
    function sendTyping(string channelId) returns @tainted json? {
        string route = "/channels/" + channelId + "/typing";
        return self.post(route);
    }

    # Sends files to a channel
    # 
    # + channelId - The ID of the channel the files should be sent to
    function sendFiles(string channelId) {
        // TODO
    }

    # Starts a DM with a user
    # 
    # + userId - The user the DM should be started with
    # + return - If the request was successful you'll recieve a `DMChannel` object, else it'll return nothing
    function startPrivateMessage(string userId) returns @tainted DMChannelData? {
        string route = "/users/@me/channels";

        json payload = {
            recipient_id: userId
        };

        var result = self.post(route, payload);
        DMChannelData|error discordChannel = trap DMChannelData.constructFrom(result);

        if (discordChannel is DMChannelData) {
            return discordChannel;
        } else {
            io:println("Error occured while making DMChannel: ", discordChannel.reason());
            return;
        }
    }

    function deleteMessage(string channelId, string messageId) returns @tainted json? {
        string route = "/channels/" + channelId + "/messages/" + messageId;
        return self.delete(route);
    }

    function deleteMessages(string channelId, string[] messageIds) returns @tainted json? {
        string route = "/channels/" + channelId + "/messages/bulk_delete";

        json payload = {
            messages: messageIds
        };

        return self.post(route, payload);
    }

    // TODO: Allow for full customization (https://discord.com/developers/docs/resources/channel#edit-message)
    function editMessage(string channelId, string messageId, string content) returns @tainted MessageData? {
        string route = "/channels/" + channelId + "/messages/" + messageId;
        
        json payload = {
            content: content
        };

        var result = self.patch(route, payload);
        MessageData|error message = trap MessageData.constructFrom(result);

        if (message is MessageData) {
            return message;
        } else {
            io:println("Error occured while making DMChannel: ", message.reason());
            return;
        }
    }
};