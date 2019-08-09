#include "config.h"
#include "hello.h"

#include <fmt/format.h>
#include <libintl.h>

#include <unistd.h>
#include <boost/filesystem.hpp>
#include <climits>

namespace fs = boost::filesystem;

#define _(STRING) gettext(STRING)

std::string getexepath() {
  char result[PATH_MAX];
  ssize_t count = readlink("/proc/self/exe", result, PATH_MAX);
  auto path_string = std::string(result, (count > 0) ? count : 0);
  return path_string;
}

std::string getLocalePath() {
  auto path_string = getexepath();
  auto dir = fs::path(path_string).parent_path();
  auto locales = dir / "../share/locale";
  return locales.string();
}

int main() {
  setlocale(LC_ALL, "");
  bindtextdomain(TRANSLATIONS_DOMAIN, getLocalePath().c_str());
  textdomain(TRANSLATIONS_DOMAIN);

  fmt::print("Build type: {}\n", CMAKE_BUILD_TYPE);
  fmt::print("directory: {}\n", getLocalePath());
  hello(_("CMake"));
}
