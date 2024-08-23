import ballerina/io;

type Coord record {
    int x;
    int y;
};

Coord c = {x: 1, y: 2};

function coord() {
    io:println(c.x);
    io:println(c.y);
}