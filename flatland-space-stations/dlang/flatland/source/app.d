import std.stdio, std.algorithm;
import std.conv, std.array;
import std.array, std.math, std.range;

void main()
{
		auto s = array(stdin.byLine
				.map!split
				.map!(words => words.map!(to!int))
				.join);
		writeln(s[0].iota.map!(i => s[2..$].map!(s => abs(s-i)).minElement).maxElement);
}
