import ballerina/io;
import ballerina/udp;
import ballerina/http;

string greeting = "Hello";
int[] arr= [1,2,3,4,5];

public function main() returns error?{
    // string name = "Ballerina";
    // io:print(greeting, " ", name);
    int result = add(10, 20);
    io:println("Result: ", result);
    int n = arr[2];
    io:println("Array element: ", n);

    //get array length
    io:print("Array length: ", arr.length(), "\n");

    // string? result2 = coord();
    // io:println("Result2: ", result2);

    int|error resultErr = parse("");
    if (resultErr is int) {
        io:println("Parsed number: ", resultErr);
    } else {
        io:println("Error occurred: ", resultErr);
    }

    any resultMatch = mtest(KEY);
    io:println("Match result: ", resultMatch);


    Employee? e = t["John"];
    if (e is Employee) {
        io:println("Employee found: ", e);
    } else {
        io:println("Employee not found");
    }

    increaseSalary(1000);
    foreach Employee i in t {
        io:println("New employee salary: ", i);
    }


}

function add(int a, int b) returns int {
    int sum = a+b;
    return sum;
}


// funtion to handle th errors
function parse(string s) returns int|error {

    int n = 0;
    int[] cps = s.toCodePointInts();

    foreach int cp in cps {
        int p = cp - 0x30;
        if p<0 || p>9 {
            return error("Invalid number");
        }
        n = n*10 + p;
    }
    return n;
}

const KEY = "xyzzy";


//match expression similar to switch case
function mtest(any v) returns string {

    match v {
        17 => {
            return "number";
        }
        true => {
            return " boolean";
        }
        "str" => {
            return "string";
        }
        KEY => {
            return "constant";
        }
        0|1 => {
            return "or";
        }
        _ => {
            return "any";
        }
    }
}

service on new udp:Listener(8080) {

    remote function onDatagram(udp:Datagram & readonly dg) {
        io:println("bytes received: ", dg.data.length());
    }
}

service /hello on new http:Listener(8080) {
    resource function get  [string name]() returns string {
        return "Hello, " + name;
    }
    
}

//table structure
type Employee record {
    readonly string name;
    int salary;
};

table<Employee> key(name) t = table [
    {name: "John", salary: 2000},
    {name: "Doe", salary: 4000}
];

function increaseSalary (int amount) {
    foreach Employee e in t {
        e.salary += amount;
    }
}