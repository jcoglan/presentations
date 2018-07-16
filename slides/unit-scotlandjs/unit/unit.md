!SLIDE title
# Unit testing
## Getting more confidence in less time


!SLIDE code

```js
$(document).ready(() => {
  let form = $('form.signup')

  form.on('submit', event => {
    event.preventDefault()
    handleSignup(form) 
  })
})
```


!SLIDE title
# 1. Take control


!SLIDE code

```js
function ajaxSignupForm(selector) {
  let form = $(selector)

  form.on('submit', event => {
    event.preventDefault()
    handleSignup(form) 
  })
}
```


!SLIDE code

```html
<form method="post" action="/users" class="signup">
  <!-- ... -->
</form>

<script>
  ajaxSignupForm('form.signup')
</script>
```


!SLIDE code

```js
describe('signup form', () => {
  fixture `
    <form action="/users/new" class="signup">
      <input type="text" name="username">
      <input type="text" name="password">
      <input type="submit" value="Save">
    </form>`

  beforeEach(() => {
    ajaxSignupForm('.signup')
  })

  // ...
})
```


!SLIDE title
# 2. Isolate dependencies


!SLIDE code

```js
async function handleSignup(form) {
  // ...

  if (response.ok)
    return location.pathname = response.redirect

  // ...
}
```


!SLIDE code

```js
function redirect(path) {
  location.pathname = path
}

async function handleSignup(form) {
  // ...

  if (response.ok)
    return redirect(response.redirect)

  // ...
}
```


!SLIDE code

```js
  beforeEach(() => {
    // ...

    spyOn(window, 'redirect')
  })
```


!SLIDE code

```js
async function handleSignup(form) {
  // ...
  let response = await $.post(action, data)

  // ...
}
```


!SLIDE code

```js
  beforeEach(() => {
    // ...

    let response = Promise.resolve({
      ok: false, errors: []
    })
    spyOn($, 'post').and.returnValue(response)
  })
```


!SLIDE title
# 3. Check interactions


!SLIDE code

```js
  it('posts the form data to the server', () => {
    $('[name=username]').val('Gregor')
    $('[name=password]').val('Samsa')
    $('form.signup').submit()

    expect($.post).toHaveBeenCalledWith(
      '/users/new',
      'username=Gregor&password=Samsa')
  })
```


!SLIDE title
# 4. Handle outcomes


!SLIDE code

```js
async function handleSignup(form) {
  // ...

  if (response.ok)
    return location.pathname = response.redirect

  let errors = errorList(form).empty()

  response.errors.forEach(msg => {
    errors.append($('<li></li>').text(msg))
  })
}
```


!SLIDE code small

```js
describe('when the request is successful', () => {
  let response

  beforeEach(() => {
    response = Promise.resolve({
      ok: true, redirect: '/next/page'
    })
    $.post.and.returnValue(response)
  })

  it('redirects to the given path', async () => {
    $('form.signup').submit()
    await response

    expect(redirect).toHaveBeenCalledWith('/next/page')
  })
})
```


!SLIDE code small

```js
describe('when the server returns an error', () => {
  let response

  beforeEach(() => {
    response = Promise.resolve({
      ok:     false,
      errors: ['The username is already taken', 'Bad password']
    })
    $.post.and.returnValue(response)
  })

  it('does not redirect', async () => {
    $('form.signup').submit()
    await response

    expect(redirect).not.toHaveBeenCalled()
  })
```


!SLIDE code

```js
  it('displays the errors', async () => {
    $('form.signup').submit()
    await response

    let errors = $('ul.errors li')

    expect(errors.eq(0).text())
        .toEqual('The username is already taken')

    expect(errors.eq(1).text())
        .toEqual('Bad password')
  })
```


!SLIDE code

```
4 specs, 0 failures, randomized with seed 83763
finished in 0.018s

signup form
  posts the form data to the server
  when the request is successful
    redirects to the given path
  when the server returns an error
    does not redirect
    displays the errors
```


!SLIDE title
# 5. Verify your assumptions


!SLIDE code 

```js
app.post('/users', async (request, response) => {
  let user = User.build(request.body)

  try {
    await user.validate()
    await user.save()
    let url = `/users/${ user.id }`
    redirect(request, response, url)
  } catch (error) {
    displayErrors(request, response, user, error)
  }
})
```


!SLIDE title
# 1. Take control


!SLIDE title
# 2. Isolate dependencies


!SLIDE code

```js
describe('POST /users', () => {
  let user

  beforeEach(() => {
    user = {
      ...jasmine.createSpyObj(['validate', 'save']),
      id: 42
    }
    spyOn(User, 'build').and.returnValue(user)
  })
```


!SLIDE title
# 3. Check interactions


!SLIDE code

```js
  it('builds a user from the params', async () => {
    let params = {
      username: 'alice',
      email: 'alice@example.com',
      password: 'something'
    }
    await request(app)
          .post('/users')
          .send(qs.stringify(params))

    expect(User.build).toHaveBeenCalledWith(params)
  })
```


!SLIDE title
# 4. Handle outcomes


!SLIDE code 

```js
app.post('/users', async (request, response) => {
  let user = User.build(request.body)

  try {
    await user.validate()
    await user.save()
    let url = `/users/${ user.id }`
    redirect(request, response, url)
  } catch (error) {
    displayErrors(request, response, user, error)
  }
})
```


!SLIDE code

```js
describe('when the user is valid', () => {
  beforeEach(() => {
    user.validate.and.returnValue(Promise.resolve())
  })

  it('saves the user', async () => {
    await request(app).post('/users')
    expect(user.save).toHaveBeenCalled()
  })

  it('redirects to the profile page', async () => {
    let response = request(app).post('/users')

    await response.expect(302)
          .expect('Location', '/users/42')
  })
```


!SLIDE code small

```js
  it('responds to XHR with a redirect path', async () => {
    let response = request(app).post('/users')
                   .set('X-Requested-With', 'XMLHttpRequest')

    await response
          .expect(200, { ok: true, redirect: '/users/42' })
          .expect('Content-Type', 'application/json; charset=utf-8')
  })
```


!SLIDE code small

```js
describe('when the user is not valid', () => {
  beforeEach(() => {
    let error = { errors: [{ message: 'Bad username' }] }
    user.validate.and.returnValue(Promise.reject(error))
  })

  it('does not save the user', async () => {
    await request(app).post('/users')
    expect(user.save).not.toHaveBeenCalled()
  })
})
```


!SLIDE title
# 5. Verify your assumptions


!SLIDE code small

```js
describe('User', () => {
  describe('validate()', () => {
    let params = {
      // valid user attributes
    }

    function validate(user) {
      return user.validate().then(() => [], (error) => {
        return error.errors.map(e => e.message)
      })
    }

    it('is valid with correct attributes', async () => {
      let user = User.build(params)
      expect(await validate(user)).toEqual([])
    })
```


!SLIDE code small

```js
    it('is invalid with a blank username', async () => {
      let user = User.build({ ...params, username: '' })

      expect(await validate(user))
          .toContain('Username cannot be blank')
    })

    it('is invalid with an invalid email', async () => {
      let user = User.build({ ...params, email: 'no' })

      expect(await validate(user))
          .toContain('Email is not a valid address')
    })
```


!SLIDE code small

```js
describe('new.hbs', () => {
  let template = compile('users/new.hbs')

  it('renders a signup form', () => {
    expect(template()).toMatchCSS('form.signup')
  })

  it('posts to the new user endpoint', () => {
    expect(template())
        .toMatchCSS('form[method="post"][action="/users"]')
  })
```


!SLIDE code small

```js
  let user = {
    username: 'bob', email: 'b@example.com', password: 'something'
  }

  it('has a username field', () => {
    expect(template())
        .toMatchCSS('input[type="text"][name="username"]')
  })

  it('echoes the submitted username', () => {
    expect(template({ user }))
        .toMatchCSS('input[name="username"][value="bob"]')
  })
```


!SLIDE title
# The result


!SLIDE code

```
Started
..........................

26 specs, 0 failures
Finished in 0.286 seconds
```


!SLIDE title
# Thank you.
## @mountain_ghosts
## `http://slides.jcoglan.com`
