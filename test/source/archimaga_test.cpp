#include <string>

#include "archimaga/archimaga.hpp"

#include <catch2/catch_test_macros.hpp>

TEST_CASE("Name is archimaga", "[library]")
{
  auto const exported = exported_class {};
  REQUIRE(std::string("archimaga") == exported.name());
}
