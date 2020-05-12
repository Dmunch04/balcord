type EmojiData record {|
    string id;
    string name;
    string[] roles;
    UserData user;
    boolean require_colons;
    boolean managed;
    boolean animated;
    boolean available;
|};