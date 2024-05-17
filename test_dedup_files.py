from dedup_files import matcher


def test_matcher():
    input_string = "kanidm-unixd_Debian_12_1.2.0.dev.202402160315%2Bfaec47d_x86_64.deb"

    result = matcher.match(input_string)

    data = result.groupdict()
    assert data["package"] == "kanidm-unixd"
    assert data["distro"] == "Debian_12"
    assert data["version"] == "1.2.0.dev"
    assert data["datestamp"] == "202402160315"
    assert data["commit"] == "faec47d"
    assert data["arch"] == "x86_64"

    input_string = "kanidm_Ubuntu_22.04_1.2.0.dev.202403260953%2B03ce2a0_x86_64.deb"

    result = matcher.match(input_string)

    data = result.groupdict()
    assert data["package"] == "kanidm"
    assert data["distro"] == "Ubuntu_22.04"
    assert data["version"] == "1.2.0.dev"
    assert data["datestamp"] == "202403260953"
    assert data["commit"] == "03ce2a0"
    assert data["arch"] == "x86_64"
