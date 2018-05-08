-module(series).

-export([from_string/2, test_version/0]).

from_string(Width, String) -> from_string(Width, String, []).

from_string(Width, String, AllStrings) when Width > length(String) -> lists:reverse(AllStrings);
from_string(Width, String, AllStrings) -> from_string(Width, tl(String), [string:sub_string(String, 1, Width) | AllStrings]).

test_version() -> 1.
