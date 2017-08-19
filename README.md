# :books: lively

_lively_ is a [Reddit live](https://github.com/reddit/reddit-plugin-liveupdate) event management system designed for use by the [Volunteer Live Team](https://liveteam.org).

## Setting Up
For the application to run, [Reddit oauth credentials](https://www.reddit.com/prefs/apps/) are required for logins, and AWS credentials with `s3:PutObject` and `s3:PutObjectAcl` permissions to an S3 bucket are required for file uploads.

- Clone the repository
- Run `bundle install` and `yarn`
- Create a `.env` file following this format:
```
REDDIT_ID=<reddit application id>
REDDIT_SECRET=<reddit application secret>

S3_BUCKET_NAME=<s3 bucket name>
AWS_REGION=<s3 bucket region>
AWS_ACCESS_KEY_ID=<aws access key id>
AWS_SECRET_ACCESS_KEY=<aws secret access key>
```
- Start the application by running `rails server`

## Contributing
Contributions are always welcome! All code in `master` must be production-ready, so please work in a separate branch or fork, and create a pull request. A project maintainer will review your contributions as soon as possible.

<br/>

---
_lively is a project created by [Kailan Blanks](https://github.com/kailan) for the [Volunteer Live Team](https://liveteam.org) under the [MIT License](./LICENSE.md)._