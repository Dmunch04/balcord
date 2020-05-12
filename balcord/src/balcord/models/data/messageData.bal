const int DEFAULT = 0;
const int RECIPIENT_ADD = 1;
const int RECIPIENT_REMOVE = 2;
const int CALL = 3;
const int CHANNEL_NAME_CHANGE = 4;
const int CHANNEL_ICON_CHANGE = 5;
const int CHANNEL_PINNED_MESSAGE = 6;
const int GUILD_MEMBER_JOIN = 7;
const int USER_PREMIUM_GUILD_SUBSCRIPTION = 8;
const int USER_PREMIUM_GUILD_SUBSCRIPTION_TIER_1 = 9;
const int USER_PREMIUM_GUILD_SUBSCRIPTION_TIER_2 = 10;
const int USER_PREMIUM_GUILD_SUBSCRIPTION_TIER_3 = 11;
const int CHANNEL_FOLLOW_ADD = 12;
const int GUILD_DISCOVERY_DISQUALIFIED = 14;
const int GUILD_DISCOVERY_REQUALIFIED = 15;

type MessageData record {|
    string id;
    string content;
    string timestamp;
    int 'type;
    string channel_id;
    string guild_id;
    UserData author;
    boolean edited_timestamp;
    boolean pinned;
    boolean mention_everyone;
    boolean tts;
    ReactionData[] reactions;
    string[] mention_roles;
    EmbedData[] embeds;
    // TODO: mentions
    // TODO: attachment
|};

type ReactionData record {|
    int 'count;
    boolean me;
    EmojiData emoji;
|};