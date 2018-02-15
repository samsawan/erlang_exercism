-module(space_age).

-export([ageOn/2, test_version/0]).

-define(SECONDS_PER_EARTH_YEAR, 31557600).

ageOn(Planet, Seconds) ->
  case Planet of
  	earth -> calculate_earth_years(Seconds);
  	mercury -> calculate_earth_years(Seconds) * (1 / 0.2408467);
  	venus -> calculate_earth_years(Seconds) * (1 / 0.61519726);
  	mars -> calculate_earth_years(Seconds) * (1 / 1.8808158);
  	jupiter -> calculate_earth_years(Seconds) * (1 / 11.862615);
  	saturn -> calculate_earth_years(Seconds) * (1 / 29.447498);
  	uranus -> calculate_earth_years(Seconds) * (1 / 84.016846);
  	neptune -> calculate_earth_years(Seconds) * (1 / 164.79132)
  end.

test_version() -> 1.

calculate_earth_years(Seconds) -> Seconds / ?SECONDS_PER_EARTH_YEAR.
