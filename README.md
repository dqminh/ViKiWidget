README
======

## How to add the ViKi widget

To embed the ViKi widget on your website, copy and paste the following code to your website's code. You can choose between two versions:

### Inline: Plays videos inside the widget.
      

    <iframe src="http://www.viki.com/widget/index.html?mode=inline" width="300" height="285" frameBorder="0" scrolling="no"></iframe>

### New Window: Opens a new window to play videos.
      

    <iframe src="http://www.viki.com/widget/index.html" width="300" height="285" frameBorder="0" scrolling="no"></iframe>


ViKi REST API
=============


## GET videos

Returns videos metadata with supports for some filters. Supported data type are JSON and XML

### Request

```
GET http://www.viki.com/videos.json
GET http://www.viki.com/videos.xml
```

#### Request Parameters

<table>

  <thead>
    <tr>
      <th>Name
      <th>Description
      <th>Parameters
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>origin_code
      <td>The country where the channel originated.
      <td>Any valid two-letter country code
    </tr>
    <tr>
      <td>subtitle_lang_code
      <td>Subtitle language filter for videos. Only videos which have subtitle completion rates of 95% or above will be returned.
      <td>Any valid two-letter language code
    </tr>
    <tr>
      <td>type
      <td>Video categories filter.
      <td>Possible values are: news, movies, and series.
    </tr>
    <tr>
      <td>thumbnail_size
      <td>Desired size of the returned thumbnails.
      <td>Possible values are: small, medium, large, huge, mr_220_160, mr_480_270
    </tr>
    <tr>
      <td>news_country_code
      <td>
      <td>
    </tr>
  </tbody>

</table>



### Response

#### Descriptions

* `id`: id of the video
* `title`: title of the video
* `embed_uri`: link for the video player.
* `uri`: link to the video on ViKi website
* `thumbnails`: list of URIs for the video's thumbnail sizes

The following is a sample XML response for GET videos. Notice that we are returning all thumbnail sizes because the `thumbnail_size` parameters are not specified

```xml
GET http://www.viki.com/videos.xml

<videos>
  <video>
    <id>52272</id>
    <title>Episode 86 - Strong Heart</title>
    <description>Ryu Shi Won, Park So Hyun, Lee Ji Hoon, f(x) Suli, Yun So Yi, Kim Sung Joo, Super Junior (Shindong, Leeteuk, Eunhyuk), Kwanghee (Ze:A), Moon Hee Jun, etc.</description>
    <timestamp>2011-09-17T07:15:45Z</timestamp>
    <embed_uri>http://www.viki.com/swfs/vikiplayer.swf?media_id=52272&host=www.smackaho.st:3000&auto_play=true</embed_uri>
    <uri>http://www.viki.com/channels/1049-strong-heart/videos/52272</uri>
    <thumbnails>
      <huge width="140" height="102">http://c3.vikiassets.com/uploads/media_resource/thumbnail/146687/huge_ef62407e891e7ee966716e6610759535ce09f8c8.jpg</huge>
      <large width="120" height="90">http://c3.vikiassets.com/uploads/media_resource/thumbnail/146687/large_ef62407e891e7ee966716e6610759535ce09f8c8.jpg</large>
      <medium width="96" height="72">http://c2.vikiassets.com/uploads/media_resource/thumbnail/146687/medium_ef62407e891e7ee966716e6610759535ce09f8c8.jpg</medium>
      <small width="60" height="45">http://c0.vikiassets.com/uploads/media_resource/thumbnail/146687/small_ef62407e891e7ee966716e6610759535ce09f8c8.jpg</small>
      <mr_480_270 width="480" height="270">http://c2.vikiassets.com/uploads/media_resource/thumbnail/146687/mr_480_270_ef62407e891e7ee966716e6610759535ce09f8c8.jpg</mr_480_270>
      <mr_220_160 width="220" height="160">http://c3.vikiassets.com/uploads/media_resource/thumbnail/146687/mr_220_160_ef62407e891e7ee966716e6610759535ce09f8c8.jpg</mr_220_160>
    </thumbnails>
  </video>
</videos>
```

```json
GET http://www.viki.com/videos.json

{
  {
    "id": 52272,
    "title": "Episode 86 - Strong Heart",
    "description": "Ryu Shi Won, Park So Hyun, Lee Ji Hoon, f(x) Suli, Yun So Yi, Kim Sung Joo, Super Junior (Shindong, Leeteuk, Eunhyuk), Kwanghee (Ze:A), Moon Hee Jun, etc.",
    "timestamp": "2011-09-17T07:15:45Z",
    "embed_uri": "http://www.smackaho.st:3000/swfs/vikiplayer.swf?media_id=52272&host=www.smackaho.st:3000&auto_play=true&source=api",
    "thumbnails": {
      "huge": "http://c2.vikiassets.com/uploads/media_resource/thumbnail/146983/huge_e23de77a80bcf3aaf6658eaffb7fb4d5d2b7a44e.png",
      "large": "http://c3.vikiassets.com/uploads/media_resource/thumbnail/146983/large_e23de77a80bcf3aaf6658eaffb7fb4d5d2b7a44e.png",
      "medium": "http://c1.vikiassets.com/uploads/media_resource/thumbnail/146983/medium_e23de77a80bcf3aaf6658eaffb7fb4d5d2b7a44e.png",
      "small": "http://c3.vikiassets.com/uploads/media_resource/thumbnail/146983/small_e23de77a80bcf3aaf6658eaffb7fb4d5d2b7a44e.png",
      "mr_480_270": "http://c2.vikiassets.com/uploads/media_resource/thumbnail/146983/mr_480_270_e23de77a80bcf3aaf6658eaffb7fb4d5d2b7a44e.png",
      "mr_220_160": "http://c2.vikiassets.com/uploads/media_resource/thumbnail/146983/mr_220_160_e23de77a80bcf3aaf6658eaffb7fb4d5d2b7a44e.png"
    },
    "uri": "http://www.smackaho.st:3000/channels/1049-strong-heart/videos/52272"
  },
}
```