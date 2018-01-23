## Welcome!

We're so glad you're thinking about contributing to an 18F open source project!
If you're unsure about anything, just ask -- or submit the issue or pull request
anyway. The worst that can happen is you'll be politely asked to change
something. We love all friendly contributions.

We want to ensure a welcoming environment for all of our projects. Our staff
follow the [18F Code of
Conduct](https://github.com/18F/code-of-conduct/blob/master/code-of-conduct.md)
and all contributors should do the same.

We encourage you to read this project's CONTRIBUTING policy (you are here), its
[LICENSE](LICENSE.md), and its [README](README.md).

If you have any questions or want to read more, check out the [18F Open Source
Policy GitHub repository]( https://github.com/18f/open-source-policy), or just
[shoot us an email](mailto:18f@gsa.gov).

## Participating in user research

We always welcome feedback from our users. For general feedback, please use the
[feedback
form](https://docs.google.com/a/gsa.gov/forms/d/15ycigLrTS7Ld4iVPgIMN-U5dMDFy6TnrHGOSkgk7qTI/viewform?c=0&w=1)
that appears in the footer of the Micro-purchase site.

## Instructions for 18F team members

Check out on the [onboarding docs](docs/onboarding.md) for instructions on how to
get going.


### Testing and style compliance

We believe in a test-driven approach for this project and any new features must
include corresponding tests. We use the
[Rspec](https://www.relishapp.com/rspec/) framework along with other tools like
[Capybara](http://jnicklas.github.io/capybara/) to test everything from basic
models up to multipage interactions with the site. All new code must be covered
by tests or it will not be accepted. You can run `rake spec` to make sure all
tests are passing before you submit your pull request.

We try to maintain a consistent style by using
[Rubocop](http://batsov.com/rubocop/), a style checker for Ruby code. We have
relaxed some of the more stringent rules in a basic Rubocop configuration, so it
should be easy to ensure your code meets our basic formatting rules. To check
style, you can run `rake rubocop` to see any style offenses.


## Public Domain

This project is in the public domain within the United States, and
copyright and related rights in the work worldwide are waived through
the [CC0 1.0 Universal public domain dedication](https://creativecommons.org/publicdomain/zero/1.0/).

All contributions to this project will be released under the CC0
dedication. By submitting a pull request, you are agreeing to comply
with this waiver of copyright interest.
