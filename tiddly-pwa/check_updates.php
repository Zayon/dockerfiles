<?php

['results' => $tags] = json_decode(
    file_get_contents("https://registry.hub.docker.com/v2/repositories/zayon/tiddly-pwa/tags?page_size=10"),
    true
);

$latestTagDigest = null;

foreach ($tags as $tag) {
    if ($tag['name'] == 'latest') {
        $latestTagDigest = $tag['digest'];
        break;
    }
}

$lastTag = null;

foreach ($tags as $tag) {
    if ($tag['name'] == 'latest') {
        continue;
    }

    if ($tag['digest'] == $latestTagDigest) {
        $lastTag = $tag['name'];
        break;
    }
}

if ($latestTagDigest === null || $lastTag === null ) {
    echo "new_release=false";
    exit(1);
}

// Fetch the RSS feed content
$rssContent = file_get_contents("https://codeberg.org/valpackett/tiddlypwa/tags.rss");

// Parse the XML content
$xml = new SimpleXMLElement($rssContent);

$lastItem = $xml->channel->item[0];

if ($lastItem->title == $lastTag) {
    echo "new_release=false";
    exit(0);
}

$issueBody = <<<EOF
New release detected: [$lastItem->title]($lastItem->link)

Please review the new release and take any necessary actions.
EOF;

echo <<<EOF
new_release=true
release_title=$lastItem->title
release_link=$lastItem->link
issue_body="""
$issueBody
"""
EOF;

