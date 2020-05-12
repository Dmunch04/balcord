const int GUILD_TEXT = 0;
const int DM = 1;
const int GUILD_VOICE = 2;
const int GROUP_DM = 3;
const int GUILD_CATEGORY = 4;
const int GUILD_NEWS = 5;
const int GUILD_STORE = 6;

int[] GUILD_CHANNELS = [GUILD_TEXT, GUILD_VOICE, GUILD_CATEGORY, GUILD_NEWS, GUILD_STORE];
int[] DM_CHANNELS = [DM, GROUP_DM];

type GuildChannelData record {|
    string id;
    string name;
    string topic;
    int 'type;
    int 'position;
    int 'rate_limit_per_user;
    boolean nsfw;
    string last_message_id;
    string guild_id;
    string parent_id;
    string[] permission_overwrites; // TODO: ??
|};

type GuildNewsChannelData record {|
    string id;
    string name;
    string topic;
    int 'type;
    int 'position;
    boolean nsfw;
    string guild_id;
    string parent_id;
    string[] permission_overwrites; // TODO: ??
|};

type GuildVoiceChannelData record {|
    string id;
    string name;
    int 'type;
    int 'position;
    int 'user_limit;
    boolean nsfw;
    string bitrate;
    string guild_id;
    string parent_id;
    string[] permission_overwrites; // TODO: ??
|};

type DMChannelData record {|
    string id;
    string last_message_id;
    int 'type;
    RecipientData[] recipients;
|};

type GroupDMChannelData record {|
    string id;
    string name;
    string icon;
    int 'type;
    string owner_id;
    string last_message_id;
    RecipientData[] recipients;
|};

type ChannelCategoryData record {|
    string id;
    string name;
    int 'type;
    int 'position;
    boolean nsfw;
    string guild_id;
    string parent_id;
    string[] permission_overwrites; // TODO: ??
|};

type StoreChannelData record {|
    string id;
    string name;
    int 'type;
    int 'position;
    boolean nsfw;
    string guild_id;
    string parent_id;
    string[] permission_overwrites; // TODO: ??
|};

type RecipientData record {|
    string id;
    string username;
    string avatar;
    string discriminator;
    int public_flags;
|};

type ChannelMentionData record {|
    string id;
    string name;
    int 'type;
    string guild_id;
|};