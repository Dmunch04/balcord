type EmbedData record {|
    string title;
    string type;
    string description;
    string url;
    string timestamp; // TODO: ??
    string color;
    EmbedFooterData footer;
    EmbedImageData image;
    EmbedThumbnailData thumbnail;
    EmbedVideoData video;
    EmbedProviderData provider;
    EmbedAuthorData author;
    EmbedFieldData[] fields;
|};

type EmbedThumbnailData record {|
    string url;
    string proxy_url;
    int 'width;
    int 'height;
|};

type EmbedVideoData record {|
    string url;
    int 'width;
    int 'height;
|};

type EmbedImageData record {|
    string url;
    string proxy_url;
    int 'width;
    int 'height;
|};

type EmbedProviderData record {|
    string name;
    string url;
|};

type EmbedAuthorData record {|
    string name;
    string url;
    string icon_url;
    string proxy_icon_url;
|};

type EmbedFooterData record {|
    string text;
    string icon_url;
    string proxy_icon_url;
|};

type EmbedFieldData record {|
    string name;
    string value;
    boolean inline;
|};