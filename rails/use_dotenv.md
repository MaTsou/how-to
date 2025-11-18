### Use dotenv to load env vars in dev and tests
```
# Gemfile
gem 'dotenv', groups: [:development, :test]
```

Then run `bundle install`

```
.env
MY_KEY=myvalue
```

Add `.env` file to `.gitignore`
