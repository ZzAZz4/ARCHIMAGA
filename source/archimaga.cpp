#include <string>

#include "archimaga/archimaga.hpp"

#include <SDL2/SDL.h>
#include <fmt/core.h>
#include <imgui.h>

exported_class::exported_class()
    : m_name {fmt::format("{}", "archimaga")}
{
}

auto exported_class::name() const -> char const*
{
  return m_name.c_str();
}
