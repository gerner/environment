# parse an ISO-8601 UTC datetime string into unix timestamp
function parsedate(s) {
    match(s, /([0-9]*)-([0-9]*)-([0-9]*)T([0-9]*):([0-9]*):([0-9]*)Z?/, a);
    return mktime(sprintf("%s %s %s %s %s %s",a[1],a[2],a[3],a[4],a[5],a[6]));
}

# parse an HH:MM:SS[.S...] string to float seconds
function parsetime(s) {
    match(s, /([0-9]{2}):([0-9]{2}):([0-9]{2}[.]?[0-9]*)/, a);
    return a[1]*3600+a[2]*60+a[3];
}
